% cost
% this is a generalizable function for generating the cost difference
% between a model and the original object. This is done so that 0 is a
% worst case scenario and 1 is a perfect match. The goal is therefore to
% optimize to a cost of 1.
%
% Usage:
%           function [ output_args ] = cost( Original_Histogram, Model_histogram, Normalization_Factor )
%           
% Where:
%           input_args  = Original_Histogram (the original histogram to compare), 
%                         Model_histogram (generated model), 
%                         Normalization_Factor (maximum possible distance)
%           output_args = distance of histograms
%
% This 
% 
% Created By: 
%           Kaliel Williamson
%

function y = cost(A,B,N)
    %the cost function
    %here, it is pdist
    y = 1 - pdist2(A,B)/N;
end