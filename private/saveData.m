function saveData(group, subNo, fpointer, Sequence, ResponseData, block)
%FUNCTION_HEADER - 
% 
% Syntax:  saveData(group, subNo, fpointer, Sequence, ResponseData, block)
%
% Input: 
%           group:              Name (string) naming the participant group being tested
%
%           subNo:              Participant ID
%
%           fpointer:           File pointer referencing the open data writable data file
%
%           Sequence:           Data structure containing stimulus information
%
%           ResponseData:       Data structure containing trial response information 
%
%           Block:              Block ID of the current trial           
%
% Output:
%             
% Example:
%
%           saveData(group, subNo, fpointer, Sequence, ResponseData, block)
%
% m-files required: none
% Subfunctions: none
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
% add empty IOI array values to the IOIarray
z = zeros(1, 9 - length(Sequence.IOIarray));
IOIarray = [Sequence.IOIarray, z];

data = {group, ...                           % participant group
        subNo, ...                           % participant number
        block, ...                           % trial block ID
        Sequence.index, ...                  % stimulus index
        Sequence.seqDur, ...                 % number of noises bursts;
        Sequence.shortLong, ...              % short = 1, long = 2;
        Sequence.nTarget, ...                % number of noise bursts
        Sequence.nIOI, ...                   % number of IOIs in noise burst
        Sequence.rhythmicVar, ...            % zero = 0, low = 1, high = 2
        Sequence.seqStd, ...                 % sequence standard deviation
        Sequence.meanIOI, ...                % sequence mean IOI
        Sequence.sumIOI, ...                 % sequence sum IOI             
        Sequence.Lowbound, ...               % lower boundary for standard deviation
        Sequence.Upbound, ...                % upper boundary for standard deviation
        ResponseData.pressedKey, ...         % keyboard ID of the pressed response key
	ResponseData.RT, ...                 % response time on the trial
	Sequence.duration, ...               % duration of the stimulus sequence
	ResponseData.startInterval, ...      % duration between start of the trial and stimulus onset
	ResponseData.totalDuration, ...      % total duration of the trial
        IOIarray(1), IOIarray(2),  IOIarray(3),  IOIarray(4), ...       % IOI array values
        IOIarray(5), IOIarray(6),  IOIarray(7),  IOIarray(8), ...
        IOIarray(9)};

ml_writetofile(fpointer(1), data);           % print data to outfiles

%------------------------------------------