function Z = getPeaks(Hist,Arg,Name)
    %smooth if you're not dealing with a shape histogram
    for cc = 1:10
        for counter = 2:(size(Hist,1) - 1)
            Hist(counter) = (Hist(counter - 1) + Hist(counter) + Hist(counter + 1)) / 3;
        end
    end
    figFile = figure;
    plot(Hist);
    titlename = strcat(Name,' Smoothed Histogram');
    title(titlename);
    xlabel('bins')
    ylabel('occurance')
    savefig(figFile,strcat('figures\',titlename,'.fig'));
    
    sig = 0.01*std(Hist);
    k = 1;
    recent = 0;
    if Arg == 2
        dydx = diff(Hist(:));
        for a = 2:size(dydx,1)-1
            if dydx(a) ~= 0
                recent = dydx(a);
            end
            if recent > 0 && dydx(a) == 0 && dydx(a+1) < 0
                Z(k) = a;
                k = k + 1;
            elseif recent > 0 && dydx(a) < recent && dydx(a+1)< 0
                Z(k) = a;
                k = k + 1;
            end
        end
    end
    
    if Arg ~= 2
        %if any bin has less than before and less than after, and is
        %significant
        for a = 2:(size(Hist,Arg)-1)
            if Hist(a-1) < Hist(a) && Hist(a) > Hist(a+1)
                if Hist(a) >= sig
                    Z(k) = a;
                    k = k + 1;
                end
            end
        end
        
        %if the last bin has a significant climb up
        if Hist(end) > Hist(end-1) && abs(abs(Hist(end)) - abs(Hist(end-1))) >= sig
            Z(k) = a;
            k = k + 1;
        end
        %if the first bin has a significant drop down
        if Hist(1) > Hist(2) && abs(abs(Hist(1)) - abs(Hist(2))) >= sig
            Z(k) = a;
            k = k + 1;
        end
    end
    
<<<<<<< HEAD
end
=======
end
>>>>>>> origin/master
