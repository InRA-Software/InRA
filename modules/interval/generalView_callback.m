function generalView_callback(~, ~, axInter)

% Set XLim and YLim
axInter.XLim = [axInter.UserData(1,1), axInter.UserData(1,2)];
axInter.YLim = [axInter.UserData(2,1), axInter.UserData(2,2)];

end

%%

function [firstInd, lastInd] = findIndex(firstPPM, lastPPM, ppmVector)

% Find first index
firstInd = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + 0.01), 1, 'first');
% Find last index
lastInd = find(ppmVector >= lastPPM & ...
    ppmVector < (lastPPM + 0.01), 1, 'last');

end