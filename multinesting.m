%returns the set of peaks and standard deviations
function [peaks, stddev] = multinesting(A,arg,T,path,str)
    %total number of data points
    N = sum(sum(A));
    %histogram peaks
    peaks = getPeaks(A,arg,str);
    %limited number of iterations before termination
    iterationLimit = 3000;    
    %rut threshold, least amount of change a new point can make
    rutThreshold = 1e-6;
    %rut limit, the point when rut threshold takes effect
    rutLimit = 7;
    %original threshold cost
    thresholdCost = 0;
    
    %number of points taken
    numPoints = 0;
    %number of bins in test histogram
    bins = size(A,arg);
    
    %threshold standard deviation change per step on gaussian
    dst = 0.2*bins;
    %initialize standard deviation array (starting point)
    for i = 1:size(peaks,2)
        stddev(i) = rand();
    end
    %test for termination of iteration
    termination = 0;
    iteration = 0;
    dPoints = 0;
    
    %wait bar
    h = waitbar(0,strcat(str,'- Learning...'));
    while termination == 0;
        iteration = iteration + 1;
        %record current standard deviation array for comparison
        testStdDev = stddev;
        %generate random direction and length vector from starting point within
        %threshold
        for i = 1:size(peaks,2);
            sign = 1;
            if rand() < 0.5;
                sign = -1;
            end
            stddev(i) = stddev(i) + (sign * dst * rand());
        end
        %generate quantized histogram
        x = 1:bins;
        for p = 1:bins
            H(p) = 0;
            for i = 1:size(peaks,2)
                H(p) = H(p) + normpdf(p,peaks(i),abs(stddev(i)));
            end
        end
        %if distance is less than current distance threshold, go back
        %you want to maximize c to 1
        c(iteration) = cost(histcounts(A,bins),histcounts(H,bins),N);
        
        %if on the first iteration set the threshold cost
        if iteration == 1
            thresholdCost = c(iteration);
            orgThresh = thresholdCost;
        end
        
        if c(iteration) < thresholdCost;
            %if the cost is less than, it's a fail
            %backtrack to the previous point
            stddev = testStdDev;
        else
            %if the cost is equal to or greater than, it's a pass
            %increment number of points
            numPoints = numPoints + 1;
            %record difference between points
            dPoints(numPoints) = c(iteration) - thresholdCost;
            %set new threshold cost
            thresholdCost = c(iteration);
            %record accepted points
        end

        %reset test histogram
        for i = 1:size(H,2)
            H(i) = 0;
        end
        %update wait bar
        waitbar(numPoints/T);
        %repeat until convergence on optimum likelihood
        exem = 1;
        if numPoints > (rutLimit + 1)
            exem = mean(dPoints(end-rutLimit+1:end));
        end
        
        if iteration >= iterationLimit || numPoints >= T || exem <= rutThreshold
            termination = 1;
            waitbar(1);
        end
    end
    close(h)
    results(bins,peaks,stddev,c,dPoints,orgThresh,path,str);
<<<<<<< HEAD
end
=======
end
>>>>>>> origin/master
