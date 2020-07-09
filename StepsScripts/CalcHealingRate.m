%% CalcHealingRate
% Using the segmentation from the previous steps, deducts the fraction of
% cellular foreground from the entire image in each frame.
% an implementation of step #3 in the book chapter.
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
function [] = CalcHealingRate(params, dirs)
% saves the healing rate plot in .jpg .eps and a .mat structure file 
whHealingRate(params,dirs);
end