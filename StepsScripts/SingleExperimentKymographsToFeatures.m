%% SingleExperimentKymographsToFeatures
% extracts and returns a 12 feature vector for a given kymograph

% Input:
%   expPrefix - the experiment name, prefixing all kymograph.mat file names
%   kymographsTopDirectoryPath - path to to top directory of all kymographs
%   of the experiment. i.e.
%           kymographsTopDirectoryPath/
%                     [not mendatory]speed/expPrefix_speedKymograph.mat
%                     [not mendatory]directionality/expPrefix_directionalityKymograph.mat
%                     [not mendatory]coordination/expPrefix_coordinationKymograph.mat
%
%   allMeasureStr  - a list of all measures kymograph, i.e. one or
%       more of the following list {'speed','directionality','coordination'}
%   params - a structure map of meta parameters for feature extraction
%
% For examples see 'exampleScript.m' @step #5
% 
% Yishaia Zabary, Jun. 2020 (Adapted for the Bioimage Data Analysis Workflows - Advanced Components
% and Methods Book from Zaritsky et. al. 2017 http://doi.org/10.1083/jcb.201609095)

function [KymographsFeaturesArray] = SingleExperimentKymographsToFeatures(expPrefix, kymographsTopDirectoryPath, allMeasureStr, params)
% output directory
outputDirectory = [kymographsTopDirectoryPath filesep 'output'];
if ~exist(outputDirectory,'dir')
    mkdir(outputDirectory);
end
KymographsFeaturesArray = {};
for iMeasure = 1 : length(allMeasureStr)  
    measureStr = allMeasureStr{iMeasure};
    kymographPath = [kymographsTopDirectoryPath filesep measureStr filesep sprintf('%s_%sKymograph.mat', expPrefix, measureStr)];
    if ~exist(kymographPath, 'file')
        warning('no %s kymograph was found at %s', measureStr, kymographsTopDirectoryPath);
    else
        feats = kymographToFeaturesVec(kymographPath, measureStr, params);
        measureName = allMeasureStr(iMeasure);
        KymographsFeaturesArray.(measureName{1}) = feats;
    end
end
end