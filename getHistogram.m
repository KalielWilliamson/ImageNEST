<<<<<<< HEAD
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


=======
>>>>>>> origin/master
function H = getHistogram(img_source,m)
    %color histogram
    if m == 1
        %get YUV from image
        YUV = getYUV(img_source,2);

        %get histograms from YUV
        H = generateHistogram(YUV(:,:,1),YUV(:,:,2),YUV(:,:,3),2);
    end
    %shape histogram
    if m == 2
        img = imread(img_source);
        for x = 1:size(img,1);
            vertical(x) = 0;
            for y = 1:size(img,2);
                if img(x,y) < 200;
                    vertical(x) = vertical(x) + 1;
                end
            end
        end
        
        for y = 1:size(img,2);
            horizontal(y) = 0;
            for x = 1:size(img,1);
                if img(x,y) < 200;
                    horizontal(y) = horizontal(y) + 1;
                end
            end
        end
        

        if size(horizontal,2) > size(vertical,2);
            lenDiff = size(horizontal,2) - size(vertical,2);
            eee = size(vertical,2);
            for ppp = eee+1:(eee+lenDiff)
                vertical(ppp) = 0;
            end
        end
        
        if size(horizontal,2) < size(vertical,2);
            lenDiff = size(vertical,2) - size(horizontal,2);
            eee = size(horizontal,2);
            for ppp = eee+1:(eee+lenDiff)
                horizontal(ppp) = 0;
            end
        end

        H = [horizontal;vertical];
    end
end

function deb(message)
yn = 0;
    if yn == 1
        disp(message)
    end
end

function YUV = getYUV(imagePath,setting)
    img = imread(imagePath);
    
    %get RGB
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    %get YUV
    for i = 1:size(R,1)
        for j = 1:size(R,2)
            Y(i,j) = 0.299 * R(i,j) + 0.587 * G(i,j) + 0.436 * B(i,j);
            U(i,j) = -0.14713 * R(i,j) - 0.28886 * G(i,j) + 0.436 * B(i,j);
            V(i,j) = 0.615*R(i,j)-0.51499*G(i,j)-0.10001*B(i,j);
        end
    end
    
    %concatenate vectors to matrix for return
    YUV(:,:,1) = Y;
    YUV(:,:,2) = U;
    YUV(:,:,3) = V;
    if setting == 1
        imshow(B);
    end
end

function YUVh = generateHistogram(Y,U,V,setting)
    %debugging comment
    deb(size(Y));
    deb(size(U));
    deb(size(V));
    
    if setting == 1
        %print histograms to screen
        figure
        Yhist = histogram(smooth(Y),256);
        title('Y');
        figure
        Uhist = histogram(smooth(U),256);
        title('U');
        figure
        Vhist = histogram(smooth(V),256);
        title('V');
        YUVh(:,1) = Yhist.Values;
        YUVh(:,2) = Uhist.Values;
        YUVh(:,3) = Vhist.Values;
    else
        YUVh(:,1) = histcounts(Y,256);
        YUVh(:,2) = histcounts(U,256);
        YUVh(:,3) = histcounts(V,256);
    end
    
    %save histograms
    
end

%smooth histogram
function smoothedYUV = smooth(X)
size(X);
    %X is a histogram
    %to do this, it will take the histogram as a vector
    %if the previous value is zero, it will take the average
    %of the value before and after it
    for i = 1:size(X,2);
        %if the element is zero, but only if it isn't the first
        %element or the last element
        if(X(1,i) == 0 && (i > 1 && i < size(X,2)));
            %take the average of the value before and after
            X(1,i) = (X(1,i-1) + X(1,i+1))/2;
            X(1,i);
        end
    end
    smoothedYUV = X;
<<<<<<< HEAD
end
=======
end
>>>>>>> origin/master
