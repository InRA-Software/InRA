%%%%%%%%%%%%%%%%%%%%%%%%%%%
% View Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function viewOther_callback(src, ~, sFirstPPM, sLastPPM, axPre)

% Recover data in axPre
data = axPre.UserData;
ppm_axis = data.CutPpm;

% Recover values from the selected ppm range
firstPPM = sFirstPPM.Value;
lastPPM = sLastPPM.Value;

% Find indices of the selected range
firstId = find(ppm_axis >= firstPPM & ppm_axis < (firstPPM + 0.01), ...
    1, 'first');
lastId = find(ppm_axis >= lastPPM & ppm_axis < (lastPPM + 0.01), 1, ...
    'last');

% Current axis limits
xLimits = xlim(axPre);
yLimits = ylim(axPre);

% Delete previous selected range
delete(findobj(axPre, 'Type', 'rectangle'));

% Alpha value to control transparency 
alpha = 0.5; 

% Plot area on the selected range
 rectangle(axPre, 'Position', [ppm_axis(firstId), yLimits(1), ...
     ppm_axis(lastId) - ppm_axis(firstId), yLimits(2) - yLimits(1)], ...
     'FaceColor', [0.8, 0.6, 0.6, alpha], 'EdgeColor', 'none');
end
