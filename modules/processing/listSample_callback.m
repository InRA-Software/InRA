%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample List Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%
function listSample_callback(src, event, axRaw, btnApplyVis, ...
    btnDeleteVis, ddVisualization)
% Recover data in btnApplyVis
data = btnApplyVis.UserData;
Raw_ppm_axis = data.ppm;
Raw_1HNMR_Data = data.RawData;

% Enable exclude Sample Button and Visualization Modes Droplist
btnDeleteVis.Enable = 'on';
ddVisualization.Enable = 'on';

% Calculate the samples to plot
totalSamples = transpose(1:size(Raw_1HNMR_Data,1));
deletedSamples = btnDeleteVis.UserData;
showSamples = setdiff(totalSamples, deletedSamples);

if event.Value==0
% If is selected All
    btnDeleteVis.Enable = 'off';
    if strcmp(src.Items(1), 'None')
        % In case there are no samples left
        ddVisualization.Enable = 'off';
    else
        % Plot all non-excluded samples
        plot(axRaw, Raw_ppm_axis, Raw_1HNMR_Data(showSamples,:))
        axRaw.Title.String = '^{1}H-NMR Spectra -Overlay-';
        % Get columns' number of matrix
        cols = size(Raw_1HNMR_Data,2);
        % Add dimensions to the title
        text(axRaw, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(size(showSamples,1)) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');
    end
else
    ddVisualization.Value = 'Overlay';
    axRaw.Title.String = '^{1}H-NMR Spectra -Overlay-';
    % Plot the sample selected by user
    if ~strcmp(src.Items(event.Value+1), '__Excluded__')
        plot(axRaw, Raw_ppm_axis, Raw_1HNMR_Data(event.Value,:));
    else
        % Disable Exclude Sample Button if a excluded samples is selected
        btnDeleteVis.Enable = 'off';
        if strcmp(src.Items(1), 'None')
        % In case there are no samples left
            ddVisualization.Enable = 'off';
        end
    end
end

end

