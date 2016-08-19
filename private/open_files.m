function [datafilepointer] = open_files(subNo, outfolder, n_files, name, log)
%ML_OPEN_FILES: Calls FUNC: ml_openout_files and FUNC: open_logfiles in a 
%safe try/catch/end. User can define the participant number assocaited with the 
%file generation, the destination output directory, the number of outfiles to be 
%made, the basename of all generated outfiles, and a binary [1,0] indicating 
%whether or not to open a diary logfile. The function returns a list containing 
%filepointer handlers for all open outfiles which can then be used to print content 
%to each file.
% 
% Syntax:  [datafilepointer] = ml_open_files(subNo, outfolder, n, name, log)
%
% Input: 
%           
%             subNo:      integer representing participant id
%
%             outfolder:  full path extension from the current working 
%                         directory to the folder containing the requested 
%                         outfile. The path should finish with '/'.
%
%             n_files:    number of outfiles to be created
%
%             name:       base name used to name each out file
%
%             log:        binary [0,1] indicating whether to create a diary log file
%                         1 = make file. 0 = do not make file
%
% Output:
% 
%             datafilepointer:  file handler to be used by fprintf() when
%                               writing data to the new outfile.
%
% Example:
%
%            datafilepointer = ml_open_files(1, /data/outfiles/, 2, 'participant_data', 1)
%
% m-files required: ml_open_outfiles.m; ml_open_logfile.m
% Subfunctions: ml_open_outfiles(); ml_open_logfile(), datestr();
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% October 2015; Last revision: 24-may-2015

%------------- BEGIN CODE -------------- 
datafilepointer = [];
try
    % open outfiles
    for i = 1:n_files
        outfile{i} = strcat(name, '_', num2str(subNo),'.',num2str(i),'.txt');
        datafilepointer(i) = ml_open_outfiles(outfolder, outfile{i});
    end
    % open log file named with timestamp
    logfile = strcat(datestr(now), '.txt');
    if (log == 1)
        ml_open_logfile(outfolder, logfile); % end program if unable to open log file successfully
    end
catch err
    disp(getReport(err,'extended'));
end
%------------- END OF CODE --------------