function [Sequence, Stimuli] = PARENT_sequenceGen(Stimuli, shortLong, seqDur, rhythmicVar, index)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try

    % define variables
    nIOI = seqDur - 1;

    % define the standard deviation cut off values computed as between ±1 and 2.5 sd of the all possible sd values on aperiodic trials.
    if rhythmicVar == 1
        lowerbound = 0.0349;
        upperbound = 0.0588;
    elseif rhythmicVar == 2
        lowerbound = 0.0906;
        upperbound = 0.1145;
    end

    % calculate IOI array
    IOIarray = {};
    if rhythmicVar > 0;
        while true
            IOIarray = computeIOIarray(2, nIOI, Stimuli.periodicIOI);
            sdIOIArray = std(IOIarray);
            if (sdIOIArray > lowerbound && sdIOIArray < upperbound)
                disp('selected a valid IOI array');
                break
            else
                disp('no match found - retying...');
                continue
            end
        end
    else
        IOIarray = computeIOIarray(1, nIOI, Stimuli.periodicIOI);
        lowerbound = 0;
        upperbound = 0;
    end

    % build structure
    f1 = 'seqDur';         v1 = seqDur;
    f2 = 'shortLong';      v2 = shortLong;
    f3 = 'IOIarray';       v3 = {IOIarray};
    f4 = 'index';          v4 = index;
    f5 = 'rhythmicVar';    v5 = rhythmicVar;
    f6 = 'nIOI';           v6 = nIOI;
    f7 = 'nTarget';        v7 = seqDur;
    f8 = 'seqStd';         v8 = std(IOIarray);
    f9 = 'meanIOI';        v9 = mean(IOIarray);
    f10 = 'sumIOI';        v10 = sum(IOIarray);
    f11 = 'Lowbound';      v11 = lowerbound;
    f12 = 'Upbound';       v12 = upperbound;

    Sequence = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
                      f5, v5, f6, v6, f7, v7, f8, v8, ...
                      f9, v9, f10, v10, f11, v11, f12, v12);

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------