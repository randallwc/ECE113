
clear, clc      % clear all variables

%%  Read in the noisy audio signal from the file 'CapnJ.wav' using audioread function
[Signal_Noisy, Fs] = audioread('CapnJ.wav');
Signal_Noisy = Signal_Noisy'; % Change to column vector
N = length(Signal_Noisy);
Index = 0:N-1;

%%  Play the noisy audio signal using sound function
sound(Signal_Noisy, Fs), % Play the "Noisy" audio signal

%% Plot the time-domain noisy signal 
figure(1), clf
subplot(2,1,1)
plot(Index, Signal_Noisy)
ylabel('Orig. Time Sig. Amp.'),
xlabel('Time (Samples)'),
grid on, zoom on

%% Obtain and plot the DTFT magnitude of the noisy signal 
% You can use FFT with a very large number of points
% Plot the normalized magnitude in dB (i.e., 20*log10(mag/max(mag))
% Use Hz for the horizontal frequency axis (based on Fs sampling rate
% obtained above)
% Use proper axis limits for your plot



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


F_cutoff = [];          % Lowpass filter cutoff freq in Hz

B = fir1([],[]);        % Simple lowpass FIR coeffs


%% Obtain and plot the filter normalized mag response
% Again, you can use FFT with a large number of points





%%  Lowpass filter the "Signal_Noisy" using the "filter" function and the filter you designed above 




%% Obtain and plot the normalized DTFT mag of your filtered signal

		

%% Play the reduced-noise sound using the sound function. What are the spoken words?



