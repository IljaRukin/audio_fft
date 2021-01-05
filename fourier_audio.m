close all;clear;clc;

%generate random data
%Fs = 20; %sampling frequency
%t = 0:1/Fs:5.05; %time steps
%fx = 5; %frequency
%Data = sin(2*pi*t*fx); %data

%load data from file as [data, samples/second]
[Data,Fs]=audioread('beep.wav');

%---

xfft = abs(fftshift(fft(Data)));
df = Fs/length(xfft); %frequency steps == 1/t
if mod(length(xfft),2)==1
    %odd number of data samples
    freq = -(Fs-df)/2:df:(Fs-df)/2;
else
    %even number of data samples
    freq = -(Fs)/2:df:(Fs-2*df)/2;
end

plot(freq,abs(xfft))
xlabel('frequency in Hz')
ylabel('amplitude')