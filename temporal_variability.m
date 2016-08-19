function temporal_variability(group, subNo)
%------------------------------------------
% TEMPORAL_VARIABILITY - Command script. Run to start the experiment
%------------------------------------------
try
    %---------------------
    % variable configuration:
    [Prepair, Stimuli] = config(group, subNo);
    %---------------------
    % folder and ptb setup:
    [Pointers, Response] = setup(group, subNo, Prepair);
    %---------------------
    % load & print welcome message:
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 1);
    ptb_onscreen_text(Pointers.w, m); 
    %---------------------
    % run practice procedure
    PARENT_practiceLoop(Pointers, Stimuli, Response, Prepair);    
    %---------------------
    % run experimental procedure:
    PARENT_trialLoop(Pointers, Stimuli, Response, Prepair);       
	%---------------------
    % clean up:
    cleanup();
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();
end
%------------------------------------------