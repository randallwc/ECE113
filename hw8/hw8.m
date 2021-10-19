clear variables; clc; close all;

% constants
% as = 40;
% rp = 0.25;
lse = 0.2;
use = 0.75;
lpe = 0.35;
upe = 0.55;

Wn = [(lse+lpe)/2 (use+upe)/2];
M = ceil(6.2/min(lpe-lse,use-upe)); % 42
order = M - 1; % 41
window = hann(M);

filter = fir1(order, Wn, window);

figure(1);
freqz(filter);

figure(2);
stem(filter);