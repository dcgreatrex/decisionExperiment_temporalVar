function [keyCode, endR] = recReactiontime(keyCode, startR, maxResp, responseKey)
%ML_REACTIONTIME - Records participant reaction times for a two key
%response task. It takes as input a clean keyCode variable (list of all 
%keyboard key ID's and their pressed state) and checks over a predefined 
%time period whether either of the two keys are pressed by the user. The 
%function returns: 1) a keyCode variable containing a binary indicator for
%the pressed state of each key, 2) the start time of the response period, 
%3) the end time of the response period.
%
%The input keyCode variable should be created by the psychtoolbox function
%KbCheck() - ([~, ~, keyCode]=KbCheck(-1)).
%
%Prior to checking for responses within the response period, the function
%checks whether any of the response keys are already depressed. If either 
%key has been pressed, the function returns after 100ms, setting the end 
%time variable (endR) to that of the start time variable (startR). If both 
%response keys are depressed prior to the response period, no response keys 
%are recorded as being depressed and an empty keyCode variable is returned.
% 
% Syntax:  [keyCode,startR,endR] = ml_reactiontime(startR, maxResp, l_key, r_key)
%
% Input: 
%           
%           keyCode:    A 256-element logical array.  Each bit within the 
%                       logical array represents one keyboard key. If a key 
%                       is pressed, its bit is set, othewise the bit is 
%                       clear. To convert a keyCode to a vector of key  
%                       numbers use FIND(keyCode). To find a key's 
%                       keyNumber use KbName or KbDemo from the
%                       psychtoolbox package. keyCode is generated using
%                       the KbCheck() function.
%
%           startR:     CPU time in which the response period begins.
%
%           maxResp:    the maximum time of the response period in seconds. 
%
%           l_key:      Key code of the left response key - generated using
%                       the KbCheck() function in psychtoolbox.
%
%           r_key:      Key code of the right response key - generated using
%                       the KbCheck() function in psychtoolbox.
%
% Output:
% 
%           keyCode:    A 256-element logical array.  Each bit within the 
%                       logical array represents one keyboard key. If a key 
%                       is pressed, its bit is set, othewise the bit is 
%                       clear. To convert a keyCode to a vector of key  
%                       numbers use FIND(keyCode). To find a key's 
%                       keyNumber use KbName or KbDemo from the
%                       psychtoolbox package. keyCode is generated using
%                       the KbCheck() function.
%
%           endR:       CPU time in which the response period finished
%
%
% Example:
%
%           [keyCode,startR,endR] = ml_reactiontime(starttime, 4.00, 6, 16)
%
% m-files required: none
% Subfunctions: none
% MAT-files required: KbCheck(); KbName(); WaitSecs(); 
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 29-10-2015
% Changes made: startR removed from the return values. 
    
%------------- BEGIN CODE --------------
EndTime=startR + maxResp;
 
%---------------------
% response window key press - check if either response keys are pressed in the response period
%---------------------
while (GetSecs < EndTime)
    if (keyCode(responseKey)==1)
         break;
    end      
    [~, endR, keyCode]=KbCheck(-1);             % check all keyboard devices
    WaitSecs(0.0005);                           % Wait 0.5 ms before checking the keyboard again
end               


% assign default response time value (0ms) if the response is void.
if (keyCode(responseKey)==0)
    endR = 'TO';
end
%------------- END OF CODE --------------