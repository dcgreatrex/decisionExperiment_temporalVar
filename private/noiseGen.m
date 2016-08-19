function noise = noiseGen(noiseDur, playbackFreq, isRamp, gateDur, soundNoise)
%FUNCTION_HEADER - 
% 
% Syntax:  noiseGen(noiseDur, playbackFreq, isRamp, gateDur, soundNoise)
%
% Input: 
%           noiseDur:       Duration of the noise burst
%
%           playbackFreq:   Playback frequency to use when converting during audio conversion
%
%           isRamp:         Boolean - 1 = include onset/offset cosine squared ramps.
%
%           gateDur:        Duration of the cosine ramp
%
%           soundNoise:     Boolean - 1 = play the generated sound file once it has been made                        
%
% Output:
% 
%           noise:          Matrix containing the generated noise file            
%
% Example:
%
%           [y] = FUNCTION_HEADER(x)
%
% m-files required: none
% Subfunctions: none
%
% Author: David C Greatrex
% Work Address: CMS, Cambridge University
% Website: http://www.davidgreatrex.com
% Last revision: 19-08-2016
    
%------------------------------------------
if nargin < 5 									% do not sound noise prior to returning function
    soundNoise = 0;
end
if nargin < 4 									% set to on/offset ramp duration to 10 ms
    gateDur = 0.01;
end
if nargin < 3 									% set to on/offset ramps required
    isRamp = 1;
end
if nargin < 2 									% set default sampling freq
    playbackFreq = 44100;
end

n = (randn(1, floor(playbackFreq*noiseDur))*2)-1; % generate noise

normalizedNoise = n/max(abs(n)); 				% normalise noise

if isRamp == 1                                  % add on and offset ramps
    gate = cos(linspace(pi, 2*pi, playbackFreq*gateDur));
    gate = gate+1;
    gate = gate/2;
    offsetgate = fliplr(gate);
    sustain = ones(1, (length(normalizedNoise)-2*length(gate)));
    envelope = [gate, sustain, offsetgate];
    smoothedNoise = envelope .* normalizedNoise;
    noise = smoothedNoise;
else
    noise = normalizedNoise;
end

% Add butterworth bandpass filter to limit the frequency of noise:
%% LINKS: http://uk.mathworks.com/help/signal/ref/designfilt.html

% % % Butterworth filter - 10th order
[b,a] = butter(8, [300 20000]/(playbackFreq/2), 'bandpass');
noise = filter(b,a,noise);

% FIR filter with 10th order
% bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
%          'StopbandFrequency1', 390, ... 
%          'PassbandFrequency1', 400, ...
%          'PassbandFrequency2',19090, ...
%          'StopbandFrequency2',20000, ...
%          'DesignMethod','ls', ...
%          'SampleRate',playbackFreq);
% noise = filter(bpFilt,noise);

if soundNoise == 1;
    sound(noise, playbackFreq);
end

%------------------------------------------