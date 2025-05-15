%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delete Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function deleteOther_callback(src, ~, sFirstPPM, sLastPPM, axPre)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Select Tolerance 
tolerance = 0.001;
% Revisar restricciones. Recordar caso de 5 a 6 que no borro.
% Find first index
firstId = find(Cut_ppm_axis >= sFirstPPM.Value & ...
    Cut_ppm_axis < (sFirstPPM.Value + tolerance), 1, 'first');
% Find last index
lastId = find(Cut_ppm_axis >= sLastPPM.Value & ...
    Cut_ppm_axis < (sLastPPM.Value + tolerance), 1, 'last');
% Delete ppm region
Cut_ppm_axis(firstId:lastId) = [];
Cut_1HNMR_Data(:,firstId:lastId) = []; 

plot(axPre,Cut_ppm_axis,Cut_1HNMR_Data);
% Get the dimensions of the matrix
        [rows, cols] = size(Cut_1HNMR_Data);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');

% Store data in axPre
axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Cut_1HNMR_Data);
end