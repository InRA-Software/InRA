%%%%%%%%%%%%%%%%%%%%%
% Processing Layout %
%%%%%%%%%%%%%%%%%%%%%
% Manage app layout
gl = uigridlayout(tabProcessing,[12,14]);
gl.RowHeight = {38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38};
gl.ColumnWidth = {25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 650};
%%
%%%%%%%%%%
% Panels %
%%%%%%%%%%
% Create 
pVisualization = uipanel(gl);
pOther = uipanel(gl);
% Manage layout
glVis = uigridlayout(pVisualization,[4,8]);
glOth = uigridlayout(pOther,[12,11]);
%glExport = uigridlayout(pExport,[2,8]);
% Positions
pVisualization.Layout.Row = [2 4];
pVisualization.Layout.Column = [1 11];
pOther.Layout.Row = [5 11];
pOther.Layout.Column = [1 11];
%pExport.Layout.Row = [12 13];
%pExport.Layout.Column = [1 11];
% Style
pVisualization.Title = 'Spectra Display Modes';
pOther.Title = 'Processing Options for 1H-NMR Spectra';
%pExport.Title = 'Export Data';
%%
%%%%%%%%%%%%%%%
% axesFigures %
%%%%%%%%%%%%%%%
% Create
axRaw = uiaxes(gl);
axPre = uiaxes(gl);
% Positions
axRaw.Layout.Row = [1 6];
axRaw.Layout.Column = [12 16];
axPre.Layout.Row = [7 12];
axPre.Layout.Column = [12 16];
% Style
% Axes Raw
axRaw.InnerPosition = [0 0 1 1];
axRaw.XDir = 'reverse';
axRaw.XLabel.String = 'δ^{1}H(ppm)';
axRaw.YLabel.String = 'Intensity';
axRaw.XLim = [-0.2 10];
% Axes Preprocessing 
axPre.InnerPosition = [ 0 0 1 1];
axPre.XDir = 'reverse';
axPre.XLabel.String = 'δ^{1}H(ppm)';
axPre.YLabel.String = 'Intensity';
axPre.XLim = [-0.2 10];
%%
%%%%%%%%%%%%%%%%%%%%%%
% Mover dos gráficos %
%%%%%%%%%%%%%%%%%%%%%%
% Create
cbxPlot = uicheckbox (gl);
% Position
cbxPlot.Layout.Row = 8;
cbxPlot.Layout.Column = [14 16];
% Style
cbxPlot.Text = 'Sync Plots'; 
cbxPlot.Enable = "off";
%%
%%%%%%%%%%%%%%%
% Import Data %
%%%%%%%%%%%%%%%
% Create
btnImportData = uibutton(gl);
% Position
btnImportData.Layout.Row = 1;
btnImportData.Layout.Column = [1 5];
% Style
btnImportData.Text = 'Import NMR Spectra';
btnImportData.FontSize = 12; 
btnImportData.FontWeight = 'bold';
btnImportData.FontAngle = 'Normal';
btnImportData.BackgroundColor = [0.7 0.9 1];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualization Options %
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ddVisualization = uidropdown(glVis);
% Create Title
labelIcoshiftOption2 = uilabel(glVis);
labelIcoshiftOption2.Text = 'Visualization Modes';
labelIcoshiftOption2.FontSize = 10;
labelIcoshiftOption2.FontWeight = 'bold';
labelIcoshiftOption2.Layout.Row = 1;
labelIcoshiftOption2.Layout.Column = [1 4];
% Position
ddVisualization.Layout.Row = 2;
ddVisualization.Layout.Column = [1 2];
% Style
ddVisualization.Items = {'None'};
ddVisualization.FontSize = 13;
ddVisualization.Enable = 'off';
%%
%%%%%%%%%%%%%%%
% Sample List %
%%%%%%%%%%%%%%%
% Create
listSample = uilistbox(glVis);
listSample.Multiselect = 'on';
% Create Title
labellistSample= uilabel(glVis);
labellistSample.Text = 'Set of Samples';
labellistSample.FontSize = 10;
labellistSample.FontWeight = 'bold';
labellistSample.Layout.Row = 1;
labellistSample.Layout.Column = [4 6];
% Position
listSample.Layout.Row = [2 4];
listSample.Layout.Column = [4 6];
listSample.Items = {'None'};
listSample.Visible =  "on";
listSample.Enable =  "off";
% Style
listSample.Tooltip = {'Select multiple samples by'; 
    'holding Ctrl while clicking'};

%%
%%%%%%%%%%%%%%%%%%%%%%%%
% Delete 1H-NMR Sample %
%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnDeleteVis = uibutton(glVis);
% Position
btnDeleteVis.Layout.Row = 2;
btnDeleteVis.Layout.Column = [7 8];
% Style
btnDeleteVis.Text = 'Exclude Sample';
btnDeleteVis.FontSize = 9;
btnDeleteVis.Enable = 'off';

%%
%%%%%%%%%%%%%%%
% Edit Button %
%%%%%%%%%%%%%%%
% Create
btnEditVis = uibutton(glVis);
% Position
btnEditVis.Layout.Row = 3;
btnEditVis.Layout.Column = [7 8];
% Style
btnEditVis.Text = 'Edit';
btnEditVis.FontSize = 9;
btnEditVis.Enable = 'off';
btnEditVis.Visible = 'off';
%%
%%%%%%%%%%%%%%%%
% Apply Button %
%%%%%%%%%%%%%%%%
% Create
btnApplyVis = uibutton(glVis);
% Position
btnApplyVis.Layout.Row = [3 4];
btnApplyVis.Layout.Column = [1 2];
% Style
btnApplyVis.Text = 'Continue';
btnApplyVis.FontSize = 10; 
btnApplyVis.FontWeight = 'bold';
btnApplyVis.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Title Range Options %
%%%%%%%%%%%%%%%%%%%%%%%
% Add text inside the Range Options
% Create
lblSpectralRange = uilabel(glOth);
% Position Labels
lblSpectralRange.Layout.Row = 1;
lblSpectralRange.Layout.Column = [1 6];
% Style
lblSpectralRange.Text = "Define Chemical Shifts Spectral Range";
lblSpectralRange.FontSize = 10;
lblSpectralRange.VerticalAlignment = "bottom";
lblSpectralRange.FontWeight = "bold";
lblSpectralRange.FontColor = [0.5, 0.2, 0.5];

%%
%%%%%%%%%%%%%%%%%
% Range Options %
%%%%%%%%%%%%%%%%%
%---------------
% Range Spinners
%---------------
% Create
sFirstRange = uispinner(glOth);
sLastRange = uispinner(glOth);
% Create Labels for Spinners
labelsFirstPPM = uilabel(glOth, 'Text', 'Lower ppm');
labelsFirstPPM.FontWeight = 'bold';
labelsFirstPPM.FontSize = 10;
labelsLastPPM = uilabel(glOth, 'Text', 'Higher ppm');
labelsLastPPM.FontWeight = 'bold';
labelsLastPPM.FontSize = 10;
% Position Labels
labelsFirstPPM.Layout.Row = 2;
labelsFirstPPM.Layout.Column = [1 2];
labelsLastPPM.Layout.Row = 2;
labelsLastPPM.Layout.Column = [3 4];
% Position
sFirstRange.Layout.Row = 3;
sFirstRange.Layout.Column = [1 2];
%
sLastRange.Layout.Row = 3;
sLastRange.Layout.Column = [3 4];
% Style
sFirstRange.Limits = [0 10];
sFirstRange.Step = 0.01;
sFirstRange.ValueDisplayFormat = '%.3f';
sFirstRange.Enable = 'off';
%
sLastRange.Limits = [0 10];
sLastRange.Step = 0.01;
sLastRange.ValueDisplayFormat = '%.3f';
sLastRange.Enable = 'off';
%---------------
% Range View Button
%---------------
% Create
btnRangeView = uibutton(glOth);
% Position
btnRangeView.Layout.Row = 2;
btnRangeView.Layout.Column = [5 6];
% Style
btnRangeView.Text = 'View';
btnRangeView.Enable = 'off';
btnRangeView.FontSize = 9;
%---------------
% Range Button
%---------------
% Create
btnRange = uibutton(glOth);
% Position
btnRange.Layout.Row = 3;
btnRange.Layout.Column = [5 6];
% Style
btnRange.Text = 'Range';
btnRange.Enable = 'off';
btnRange.FontSize = 9;
%%
%%%%%%%%%%%%%%%%%%%
% Title Alignment %
%%%%%%%%%%%%%%%%%%%
% Add text inside the Alignment Option
% Create
lblCorrectMisalignments = uilabel(glOth);
% Position Labels
lblCorrectMisalignments.Layout.Row = 4;
lblCorrectMisalignments.Layout.Column = [1 6];
% Style
lblCorrectMisalignments.Text = "Correct Chemical Shifts Misalignments";
lblCorrectMisalignments.FontSize = 10;
lblCorrectMisalignments.VerticalAlignment = "bottom";
lblCorrectMisalignments.FontWeight = "bold";
lblCorrectMisalignments.FontColor = [0.7, 0, 0.2];

%%
%%%%%%%%%%%%%%%%%%%%
% Icoshift Options %
%%%%%%%%%%%%%%%%%%%%
%----------------
% Icoshift DropDowns
%----------------
% Create
ddIcoshiftOption1 = uidropdown(glOth);
ddIcoshiftOption2 = uidropdown(glOth);
%{
ddIcoshiftOption3 = uidropdown(glOth);
%}
% Create Title Option1
labelIcoshiftOption2 = uilabel(glOth);
labelIcoshiftOption2.Text = 'Reference';
labelIcoshiftOption2.FontSize = 10;
labelIcoshiftOption2.FontWeight = 'bold';
labelIcoshiftOption2.Layout.Row = 5;
labelIcoshiftOption2.Layout.Column = [1 2];
% Create Title Option2
labelIcoshiftOption2 = uilabel(glOth);
labelIcoshiftOption2.Text = 'Mode';
labelIcoshiftOption2.FontSize = 10;
labelIcoshiftOption2.FontWeight = 'bold';
labelIcoshiftOption2.Layout.Row = 5;
labelIcoshiftOption2.Layout.Column = [3 4];
%{
% Create Title Option3
labelIcoshiftOption3 = uilabel(glOth);
labelIcoshiftOption3.Text = 'Shift Correction';
labelIcoshiftOption3.FontSize = 10;
labelIcoshiftOption3.FontWeight = 'bold';
labelIcoshiftOption3.Layout.Row = 5;
labelIcoshiftOption3.Layout.Column = [7 10];
%}
% Position
ddIcoshiftOption1.Layout.Row = 6;
ddIcoshiftOption1.Layout.Column = [1 2]; 
%
ddIcoshiftOption2.Layout.Row = 6;
ddIcoshiftOption2.Layout.Column = [3 4]; 
%
%{
ddIcoshiftOption3.Layout.Row = 6;
ddIcoshiftOption3.Layout.Column = [7 9]; 
%}
% Style
ddIcoshiftOption1.Items = {'Average', 'Median', 'Max', 'Average 2'};
ddIcoshiftOption1.FontSize = 11;
ddIcoshiftOption1.Enable = 'off';
ddIcoshiftOption2.Items = {'Whole','Interval'};
ddIcoshiftOption2.FontSize = 11;
ddIcoshiftOption2.Enable = 'off';
%{
ddIcoshiftOption3.Items = {'Best', 'Fast'};
ddIcoshiftOption3.Enable = 'off';
%}
% UserData
ddIcoshiftOption1.UserData = 3; %Default multiplier for Average 2
%---------------
% Icoshift Button
%---------------
% Create
btnIcoshift = uibutton (glOth);
% Position
btnIcoshift.Layout.Row = 6;
btnIcoshift.Layout.Column = [5 6];
% Style
btnIcoshift.Text = 'Alignment';
btnIcoshift.Enable = 'off';
btnIcoshift.FontSize = 9;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Remove Resonance Signal %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add text inside the Remove Option
% Create
lblExcludeResonance = uilabel(glOth);
% Position Labels
lblExcludeResonance.Layout.Row = 7;
lblExcludeResonance.Layout.Column = [1 6];
% Style
lblExcludeResonance.Text = "Exclude Resonance Signals";
lblExcludeResonance.FontSize = 10;
lblExcludeResonance.VerticalAlignment = "bottom";
lblExcludeResonance.FontWeight = "bold";
lblExcludeResonance.FontColor = [0, 0.4, 0];

%%
%%%%%%%%%%%%%%%%%%
% Remove Options %
%%%%%%%%%%%%%%%%%%
%----------------
% Spinners Remove
%----------------
% Create
sFirstPPM = uispinner(glOth);
sLastPPM = uispinner(glOth);
% Create Labels for Spinners
labelsFirstPPM = uilabel(glOth, 'Text', 'Lower ppm');
labelsFirstPPM.FontWeight = 'bold';
labelsFirstPPM.FontSize = 10;
labelsLastPPM = uilabel(glOth, 'Text', 'Higher ppm');
labelsLastPPM.FontWeight = 'bold';
labelsLastPPM.FontSize = 10;
% Position Labels
labelsFirstPPM.Layout.Row = 8;
labelsFirstPPM.Layout.Column = [1 2];
labelsLastPPM.Layout.Row = 8;
labelsLastPPM.Layout.Column = [3 4];
% Positions
sFirstPPM.Layout.Row = 9;
sFirstPPM.Layout.Column = [1 2];
%
sLastPPM.Layout.Row = 9;
sLastPPM.Layout.Column = [3 4];
% Style
sFirstPPM.Limits = [0 10];
sFirstPPM.Step = 0.01;
sFirstPPM.ValueDisplayFormat = '%.3f';
sFirstPPM.Enable = 'off';
%
sLastPPM.Limits = [0 10];
sLastPPM.Step = 0.01;
sLastPPM.ValueDisplayFormat = '%.3f';
sLastPPM.Enable = 'off';
%----------------
% Add Button
%----------------
% Create
btnAdd = uibutton(glOth);
% Position
btnAdd.Layout.Row = 8;
btnAdd.Layout.Column = [5 6];
% Style
btnAdd.Text = 'View';
btnAdd.Enable = 'off';
btnAdd.FontSize = 9;
%--------------
% Delete Button
%--------------
% Create
btnDelete = uibutton(glOth);
% Position
btnDelete.Layout.Row = 9;
btnDelete.Layout.Column = [5 6];
% Style
btnDelete.Text = 'Delete';
btnDelete.Enable = 'off';
btnDelete.FontSize = 9;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Normalization and Binning %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add text inside the Remove Option
% Create
lblNormalizeBinning = uilabel(glOth);
% Position Labels
lblNormalizeBinning.Layout.Row = 10;
lblNormalizeBinning.Layout.Column = [1 6];
% Style
lblNormalizeBinning.Text = "Normalize - Binning Spectra";
lblNormalizeBinning.FontSize = 10;
lblNormalizeBinning.FontWeight = "bold";
lblNormalizeBinning.HorizontalAlignment = "left";
lblNormalizeBinning.VerticalAlignment = "bottom";
lblNormalizeBinning.FontColor = [0.6, 0.3, 0.1];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalization Options %
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ddNormalization = uidropdown(glOth);
% Create Label for Normalization
LabelsWidthBinning = uilabel(glOth, 'Text','Normalization');
LabelsWidthBinning.FontWeight = 'bold';
LabelsWidthBinning.FontSize = 10;
% Position Label
LabelsWidthBinning.Layout.Row = 11;
LabelsWidthBinning.Layout.Column = [1 3];
% Position
ddNormalization.Layout.Row = 12;
ddNormalization.Layout.Column = [1 3];
% Style
ddNormalization.Items = {'None'};
ddNormalization.Enable = 'off';
ddNormalization.FontSize = 12;
%%
%%%%%%%%%%%%%%%%%%%
% Binning Options %
%%%%%%%%%%%%%%%%%%%
%----------------
% Binning Spinner
%----------------
% Create
sWidthBinning = uispinner(glOth);
% Create Label for Binning
LabelsWidthBinning = uilabel(glOth, 'Text','Bucket Width');
LabelsWidthBinning.FontWeight = 'bold';
LabelsWidthBinning.FontSize = 10;
LabelsWidthBinning.HorizontalAlignment = "right";
% Position Label
LabelsWidthBinning.Layout.Row = 11;
LabelsWidthBinning.Layout.Column = [3 5];
% Position
sWidthBinning.Layout.Row = 12;
sWidthBinning.Layout.Column = [4 5]; 
% Style
sWidthBinning.Limits = [0 1];
sWidthBinning.Step = 0.001;
sWidthBinning.ValueDisplayFormat = '%.3f';
sWidthBinning.Value = 0.001;
sWidthBinning.Enable = 'off';
%---------------
% Binning Button
%---------------
% Create
btnBinning = uibutton (glOth);
% Position
btnBinning.Layout.Row = 11;
btnBinning.Layout.Column = [6 7];
% Style
btnBinning.Text = 'Binning';
btnBinning.Enable = 'off';
btnBinning.FontSize = 9;
%---------------
% Integration Button
%---------------
% Create
btnIntegration = uibutton (glOth);
% Position
btnIntegration.Layout.Row = 12;
btnIntegration.Layout.Column = [6 7];
% Style
btnIntegration.Text = 'Integration';
btnIntegration.Enable = 'off';
btnIntegration.FontSize = 9;
%%
%%%%%%%%%%%%%%%%%%%%%%
% Binning to Compare %
%%%%%%%%%%%%%%%%%%%%%%
% Create
btnBin2Com = uibutton (glOth);
% Position
btnBin2Com.Layout.Row = 10;
btnBin2Com.Layout.Column = [8 11];
% Style
btnBin2Com.Text = "Binning to Compare";
btnBin2Com.Enable = 'off';
btnBin2Com.FontSize = 9;
%btnBin2Com.FontWeight = 'bold';
%btnBin2Com.BackgroundColor = [0.7725, 1.0000, 0.5098];%[0.5, 0.5, 0.4];
%%
%%%%%%%%%%%%%%%%%%
% Proceed Button %
%%%%%%%%%%%%%%%%%%
% Create
btnDone = uibutton (glOth);
% Position
btnDone.Layout.Row = [11 12];
btnDone.Layout.Column = [8 11];
% Style
btnDone.Text = "Proceed to "+newline+"Interval Detection";
btnDone.Enable = 'off';
btnDone.FontWeight = 'bold';
btnDone.BackgroundColor = [0.7725, 1.0000, 0.5098];%[0.5, 0.5, 0.4];

%%%%%%%%%%%%%%%%%%%%%%%%
% Automatization Panel %
%%%%%%%%%%%%%%%%%%%%%%%%
% Create
pAuto = uipanel(glOth);
% Position
pAuto.Layout.Row = [1 9];
pAuto.Layout.Column = [7 11];
% Style
pAuto.Title = "Automatization";
pAuto.TitlePosition = "centertop";
%-------------
% Grid Layout
%-------------
glAuto = uigridlayout(pAuto,[2,3]);
glAuto.RowHeight = {'fit', '1x'};
glAuto.ColumnWidth = {'1x', '1x', '1x'};

%--------------------
% New Settings Button
%--------------------
% Create
btnNewSettings = uibutton(glAuto);
% Position
btnNewSettings.Layout.Row = 1;
btnNewSettings.Layout.Column = 1;
% Style
btnNewSettings.Text = "New";
btnNewSettings.Enable = 'off';
%--------------------
% Save Settings Button
%--------------------
% Create
btnSaveSettings = uibutton(glAuto);
% Position
btnSaveSettings.Layout.Row = 1;
btnSaveSettings.Layout.Column = 2;
% Style
btnSaveSettings.Text = "Save";
btnSaveSettings.Enable = 'off';
%--------------------
% Use Settings Button
%--------------------
% Create
btnUseSettings = uibutton(glAuto);
% Position
btnUseSettings.Layout.Row = 1;
btnUseSettings.Layout.Column = 3;
% Style
btnUseSettings.Text = "Use";
btnUseSettings.Enable = 'off';
%--------------------
% Settings List
%--------------------
% Create
listSettings = uilistbox(glAuto);
% Position
listSettings.Layout.Row = [2 3];
listSettings.Layout.Column = [1 3];
% Style
listSettings.Items = {'Automatization will be', ...
    'available in the next', 'update of InRA'};
listSettings.Enable = 'off';

%%
%%%%%%%%%%%%%%%%%%%%%%
% Export Data Button %
%%%%%%%%%%%%%%%%%%%%%%
%-----------
% Workspace
%-----------
% Create
btnExportDataW = uibutton(gl);
% Position
btnExportDataW.Layout.Row = 12;
btnExportDataW.Layout.Column = [1 4];
% Style
btnExportDataW.Text = 'Export Spectra to Workspace';
btnExportDataW.FontSize = 9;
btnExportDataW.Enable = 'off';
%------
% csv
%------
% Create
btnExportDataCSV = uibutton (gl);
% Position
btnExportDataCSV.Layout.Row = 12;
btnExportDataCSV.Layout.Column = [5 8];
% Style
btnExportDataCSV.Text = 'Export Spectra to .csv file';
btnExportDataCSV.FontSize = 9;
btnExportDataCSV.Enable = 'off';
%------
% Export Integrated Data
%------
% Create
btnIntegrationDataCSV = uibutton (gl);
% Position
btnIntegrationDataCSV.Layout.Row = 12;
btnIntegrationDataCSV.Layout.Column = [9 11];
% Style
btnIntegrationDataCSV.Text = "Export Integrated"+newline+...
    "Bins to .csv file";
btnIntegrationDataCSV.FontSize = 9;
btnIntegrationDataCSV.Enable = 'off';