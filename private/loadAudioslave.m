function [pabufTarget] = loadAudioslave(paTarget, Stimuli, paTestTone, Sequence)
%FUNCTION_HEADER - 
% 
% Syntax:  loadAudioslave(paTarget, Stimuli, paTestTone, Sequence)
%
% Input: 
%           paTarget:       PsychoportAudio channel handle for each noise burst
%
%           Stimuli:        Data structure containing stimulus information  
%
%           paTestTone:     PsychoportAudio channel handle for the probe tone
%
%           Sequence:       Data structure containing stimulus information         
%
% Output:
% 
%           pabufTarget:    PsychportAudio buffer handel for each noise burst            
%
% Example:
%
%           loadAudioslave(paTarget, Stimuli, paTestTone, Sequence)
%
% m-files required: noiseGen
% Subfunctions: PsychPortAudio
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
try 

    % create broadband Gaussian noise    
    for i = 1:Sequence.nTarget
        noise = noiseGen(Stimuli.noiseDur, Stimuli.playbackFreq, ...    
                          Stimuli.isRamp, Stimuli.gateDur, 0);
        noise = [noise; noise];

    % fill buffer
    	pabufTarget{i} = PsychPortAudio('CreateBuffer', [], noise); 
        PsychPortAudio('FillBuffer', paTarget, pabufTarget{i});
        disp('yes'); 
    end

    % create probe tone 2 kHz stimulus
    freq1 = 2000;
    numSamples=round(Stimuli.playbackFreq*0.050);
    time=(1:numSamples)/Stimuli.playbackFreq;
    tone=sin(2*pi*freq1*time);  % pure tone
    gate = cos(linspace(pi, 2*pi, Stimuli.playbackFreq*0.005));
    gate = gate+1;
    gate = gate/2;
    offsetgate = fliplr(gate);
    sustain = ones(1, (length(tone)-2*length(gate)));
    envelope = [gate, sustain, offsetgate];
    audio = envelope .* tone;
    audio = [audio; audio];
    
    % fill buffer
    pabufTestTone = PsychPortAudio('CreateBuffer', [], audio); 
	PsychPortAudio('FillBuffer', paTestTone, pabufTestTone); 

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------