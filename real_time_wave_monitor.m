% -------------------------------
% Real-Time Earthquake Wave Monitor (MATLAB)
% -------------------------------
clear; clc;

% ---- CONFIG ----
port = "COM7";         % Change this to your Arduino COM port
baud = 115200;
bufferSize = 200;

% ---- SERIAL ----
s = serialport(port, baud);
configureTerminator(s, "LF");

% ---- INIT DATA ----
P_mag = zeros(1, bufferSize);
S_mag = zeros(1, bufferSize);
t = zeros(1, bufferSize);
waveType = strings(1, bufferSize);
idx = 1;

% ---- FIGURE SETUP ----
figure('Name', 'P vs S Waves', 'NumberTitle', 'off', 'Position', [100 100 800 600]);
tiledlayout(3,1);

tAxes = nexttile;
magAxes = nexttile;
compAxes = nexttile;

% ---- TIMERS ----
tic;

% ---- LOOP ----
while true
    try
        % Read serial line
        line = readline(s);
        disp(">> " + line);
        data = sscanf(line, "%f,%f");

        % Validate data
        if numel(data) ~= 2
            continue;
        end

        acc = data(1);      % rawMagnitude
        freq = data(2);     % frequency

        % Time
        t(idx) = toc;

        % ----- MAGNITUDE CALCULATION -----
        P_mag(idx) = log10(acc + 1e-6) + 1.0;
        S_mag(idx) = log10(acc + 1e-6) + 1.5;
        
        % Calculate simulated magnitude (Richter scale approximation)
        simulated_magnitude = 0.67 * log10(acc * 1000) + 1.17;

        % ----- WAVE TYPE DETECTION -----
        if freq > 2.0
            waveType(idx) = "P";
        elseif freq > 0.5
            waveType(idx) = "S";
        else
            waveType(idx) = "Unknown";
        end

        % ----- PLOTTING -----
        range = 1:min(idx, bufferSize);
        cla(tAxes); cla(magAxes); cla(compAxes);

        % Top plot: wave type
        scatter(tAxes, t(range), double(categorical(waveType(range))), 36, 'filled');
        yticks(tAxes, [1 2 3]);
        yticklabels(tAxes, {'P', 'S', 'Unknown'});
        title(tAxes, 'Detected Wave Type');
        grid(tAxes, 'on');

        % Middle plot: magnitudes
        plot(magAxes, t(range), P_mag(range), 'b', t(range), S_mag(range), 'r');
        legend(magAxes, 'M_P', 'M_S');
        title(magAxes, 'Wave Magnitudes');
        ylabel(magAxes, 'Magnitude');
        grid(magAxes, 'on');

        % Add current values to corner (including simulated magnitude)
        maxY = max([P_mag(range), S_mag(range)]) + 0.1;
        minT = t(range(end));
        text(minT, maxY, sprintf('M_P = %.2f\nM_S = %.2f\nMagnitude simulée: %.2f', ...
            P_mag(range(end)), S_mag(range(end)), simulated_magnitude), ...
            'Parent', magAxes, 'VerticalAlignment', 'top', ...
            'HorizontalAlignment', 'right', 'FontSize', 10, 'Color', 'k', ...
            'BackgroundColor', [1 1 1 0.7]);

        % Bottom plot: P-S difference
        plot(compAxes, t(range), P_mag(range) - S_mag(range), 'k');
        title(compAxes, 'P - S Magnitude Difference');
        ylabel(compAxes, 'ΔMagnitude');
        xlabel(compAxes, 'Time (s)');
        grid(compAxes, 'on');

        drawnow;

        % Next index
        idx = idx + 1;
        if idx > bufferSize
            idx = 1;
        end

    catch ME
        warning("Serial read error: %s", ME.message);
    end

    pause(0.05);  % ~20 Hz
end