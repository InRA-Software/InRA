%%%%%%%%%%%%%%%%%%%%%%%%%%%
% View Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function viewOtherRange_callback(src, ~, sFirstRange, sLastRange, axPre)
    % Recover data in axPre
    data = axPre.UserData;
    ppm_axis = data.CutPpm;

    % Recover values from the selected ppm range
    RangefirstPPM = sFirstRange.Value;
    RangelastPPM = sLastRange.Value;

    [firstIdRange, lastIdRange] = findIndex(RangefirstPPM, ...
        RangelastPPM, ppm_axis);

    % Delete previous selected range
    delete(findobj(axPre,  'Tag', 'FirstRangeLine'));
    delete(findobj(axPre,  'Tag', 'LastRangeLine'));

    % Plot lines on the selected range
    xline(axPre, ppm_axis(firstIdRange), 'Tag', 'FirstRangeLine', ...
        'Color', [0.8, 0.6, 0.6])
    xline(axPre, ppm_axis(lastIdRange), 'Tag', 'LastRangeLine', ...
        'Color', [0.8, 0.6, 0.6])


end

function [firstInd, lastInd] = findIndex(firstPPM, lastPPM, ppmVector)

% Counting digits after dot
strPPM = num2str(firstPPM);
dot_pos = find(strPPM == '.');
numDeci = length(strPPM) - dot_pos;

% Tolerance to find index
tolerance = 6*10^(-numDeci);

% Find first index
firstInd = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + tolerance), 1, 'first');
% Find last index
lastInd = find(ppmVector >= lastPPM & ...
    ppmVector < (lastPPM + tolerance), 1, 'first');

end


