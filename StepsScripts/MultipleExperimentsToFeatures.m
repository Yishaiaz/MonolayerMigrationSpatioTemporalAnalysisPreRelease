%% MultipleExperimentsToFeatures
% extracts and returns a 12 feature vector for a given kymograph
% 
% Input:
%   mainExperimentsDirectory - path to to top directory of all kymographs
%   of the experiments. i.e.
%       mainExperimentsDirectory/
%           exp1Prefix/kymographs/
%               [not mendatory]speed/expPrefix_speedKymograph.mat
%               [not mendatory]directionality/expPrefix_directionalityKymograph.mat
%               [not mendatory]coordination/expPrefix_coordinationKymograph.mat
%           exp2Prefix/kymographs/
%               [not mendatory]speed/expPrefix_speedKymograph.mat
%               [not mendatory]directionality/expPrefix_directionalityKymograph.mat
%               [not mendatory]coordination/expPrefix_coordinationKymograph.mat
% 
%   allMeasuresToProcess - a list of all measures kymograph, i.e. one or
%       more of the following list {'speed','directionality','coordination'}
%   params - a structure map of meta parameters for feature extraction
%
% Example:
%   params.timePerFrame = 5;
%   mainExperimentsDirectory = '/Users/yishaiazabary/MonolayerKymographs/Sample_DATA/AllKymographs';
%   allMeasuresToProcess = {'speed','directionality'};
%   allExperimentsKymographsTo12FeatureVector(mainExperimentsDirectory, allMeasuresToProcess, params);
% 
% 
% Yishaia Zabary, Jun. 2020 (Adapted for the Bioimage Data Analysis Workflows - Advanced Components
% and Methods Book from Zaritsky et. al. 2017 http://doi.org/10.1083/jcb.201609095)
function [allExperimentsKymographsFeaturesArray] = MultipleExperimentsToFeatures(mainExperimentsDirectory, allMeasuresToProcess, params)
    allExperimentsDirectoryContent = dir(mainExperimentsDirectory);
    
    for expPrefixIDX = 1 : length(allExperimentsDirectoryContent)
        expPrefix =allExperimentsDirectoryContent(expPrefixIDX).name;
        if strcmp(expPrefix, '.DS_Store') || strcmp(expPrefix, '.') || strcmp(expPrefix, '..')
            continue;
        else
            kymographsTopDirectoryPath = [mainExperimentsDirectory filesep expPrefix filesep 'kymographs'];
            singleExpKymographFeaturesArray = SingleExperimentKymographsToFeatures(expPrefix, kymographsTopDirectoryPath, allMeasuresToProcess, params);
            existingFieldsNames = fieldnames(singleExpKymographFeaturesArray);
            for measureIDX = 1 : length(existingFieldsNames)
                measureName = existingFieldsNames(measureIDX);
                allExperimentsKymographsFeaturesArray.(expPrefix).(measureName{1}) = singleExpKymographFeaturesArray.(measureName{1}); 
            end
        end
        
        
    end
end