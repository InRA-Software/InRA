%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function AddOtherSignal_callback(src, ~, sFirstPPM, sLastPPM, axPre)
fig = ancestor(src,"figure","toplevel");

% Recover data in figure
data = fig.UserData;
ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Recover values from the selected ppm range
firstPPM = sFirstPPM.Value;
lastPPM = sLastPPM.Value;

% Select Tolerance 
tolerance = 0.001;

% Find indices of the selected range
firstId = find(ppm_axis >= firstPPM & ppm_axis < (firstPPM + ...
    tolerance), 1, 'first');
lastId = find(ppm_axis >= lastPPM & ppm_axis < (lastPPM + tolerance), ...
    1,'last');

 % Current axis limits
    yLimits = ylim(axPre);

    % Get existing rectangles' positions
    existingRectPositions = [];
    existingRectangles = findobj(axPre, 'Type', 'rectangle');
    for i = 1:numel(existingRectangles)
        existingRectPositions = [existingRectPositions; 
            existingRectangles(i).Position];
    end

    % Delete previous selected ranges
    delete(existingRectangles);

    % Alpha value to control transparency 
    alpha = 0.5;

    % Plot existing rectangles
    for i = 1:size(existingRectPositions, 1)
        rectangle(axPre, 'Position', existingRectPositions(i, :), ...
            'FaceColor', [0.8, 0.6, 0.6, alpha], 'EdgeColor', 'none');
    end

    % Plot area on the selected range, maintaining x position
    rectangle(axPre, 'Position', [ppm_axis(firstId), yLimits(1), ...
        ppm_axis(lastId) - ppm_axis(firstId), yLimits(2) - yLimits(1)], ...
        'FaceColor', [0.8, 0.6, 0.6, alpha], 'EdgeColor', 'none');
end