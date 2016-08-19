function PARENT_practiceLoop(Pointers, Stimuli, Response, Prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try  
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 2);
    ptb_onscreen_text(Pointers.w, m); 
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 3);
    ptb_onscreen_text(Pointers.w, m); 
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 4);
    ptb_onscreen_text(Pointers.w, m); 
    
    % run the practice loop
    n_blocks = 1;
    for block = 1:n_blocks;

        % load practice trial information    
        [index, shortLong, seqDur, rhythmicVar] = textread(Pointers.practice_file,'%f %f %f %f');
        ntrials     = length(index);            % get number of trials
        randomorder = randperm(ntrials);        % random permiatations
        index       = index(randomorder);       % randomise input list
        shortLong   = shortLong(randomorder);
        seqDur      = seqDur(randomorder);
        rhythmicVar = rhythmicVar(randomorder);

        for i = 1:ntrials;
            
            % compute target array and return sequence information
            disp(index(i)); disp(shortLong(i)); disp(seqDur(i)); disp(rhythmicVar(i));  
            [Sequence, Stimuli] = PARENT_sequenceGen(Stimuli, shortLong(i), seqDur(i), rhythmicVar(i), index(i));

            % load audio sequence into audio buffers ready for playback
            [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence);

            % play trial sequence, compute trial data
            ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone);

            % pause before starting next trial
            WaitSecs(0.200);
        end  
    end

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------