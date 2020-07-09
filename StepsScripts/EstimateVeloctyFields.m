%% EstimateVeloctyFields
% Using PIV analysis, measures the velocity fields in the image stack
% given (via dirs object).
% an implementation of step #1 in the book chapter.
% 
% Input:
%   params - a structure map of meta parameters for feature extraction
% 
%   dirs - a structure map of the created directories and files used for
%       analysis.
%
% For examples see 'exampleScript.m' @step #1
% 
% 
% Yishaia Zabary, Jun. 2020 (Adapted for the Bioimage Data Analysis Workflows - Advanced Components
% and Methods Book from Zaritsky et. al. 2017 http://doi.org/10.1083/jcb.201609095)
function [] = EstimateVeloctyFields(params, dirs)
whLocalMotionEstimation(params,dirs); % velocity fields estimation
whTemporalBasedSegmentation(params,dirs); % cellular-background segmentation
whCorrectGlobalMotion(params,dirs); % correction of stage-location errors
end