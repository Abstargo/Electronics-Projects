clc;
clear;

% Adjust to your correct port
s = serialport("COM7", 115200);
configureTerminator(s, "LF");
flush(s);

% Preallocate
maxSamples = 1000;
g_data = nan(1, maxSamples);
richter_data = nan(1, maxSamples);
wave_labels = strings(1, maxSamples);

% Setup plot
figure;
subplot(2,1,1);
h_plot = plot(nan, nan, 'b');
title('Amplitude sismique');
xlabel('Temps (échantillons)');
ylabel('Accélération (g)');
grid on;
ylim([0 1]);

subplot(2,1,2);
txt = text(0.1, 0.6, '', 'FontSize', 14);
axis off;

i = 1;
while i <= maxSamples
    if s.NumBytesAvailable > 0
        raw = readline(s);
        try
            vals = split(raw, ',');
            if numel(vals) ~= 2
                continue;
            end

            g_val = str2double(vals{1});
            freq = str2double(vals{2});

            a_mps2 = g_val * 9.81;
            f = max(freq, 5); % Avoid division by 0
            A_m = a_mps2 / (2 * pi * f)^2;
            A_mm = A_m * 1000;

            % Richter magnitude formula
            if A_mm <= 0
                M = 0;
            else
                M = log10(A_mm) + 2.0;
            end

            if M < 2.5
                waveType = "P-wave";
            elseif M < 4.0
                waveType = "S-wave";
            elseif M < 5.9
                waveType = "Surface";
            else
                waveType = "Majeur";
            end

            g_data(i) = g_val;
            richter_data(i) = M;
            wave_labels(i) = waveType;

            % Update plot
            subplot(2,1,1);
            set(h_plot, 'XData', 1:i, 'YData', g_data(1:i));
            subplot(2,1,2);
            cla;
            text(0.1, 0.6, sprintf('Type: %s', waveType), 'FontSize', 16);
            text(0.1, 0.4, sprintf('Magnitude simulée: %.2f', M), 'FontSize', 16);
            drawnow;

            i = i + 1;

        catch err
            warning("Parsing error: %s", err.message);
        end
    end
end

% Save results
data = table((1:i-1)', g_data(1:i-1)', richter_data(1:i-1)', wave_labels(1:i-1)', ...
    'VariableNames', {'Index','Acceleration_g','SimulatedMagnitude','WaveType'});
writetable(data, 'seismic_data.csv');
