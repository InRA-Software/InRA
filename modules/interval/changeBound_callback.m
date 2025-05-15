function changeBound_callback(src, ~, axPre, btnReadyIntervals, ...
    pRangeMax, pRangeMdd, pRangeMin)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;
regions = btnReadyIntervals.UserData;

% Create figure window
figEditBound = uifigure('Name', 'Change Bound');
figEditBound.WindowStyle = 'modal';
figEditBound.Resize = 'on';

gfigEdit = uigridlayout(figEditBound);
gfigEdit.RowHeight = {'fit','1x', 'fit'};
gfigEdit.ColumnWidth = {'1x', '1x', '1x'};

% Select bounds depending on the region
if strcmp(src.Tag,"Max")
    regionBound = regions(3); % Default is 6.0 ppm
    regionTag = "Max";
else 
    regionBound = regions(2); % Default is 3.0 ppm
    regionTag = "Mid";
end

%%%%%%%%%%%%%%%%
% axEdit Bound %
%%%%%%%%%%%%%%%%
% Create
axEdit = uiaxes(gfigEdit);
% Positions
axEdit.Layout.Row = 1;
axEdit.Layout.Column = [1 3];
% Style
% Axes Interval
axEdit.XDir = 'reverse';
axEdit.XLabel.String = 'δ^{1}H (ppm)';
axEdit.YLabel.String = 'Intensity';
axEdit.XLim = [regionBound-0.2, regionBound+0.2];

% Plot the data
plot(axEdit, Cut_ppm_axis, Cut_1HNMR_Data);
axis(axEdit, 'manual');

% Plot bound line
xl = xline(axEdit, regionBound);
xl.Color = [1 0 0]; % red

%%%%%%%%%%%
% Sliders %
%%%%%%%%%%%
% Create
sldBound = uislider(gfigEdit);
% Positions
sldBound.Layout.Row = 3;
sldBound.Layout.Column = [1 3];
% Style
sldBound.Limits = [regionBound-0.2, regionBound+0.2];
sldBound.MajorTicks = linspace(min(sldBound.Limits), max(sldBound.Limits), 8);
sldBound.MajorTickLabels = string(flip(sldBound.MajorTicks));
sldBound.Value = regionBound;
sldBound.Tag = regionTag;
%%%%%%%%%%%%%%%
% Edit Fields %
%%%%%%%%%%%%%%%
% Create
efBound = uieditfield(gfigEdit,"numeric");
% Positions
efBound.Layout.Row = 2;
efBound.Layout.Column = 3;
% Style
efBound.Value = sldBound.Value;

%%%%%%%%%%%%%%%%%%%%%%%%
% Apply Changes Button %
%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnApplyChanges = uibutton(gfigEdit);
% Positions
btnApplyChanges.Layout.Row = 2;
btnApplyChanges.Layout.Column = 2;
% Style
btnApplyChanges.Text = 'Apply Changes';
% Default Behaviour
btnApplyChanges.Enable = 'off';
% User's Data
btnApplyChanges.UserData = regions;

%%%%%%%%%%%%%%
% Behaviours %
%%%%%%%%%%%%%%
% Sliders
sldBound.ValueChangingFcn = {@updateBound, xl, btnApplyChanges, ...
    efBound};

% Apply Changes Button
btnApplyChanges.ButtonPushedFcn = {@applyChanges, efBound, ...
    btnReadyIntervals, regionTag, pRangeMax, pRangeMdd, pRangeMin};

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Low Bound Callback %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateBound(src, event, xl, btnApplyChanges, efBound)
% Reverse the slider values.
% Initially, was written like this: 
% max(src.Limits) - event.Value + min(src.Limits)
% It's the same logic for the other callbacks
auxLimits = sum(src.Limits);
valBound = auxLimits - event.Value;

% Plot selection interval
xl.Value = valBound;

% Select bounds depending on the region
if strcmp(src.Tag,"Max")
    btnApplyChanges.UserData(3) = valBound; % Default is 6.0 ppm
else 
    btnApplyChanges.UserData(2) = valBound; % Default is 3.0 ppm
end

btnApplyChanges.Enable = 'on';
efBound.Value = valBound;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply Changes Callback %
%%%%%%%%%%%%%%%%%%%%%%%%%%
function applyChanges(src, ~, efBound, btnReadyIntervals, regionTag, ...
    pRangeMax, pRangeMdd, pRangeMin) 

% Select bounds depending on the region
if strcmp(regionTag,"Max")
    btnReadyIntervals.UserData(3) = efBound.Value; % Default is 6.0 ppm
else 
    btnReadyIntervals.UserData(2) = efBound.Value; % Default is 3.0 ppm
end


% Refresh Region Panel Titles
pRangeMax.Title = "High Frequencies (Downfield Shift): δ " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(4)) + " - " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(3)) + " ppm";
pRangeMdd.Title = "Medium Frequencies: δ " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(3)) + " - " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(2)) + " ppm";
pRangeMin.Title = "Low Frequencies (Upfield Shift): δ " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(2)) + " - " + ...
    sprintf('%0.1f', btnReadyIntervals.UserData(1)) + " ppm";

% Disable Apply Changes Button
src.Enable = 'off';

% Close windows after apply changes
fig = ancestor(src, 'figure', 'toplevel');
delete(fig)
end
