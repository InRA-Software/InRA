%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualization Options Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ddRawVisualization_callback(src, ~,axRaw, btnApplyVis, ...
    btnDeleteVis, listSample)
% Recover data in btnApplyVis
data = btnApplyVis.UserData;
Raw_ppm_axis = data.ppm;
Raw_1HNMR_Data = data.RawData;

% Get the dimensions of the matrix
[rows, cols] = size(Raw_1HNMR_Data);

% Calculate the remaining samples
deletedRows = size(btnDeleteVis.UserData,1);
showRows = rows-deletedRows;

switch src.Value
    case 'Overlay'
        % Plot the Raw data
        plot(axRaw,Raw_ppm_axis,Raw_1HNMR_Data);
        % Add dimensions to the title
        axRaw.Title.String = '^{1}H-NMR Spectra -Overlay-';
        axRaw.Title.Color = 'blue';
        % Add dimensions to the title
        text(axRaw, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(showRows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
    case 'Average'
        % Calculate the average of the data
        Avg_1HNMR_Data = mean(Raw_1HNMR_Data);
        % Plot the average data
        plot(axRaw,Raw_ppm_axis,Avg_1HNMR_Data);
        % Add dimensions to the title
        axRaw.Title.String = '^{1}H-NMR Spectra -Average-';
        % Add dimensions to the title
        text(axRaw, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(showRows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
        listSample.Value = 0;
    case 'Median'
        % Calculate the median of the data
        Med_1HNMR_Data = median(Raw_1HNMR_Data);
        % Plot the median data
        plot(axRaw,Raw_ppm_axis,Med_1HNMR_Data);
        % Add dimensions to the title
        axRaw.Title.String = '^{1}H-NMR Spectra -Median-';
        % Add dimensions to the title
        text(axRaw, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(showRows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k'); 
        listSample.Value = 0;
end
end
