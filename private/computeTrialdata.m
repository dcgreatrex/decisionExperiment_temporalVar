function [ResponseData] = computeTrialdata(ResponseData)
%FUNCTION_HEADER - 
% 
% Syntax:  [ResponseData] = computeTrialdata(ResponseData)
%
% Input: 
%           ResponseData:   Data structure containing trial response data           
%
% Output:
% 
%           ResponseData:   Data structure containing RT and pressed key information           
%
% Example:
%
%           [ResponseData] = computeTrialdata(ResponseData)
%
% m-files required: none
% Subfunctions: KbName
% 
% Author:  David C Greatrex
% Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 18-08-2016
    
%------------------------------------------
try
    if ResponseData.endResponse == 'TO'
    	RT = 'TO';
        pressedKey = 'NA';
    else
        RT = round((ResponseData.endResponse - ResponseData.startResponse) * 1000) / 1000; % response time
        pressedKey = KbName(ResponseData.keyCode); % key pressed by subject
    end

    % append computed data to the responseData structure
    [ResponseData(:).RT] = RT;
    [ResponseData(:).pressedKey] = pressedKey;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------