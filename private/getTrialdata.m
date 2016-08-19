function [ResponseData] = getTrialdata(Pointers, Response, keyCode, playtimeEnd, Sequence)
%FUNCTION_HEADER - 
% 
% Syntax:  getTrialdata(Pointers, Response, keyCode, playtimeEnd, Sequence)
%
% Input: 
%           Pointers:       Data structure containing psychtoolbox variables   
%
%           Response:       Data structure containing response data
%
%           keyCode:        Key code of the response keyboard
%
%           playtimeEnd:    Time point of the end of the stimulus
%
%           Sequence:       Data structure containing stimulus information       
%
% Output:
% 
%           ResponseData:   Data structure containing computed response data            
%
% Example:
%
%           getTrialdata(Pointers, Response, keyCode, playtimeEnd, Sequence)
%
% m-files required: recReactiontime, trialTexture, 
% Subfunctions: Screen, 
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
try
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start response period
    trialTexture(Pointers, [255,255,255]);        % make onscreen trial texture
    [~, startResponse] = Screen('Flip', Pointers.w, playtimeEnd - Pointers.slack);    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check for keyboard responses
	[keyCode, endResponse] = recReactiontime(keyCode, startResponse, ...    
										Response.timeoutDur, ...
										Response.respond); 
	% flip screen again
	trialTexture(Pointers, [0,255,0]);            % flash green fixation point for 50 ms
    tStart = Screen('Flip', Pointers.w, 0);  
    trialTexture(Pointers, [255,255,255]);        % revert to white fixation point for next trial
    Screen('Flip', Pointers.w, tStart + 0.050);   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save data in the ResponseData structure
	f1 = 'startResponse'; v1 = startResponse;
	f2 = 'endResponse';   v2 = endResponse;
	f3 = 'keyCode';       v3 = keyCode;
	ResponseData = struct(f1, v1, f2, v2, f3, v3);
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------