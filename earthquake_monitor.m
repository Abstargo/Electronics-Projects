% MATLAB script to monitor Arduino serial data
clc;
clear;

% Adjust the COM port and baud rate as per your setup
arduinoPort = "COM7";  % change this if different
baudRate = 115200;

s = serialport(arduinoPort, baudRate);
configureTerminator(s, "LF");
flush(s);

% Setup real-time plot
figure;
title("Earthquake Monitoring");
xlabel("Time (s)");
ylabel("Magnitude / Frequency");
grid on;
hold on;

startTime = datetime('now');
maxPoints = 300;
mags = nan(1, maxPoints);
freqs = nan(1, maxPoints);

while true
    try
        data = readline(s);
        splitData = split(data, ',');
        if length(splitData) == 2
            mag = str2double(splitData(1));
            freq = str2double(splitData(2));
            
            mags = [mags(2:end), mag];
            freqs = [freqs(2:end), freq];
            
            % Plot
            clf;
            subplot(2,1,1);
            plot(mags, 'r');
            title("Smoothed Magnitude");
            ylim([0, 1]);
            grid on;

            subplot(2,1,2);
            plot(freqs, 'b');
            title("Frequency (Hz)");
            ylim([0, 20]);
            grid on;
            
            drawnow;
        end
    catch e
        warning("%s", e.message);
        break;
    end
end

clear s;
