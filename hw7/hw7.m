clear; close all; clc;      % clear all variables

%%  Read in the noisy audio signal from the file 'CapnJ.wav' using audioread function
[Signal_Noisy, Fs] = audioread('CapnJ.wav');
Signal_Noisy = Signal_Noisy'; % Change to column vector
N = length(Signal_Noisy);
Index = 0:N-1;

%%  Play the noisy audio signal using sound function
%sound(Signal_Noisy, Fs), % Play the "Noisy" audio signal

%% Plot the time-domain noisy signal

figure(1);
plot(Index, Signal_Noisy);
title('time-domain noisy signal');
ylabel('Orig. Time Sig. Amp.');
xlabel('Time (Samples)');
grid on; zoom on;

%% Obtain and plot the DTFT magnitude of the noisy signal 
% You can use FFT with a very large number of points
% Plot the normalized magnitude in dB (i.e., 20*log10(mag/max(mag))
% Use Hz for the horizontal frequency axis (based on Fs sampling rate
% obtained above)
% Use proper axis limits for your plot

seconds = N / Fs;
f = Index/seconds;
xk = fft(Signal_Noisy, N);

figure(2);
mag = abs(xk);
db = 20*log10(mag/max(mag));
plot(f, db);
xlim([0 5000]);
title("dtft");
ylabel('normalized magnitude (db)');
xlabel('frequency (hz)');
grid on;

%%  Using fir1 function, design a lowpass FIR filter
% You need to select your filter order as well as the desired cut-off
% frequency. 
% For cut-off, try a few values in 2-4KHz range.
% Play with both cut-off and the filter order till you can properly hear and understand the spoken words.  
% Remember that the cut-off frequency input to fir1 is 0<Wn<1 with 1
% corresponding to the Nyquist rate (i.e., Fs/2 Hz or pi rad/sample)
% For estimating the required order of your filter, besides trial and
% error, you may also use "kaiserord" function, and then use Kaiser window
% in your FIR filter design. See examples here: https://www.mathworks.com/help/signal/ref/kaiserord.html

F_cutoff = [3000 3100];          % Lowpass filter cutoff freq in Hz
mags = [100 0];
dev = [0.05 0.01];
% dev = [1 1];
[n, Wn, beta, ftype] = kaiserord(F_cutoff, mags, dev, Fs);

% B = fir1([],[]);        % Simple lowpass FIR coeffs
B = fir1(n, Wn, ftype, kaiser(n+1, beta));

%% Obtain and plot the filter normalized mag response
% Again, you can use FFT with a large number of points

figure(4);
freqz(B);

%%  Lowpass filter the "Signal_Noisy" using the "filter" function and the filter you designed above 

[filtered_signal] = filter(B, 1, Signal_Noisy);

%% Obtain and plot the normalized DTFT mag of your filtered signal

xk = fft(filtered_signal, N);
mag = abs(xk);
db = 20*log10(mag/max(mag));

figure(5);
plot(f, db);
title("normalized DTFT mag");
ylabel('normalized dtft mag (db)');
xlabel('frequency (hz)');
xlim([0 5000]);
grid on;

%% Play the reduced-noise sound using the sound function. What are the spoken words?
sound(2*filtered_signal, Fs), % Play the "Filtered" audio signal
% the words are
% not chess mr spock poker

