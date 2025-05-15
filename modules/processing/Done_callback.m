%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Done Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Done_callback(src, ~, axInter, axPre, btnReadyIntervals, ...
    pRangeMax, pRangeMdd, pRangeMin, ddNormalization, ...
    btnAutoDetection, btnZoomInterRngMax, btnDetectionMax, ...
    btnZoomInterRngMdd, btnDetectionMdd, btnZoomInterRngMin, ...
    btnDetectionMin, btnChangeMaxBound, btnChangeMddBound, ...
    btnGeneralView, listInterRngMax, listInterRngMdd, listInterRngMin, ...
    btnDelInterRngMax, btnEditInterRngMax, btnNewInterRngMax, ...
    btnDelInterRngMdd, btnEditInterRngMdd, btnNewInterRngMdd, ...
    btnDelInterRngMin, btnEditInterRngMin, btnNewInterRngMin, ...
    btnExportIntervals, btnDetectionSettings)

% Enable buttons and options in Interval-Based Detection tab
btnAutoDetection.Enable = "on";
btnDetectionSettings.Enable = "on";
btnZoomInterRngMax.Enable = "on";
btnDetectionMax.Enable = "on";
btnZoomInterRngMdd.Enable = "on";
btnDetectionMdd.Enable = "on";
btnZoomInterRngMin.Enable = "on";
btnDetectionMin.Enable = "on";
btnChangeMaxBound.Enable = "on";
btnChangeMddBound.Enable = "on";
btnGeneralView.Enable = "on";
% Disable Delete, Edit, Add and Proceed buttons in Interval-Based Detection tab
btnDelInterRngMax.Enable = "off";
btnEditInterRngMax.Enable = "off";
btnNewInterRngMax.Enable = "off";
btnDelInterRngMdd.Enable = "off";
btnEditInterRngMdd.Enable = "off";
btnNewInterRngMdd.Enable = "off";
btnDelInterRngMin.Enable = "off";
btnEditInterRngMin.Enable = "off";
btnNewInterRngMin.Enable = "off";
btnReadyIntervals.Enable = "off";
btnExportIntervals.Enable = "off";

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Plot the data 
plot(axInter, Cut_ppm_axis, Cut_1HNMR_Data);
axInter.Title.String = "Processed ^{1}H-NMR Spectra -"+...
    ddNormalization.Value+"-";
axInter.Title.Color = [0, 0.5, 0];

% Automatically scale the axis to the selected range 
axInter.XLim = [min(Cut_ppm_axis, [], "all"), max(Cut_ppm_axis, [], "all")];
axInter.YLim = [min(Cut_1HNMR_Data, [], "all"), max(Cut_1HNMR_Data, [], "all")];
% Set scale
axInter.UserData = [axInter.XLim; axInter.YLim];

% Default region bounds
higherRegionBound = max(Cut_ppm_axis, [], "all");
midRegionBounds = [3, 6];
lowerRegionBound = min(Cut_ppm_axis, [], "all");

% Store region bounds in Detection Buttons
btnReadyIntervals.UserData = [lowerRegionBound, ...
    midRegionBounds, higherRegionBound];

% Refresh Region Panel Titles
pRangeMax.Title = "High Frequencies (Downfield Shift): δ " + ...
    sprintf('%0.1f',higherRegionBound) + " - " + ...
    sprintf('%0.1f',midRegionBounds(2)) + " ppm";
pRangeMdd.Title = "Medium Frequencies: δ " + ...
    sprintf('%0.1f',midRegionBounds(2)) + " - " + ...
    sprintf('%0.1f',midRegionBounds(1)) + " ppm";
pRangeMin.Title = "Low Frequencies (Upfield Shift): δ " + ...
    sprintf('%0.1f',midRegionBounds(1)) + " - " + ...
    sprintf('%0.1f',lowerRegionBound) + " ppm";

% Delete previous data of detected intervals
listInterRngMax.UserData = [];
listInterRngMax.Items = "None";
listInterRngMax.ItemsData = [];

listInterRngMdd.UserData = [];
listInterRngMdd.Items = "None";
listInterRngMdd.ItemsData = [];

listInterRngMin.UserData = [];
listInterRngMin.Items = "None";
listInterRngMin.ItemsData = [];
end

