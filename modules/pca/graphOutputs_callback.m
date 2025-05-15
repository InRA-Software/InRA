function graphOutputs_callback(~, event, axVariance, listComponentST)

explained_variance = axVariance.UserData.explained_variance;
cumulative_variance = axVariance.UserData.cumulative_variance;
rmsec_values = axVariance.UserData.rmsec_values;
rmsecv_values = axVariance.UserData.rmsecv_values;
numComponents = axVariance.UserData.numComponents;

% Clean axes
cla(axVariance);
axVariance.Subtitle.String = "";
% Deactivate legend
legend(axVariance, 'off');
if strcmp(axVariance.XAxis.Direction, 'reverse')
    axVariance.XAxis.Direction = 'normal';
end

switch event.NewValue.Text
case "Explained Variance"
        listComponentST.Enable = "off";
        % Plot Explained Variance
        plot(axVariance, explained_variance(1:numComponents,:),'o-', ...
            'LineWidth', 2);
        title(axVariance, 'Explained Variance vs Number of PCs', ...
            'FontSize', 12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'Explained Variance (%)');
        axVariance.XLim = [1, numComponents];
        grid (axVariance,'on');
%%%%%%%%%%%%%%%%%%%%%%%
% Cumulative Variance %
%%%%%%%%%%%%%%%%%%%%%%%
    case "Cumulative Variance"
        listComponentST.Enable = "off";
        % Plot Cumulative Variance
        plot(axVariance, cumulative_variance(1:numComponents,:),'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        title(axVariance, 'Cumulative Variance vs Number of PCs', ...
            'FontSize', 12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'Cumulative Variance (%)');
        axVariance.XLim = [1, numComponents];
        grid (axVariance,'on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cross-Validation by Venetian-Blinds %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case "RMSEC/RMSECV"
        listComponentST.Enable = "off";

        % Plot RMSEC and RMSECV 
        plot(axVariance, 1:numComponents, rmsec_values,'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        hold(axVariance,'on');
        plot(axVariance, 1:numComponents, rmsecv_values,'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        title(axVariance, 'RMSEC/RMSECV vs Number of PCs', 'FontSize', ...
            12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'RMSEC and RMSECV');
        axVariance.XLim = [1, numComponents];
        grid (axVariance,'on');
        hold(axVariance,'off');

%%%%%%%%%%%%%%%
% Resolved ST %
%%%%%%%%%%%%%%%      
    case "Resolved ST"
        listComponentST.Enable = "on";
        if strcmp(axVariance.XAxis.Direction, 'normal')
            axVariance.XAxis.Direction = 'reverse';
        end

        axVariance.Title.String = "Resolved Spectral Profile S^{T}";
        axVariance.Subtitle.String = "Region (1/2/3) - Interval X";
        axVariance.XLabel.String = "δ^{1}H (ppm)";
        axVariance.YLabel.String = "Intensity";
end

end