function sequenceDur = openAudioschedule(periodicIOI, paTarget, pabufTarget, IOIarray)
%FUNCTION_HEADER - 
% 
% Syntax:  openAudioschedule(periodicIOI, paTarget, pabufTarget, IOIarray)
%
% Input: 
%           periodicIOI:		Boolean - 1 = periodic sequence, 0 = aperiodic sequence
%
%			paTarget:			Psychportaudio data handle for each noise burst
%
%			pabufTarget:		PsychportAudio buffer handel for each noise burst 
%
%			IOIarray:			Array of IOI values associated with the stimulus sequence            
%
% Output:
% 
%           sequenceDur:		Duration of the primed audio schedule            
%
% Example:
%
%           openAudioschedule(periodicIOI, paTarget, pabufTarget, IOIarray)
%
% m-files required: nonr
% Subfunctions: PsychPortAudio
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
try 
	%---------------------
	% assign target tone sequence to an audio schedule
	%---------------------
	PsychPortAudio('UseSchedule', paTarget, 1);
	cmdCode = -(1 + 16); % set AddToSchedule special command to ensure accurate timing presentation

	sequenceDur = [];
	sequenceDur = 0;
	for i = 1:length(pabufTarget)
	    if i == 1 % assign onset asychrony to each of the target sequence values
	        PsychPortAudio('AddToSchedule', paTarget, pabufTarget{i});
	    else
	        PsychPortAudio('AddToSchedule', paTarget, cmdCode, IOIarray(i-1));
	        PsychPortAudio('AddToSchedule', paTarget, pabufTarget{i});
	        sequenceDur = sequenceDur + IOIarray(i-1);
	    end
	end
	sequenceDur = sequenceDur + 0.250;
	PsychPortAudio('AddToSchedule', paTarget, cmdCode, periodicIOI);

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------