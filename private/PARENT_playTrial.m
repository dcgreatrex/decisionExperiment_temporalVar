function ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    while KbCheck; end    % flush keyboard events
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % play sequence
    [keyCode, startTime, startInterval, playtimeEnd, totalDuration, early] = playStimulus(Pointers, ...
                                                          paTarget, Sequence.duration, ...
                                                          paTestTone, Response.respond);

    if early == 1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % aborting trial if response is premature
        m = 'You responded too early!';
        ptb_onscreen_text(Pointers.w, m, 'center', 'center', 0, 1); 
        WaitSecs(1.3);

        % save data in the ResponseData structure
        f1 = 'RT';            v1 = 'E';
        f2 = 'pressedKey';    v2 = 'NA'; % key pressed by subject
        ResponseData = struct(f1, v1, f2, v2);
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % get trial data
        ResponseData = getTrialdata(Pointers, Response, keyCode, playtimeEnd, Sequence);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % compute trial data
        ResponseData = computeTrialdata(ResponseData, Response);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % update response data structure
    [ResponseData(:).startInterval] = startInterval;
    [ResponseData(:).totalDuration] = totalDuration;
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------