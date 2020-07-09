%% SegmentationMovie
% Using the velocity fields obtained in step #1, segments the image stack
% into cellular foreground and background. 
% an implementation of step #2 in the book chapter.
% 
% Input:
%   params - a structure map of meta parameters for feature extraction
% 
%   dirs - a structure map of the created directories and files used for
%       analysis.
%
% For examples see 'exampleScript.m' @step #3
% 
% 
% Yishaia Zabary, Jun. 2020 (Adapted for the Bioimage Data Analysis Workflows - Advanced Components
% and Methods Book from Zaritsky et. al. 2017 http://doi.org/10.1083/jcb.201609095)
function [] = SegmentationMovie(params, dirs)
% if no prior segmentation was performed
whTemporalBasedSegmentation(params,dirs); % cellular-background segmentation
% create segmentation movie
whSegmentationMovie(params,dirs); % segmentation movie
end