%%%%%%%%%%%%%%%%%%%%%%%%%%
% Range Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%
function rangeOther_callback(src, ~, sFirstRange, sLastRange, axPre)
% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Select Tolerance 
tolerance = 1e-7;

% keep only those rows
keepRows = Cut_ppm_axis > (sFirstRange.Value - tolerance) & ...
    Cut_ppm_axis < (sLastRange.Value + tolerance);
Cut_ppm_axis = Cut_ppm_axis(keepRows);
Cut_1HNMR_Data = Cut_1HNMR_Data(:, keepRows);

plot(axPre,Cut_ppm_axis,Cut_1HNMR_Data);
% Get the dimensions of the matrix
        [rows, cols] = size(Cut_1HNMR_Data);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');

%Automatically scale the X axis to the selected range 
xlim(axPre, [sFirstRange.Value, sLastRange.Value]);

% Store data in axPre
axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Cut_1HNMR_Data);
end
