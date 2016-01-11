<<<<<<< HEAD
% ImageNest
% this function returns the final outputs of the program and will take in a
% 
%
% Usage:
%           function [ output_args ] = getHistogram(input_args)
%           
% Where:
%           input_args  = imgg (the image source), 
%                         setting (number for setting)
% 
% Created By: 
%           Kaliel Williamson & Nicole Wallack
%


=======
>>>>>>> origin/master
function ImageNest(imgg,setting)
    tic;
    temp = strsplit(imgg,'\');
    temp2 = temp(2);
    temp3 = rptgen.toString(temp2);
    temp3 = strsplit(temp3,'.');
    temp4 = temp3(1);
    name = rptgen.toString(temp4);
    if setting == 3
        %shape histogram, horizontal
        str = 'Horizontal Shape';
        pic = strcat(name,str);
        H = getHistogram(imgg,2);
        multinesting(H(1,:),2,50,pic,str);

        %shape histogram, vertical
        str = 'Vertical Shape';
        pic = strcat(name,str);
        H = getHistogram(imgg,2);
        multinesting(H(2,:),2,50,pic,str);
    end
    
    if setting == 1 || setting == 2 || setting == 3
        %luminocity histogram
        str = 'Luminance';
        pic = strcat(name,str);
        H = getHistogram(imgg,1);
        multinesting(H(:,1),1,50,pic,str);
    end
    
    if setting == 2 || setting == 3
        %color U histogram
        str = 'Blue-Luminance';
        pic = 'redapple_blueluminance';
        H = getHistogram(imgg,1);
        multinesting(H(:,2),1,50,pic,str);
        %color V histogram
        str = 'Red-Luminance';
        pic = 'redapple_redluminance';
        multinesting(H(:,3),1,50,pic,str);
    end
    time = toc;
    sprintf('elapsed time (s): %g',time)
<<<<<<< HEAD
end
=======
end
>>>>>>> origin/master
