% === Setup Serial Connection ===
clear; clc;

port = "COM7";           % <-- CHANGE to your actual Arduino COM port
baudRate = 115200;
s = serialport(port, baudRate);
flush(s);

% === Parameters ===
fs = 50;                          % Sampling frequency (Hz)
windowSize = fs * 5;             % Plot window
buffer = zeros(1, windowSize);   % Buffer for scrolling plot
time = 1:windowSize;

% === Create/Prepare Log File ===
filename = "seismic_data.csv";
if ~isfile(filename)
    fid = fopen(filename, 'w');
    fprintf(fid, "Timestamp,Magnitude,Frequency,WaveType,SimulatedMagnitude\n");
    fclose(fid);
end

% === Plot Initialization ===
figure;
hPlot = plot(time, buffer, 'b');
xlabel('Temps (échantillons)');
ylabel('Accélération (g)');
title('Amplitude sismique');
ylim([0, 1]);
grid on;

txt = text(30, 0.9, '', 'FontSize', 12, 'FontWeight', 'bold');

% === Main Loop ===
while true
    try
        if s.NumBytesAvailable > 0
            line = readline(s);
            data = str2num(line); %#ok<ST2NM>
            if numel(data) == 2
                mag = data(1);
                freq = data(2);
                timestamp = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');

                % Update buffer for plot
                buffer = [buffer(2:end), mag];

                % Wave classification
                if mag < 0.06
                    wave = 'P-wave'; magRange = [2.0, 3.5]; accMin = 0.05; accMax = 0.06;
                elseif mag < 0.12
                    wave = 'S-wave'; magRange = [3.5, 5.0]; accMin = 0.06; accMax = 0.12;
                else
                    wave = 'Surface'; magRange = [5.5, 7.0]; accMin = 0.12; accMax = 0.20;
                end

                % Simulated Magnitude Calculation
                simMag = magRange(1) + (mag - accMin)/(accMax - accMin) * (magRange(2) - magRange(1));
                simMag = min(max(simMag, magRange(1)), magRange(2));

                % === Append to CSV ===
                fid = fopen(filename, 'a');
                fprintf(fid, "%s,%.4f,%.2f,%s,%.2f\n", string(timestamp), mag, freq, wave, simMag);
                fclose(fid);

                % === Update Plot ===
                set(hPlot, 'YData', buffer);
                annotation = sprintf('Type: %s\nMagnitude simulée: %.2f', wave, simMag);
                set(txt, 'String', annotation);
                drawnow limitrate;
            end
        end
    catch err
        disp("Erreur: " + err.message);
    end
end
