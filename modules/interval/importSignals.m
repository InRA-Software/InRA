function importSignals(~, ~, efInterLimMin, efInterLimMax, ...
    axInter, listInterval, btnMCRBuildMod, btnReadyIntervals)

intervals = evalin('base','signals');

% Create arrays with founds signals
nIntervals = (1:size(intervals,1));
IntervalItems = "Interval "+nIntervals;

listInterval.Items = IntervalItems;
listInterval.ItemsData = nIntervals;

% Plot interval regions
xrInter = xregion(axInter, intervals);

% Tag each interval region
for k = 1:size(intervals,1)
    xrInter(k).Tag = "Interval " + num2str(k);
end

for i=1:size(intervals,1)*0.5
    xrInter(2*i-1).FaceColor = "blue";
    xrInter(2*i).FaceColor = "magenta";
end
if mod(size(intervals,1),2)==1
    xrInter(2*i+1).FaceColor = "blue";
end

% Plot default selected range
xrInterDefault = xregion(axInter, intervals(1,:));
xrInterDefault.Tag = "thisLine";
% Default Edit Field Values
efInterLimMin.Value = intervals(1,1);
efInterLimMax.Value = intervals(1,2);
% Default List Value
listInterval.Value = 1;

% Store ppm data in listInterval object
listInterval.UserData = intervals;

% Enable Build MCR Model 
btnMCRBuildMod.Enable = 'on';

% Enable Ready Button
btnReadyIntervals.Enable = 'on';

end

