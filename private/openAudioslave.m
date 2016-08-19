function [paMASTER, paTarget, paTestTone] = openAudioslave(playbackFreq)
%FUNCTION_HEADER - 
% 
% Syntax:  [paMASTER, paTarget, paTestTone] = openAudioslave(playbackFreq)
%
% Input: 
%           playbackFreq:		Playback frequency to use when converting during audio conversion            
%
% Output:
% 
%           paMASTER:			PsychportAudio master data handle - all slave channels
%
%           paTarget:			PsychportAudio noise burst data handle
%
%			paTestTone:			PsychportAudio probe tone data handle
%
% Example:
%
%           [paMASTER, paTarget, paTestTone] = openAudioslave(playbackFreq)
%
% m-files required: ptb_open_audiomaster, PsychPortAudio
% Subfunctions: none
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
try 
	%---------------------
	% initialse master audio handle
	%---------------------
	[paMASTER] = ptb_open_audiomaster(playbackFreq); % master handle
	PsychPortAudio('Volume', paMASTER, 0.5);

	%---------------------
	% open slave handles
	%---------------------
    paTarget = PsychPortAudio('OpenSlave', paMASTER, 1); % sine tone slave
    PsychPortAudio('Volume', paTarget, 1);

    %---------------------
	% initialse test tone handle
	%---------------------
	paTestTone = PsychPortAudio('OpenSlave', paMASTER, 1);         % sine tone slave
	PsychPortAudio('Volume', paTestTone, 1);

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------