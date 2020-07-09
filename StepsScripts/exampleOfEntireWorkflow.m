%% exampleOfEntireWorkflow
% A run of the entire workflow demonstrated on the supplied sample data
%
% Uncomment each step code to perform that step.
% Don't forget to perform in order (i.e. step1 must preceed step2).
% 
% Yishaia Zabary, Jun. 2020 (Adapted for the Bioimage Data Analysis Workflows - Advanced Components
% and Methods Book from Zaritsky et. al. 2017 http://doi.org/10.1083/jcb.201609095)
function [] = exampleOfEntireWorkflow()
%   parameters initialization
filename = '/Users/yishaiazabary/MonolayerKymographs/Sample_DATA/Angeles_20150402_14hrs_5min_AA01_7.tif';
params.pixelSize  = 1.267428;% µm 
params.timePerFrame = 5; % minutes
params.maxSpeed = 90; % µm/hour
params.patchSizeUm = 5;% µm

[params,dirs] = initParamsDirs(filename,params); % set missing parameters, create output directories
%%   Step #1 - calculates velocity fields with PIV, 
% saves the results into the created folders. 
% uncomment:
EstimateVeloctyFields(params, dirs);
%% Examination of velocity fields
% uncomment:
% params.showScoreHeatMaps = true;
% EstimateVeloctyFields(params, dirs);
%%   Step #2 - segmentation movie creator, calculates segmentation itself as well as it creates the movie if segmentation hasn't occured previously (in step #1).
% saves the results into the created folders.
% uncomment:
SegmentationMovie(params, dirs);

%%   Step #3 - healing rate calculation and plot creator.
% saves the results into the created folders.
% uncomment:
% CalcHealingRate(params, dirs);

%%   Step #4 - create kymographs, here all measures are extracted.
% saves the results into the created folders. for coordination kymographs
% see bonus step.
% uncomment:
% allMeasuresToProcess = {'speed', 'directionality'};
% KymographsByMeasure(params, dirs, allMeasuresToProcess);

%%   Step #5 - extract features from kymographs
% the meta parameters for the feature extraction, 

metaParameters.timeToAnalyze = 200;
metaParameters.timePartition = 4;
metaParameters.spatialPartition = 3;
metaParameters.initialTimePartition = 0; 
params.kymographFeatMetaParams = metaParameters;
% you can any of the three function demonstrated below, but none of the
% three is necessary to the performance of rest;

% 1. To extract features from a single kymograph uncomment:
% kymographPath = '/Users/yishaiazabary/MonolayerKymographs/Sample_DATA/kymographs/speed/Angeles_20150402_14hrs_5min_AA01_7_speedKymograph.mat';
% measureStr = 'speed';  % the measurement of kymograph in the path.
% featuresStruct = kymographToFeaturesVec(kymographPath, measureStr, params);

% 2. To extract features from an entire experiments kymographs folder uncomment:
% expPrefix = 'Exp1';
% kymographsTopDirectoryPath = '/Users/yishaiazabary/MonolayerKymographs/Sample_DATA/AllKymographs/Exp1/kymographs';
% allMeasuresToProcess = {'speed', 'directionality'};
% featuresStruct = SingleExperimentKymographsToFeatures(expPrefix, kymographsTopDirectoryPath, allMeasuresToProcess, params)

% 3. To extract features from Multiple experiments kymographs. uncomment:
% mainExperimentsDirectory = '/Users/yishaiazabary/MonolayerKymographs/Sample_DATA/AllKymographs';
% allMeasuresToProcess = {'speed', 'directionality'};
% featuresStruct = MultipleExperimentsToFeatures(mainExperimentsDirectory, allMeasuresToProcess, params);

disp('finished running workflow');
end
