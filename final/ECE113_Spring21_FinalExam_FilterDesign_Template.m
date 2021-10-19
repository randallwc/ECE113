%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ECE113 Spring 21 Final Exam Filter Design Template
%  Spring 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For this problem, we will be designing four filters: 
%   - Filters 1 and 2 have the same passband cutoff but different stopband
%   cutoffs and hence different transition bandwidths (sharpness)
%   - Filters 3 and 4 have different passband cutoffs but the same 
%   transition bandwidths (sharpness)
%   - All four filters have the same specs for passband ripple and stopband
%   attenuation 
%   - We first design these four filters as FIR using Kaiser window-based
%   design and Parks-McClellan optimal equiripple design.
%   - We then design Filter 3 using Checbyshev Type II and Elliptic IIR
%   filters.
% Feel free to add new variables if needed, but please do NOT change the
% variable names already defined to make sure correct plots are generated.


clear all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Filter Specifications
%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 1e6;               % Sampling rate

Fpass1 = 100e3;         % Passband cutoff for Filters 1 and 2
Fstop11 = 150e3;        % Stopband cutoff for Filter 1
Fstop12 = 250e3;        % Stopband cutoff for Filter 2

Fpass21 = 100e3;        % Passband cutoff for Filter 3
Fpass22 = 300e3;        % Passband cutoff for Filter 4
Fstop21 = 200e3;        % Stopband cutoff for Filter 3
Fstop22 = 400e3;        % Stopband cutoff for Filter 4

% All four filters have the same passband ripple and stopband attenuation 
Rp = 0.1;               % Max passband ripple in dB
Rs = 60;                % Min stopband attenuation in dB


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Window-based FIR design using kaiserord and fir1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use kaiserord to obtain the filter orders required to meet the specs for
% the four filters
% See the examples here: https://www.mathworks.com/help/signal/ref/kaiserord.html

fcuts1 = [];        
fcuts2 = [];
fcuts3 = [];
fcuts4 = [];

mags = [];

dev = []; 

[n11,Wn1,beta1,ftype1] = kaiserord(...);
[n12,Wn2,beta2,ftype2] = kaiserord(...);
[n13,Wn3,beta3,ftype3] = kaiserord(...);
[n14,Wn4,beta4,ftype4] = kaiserord(...);

% Use fir1 to obtain the filter coeffcients for the four filters using
% Kaiser window with the beta values and the window lengths you found above.

hn11 = fir1(...);
hn12 = fir1(...);
hn13 = fir1(...);
hn14 = fir1(...);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parks-McClellan Optimal equiripple FIR design using firpmord and firpm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use firpmord to obtain the the filter orders required to meet the specs 
% for the four filters. Compare the filter orders with the window-based design above. 
% See the examples here: https://www.mathworks.com/help/signal/ref/firpmord.html

[n21,fo1,ao1,w1] = firpmord(...);
[n22,fo2,ao2,w2] = firpmord(...);
[n23,fo3,ao3,w3] = firpmord(...);
[n24,fo4,ao4,w4] = firpmord(...);

% Use firpm command along with the outputs of firpmord commands above 
% to obtain the optimal filter coeffcients for the four filters.   

hn21 = firpm(...);
hn22 = firpm(...);
hn23 = firpm(...);
hn24 = firpm(...);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Obtain the FIR filter frequency responses using freqz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 2048;               % Number of frequency points in one Nyquist range [0,Fs)
F= 0:Fs/N:(N-1)*Fs/2/N; % Frequency vector in Hz
FkHz = F/1e3;           % Frequency in KHz, for setting the frequnecy scale in plots

% For filters 1 and 2 (same passband, different transition bandwidths)
% using Kaiser window and Parks-McClellan
% Use freqz command with frequency in Hz, i.e., H = freqz(...,F,Fs)

H11=freqz(hn11,...,F,Fs);
H12=freqz(hn12,...,F,Fs);
H21=freqz(hn21,...,F,Fs);
H22=freqz(hn22,...,F,Fs);

% For filters 3 and 4 (different passband, same transition bandwidths)
% using Kaiser window and Parks-McClellan
% Use freqz command with frequency in Hz, i.e., H = freqz(...,F,Fs)

H13=freqz(hn13,...,F,Fs);
H14=freqz(hn14,...,F,Fs);
H23=freqz(hn23,...,F,Fs);
H24=freqz(hn24,...,F,Fs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot and compare FIR magnitude and phase frequency responses 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compare Filters 1 and 2
figure;
subplot(211);
plot(FkHz,20*log10(abs(H11)),FkHz,20*log10(abs(H12)),FkHz,20*log10(abs(H21)),FkHz,20*log10(abs(H22)),'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Magnitude Response (dB)');
leg11=sprintf('Filter 1, Kaiser, N11=%2d',n11);
leg12=sprintf('Filter 2, Kaiser, N12=%2d',n12);
leg21=sprintf('Filter 1, Parks-McClellan, N21=%2d',n21);
leg22=sprintf('Filter 2, Parks-McClellan, N22=%2d',n22);
legend(leg11,leg12,leg21,leg22);
title('Filter 1: Passband=100KHz, Stopband=150KHz, Filter 2: Passband=100KHz, Stopband=250KHz');
subplot(212);
plot(FkHz,unwrap(angle(H11))*180/pi,FkHz,unwrap(angle(H12))*180/pi,FkHz,unwrap(angle(H21))*180/pi,FkHz,unwrap(angle(H22))*180/pi,'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Phase Response (deg)');
legend(leg11,leg12,leg21,leg22);  

% Compare Filters 3 and 4
figure;
subplot(211);
plot(FkHz,20*log10(abs(H13)),FkHz,20*log10(abs(H14)),FkHz,20*log10(abs(H23)),FkHz,20*log10(abs(H24)),'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Magnitude Response (dB)');
leg13=sprintf('Filter 3, Kaiser, N13=%2d',n13);
leg14=sprintf('Filter 4, Kaiser, N14=%2d',n14);
leg23=sprintf('Filter 3, Parks-McClellan, N23=%2d',n23);
leg24=sprintf('Filter 4, Parks-McClellan, N24=%2d',n24);
legend(leg13,leg14,leg23,leg24,'Location','southwest');
title('Filter 3: Passband=100KHz, Stopband=200KHz, Filter 4: Passband=300KHz, Stopband=400KHz');
subplot(212);
plot(FkHz,unwrap(angle(H13))*180/pi,FkHz,unwrap(angle(H14))*180/pi,FkHz,unwrap(angle(H23))*180/pi,FkHz,unwrap(angle(H24))*180/pi,'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Phase Response (deg)');
legend(leg13,leg14,leg23,leg24,'Location','southwest');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IIR Filter Design (for Filter 3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fp3 = Fpass21;
Fs3 = Fstop21;

% Use cheb2ord to find the minimum Chebyshev Type II filter order given the specs
[n33,ws] = cheb2ord(...);

% Use cheby2 to design the Chebyshev Type II filter using the order and cutoff
% you found above
[b33,a33] = cheby2(...);

% Use ellipord to find the minimum Elliptic filter order given the specs
[n43,wp]=ellipord(...);

% Use ellip to design the Elliptic filter using the order and cutoff
% you found above
[b43,a43] = ellip(...);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Obtain the IIR filter frequency responses using freqz 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H33 = freqz(...,F,Fs);         % Chebyshev Type II
H43 = freqz(...,F,Fs);         % Elliptic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot and compare the magnitude and phase frequency responses for Filter 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
subplot(211);
plot(FkHz,20*log10(abs(H33)),FkHz,20*log10(abs(H43)),FkHz,20*log10(abs(H23)),'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Magnitude Response (dB)');
leg33=sprintf('Filter 3, Chebyshev II IIR, N33=%2d',n33);
leg43=sprintf('Filter 3, Elliptic IIR, N43=%2d',n43);
leg23=sprintf('Filter 3, FIR Parks-McClellan, N23=%2d',n23);
legend(leg33,leg43,leg23,'Location','southwest');
title('Filter 3: Passband=100KHz, Stopband=200KHz');
subplot(212);
plot(FkHz,unwrap(angle(H33))*180/pi,FkHz,unwrap(angle(H43))*180/pi,FkHz,unwrap(angle(H23))*180/pi,'LineWidth',1.5);
grid on;
xlabel('Frequency (KHz)');
ylabel('Filter Phase Response (deg)');
legend(leg33,leg43,leg23,'Location','southwest');




