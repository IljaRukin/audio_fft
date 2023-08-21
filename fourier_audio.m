close all;clear;clc;

%generate random data
%Fs = 20; %sampling frequency
%t = 0:1/Fs:5.05; %time steps
%fx = 5; %frequency
%x = sin(2*pi*t*fx); %data

%load data from file as [data, samples/second]
[data,Fs]=audioread('guitar.wav');
x = data(:,1);%stereo audio: select one channel

%---

xfft = fftshift(fft(x)) * 1/sqrt(length(x));
df = Fs/length(xfft); %frequency steps == 1/t
if mod(length(xfft),2)==1
    %odd number of data samples
    freq = -(Fs-df)/2:df:(Fs-df)/2;
    %...(N-1)/2...0...(N-1)/2...
    %-3,-2,-1,0,1,2,3
else
    %even number of data samples
    freq = -(Fs)/2:df:(Fs-2*df)/2;
    %...N/2...0...(N-2)/2...
    %-3,-2,-1,0,1,2
end

%---

%plot real data
%{
figure(1);
plot(t,abs(x))
title('real data')
xlabel('time in s')
ylabel('amplitude')
%}

%plot fourier
figure(2);
plot(freq,abs(xfft))
title('fourier transform')
xlabel('frequency in Hz')
ylabel('amplitude')

%plot spectogram
window = floor(Fs/8);%window width in samples
noverlap = floor(Fs/64);%number of overlapping samles
nfft = 2048;%number of fft points used for fft of each window
figure(3);
spectrogram(x,window,noverlap,nfft,Fs,'yaxis')
title('spectrogram')
