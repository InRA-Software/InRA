%%%%
% Interval Layout
%%%%
% Manage app layout
glInterval = uigridlayout(tabInterval,[2,4]);
glInterval.RowHeight = {280, 280};
glInterval.ColumnWidth = {90, 350, 350, 350};
%%
%%%%%%%%%%%%%%
% axInterval %
%%%%%%%%%%%%%%
% Create
axInter = uiaxes(glInterval);
% Positions
axInter.Layout.Row = 1;
axInter.Layout.Column = [1 4];
% Style
% Axes Interval
axInter.InnerPosition = [0 0 1 1];
axInter.XDir = 'reverse';
axInter.XLabel.String = 'δ^{1}H (ppm)';
axInter.YLabel.String = 'Intensity';
axInter.XLim = [0 9.5];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interval General Options %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
glGenOpt = uigridlayout(glInterval, [8 1]);
glGenOpt.RowHeight = {"fit", "fit", "1x", "fit", "fit", "1x", ...
    "fit", "1x"};
glGenOpt.Layout.Row = 2;
glGenOpt.Layout.Column = 1;
%---------------
% Auto Detection Label
%---------------
% Create
lblAutoDetection = uilabel(glGenOpt);
% Position
lblAutoDetection.Layout.Row = 1;
lblAutoDetection.Layout.Column = 1;
% Style
lblAutoDetection.Text = "Signal"+newline+"Recognition";
lblAutoDetection.HorizontalAlignment = "center";
lblAutoDetection.FontSize = 10;
lblAutoDetection.FontWeight = "bold";
lblAutoDetection.FontColor = [0.5, 0.2, 0.5];
%---------------
% Auto Detection Button
%---------------
% Create
btnAutoDetection = uibutton(glGenOpt);
% Position
btnAutoDetection.Layout.Row = 2;
btnAutoDetection.Layout.Column = 1;
% Style
btnAutoDetection.Text = 'Detect';
btnAutoDetection.BackgroundColor = [0.7 0.5 1];
btnAutoDetection.FontWeight = 'bold';
btnAutoDetection.Enable = 'off';
%---------------
% Settings Button
%---------------
% Create
btnDetectionSettings = uibutton(glGenOpt);
% Position
btnDetectionSettings.Layout.Row = 3;
btnDetectionSettings.Layout.Column = 1;
% Style
btnDetectionSettings.Text = 'Settings';
%btnDetectionSettings.BackgroundColor = [0.7 0.5 1];
btnDetectionSettings.FontWeight = 'bold';
btnDetectionSettings.Enable = 'off';
btnDetectionSettings.UserData.D = 0.01;
btnDetectionSettings.UserData.L = 0.03;
btnDetectionSettings.UserData.H = 0.005;
%-----------------
% Visualization Label
%-----------------
% Create
lblVisualization = uilabel(glGenOpt);
% Position
lblVisualization.Layout.Row = 4;
lblVisualization.Layout.Column = 1;
% Style
lblVisualization.Text = "Visualization";
lblVisualization.HorizontalAlignment = "center";
lblVisualization.FontSize = 9.5;
lblVisualization.FontWeight = "bold";
%---------------
% General View Button
%---------------
% Create
btnGeneralView = uibutton(glGenOpt);
% Position
btnGeneralView.Layout.Row = 5;
btnGeneralView.Layout.Column = 1;
% Style
btnGeneralView.Text = 'General View';
btnGeneralView.Enable = 'off';
btnGeneralView.FontWeight = 'bold';
btnGeneralView.FontSize = 9;
%-----------------
% Ready Intervals Label
%-----------------
% Create
lblReadyIntervals = uilabel(glGenOpt);
% Position
lblReadyIntervals.Layout.Row = 6;
lblReadyIntervals.Layout.Column = 1;
% Style
lblReadyIntervals.Text = "Decomposition";
lblReadyIntervals.HorizontalAlignment = "center";
lblReadyIntervals.FontSize = 9.5;
lblReadyIntervals.FontWeight = "bold";
lblReadyIntervals.FontColor = [0.5, 0.2, 0];
%---------------
% Ready Intervals Button
%---------------
% Create
btnReadyIntervals = uibutton(glGenOpt);
% Position
btnReadyIntervals.Layout.Row = 7;
btnReadyIntervals.Layout.Column = 1;
% Style
btnReadyIntervals.Text = 'Proceed!';
btnReadyIntervals.Enable = 'off';
btnReadyIntervals.BackgroundColor = [0.8, 0.5, 0.3];
btnReadyIntervals.FontWeight = 'bold';
%---------------
% Export Intervals Button
%---------------
% Create
btnExportIntervals = uibutton(glGenOpt);
% Position
btnExportIntervals.Layout.Row = 8;
btnExportIntervals.Layout.Column = 1;
% Style
btnExportIntervals.Text = "Export"+newline+"Intervals";
btnExportIntervals.Enable = 'off';
btnExportIntervals.FontWeight = 'bold';
btnExportIntervals.FontSize = 9;
%%
%%%%%%%%%%%%%%%%%%%
% Range Max Panel %
%%%%%%%%%%%%%%%%%%%
% Create 
pRangeMax = uipanel(glInterval);
% Manage layout
glRangeMax = uigridlayout(pRangeMax,[10,8]);
glRangeMax.RowHeight = {"fit", "fit", "1x", "1x", "1x", "1x", ...
    "1x", "1x", "1x", "fit"};
glRangeMax.ColumnWidth = {"1x", "1x", "1x", "1x", "1x", "1x", ...
    "1x", "fit"};
% Positions
pRangeMax.Layout.Row = 2;
pRangeMax.Layout.Column = 2;
% Style
pRangeMax.Title = 'High Frequencies (Downfield Shift): δ 9.5 - 6.0 ppm';
pRangeMax.FontSize = 11.5;
%-------------------------------
% Change Max Region Lower Bound
%-------------------------------
% Create
btnChangeMaxBound = uibutton(pRangeMax);
% Position
btnChangeMaxBound.Position = [270, 261, 70, 17];
% Style
btnChangeMaxBound.Text = 'Change Bound';
btnChangeMaxBound.Enable = 'off';
btnChangeMaxBound.FontWeight = 'bold';
btnChangeMaxBound.FontSize = 8.6;
btnChangeMaxBound.Tag = "Max";
%|||||||||||||||||||||||||||
% Detected Intervals Panel %
%|||||||||||||||||||||||||||
% Create 
pDetectedRangeMax = uipanel(glRangeMax);
% Manage layout
glDetectedRangeMax = uigridlayout(pDetectedRangeMax,[6,6]);
glDetectedRangeMax.RowHeight = {"1x", "1x", "1x", "1x", "fit", ...
    "1x"};
% Positions
pDetectedRangeMax.Layout.Row = [1 10];
pDetectedRangeMax.Layout.Column = [1 5];
% Style
pDetectedRangeMax.Title = 'Detected intervals';
pDetectedRangeMax.TitlePosition = 'centertop';
%-----------------%--------
% Interval's List % ListBox
%-----------------%--------
% Create
listInterRngMax = uilistbox(glDetectedRangeMax);
% Position
listInterRngMax.Layout.Row = [1 4];
listInterRngMax.Layout.Column = [1 4];
% Style
listInterRngMax.Items = "None";
listInterRngMax.Tag = "Max";
%---------------
% Delete Interval Button
%---------------
% Create
btnDelInterRngMax = uibutton(glDetectedRangeMax);
% Position
btnDelInterRngMax.Layout.Row = 1;
btnDelInterRngMax.Layout.Column = [5 6];
% Style
btnDelInterRngMax.Text = 'Delete';
btnDelInterRngMax.Enable = 'off';
%---------------
% Edit Interval Button
%---------------
% Create
btnEditInterRngMax = uibutton(glDetectedRangeMax);
% Position
btnEditInterRngMax.Layout.Row = 3;
btnEditInterRngMax.Layout.Column = [5 6];
% Style
btnEditInterRngMax.Text = 'Edit';
btnEditInterRngMax.Enable = 'off';
%---------------
% Zoom Region Button
%---------------
% Create
btnZoomInterRngMax = uibutton(glDetectedRangeMax);
% Position
btnZoomInterRngMax.Layout.Row = 4;
btnZoomInterRngMax.Layout.Column = [5 6];
% Style
btnZoomInterRngMax.FontSize = 9.5;
btnZoomInterRngMax.Text = "Zoom"+newline+"Region";
btnZoomInterRngMax.Tag = "Max";
btnZoomInterRngMax.Enable = 'off';
%----------------------%-------
% Lower Interval Limit % Label
%----------------------%-------
% Create
lblLowLimRngMax = uilabel(glDetectedRangeMax);
% Position
lblLowLimRngMax.Layout.Row = 5;
lblLowLimRngMax.Layout.Column = [1 2];
% Style
lblLowLimRngMax.Text = "Lower ppm";
lblLowLimRngMax.HorizontalAlignment = "center";
lblLowLimRngMax.VerticalAlignment = "top";
lblLowLimRngMax.FontSize = 9;
lblLowLimRngMax.FontWeight = "bold";
%-----------------------%-------
% Higher Interval Limit % Label
%-----------------------%-------
% Create
lblHighLimRngMax = uilabel(glDetectedRangeMax);
% Position
lblHighLimRngMax.Layout.Row = 5;
lblHighLimRngMax.Layout.Column = [3 4];
% Style
lblHighLimRngMax.Text = "Higher ppm";
lblHighLimRngMax.HorizontalAlignment = "center";
lblHighLimRngMax.VerticalAlignment = "top";
lblHighLimRngMax.FontSize = 9;
lblHighLimRngMax.FontWeight = "bold";
%-----------------%-------------
% Interval Limits % Edit Fields
%-----------------%-------------
% Create
efLowLimRngMax = uieditfield(glDetectedRangeMax,"numeric");
%
efHighLimRngMax = uieditfield(glDetectedRangeMax,"numeric");
% Position
efLowLimRngMax.Layout.Row = 6;
efLowLimRngMax.Layout.Column =[1 2];
%
efHighLimRngMax.Layout.Row = 6;
efHighLimRngMax.Layout.Column = [3 4];
% Style
efLowLimRngMax.Editable = "on";
efLowLimRngMax.AllowEmpty = "on";
efHighLimRngMax.Editable = "on";
efHighLimRngMax.AllowEmpty = "on";
%---------------------
% Add Interval Button
%---------------------
% Create
btnNewInterRngMax = uibutton(glDetectedRangeMax);
% Position
btnNewInterRngMax.Layout.Row = 6;
btnNewInterRngMax.Layout.Column = [5 6];
% Style
btnNewInterRngMax.Text = 'Add';
btnNewInterRngMax.Enable = 'off';
%--------------------%-------
% Threshold Max Text % Label
%--------------------%-------
% Create
lblThresholdMax = uilabel(glRangeMax);
% Position
lblThresholdMax.Layout.Row = 1;
lblThresholdMax.Layout.Column = [6 8];
% Style
lblThresholdMax.Text = "Threshold";
lblThresholdMax.HorizontalAlignment = "center";
lblThresholdMax.VerticalAlignment = "center";
lblThresholdMax.FontSize = 12;
lblThresholdMax.FontWeight = "bold";
%---------------
% Threshold Max Spinner
%---------------
% Create
sThresholdMax = uispinner(glRangeMax);
% Position
sThresholdMax.Layout.Row = 2;
sThresholdMax.Layout.Column = [6 7];
% Style
sThresholdMax.Limits = [0.0001 0.75];
sThresholdMax.Step = 0.05;
sThresholdMax.Value = 0.1;
sThresholdMax.ValueDisplayFormat = '%0.4f';
sThresholdMax.Enable = 'on';
%---------------
% Detection Max Button
%---------------
% Create
btnDetectionMax = uibutton(glRangeMax);
% Position
btnDetectionMax.Layout.Row = 2;
btnDetectionMax.Layout.Column = 8;
% Style
btnDetectionMax.Text = 'Detect';
btnDetectionMax.FontSize = 10;
btnDetectionMax.Enable = 'off';
%||||||||||||||||||||||||||||
% Added - Deleted Tab Group %
%||||||||||||||||||||||||||||
% Create
tgRangeMax = uitabgroup(glRangeMax);
% Positions
tgRangeMax.Layout.Row = [3 10];
tgRangeMax.Layout.Column = [6 8];
%////////////
% Added Tab ---------
%////////////
% Create
tAddedRangeMax = uitab(tgRangeMax,"Title","Added");
% Manage layout
gltAddedRangeMax = uigridlayout(tAddedRangeMax,[6,6]);
%---------------
% Added intervals Table
%---------------
% Create
uitAddedMax = uitable(gltAddedRangeMax);
% Position
uitAddedMax.Layout.Row = [1 6];
uitAddedMax.Layout.Column = [1 6];
% Style
uitAddedMax.FontSize = 10;
uitAddedMax.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitAddedMax.ColumnWidth = {"1x","1x"};
uitAddedMax.RowName = [];
%//////////////
% Deleted Tab ---------
%//////////////
% Create
tDeletedRangeMax = uitab(tgRangeMax,"Title","Deleted");
% Manage layout
gltDeletedRangeMax = uigridlayout(tDeletedRangeMax,[6,6]);
%---------------
% Deleted intervals Table
%---------------
% Create
uitDeletedMax = uitable(gltDeletedRangeMax);
% Position
uitDeletedMax.Layout.Row = [1 6];
uitDeletedMax.Layout.Column = [1 6];
% Style
uitDeletedMax.FontSize = 10;
uitDeletedMax.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitDeletedMax.ColumnWidth = {"1x","1x"};
uitDeletedMax.RowName = [];
%%
%%%%%%%%%%%%%%%%%%%
% Range Mdd Panel %
%%%%%%%%%%%%%%%%%%%
% Create 
pRangeMdd = uipanel(glInterval);
% Manage layout
glRangeMdd = uigridlayout(pRangeMdd,[10,8]);
glRangeMdd.RowHeight = {"fit", "fit", "1x", "1x", "1x", "1x", ...
    "1x", "1x", "1x", "fit"};
glRangeMdd.ColumnWidth = {"1x", "1x", "1x", "1x", "1x", "1x", ...
    "1x", "fit"};
% Positions
pRangeMdd.Layout.Row = 2;
pRangeMdd.Layout.Column = 3;
% Style
pRangeMdd.Title = 'Medium Frequencies: δ 6.0 - 3.0 ppm';
%-------------------------------
% Change Mid Region Lower Bound
%-------------------------------
% Create
btnChangeMddBound = uibutton(pRangeMdd);
% Position
btnChangeMddBound.Position = [270, 261, 70, 17];
% Style
btnChangeMddBound.Text = 'Change Bound';
btnChangeMddBound.Enable = 'off';
btnChangeMddBound.FontWeight = 'bold';
btnChangeMddBound.FontSize = 8.6;
btnChangeMddBound.Tag = "Mid";
%|||||||||||||||||||||||||||
% Detected Intervals Panel %
%|||||||||||||||||||||||||||
% Create 
pDetectedRangeMdd = uipanel(glRangeMdd);
% Manage layout
glDetectedRangeMdd = uigridlayout(pDetectedRangeMdd,[6,6]);
glDetectedRangeMdd.RowHeight = {"1x", "1x", "1x", "1x", "fit", ...
    "1x"};
% Positions
pDetectedRangeMdd.Layout.Row = [1 10];
pDetectedRangeMdd.Layout.Column = [1 5];
% Style
pDetectedRangeMdd.Title = 'Detected intervals';
pDetectedRangeMdd.TitlePosition = 'centertop';
%-----------------%--------
% Interval's List % ListBox
%-----------------%--------
% Create
listInterRngMdd = uilistbox(glDetectedRangeMdd);
% Position
listInterRngMdd.Layout.Row = [1 4];
listInterRngMdd.Layout.Column = [1 4];
% Style
listInterRngMdd.Items = "None";
listInterRngMdd.Tag = "Mid";
%---------------
% Delete Interval Button
%---------------
% Create
btnDelInterRngMdd = uibutton(glDetectedRangeMdd);
% Position
btnDelInterRngMdd.Layout.Row = 1;
btnDelInterRngMdd.Layout.Column = [5 6];
% Style
btnDelInterRngMdd.Text = 'Delete';
btnDelInterRngMdd.Enable = 'off';
%---------------
% Edit Interval Button
%---------------
% Create
btnEditInterRngMdd = uibutton(glDetectedRangeMdd);
% Position
btnEditInterRngMdd.Layout.Row = 3;
btnEditInterRngMdd.Layout.Column = [5 6];
% Style
btnEditInterRngMdd.Text = 'Edit';
btnEditInterRngMdd.Enable = 'off';
%---------------
% Zoom Region Button
%---------------
% Create
btnZoomInterRngMdd = uibutton(glDetectedRangeMdd);
% Position
btnZoomInterRngMdd.Layout.Row = 4;
btnZoomInterRngMdd.Layout.Column = [5 6];
% Style
btnZoomInterRngMdd.FontSize = 9.5;
btnZoomInterRngMdd.Text = "Zoom"+newline+"Region";
btnZoomInterRngMdd.Tag = "Mid";
btnZoomInterRngMdd.Enable = 'off';
%----------------------%-------
% Lower Interval Limit % Label
%----------------------%-------
% Create
lblLowLimRngMdd = uilabel(glDetectedRangeMdd);
% Position
lblLowLimRngMdd.Layout.Row = 5;
lblLowLimRngMdd.Layout.Column = [1 2];
% Style
lblLowLimRngMdd.Text = "Lower ppm";
lblLowLimRngMdd.HorizontalAlignment = "center";
lblLowLimRngMdd.VerticalAlignment = "top";
lblLowLimRngMdd.FontSize = 9;
lblLowLimRngMdd.FontWeight = "bold";
%-----------------------%-------
% Higher Interval Limit % Label
%-----------------------%-------
% Create
lblHighLimRngMdd = uilabel(glDetectedRangeMdd);
% Position
lblHighLimRngMdd.Layout.Row = 5;
lblHighLimRngMdd.Layout.Column = [3 4];
% Style
lblHighLimRngMdd.Text = "Higher ppm";
lblHighLimRngMdd.HorizontalAlignment = "center";
lblHighLimRngMdd.VerticalAlignment = "top";
lblHighLimRngMdd.FontSize = 9;
lblHighLimRngMdd.FontWeight = "bold";
%-----------------%-------------
% Interval Limits % Edit Fields
%-----------------%-------------
% Create
efLowLimRngMdd = uieditfield(glDetectedRangeMdd,"numeric");
%
efHighLimRngMdd = uieditfield(glDetectedRangeMdd,"numeric");
% Position
efLowLimRngMdd.Layout.Row = 6;
efLowLimRngMdd.Layout.Column =[1 2];
%
efHighLimRngMdd.Layout.Row = 6;
efHighLimRngMdd.Layout.Column = [3 4];
% Style
efLowLimRngMdd.Editable = "on";
efLowLimRngMdd.AllowEmpty = "on";
efHighLimRngMdd.Editable = "on";
efHighLimRngMdd.AllowEmpty = "on";
%---------------------
% Add Interval Button
%---------------------
% Create
btnNewInterRngMdd = uibutton(glDetectedRangeMdd);
% Position
btnNewInterRngMdd.Layout.Row = 6;
btnNewInterRngMdd.Layout.Column = [5 6];
% Style
btnNewInterRngMdd.Text = 'Add';
btnNewInterRngMdd.Enable = 'off';
%--------------------%-------
% Threshold Max Text % Label
%--------------------%-------
% Create
lblThresholdMdd = uilabel(glRangeMdd);
% Position
lblThresholdMdd.Layout.Row = 1;
lblThresholdMdd.Layout.Column = [6 8];
% Style
lblThresholdMdd.Text = "Threshold";
lblThresholdMdd.HorizontalAlignment = "center";
lblThresholdMdd.VerticalAlignment = "center";
lblThresholdMdd.FontSize = 12;
lblThresholdMdd.FontWeight = "bold";
%---------------
% Threshold Max Spinner
%---------------
% Create
sThresholdMdd = uispinner(glRangeMdd);
% Position
sThresholdMdd.Layout.Row = 2;
sThresholdMdd.Layout.Column = [6 7];
% Style
sThresholdMdd.Limits = [0.0001 0.75];
sThresholdMdd.Step = 0.05;
sThresholdMdd.Value = 0.1;
sThresholdMdd.ValueDisplayFormat = '%0.4f';
sThresholdMdd.Enable = 'on';
%---------------
% Detection Mid Button
%---------------
% Create
btnDetectionMdd = uibutton(glRangeMdd);
% Position
btnDetectionMdd.Layout.Row = 2;
btnDetectionMdd.Layout.Column = 8;
% Style
btnDetectionMdd.Text = 'Detect';
btnDetectionMdd.FontSize = 10;
btnDetectionMdd.Enable = 'off';
%||||||||||||||||||||||||||||
% Added - Deleted Tab Group %
%||||||||||||||||||||||||||||
% Create
tgRangeMdd = uitabgroup(glRangeMdd);
% Positions
tgRangeMdd.Layout.Row = [3 10];
tgRangeMdd.Layout.Column = [6 8];
%////////////
% Added Tab ---------
%////////////
% Create
tAddedRangeMdd = uitab(tgRangeMdd,"Title","Added");
% Manage layout
gltAddedRangeMdd = uigridlayout(tAddedRangeMdd,[6,6]);
%---------------
% Added intervals Table
%---------------
% Create
uitAddedMdd = uitable(gltAddedRangeMdd);
% Position
uitAddedMdd.Layout.Row = [1 6];
uitAddedMdd.Layout.Column = [1 6];
% Style
uitAddedMdd.FontSize = 10;
uitAddedMdd.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitAddedMdd.ColumnWidth = {"1x","1x"};
uitAddedMdd.RowName = [];
%//////////////
% Deleted Tab ---------
%//////////////
% Create
tDeletedRangeMdd = uitab(tgRangeMdd,"Title","Deleted");
% Manage layout
gltDeletedRangeMdd = uigridlayout(tDeletedRangeMdd,[6,6]);
%---------------
% Deleted intervals Table
%---------------
% Create
uitDeletedMdd = uitable(gltDeletedRangeMdd);
% Position
uitDeletedMdd.Layout.Row = [1 6];
uitDeletedMdd.Layout.Column = [1 6];
% Style
uitDeletedMdd.FontSize = 10;
uitDeletedMdd.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitDeletedMdd.ColumnWidth = {"1x","1x"};
uitDeletedMdd.RowName = [];
%%
%%%%%%%%%%%%%%%%%%%
% Range Min Panel %
%%%%%%%%%%%%%%%%%%%
% Create 
pRangeMin = uipanel(glInterval);
% Manage layout
glRangeMin = uigridlayout(pRangeMin,[10,8]);
glRangeMin.RowHeight = {"fit", "fit", "1x", "1x", "1x", "1x", ...
    "1x", "1x", "1x", "fit"};
glRangeMin.ColumnWidth = {"1x", "1x", "1x", "1x", "1x", "1x", ...
    "1x", "fit"};
% Positions
pRangeMin.Layout.Row = 2;
pRangeMin.Layout.Column = 4;
% Style
pRangeMin.Title = 'Low Frequencies (Upfield Shift): δ 3.0 - 0.0 ppm';
%|||||||||||||||||||||||||||
% Detected Intervals Panel %
%|||||||||||||||||||||||||||
% Create 
pDetectedRangeMin = uipanel(glRangeMin);
% Manage layout
glDetectedRangeMin = uigridlayout(pDetectedRangeMin,[6,6]);
glDetectedRangeMin.RowHeight = {"1x", "1x", "1x", "1x", "fit", ...
    "1x"};
% Positions
pDetectedRangeMin.Layout.Row = [1 10];
pDetectedRangeMin.Layout.Column = [1 5];
% Style
pDetectedRangeMin.Title = 'Detected intervals';
pDetectedRangeMin.TitlePosition = 'centertop';
%-----------------%--------
% Interval's List % ListBox
%-----------------%--------
% Create
listInterRngMin = uilistbox(glDetectedRangeMin);
% Position
listInterRngMin.Layout.Row = [1 4];
listInterRngMin.Layout.Column = [1 4];
% Style
listInterRngMin.Items = "None";
listInterRngMin.Tag = "Min";
%---------------
% Delete Interval Button
%---------------
% Create
btnDelInterRngMin = uibutton(glDetectedRangeMin);
% Position
btnDelInterRngMin.Layout.Row = 1;
btnDelInterRngMin.Layout.Column = [5 6];
% Style
btnDelInterRngMin.Text = 'Delete';
btnDelInterRngMin.Enable = 'off';
%---------------
% Edit Interval Button
%---------------
% Create
btnEditInterRngMin = uibutton(glDetectedRangeMin);
% Position
btnEditInterRngMin.Layout.Row = 3;
btnEditInterRngMin.Layout.Column = [5 6];
% Style
btnEditInterRngMin.Text = 'Edit';
btnEditInterRngMin.Enable = 'off';
%---------------
% Zoom Region Button
%---------------
% Create
btnZoomInterRngMin = uibutton(glDetectedRangeMin);
% Position
btnZoomInterRngMin.Layout.Row = 4;
btnZoomInterRngMin.Layout.Column = [5 6];
% Style
btnZoomInterRngMin.FontSize = 9.5;
btnZoomInterRngMin.Text = "Zoom"+newline+"Region";
btnZoomInterRngMin.Tag = "Min";
btnZoomInterRngMin.Enable = 'off';
%----------------------%-------
% Lower Interval Limit % Label
%----------------------%-------
% Create
lblLowLimRngMin = uilabel(glDetectedRangeMin);
% Position
lblLowLimRngMin.Layout.Row = 5;
lblLowLimRngMin.Layout.Column = [1 2];
% Style
lblLowLimRngMin.Text = "Lower ppm";
lblLowLimRngMin.HorizontalAlignment = "center";
lblLowLimRngMin.VerticalAlignment = "top";
lblLowLimRngMin.FontSize = 9;
lblLowLimRngMin.FontWeight = "bold";
%-----------------------%-------
% Higher Interval Limit % Label
%-----------------------%-------
% Create
lblHighLimRngMin = uilabel(glDetectedRangeMin);
% Position
lblHighLimRngMin.Layout.Row = 5;
lblHighLimRngMin.Layout.Column = [3 4];
% Style
lblHighLimRngMin.Text = "Higher ppm";
lblHighLimRngMin.HorizontalAlignment = "center";
lblHighLimRngMin.VerticalAlignment = "top";
lblHighLimRngMin.FontSize = 9;
lblHighLimRngMin.FontWeight = "bold";
%-----------------%-------------
% Interval Limits % Edit Fields
%-----------------%-------------
% Create
efLowLimRngMin = uieditfield(glDetectedRangeMin,"numeric");
%
efHighLimRngMin = uieditfield(glDetectedRangeMin,"numeric");
% Position
efLowLimRngMin.Layout.Row = 6;
efLowLimRngMin.Layout.Column =[1 2];
%
efHighLimRngMin.Layout.Row = 6;
efHighLimRngMin.Layout.Column = [3 4];
% Style
efLowLimRngMin.Editable = "on";
efLowLimRngMin.AllowEmpty = "on";
efHighLimRngMin.Editable = "on";
efHighLimRngMin.AllowEmpty = "on";
%---------------------
% Add Interval Button
%---------------------
% Create
btnNewInterRngMin = uibutton(glDetectedRangeMin);
% Position
btnNewInterRngMin.Layout.Row = 6;
btnNewInterRngMin.Layout.Column = [5 6];
% Style
btnNewInterRngMin.Text = 'Add';
btnNewInterRngMin.Enable = 'off';
%--------------------%-------
% Threshold Max Text % Label
%--------------------%-------
% Create
lblThresholdMin = uilabel(glRangeMin);
% Position
lblThresholdMin.Layout.Row = 1;
lblThresholdMin.Layout.Column = [6 8];
% Style
lblThresholdMin.Text = "Threshold";
lblThresholdMin.HorizontalAlignment = "center";
lblThresholdMin.VerticalAlignment = "center";
lblThresholdMin.FontSize = 12;
lblThresholdMin.FontWeight = "bold";
%---------------
% Threshold Max Spinner
%---------------
% Create
sThresholdMin = uispinner(glRangeMin);
% Position
sThresholdMin.Layout.Row = 2;
sThresholdMin.Layout.Column = [6 7];
% Style
sThresholdMin.Limits = [0.0001 0.75];
sThresholdMin.Step = 0.05;
sThresholdMin.Value = 0.1;
sThresholdMin.ValueDisplayFormat = '%0.4f';
sThresholdMin.Enable = 'on';
%---------------
% Detection Min Button
%---------------
% Create
btnDetectionMin = uibutton(glRangeMin);
% Position
btnDetectionMin.Layout.Row = 2;
btnDetectionMin.Layout.Column = 8;
% Style
btnDetectionMin.Text = 'Detect';
btnDetectionMin.FontSize = 10;
btnDetectionMin.Enable = 'off';
%||||||||||||||||||||||||||||
% Added - Deleted Tab Group %
%||||||||||||||||||||||||||||
% Create
tgRangeMin = uitabgroup(glRangeMin);
% Positions
tgRangeMin.Layout.Row = [3 10];
tgRangeMin.Layout.Column = [6 8];
%////////////
% Added Tab ---------
%////////////
% Create
tAddedRangeMin = uitab(tgRangeMin,"Title","Added");
% Manage layout
gltAddedRangeMin = uigridlayout(tAddedRangeMin,[6,6]);
%---------------
% Added intervals Table
%---------------
% Create
uitAddedMin = uitable(gltAddedRangeMin);
% Position
uitAddedMin.Layout.Row = [1 6];
uitAddedMin.Layout.Column = [1 6];
% Style
uitAddedMin.FontSize = 10;
uitAddedMin.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitAddedMin.ColumnWidth = {"1x","1x"};
uitAddedMin.RowName = [];
%//////////////
% Deleted Tab ---------
%//////////////
% Create
tDeletedRangeMin = uitab(tgRangeMin,"Title","Deleted");
% Manage layout
gltDeletedRangeMin = uigridlayout(tDeletedRangeMin,[6,6]);
%---------------
% Deleted intervals Table
%---------------
% Create
uitDeletedMin = uitable(gltDeletedRangeMin);
% Position
uitDeletedMin.Layout.Row = [1 6];
uitDeletedMin.Layout.Column = [1 6];
% Style
uitDeletedMin.FontSize = 10;
uitDeletedMin.ColumnName = {"Lower"+newline+"ppm", "Higher"+newline+"ppm"};
uitDeletedMin.ColumnWidth = {"1x","1x"};
uitDeletedMin.RowName = [];
