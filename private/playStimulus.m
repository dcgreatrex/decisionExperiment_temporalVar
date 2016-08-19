function [keyCode, startTrial, startInterval, playtimeEnd, totalDuration, early] = playStimulus(Pointers, paTarget, sequenceDur, paTestTone, responseKey)
%PLAYSTIMULUS - Function for presenting the stimlus in each trial of the experiment 
% 
% 
% Syntax:   [keyCode, startTrial, startInterval, playtimeEnd, totalDuration, early] = playStimulus(Pointers, paTarget, sequenceDur, paTestTone, responseKey)
%
% Input: 
%           Pointers:		Data structure containing psychtoolbox variables  
%
%			paTarget:		PsychoportAudio channel handle for each noise burst
%
%			sequenceDur:	Duration of the primed audio schedule
%
%			paTestTone:		PsychoportAudio channel handle for the probe tone
%
%			responseKey:	Keyboard id for the two response keys                  
%
% Output:
% 
%           keyCode:		Key code of the response keyboard
%
%			startTrial:		Time stamp of the start of the trial
%
%			startInterval:	Duration between the start of the trial and the onset of the stimulus
%
%			playtimeEnd:	Timestamp of the end of the trial
%
%			totalDuration:	Total duration of the trial
%
%			early:			Boolean - 1 = participant responded early           
%
% Example:
%
%           [keyCode, startTrial, startInterval, playtimeEnd, totalDuration, early] = playStimulus(Pointers, paTarget, sequenceDur, paTestTone, responseKey)
%
% m-files required: trialTexture
% Subfunctions: KbCheck, WaitSecs, Screen, PsychPortAudio   
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
try
	[~, ~, keyCode] = KbCheck(-1);% Initialize KbCheck:
	[~, ~, keyCode2] = KbCheck(-1);% Initialize KbCheck:
	WaitSecs(0.050);
    startInterval = 0.500.* rand(1,1) + 1.000;    % any number between 1000 - 1500 ms
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start trial
    trialTexture(Pointers, [255,255,255]);        % make onscreen trial texture
	[~, startTrial] = Screen('Flip', Pointers.w, 0); 				             
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % start sequence
    trialTexture(Pointers, [255,255,255]);        % make onscreen trial texture
    when = startTrial + startInterval;
	[~, startSound] = Screen('Flip', Pointers.w, when - Pointers.slack);  
	PsychPortAudio('Start', paTarget, [], 0);     % start target sequence
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % end sequence
	whenProbe = startSound + sequenceDur;         % define CPU time to play probe tone

	early = 0;                                    % check for early responses during sequence presentation. 
	while (GetSecs < whenProbe)
    if (keyCode2(responseKey)==1)
    	 early = 1;
         break;
    end      
        [~, ~, keyCode2]=KbCheck(-1);             % check all keyboard devices
        WaitSecs(0.0005);                         % Wait 0.5 ms before checking the keyboard again
    end               

	PsychPortAudio('Stop', paTarget, 3);	      % stop target sequence	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% probe tone
    PsychPortAudio('Start', paTestTone, 1, whenProbe - Pointers.slack); % start probe
	PsychPortAudio('Stop', paTestTone, 3);                              % stop probe
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	playtimeEnd =  when - Pointers.slack;    % calculate CPU time to begin response
	totalDuration = playtimeEnd - startTrial;
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------