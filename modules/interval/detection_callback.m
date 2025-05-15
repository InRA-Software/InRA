%%%%%%%%%%%%%%%%%%%%%%%
% Detection Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%
function detection_callback(src, ~, axPre, axInter, ...
    listInter, efLowLim, efHighLim, sThreshold, btnReadyIntervals, OaT, ...
    btnDelete, btnEdit, btnAdd, btnDetectionSettings)

if OaT == 1
% Loading window
fig = ancestor(src, 'figure', 'toplevel');
loadingWindow = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Detecting . . .', 'Indeterminate','on');
end

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Enable Ready Button
btnReadyIntervals.Enable = 'on';

% Mean data to detect peaks
% We remove negative values from mean
Mean_1HNMR_Data = 0.5*(abs(mean(Cut_1HNMR_Data,1))+mean(Cut_1HNMR_Data,1));

% Select bounds depending on the region
if strcmp(listInter.Tag,"Max")
    LowBound = btnReadyIntervals.UserData(3); 
    HighBound = btnReadyIntervals.UserData(4);
    ppmRegion = "R3 - ";
    color1 = [0, 0, 128/255, 0.3]; % azul
    color2 = [0.2, 0, 128/255, 0.3];
elseif strcmp(listInter.Tag,"Min")
    LowBound = btnReadyIntervals.UserData(1); 
    HighBound = btnReadyIntervals.UserData(2);
    ppmRegion = "R1 - ";
    color1 = [128/255, 0, 128/255, 0.3]; %morado
    color2 = [128/255, 0.2, 128/255, 0.3];
else 
    LowBound = btnReadyIntervals.UserData(2);
    HighBound = btnReadyIntervals.UserData(3);
    ppmRegion = "R2 - ";
    color1 = [0, 128/255, 0, 0.3]; % verde
    color2 = [0, 128/255, 0.2, 0.3];
end

% Find indexes for ppm Range
[LowInd, HighInd] = findIndex(LowBound, HighBound, Cut_ppm_axis);

% Define a threshold
peakPct = sThreshold.Value;
threshold = peakPct*(max(Mean_1HNMR_Data(LowInd:HighInd)));

% Detect signals of spectrum
DLH = [btnDetectionSettings.UserData.D, ...
    btnDetectionSettings.UserData.L, btnDetectionSettings.UserData.H];
[~, ~, signalsInd] = signalDetection(Mean_1HNMR_Data(LowInd:HighInd), ...
    Cut_ppm_axis(LowInd:HighInd), threshold, DLH);

% Define a PPM vector of same size as Mean_1HNMR_Data(LowInd:HighInd)
ppm = Cut_ppm_axis(LowInd:HighInd);

% Save found signals
intervals = ppm(signalsInd);

% Create arrays to display in listInterval
nIntervals = (1:size(intervals,1));
IntervalItems = ppmRegion+"Interval "+nIntervals;
% Save them in listInterval
listInter.Items = IntervalItems;
listInter.ItemsData = nIntervals;

% Values to plot intervals regions
xrY1 = min(Cut_1HNMR_Data, [], "all");
xrY2 = max(Cut_1HNMR_Data, [], "all");
xrWidth = intervals(:,2) - intervals(:,1);
xrHeight = xrY2 - xrY1;

% Delete previous intervals regions
% Deleted all rectangles with Tag = Interval + "number"
toBeDeleted = findobj(axInter,'Type','rectangle','-and', ...
    {'-regexp','Tag',ppmRegion+"\w*"});
delete(toBeDeleted)
delete(findobj(axInter, 'Tag','thisLine'));

% Plot interval regions
for k = 1:size(intervals,1)
    xrInter(k) = rectangle(axInter);
    xrInter(k).Position = [intervals(k,1), xrY1, xrWidth(k), xrHeight];
    xrInter(k).EdgeColor = 'none';
    xrInter(k).Tag = IntervalItems(k);
    if mod(k,2)==1
        xrInter(k).FaceColor = color1;
    else
        xrInter(k).FaceColor = color2;
    end
end 

% Plot default selected interval
xrInterDefault = rectangle(axInter);
xrInterDefault.Position = [intervals(1,1), xrY1, xrWidth(1), xrHeight];
xrInterDefault.EdgeColor = 'none';
xrInterDefault.FaceColor = [1 0 0 0.3]; % red
xrInterDefault.Tag = "thisLine";

% Default Edit Field Values
efLowLim.Value = intervals(1,1);
efHighLim.Value = intervals(1,2);
% Default List Value
listInter.Value = 1;

% Store ppm data in listInterval object
listInter.UserData = intervals;

% Enable buttons to Delete, Edit or Add intervals
btnDelete.Enable = "on"; 
btnEdit.Enable = "on";
btnAdd.Enable = "on";

if OaT == 1
% Close loading windows and delete corresponding object
close(loadingWindow)
delete(loadingWindow)
end

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

