%% kymographsToFeaturesVec
% extracts and returns a 12 feature vector for a given kymograph

% Input:
%   kymographPath - path to input kymograph.mat file
%   measureStr - 'speed'/'directionality'/'coordination'
%   params - a structure map of meta parameters for feature extraction
%
% For examples see 'exampleScript.m' @step #5
% 
% Assaf Zaritsky, Jan. 2018 (implemented for the NEUBIAS training school)

function [featuresArray] = kymographToFeaturesVec(kymographPath, measureStr, params)
metaParameters = params.kymographFeatMetaParams;
metaParameters.timePerFrame = params.timePerFrame;
metaParameters.spaceToAnalyze = metaParameters.spatialPartition * metaParameters.timePartition;
% the 'grid' attributes, defines the size and scale of the features.

%%
load(kymographPath)
eval(sprintf('kymograph = %sKymograph;',measureStr)); % kymograph
assert(exist('kymograph','var') > 0);
%%
distancesFromWound = find(isnan(kymograph(:,1)),1,'first')-1;
if isempty(distancesFromWound)
    distancesFromWound = size(kymograph,1);
end

if distancesFromWound < metaParameters.spaceToAnalyze % 180 um
    warning('Too few cells at %s!',kymographPath);
end

featuresArray = getFeatures(kymograph,metaParameters);

end


%%
function [features] = getFeatures(kymograph,metaParameters)

nTime = floor(metaParameters.timeToAnalyze/metaParameters.timePerFrame);
nFeats = (metaParameters.timePartition-metaParameters.initialTimePartition) * metaParameters.spatialPartition;
features = zeros(nFeats,1);

ys = 1 : floor(metaParameters.spaceToAnalyze/(metaParameters.spatialPartition)) : (metaParameters.spaceToAnalyze+1);
xs = 1 : floor(nTime/(metaParameters.timePartition)) : (nTime+1);

curFeatI = 0;
for y = 1 : metaParameters.spatialPartition
    for x = (1+metaParameters.initialTimePartition) : metaParameters.timePartition%x = 1 : metaParameters.timePartition
        curFeatI = curFeatI + 1;
        values = kymograph(ys(y):(ys(y+1)-1),xs(x):(xs(x+1)-1));
        values = values(~isinf(values));
        values = values(~isnan(values));
        features(curFeatI) = mean(values(:));
    end
end
end