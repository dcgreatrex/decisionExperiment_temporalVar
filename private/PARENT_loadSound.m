function [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    % open audio slave for each targetArray
    [paMASTER, paTarget, paTestTone] = openAudioslave(Stimuli.playbackFreq);

    % assign localised noise bursts to an audioslave
    [pabufTarget] = loadAudioslave(paTarget, Stimuli, paTestTone, Sequence);
    
    % create audio schedule - requires array input
    duration = openAudioschedule(Stimuli.periodicIOI, paTarget, ...
                                         pabufTarget, Sequence.IOIarray);

    % update the Sequence structure with the duration value
    [Sequence(:).duration] = duration;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------