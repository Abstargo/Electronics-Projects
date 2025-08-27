clc;
clear;

% Create serial port
s = serialport("COM7", 115200);
configureTerminator(s, "LF");
flush(s);

% Initialize storage
maxSamples = 500;
mags = nan(1, maxSamples);
richterMags = nan(1, maxSamples);
waveLabels = strings(1, maxSamples);
i = 1;

% Set up figure
figure;
hPlot = plot(nan, nan, 'b.-');
title('Real-Time Seismic Data');
xlabel('Sample Index');
ylabel('Magnitude (g)');
grid on;
ylim([0 2]);

% Main loop
while i <= maxSamples
    if s.NumBytesAvailable > 0
        line = readline(s);
        tokens = split(strtrim(line), ',');
        
        if numel(tokens) == 3
            magRaw = str2double(tokens{1});
            waveType = string(tokens{2});
            richter = str2double(tokens{3});
            
            % Save values
            mags(i) = magRaw;
            richterMags(i) = richter;
            waveLabels(i) = waveType;

            % Update plot
            set(hPlot, 'XData', 1:i, 'YData', mags(1:i));
            title(sprintf("Seismic Magnitude: %.2f | Type: %s | Richter: %.2f", ...
                magRaw, waveType, richter));
            
            % Red warning line for magnitude >= 7
            if richter >= 7
                line([1 i], [1 1]*1.5, 'Color', 'r', 'LineStyle', '--');
                text(i, 1.6, 'ALERT: M7+ Earthquake!', 'Color', 'red');
            end
            
            drawnow;
            i = i + 1;
        end
    end
end

% Clean up
clear s;
