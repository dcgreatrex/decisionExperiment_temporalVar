function [pamaster, freq] = ptb_open_audiomaster(freq)
%PTB_OPEN_AUDIOMASTER - Set up psychportaudio master handle. Initialise
%relevant sound card, set frequency and number of channels and open
%the master sound channel set to high accuracy presentation settings.
% 
% Syntax:  [pamaster, freq] = ptb_open_audiomaster()
%
% Output:
% 
%           pamaster:   handle associated with the opened psychportaudio
%                       master channel.
%
%           freq:       frequency of sampling rate - set to standard 44100.
%
% Example:
%
%           [pamaster, freq] = ptb_open_audiomaster()
%
% m-files required: PsychPortAudio.m; InitializePsychSound.m; 
% Subfunctions: ml_file_check(); ml_create_file();
% MAT-files required: none
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% May 2015; Last revision: 07-may-2015
    
%------------- BEGIN CODE -------------- 
if nargin < 1
	freq = 44100; % playback speed in hz
end

PsychPortAudio('Close'); % close in case ppa is open  
InitializePsychSound(1); % setup and initialise psychportaudio  
suggestedLatencySecs = [];  
nrchannels = 2;

% open master handler and set criteria for high accuacy sound presentation.
pamaster = PsychPortAudio('Open', [], 1+8, 3, freq, nrchannels, 0, suggestedLatencySecs);
PsychPortAudio('Start', pamaster, 0, 0);
%------------- END OF CODE --------------