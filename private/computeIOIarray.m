function IOIarray = computeIOIarray(rhythmicVar, nTarget, periodicIOI)
%FUNCTION_HEADER - 
% 
% Syntax:  IOIarray = computeIOIarray(rhythmicVar, nTarget, periodicIOI)
%
% Input: 
%           rhythmicVar: Integer [0,1,2]. 0 = periodic; 1 = low variability;
%                        2 = high variability stimulus rhythm.
%
%           nTarget:     Number of noise bursts in target sequence
%
%           periodicIOI: Boolean - 1 = Periodic, 0 = aperiodic.                        
%
% Output:
% 
%           y:           Array of IOI values 
%
% Example:
%
%           IOIarray = computeIOIarray(rhythmicVar, nTarget, periodicIOI)
%
% m-files required: none
% Subfunctions: none
% 
% Author:  David C Greatrex
% Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 18-08-2016

%------------------------------------------
try 
    % setup exclusion sampling range
    excludeWindow = 0.025;                  % IOI resampling limit
    IOIrange = periodicIOI * 0.6;           % 0.6 for 250 IOI -- 0.7 for 333 IOI

    % generate IOI array
    if rhythmicVar == 1                   
        IOIarray(1:nTarget) = periodicIOI;  % periodic: return an array of zeros
        return;
    else                                        % aperiodic: randomly select IOI array    
        lsum = (periodicIOI * nTarget)-(0.005); % lowest total sequence duration possible
        usum = (periodicIOI * nTarget)+(0.005); % highest total sequence duration possible
        tMinus1 = 0;
        IOIarray = [];
        while true
            for i = 1:nTarget                   % loop until n_target IOIs are found
                
                while true
                    
                    t = periodicIOI.*rand(1,1) + IOIrange;    % random number between periodicIOI ± IOIrange
                    
                    if tMinus1 ~= 0

                        isLowbound  = t >= (tMinus1 - excludeWindow);  
                        isHighbound = t <= (tMinus1 + excludeWindow);
                        if (isLowbound && isHighbound)        % resample if IOI value is within IOI exclude window
                            continue
                        else
                            break
                        end
                    else
                        break
                    end
                end

                IOIarray(i) = t;    % update IOI array with value
                tMinus1 = t;
            end

            if (sum(IOIarray) < lsum || sum(IOIarray) > usum)
                continue
            else
                break
            end
        end
    end
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------