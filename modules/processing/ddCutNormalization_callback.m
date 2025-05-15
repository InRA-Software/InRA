%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalization Options Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ddCutNormalization_callback(src, ~, axPre, btnComparativePre)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Verify if src.UserData contain data
if isempty(src.UserData)
    % Store data without normalization in src.UserData
    src.UserData.WONPpm = Cut_ppm_axis;
    src.UserData.WONData = Cut_1HNMR_Data;
    WON_ppm_axis = data.CutPpm;
    WON_1HNMR_Data = data.CutData;
else
    dataAux = src.UserData;
    WON_ppm_axis = dataAux.WONPpm;
    WON_1HNMR_Data = dataAux.WONData;
end

switch src.Value
    case 'None'
        % Plot the Raw data
        plot(axPre,WON_ppm_axis,WON_1HNMR_Data);
        % Add dimensions to the title
        axPre.Title.String = 'Processed ^{1}H-NMR Spectra';
        axPre.Title.Color = 'blue';
        % Store data in axPre
        axPre.UserData = struct("CutPpm", WON_ppm_axis, ...
            "CutData", WON_1HNMR_Data);
        % Get the dimensions of the matrix
        [rows, cols] = size(WON_1HNMR_Data);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
        % Store Data in Comparative Treatment Button
        btnComparativePre.UserData.OriginalPpm = WON_ppm_axis;
        btnComparativePre.UserData.OriginalData = WON_1HNMR_Data;
    case 'Norm-1'
        % Total sum Normalization 
        Cut_Norm1 = WON_1HNMR_Data./(sum(WON_1HNMR_Data, 2)*ones(1, ...
            size(WON_1HNMR_Data, 2)));
        % Plot the Pre data
        plot(axPre,Cut_ppm_axis,Cut_Norm1);
        % Add dimensions to the title
        axPre.Title.String = 'Processed ^{1}H-NMR Spectra -1-Norm- ';
        axPre.Title.Color = 'blue';
        % Store data in figure
        Cut_1HNMR_Data = Cut_Norm1;
        axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Cut_1HNMR_Data);
        % Get the dimensions of the matrix
        [rows, cols] = size(Cut_Norm1);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
        % Store Data in Comparative Treatment Button
        btnComparativePre.UserData.OriginalPpm = Cut_ppm_axis;
        btnComparativePre.UserData.OriginalData = Cut_1HNMR_Data;
    case 'Norm-2'
        % Norm Normalization 
        Norm_factor = 1./sqrt(sum(WON_1HNMR_Data.^2, 2));
        diag_Norm_factor = diag(Norm_factor);
        Cut_Norm2 = diag_Norm_factor * WON_1HNMR_Data; 
        % Plot the average data
        plot(axPre,Cut_ppm_axis,Cut_Norm2);
        % Add dimensions to the title
        axPre.Title.String = 'Processed ^{1}H-NMR Spectra -2-Norm- ';
        axPre.Title.Color = 'blue';
        % Store data in axPre
        Cut_1HNMR_Data = Cut_Norm2;
        axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Cut_1HNMR_Data);
        % Get the dimensions of the matrix
        [rows, cols] = size(Cut_Norm2);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
        % Store Data in Comparative Treatment Button
        btnComparativePre.UserData.OriginalPpm = Cut_ppm_axis;
        btnComparativePre.UserData.OriginalData = Cut_1HNMR_Data;
    case 'Norm-Ref'
        % Calculate the median of the data
        Med_1HNMR_Data = median(WON_1HNMR_Data);
        % Plot the median data
        plot(axPre,Cut_ppm_axis,Med_1HNMR_Data);
        % Add dimensions to the title
        axPre.Title.String = ['Processed ^{1}H-NMR Spectra -ref-Norm-' ...
            'Matrix Size ='];
        axPre.Title.Color = [0, 0.5, 0];
        % Get the dimensions of the matrix
        [rows, cols] = size(Cut_1HNMR_Data);
        % Add dimensions to the title
        axPre.Title.String = [axPre.Title.String ' (' num2str(rows) ...
            ' x ' num2str(cols) ')'];
        % Store data in axPpre
        axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Cut_1HNMR_Data);
    
end
end
