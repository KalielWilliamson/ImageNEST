% getHistogram
% this function returns the various histograms for a given image. It is
% capable of returning the Y', U, V, Horizontal-Shape, and Vertical-Shape
% histograms.
%
% Usage:
%           function [ output_args ] = getHistogram(input_args)
%           
% Where:
%           input_args  = img_source (the image source), 
%                         m (number for setting), 
%           output_args = returned histogram 
% 
% Created By: 
%           Kaliel Williamson & Nicole Wallack
%


function results(bins,peaks,stddev,c,dPoints,orgThresh,path,str)
    x = 0:1:bins;
    fileFig = figure;
    for i = 1:size(peaks,2)
        y = normpdf(x,peaks(i),abs(stddev(i)));
        plot(x,y);
        hold on;
    end
    hold off;
    titlename = strcat(str,' Gaussian Mixture');
    title(titlename);
    xlabel('bin');
    ylabel('occurance');
    savefig(fileFig,strcat('figures\',titlename,'.fig'));
    
    fileFig = figure;
    for p = 1:size(x,2)
        hist(p) = 0;
        for i = 1:size(peaks,2)
            hist(p) = hist(p) + normpdf(p,peaks(i),abs(stddev(i)));
        end
        hist(p);
    end
    plot(x,hist);
    titlename = strcat(str,' Model');
    title(titlename);
    xlabel('bin');
    ylabel('occurance');
    savefig(fileFig,strcat('figures\',titlename,'.fig'));
    
    fileFig = figure;
    plot(c);
    titlename = strcat(str,' Histogram Similarity');
    title(titlename);
    xlabel('iteration');
    ylabel('similarity');
    savefig(fileFig,strcat('figures\',titlename,'.fig'));
    
    fileFig = figure;
    plot(dPoints);
    titlename = strcat(str,' Eurika Moment');
    title(titlename);
    xlabel('accepted point number');
    ylabel('increased similarity');
    savefig(fileFig,strcat('figures\',titlename,'.fig'));
    
    minBoundary = 0;
    maxBoundary = bins;
    cmp = 0;
    for i = 1:length(peaks)
        Integral(i) = sum(normpdf([minBoundary:maxBoundary],peaks(i),abs(stddev(i))));
        if cmp < Integral(i)
            cmp = Integral(i);
            maxGauss = i;
        end
    end
    Thresh = 0.8;
    minT = peaks(maxGauss) - (abs(stddev(maxGauss)) * Thresh);
    maxT = peaks(maxGauss) + (abs(stddev(maxGauss)) * Thresh);
    
    str2 = strcat(str,sprintf('\nForeground Object: %g',peaks(maxGauss)));
    str2 = strcat(str2,sprintf('\nminimum threshold: %g\nmaximum threshold: %g',minT,maxT));
    str2 = strcat(str2,sprintf('\nnumber of peaks: %g',size(peaks,2)));
    str2 = strcat(str2,sprintf('\nfound appropriate points: %g',length(dPoints)));
    str2 = strcat(str2,sprintf('\noriginal threshold: %g\nfinal threshold: %g\n----------------------',orgThresh,c(end)));
    
    disp(str2)
    
    %save variables
    M = [peaks;abs(stddev)];
    save(strcat('database\',str,path,'.mat'),'M');
end