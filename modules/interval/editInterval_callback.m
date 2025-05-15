function editInterval_callback(~, ~, axPre, listInter, axInter, ...
    efLowLim, efHighLim)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Recover data in listInterval
intervals = listInter.UserData;

% Create figure window
figEditInterval = uifigure('Name', 'Edit Interval');
figEditInterval.WindowStyle = 'modal';
figEditInterval.Resize = 'on';

gfigEdit = uigridlayout(figEditInterval);
gfigEdit.RowHeight = {'fit','1x', '1x', '1x'};
gfigEdit.ColumnWidth = {'1x', '1x', '1x'};

%%%%%%%%%%%%%%%%%%%
% axEdit Interval %
%%%%%%%%%%%%%%%%%%%
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
axEdit.XLim = [intervals(listInter.Value,1)-0.07 ...
    intervals(listInter.Value,2)+0.07];

% Plot the data
plot(axEdit, Cut_ppm_axis, Cut_1HNMR_Data);
axis(axEdit, 'manual');

% Values to plot intervals regions
xrY1 = axInter.UserData(2,1);
xrY2 = axInter.UserData(2,2);
xrWidth = intervals(:,2) - intervals(:,1);
xrHeight = xrY2 - xrY1;

% Select colors depending on the region
if strcmp(listInter.Tag,"Max")
    ppmRegion = "R3 - ";
    color1 = [0, 0, 128/255, 0.3]; % azul
    color2 = [0.2, 0, 128/255, 0.3];
elseif strcmp(listInter.Tag,"Min")
    ppmRegion = "R1 - ";
    color1 = [128/255, 0, 128/255, 0.3]; %morado
    color2 = [128/255, 0.2, 128/255, 0.3];
else 
    ppmRegion = "R2 - ";
    color1 = [0, 128/255, 0, 0.3]; % verde
    color2 = [0, 128/255, 0.2, 0.3];
end

% Plot intervals region
for k = 1:size(intervals,1)
    xrInter(k) = rectangle(axEdit);
    xrInter(k).Position = [intervals(k,1), xrY1, xrWidth(k), xrHeight];
    xrInter(k).EdgeColor = 'none';
    if mod(k,2)==1
        xrInter(k).FaceColor = color1;
    else
        xrInter(k).FaceColor = color2;
    end
end 

% Hide interval region selected to show de variable interval selected
xrInter(listInter.Value).Visible = 'off';

% Plot selection interval
xr = rectangle(axEdit);
xr.Position = [intervals(listInter.Value,1), xrY1, ...
    intervals(listInter.Value,2) - intervals(listInter.Value,1), xrHeight];
xr.EdgeColor = 'none';
xr.FaceColor = [1 0 0 0.3]; % red

% Store xrY1 and xrY2 in xr.UserData
xr.UserData = [xrY1, xrY2];

%%%%%%%%%%%
% Sliders %
%%%%%%%%%%%
% Create
sldLow = uislider(gfigEdit);
sldHigh = uislider(gfigEdit);
% Positions
sldLow.Layout.Row = 3;
sldLow.Layout.Column = [1 3];
%
sldHigh.Layout.Row = 4;
sldHigh.Layout.Column = [1 3];
% Style
sldLow.Limits = [intervals(listInter.Value,1)-0.26 ...
    intervals(listInter.Value,2)+0.26];
sldLow.MajorTicks = linspace(min(sldLow.Limits), max(sldLow.Limits), 8);
sldLow.MajorTickLabels = string(flip(sldLow.MajorTicks));
sldLow.Value = intervals(listInter.Value, 2);
%{
Internally, the numerical values of sldLow are the high ones, and those of 
sldHigh are the low ones.
The magic is in the callback functions.
%}
sldHigh.Limits = sldLow.Limits;
sldHigh.MajorTicks = sldLow.MajorTicks;
sldHigh.MajorTickLabels = sldLow.MajorTickLabels;
sldHigh.Value = intervals(listInter.Value, 1);

%%%%%%%%%%%%%%%
% Edit Fields %
%%%%%%%%%%%%%%%
% Create
efLow = uieditfield(gfigEdit,"numeric");
efHigh = uieditfield(gfigEdit,"numeric");
% Positions
efLow.Layout.Row = 2;
efLow.Layout.Column = 3;
%
efHigh.Layout.Row = 2;
efHigh.Layout.Column = 1;
% Style
efLow.Value = sldHigh.Value;
efHigh.Value = sldLow.Value;

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
btnApplyChanges.UserData = ppmRegion;

%%%%%%%%%%%%%%
% Behaviours %
%%%%%%%%%%%%%%
% Sliders
sldLow.ValueChangingFcn = {@updateRangeL, xr, btnApplyChanges, efLow, ...
    sldHigh};
sldHigh.ValueChangingFcn = {@updateRangeH, xr, btnApplyChanges, efHigh, ...
    sldLow};

% Apply Changes Button
btnApplyChanges.ButtonPushedFcn = {@applyChanges, sldLow, sldHigh, ...
    listInter, axInter, efLowLim, efHighLim};

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Low Bound Callback %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateRangeL(src, event, xr, btnApplyChanges, efLow, sldHigh)
% Reverse the slider values.
% Initially, was written like this: 
% max(src.Limits) - event.Value + min(src.Limits)
% It's the same logic for the other callbacks
auxLimits = sum(src.Limits);
valLow = auxLimits - event.Value;
valHigh = auxLimits - sldHigh.Value;

% Recover data in xr.UserData
xrY1 = xr.UserData(1);
xrY2 = xr.UserData(2);
xrHeight = xrY2 - xrY1;

try
    % Plot selection interval
    xr.Position = [valLow, xrY1, ...
        valHigh - valLow, xrHeight];

    % Check if the lower slider is to close to the higher slider
    if abs(event.Value-sldHigh.Value) <= 0.001
        sldHigh.Value = sldHigh.Value - 0.02;
    end
catch ME
    % Error alert
    fig = ancestor(src, 'figure', 'toplevel');
    uialert(fig, "Exceeded the higher limit."+newline+newline+ ...
        "Close the Edit Interval window and try again.", "Error", ...
        "CloseFcn", {@closereq, fig});
end

btnApplyChanges.Enable = 'on';
efLow.Value = valLow;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update High Bound Callback %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateRangeH(src, event, xr, btnApplyChanges, efHigh, sldLow)
% Reverse the sliders values
auxLimits = sum(src.Limits);
valLow = auxLimits - sldLow.Value;
valHigh = auxLimits - event.Value;

% Recover data in xr.UserData
xrY1 = xr.UserData(1);
xrY2 = xr.UserData(2);
xrHeight = xrY2 - xrY1;

try
    % Plot selection interval
    xr.Position = [valLow, xrY1, ...
        valHigh - valLow, xrHeight];

    % Check if the lower slider is to close to the lower slider
    if abs(event.Value-sldLow.Value) <= 0.001
        sldLow.Value = sldLow.Value + 0.02;
    end
catch ME
    % Error alert
    fig = ancestor(src, 'figure', 'toplevel');
    uialert(fig, "Exceeded the higher limit."+newline+newline+ ...
        "Close the Edit Interval window and try again.", "Error", ...
        "CloseFcn", {@closereq, fig});
end

btnApplyChanges.Enable = 'on';
efHigh.Value = valHigh;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply Changes Callback %
%%%%%%%%%%%%%%%%%%%%%%%%%%
function applyChanges(src, ~, sldLow, sldHigh, listInterval, axInter, ...
    efLowLim, efHighLim) 
% Recover data in listInterval
intervals = listInterval.UserData;
% Recover data in btnApplyChanges
ppmRegion = src.UserData;

% Reverse the sliders values
auxLimits = sum(sldLow.Limits);
valLow = auxLimits - sldLow.Value;
valHigh = auxLimits - sldHigh.Value;

% Save User's changes
intervals(listInterval.Value,:) = [valLow valHigh];

% Update Interval Limits Edit Fields
efLowLim.Value = intervals(listInterval.Value,1);
efHighLim.Value = intervals(listInterval.Value,2);

% Values to plot Selected Region
xrY1 = axInter.UserData(2,1);
xrY2 = axInter.UserData(2,2);
xrWidth = intervals(listInterval.Value,2) - intervals(listInterval.Value,1);
xrHeight = xrY2 - xrY1;

% Update Selected Region
xrSelected =  findobj(axInter, 'Tag', 'thisLine');
xrSelected.Position = [intervals(listInterval.Value,1), xrY1, ...
    xrWidth, xrHeight];

% Plot
xr = findobj(axInter,'Type','rectangle','-and', ...
    {'Tag',ppmRegion+"Interval "+num2str(listInterval.Value)});
xr.Position = [intervals(listInterval.Value,1), xrY1, ...
    xrWidth, xrHeight];

% Store ppm data in listInterval object
listInterval.UserData = intervals;

% Disable Apply Changes Button
src.Enable = 'off';

end

% Close de Edit Interval windows when Error Window is closed
function closereq(~, ~, fig)
    delete(fig)
end