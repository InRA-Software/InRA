function zoomRegion_callback(src, ~, axInter, axPre, btnReadyIntervals)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Select bounds depending on the region
if strcmp(src.Tag,"Max")
    LowBound = btnReadyIntervals.UserData(3);
    HighBound = btnReadyIntervals.UserData(4);
elseif strcmp(src.Tag,"Min")
    LowBound = btnReadyIntervals.UserData(1); 
    HighBound = btnReadyIntervals.UserData(2);
else 
    LowBound = btnReadyIntervals.UserData(2);
    HighBound = btnReadyIntervals.UserData(3);
end

% Find indexes for ppm Range
[LowInd, HighInd] = findIndex(LowBound, HighBound, Cut_ppm_axis);

% X Lim for Plot
xLowLim = min(Cut_ppm_axis(LowInd:HighInd), [], "all");
xHighLim = max(Cut_ppm_axis(LowInd:HighInd), [], "all");

% Y Lim for Plot
yLowLim = min(Cut_1HNMR_Data(:,LowInd:HighInd), [], "all");
yHighLim = max(Cut_1HNMR_Data(:,LowInd:HighInd), [], "all");

% Set XLim and YLim
axInter.XLim = [xLowLim, xHighLim];
axInter.YLim = [yLowLim, yHighLim];

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