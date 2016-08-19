
function [Pointers, Response] = setup(group, subNo, prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
	% open writable output files in the output directory
	datafilepointer = open_files(subNo, prepair.outFolder, ... 
	 								prepair.nOutfile, prepair.exptName, ...
	  								prepair.isLogfile); 
	% print headings to outfiles
	ml_writetofile(datafilepointer(1), prepair.tableVariable);

    % define names of the input files
    practice_file  = strcat(prepair.inFolder, 'practiceLoop.txt');   
    input_file     = strcat(prepair.inFolder, 'trialLoop.txt');   

	% setup psychtoolbox and open a screen:   
	ptb_screen_setup(prepair.skipTest); 				              % prepair MATLAB for ptb
	[~, w, wRect, slack] = ptb_open_screen(prepair.textSize);	      % open a new experimental window						 	
	[screenXpixels, screenYpixels] = Screen('WindowSize', w); 	      % max x and y screen pixels
	[xs,ys] = RectCenter(wRect); 					                  % coordinates for screen mid point	
	Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % Enable Alpha blending
    
    % assign ptb window and open file variables to a structure named 'Pointers'.
    f1 = 'group';           v1 = group;
    f2 = 'subNo';           v2 = subNo;
    f3 = 'w';               v3 = w;									  
    f4 = 'wRect';           v4 = wRect;
    f5 = 'slack';           v5 = slack;
    f6 = 'screenCenter';    v6 = [screenXpixels, screenYpixels];
    f7 = 'fpointer';        v7 = datafilepointer;
    f8 = 'coordinates';     v8 = [xs, ys];
    f9 = 'practice_file';   v9 = practice_file;
    f10 = 'input_file';     v10 = input_file;
    Pointers = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
    	              f5, v5, f6, v6, f7, v7, f8, v8, ...
    	              f9, v9, f10, v10);

    % assign response key and timeout value to a structure named 'Response'
	f1 = 'respond';	v1 = KbName( prepair.keyArray{1} );        % left response key - " "
	f2 = 'timeoutDur';	v2 = prepair.timeoutDur;		       % time out duration
	Response = struct(f1, v1, f2, v2);
	
	GetSecs; 											       % initiate timing functions
	WaitSecs(1);
	
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------