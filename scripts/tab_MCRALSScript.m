%%%%%%%%%%%%%%%%%%%%%
% Manage app layout %
%%%%%%%%%%%%%%%%%%%%%
glMCRALS = uigridlayout(tabMCR,[13,14]);
glMCRALS.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', ...
    '1x', '1x', '1x', '1x', 20};
glMCRALS.ColumnWidth = {88, 88, '1x', '1x', '1x', '1x', '1x', '1x', ...
    '1x', '1x', '1x', '1x', '1x', '1x'};
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Model-Signals Panel %
%%%%%%%%%%%%%%%%%%%%%%%
% Create
pMCRoptions = uipanel(glMCRALS);
% Manage layout
glMCRopt = uigridlayout(pMCRoptions, [8, 10]);
glMCRopt.RowHeight = {'1x', '1x', '1x', '1x', '1x', 16, 16, ...
    16};
glMCRopt.ColumnWidth = {5, 5, 5, 5, 5, 5, 'fit', 'fit', 'fit', 'fit'};
% Style
pMCRoptions.Title = 'Model';
pMCRoptions.Layout.Row = [1 6];
pMCRoptions.Layout.Column = [1 2];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tab Group of Interval's List %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
tgRegions = uitabgroup(glMCRopt);
% Position
tgRegions.Layout.Row = [1 5];
tgRegions.Layout.Column = [1 10];
%////////////////////////////
% Tab: Region 1 - Intervals /
%////////////////////////////
% Create
tabRegion1 = uitab(tgRegions,"Title","Region 1");
% Layout
glRegion1 = uigridlayout(tabRegion1,[4,10]);
%---------------
% List: Region 1 
%---------------
% Create
listRegion1 = uilistbox(glRegion1);
% Position
listRegion1.Layout.Row = [1 4];
listRegion1.Layout.Column = [1 10];
% Style
listRegion1.Items = "None";
listRegion1.Tag = "Min";
%////////////////////////////
% Tab: Region 2 - Intervals /
%////////////////////////////
% Create
tabRegion2 = uitab(tgRegions,"Title","Region 2");
% Layout
glRegion2 = uigridlayout(tabRegion2,[4,10]);
%---------------
% List: Region 2 
%---------------
% Create
listRegion2 = uilistbox(glRegion2);
% Position
listRegion2.Layout.Row = [1 4];
listRegion2.Layout.Column = [1 10];
% Style
listRegion2.Items = "None";
listRegion2.Tag = "Mid";
%////////////////////////////
% Tab: Region 3 - Intervals /
%////////////////////////////
% Create
tabRegion3 = uitab(tgRegions,"Title","Region 3");
% Layout
glRegion3 = uigridlayout(tabRegion3,[4,10]);
%---------------
% List: Region 3 
%---------------
% Create
listRegion3 = uilistbox(glRegion3);
% Position
listRegion3.Layout.Row = [1 4];
listRegion3.Layout.Column = [1 10];
% Style
listRegion3.Items = "None";
listRegion3.Tag = "Max";
%%
%%%%%%%%%%%%%%%%%%%%
% Figures of merit %
%%%%%%%%%%%%%%%%%%%%
%-----------------%-------
% Lack of fit exp % Label
%-----------------%-------
% Create
lblLOfExp = uilabel(glMCRopt);
% Position
lblLOfExp.Layout.Row = 6;
lblLOfExp.Layout.Column = [1 6];
% Style
lblLOfExp.Text = "LOF EXP (%)";
%-----------------%------------
% Lack of fit exp % Edit Field
%-----------------%------------
% Create
efLOfExp = uieditfield(glMCRopt,"numeric");
% Position
efLOfExp.Layout.Row = 6;
efLOfExp.Layout.Column = [7 10];
% Behaviour
efLOfExp.Editable = "off";
% Other
% To use as a confirmation that MCR wasn't done
efLOfExp.UserData = 0;
%--------------------%-------
% Explained variance % Label
%--------------------%-------
% Create
lblLOfExVa = uilabel(glMCRopt);
% Position
lblLOfExVa.Layout.Row = 7;
lblLOfExVa.Layout.Column = [1 6];
% Style
lblLOfExVa.Text = "EV (%)";
%--------------------%------------
% Explained variance % Edit Field
%--------------------%------------
% Create
efLOfExVa = uieditfield(glMCRopt, "numeric");
% Position
efLOfExVa.Layout.Row = 7;
efLOfExVa.Layout.Column = [7 10];
% Behaviour
efLOfExVa.Editable = "off";
%-----------------%-------
% STD of Residual % Label
%-----------------%-------
% Create
lblLOfStdRes = uilabel(glMCRopt);
% Position
lblLOfStdRes.Layout.Row = 8;
lblLOfStdRes.Layout.Column = [1 6];
% Style
lblLOfStdRes.Text = "sigma (%)";
%-----------------%------------
% STD of Residual % Edit Field
%-----------------%------------
% Create
efLOfStdRes = uieditfield(glMCRopt, "numeric");
% Position
efLOfStdRes.Layout.Row = 8;
efLOfStdRes.Layout.Column = [7 10];
% Behaviour
efLOfStdRes.Editable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%
% One-at-time Panel %
%%%%%%%%%%%%%%%%%%%%%
% Create
pMCROaT = uipanel(glMCRALS);
% Manage layout
glMCROaT = uigridlayout(pMCROaT, [4, 4]);
glMCROaT.RowHeight = {18, 18, 11, 18};
glMCROaT.ColumnWidth = {'1x', '1x', '1x', '1x'};
% Position
pMCROaT.Layout.Row = [7 9];
pMCROaT.Layout.Column = [1 2];
% Style
pMCROaT.Title = 'One-at-Time';
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Number of Iteration % One-at-Time
%%%%%%%%%%%%%%%%%%%%%%%
%---------------%-------
% N° Iterations % Label % One-at-Time
%---------------%-------
% Create
lblIterMCROaT = uilabel(glMCROaT);
% Position
lblIterMCROaT.Layout.Row = 1;
lblIterMCROaT.Layout.Column = [1 2];
% Style
lblIterMCROaT.Text = "n° of Iterations";
%lblIterations.HorizontalAlignment = "center";
lblIterMCROaT.FontSize = 9;
lblIterMCROaT.FontWeight = "bold";
lblIterMCROaT.FontColor = [0.5, 0, 0];
%---------------%---------
% N° Iterations % Spinner % One-at-Time
%---------------%---------
% Create
sIterMCROaT = uispinner(glMCROaT);
% Position
sIterMCROaT.Layout.Row = 1;
sIterMCROaT.Layout.Column = [3 4];
% Style
sIterMCROaT.Value = 100;
sIterMCROaT.Limits = [1 500];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build MCR OaT Model Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnMCROaTBuildMod = uibutton(glMCROaT);
% Position
btnMCROaTBuildMod.Layout.Row = 2;
btnMCROaTBuildMod.Layout.Column = [2 3];
% Style
btnMCROaTBuildMod.Text = "Build Model";
btnMCROaTBuildMod.FontSize = 10; 
btnMCROaTBuildMod.FontWeight = 'bold';
btnMCROaTBuildMod.Enable = 'off';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------
% Only for selected interval % Label % One-at-Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------
% Create
lblOnlySelectInter = uilabel(glMCROaT);
% Position
lblOnlySelectInter.Layout.Row = 3;
lblOnlySelectInter.Layout.Column = [1 4];
% Style
lblOnlySelectInter.Text = "----  Only for selected interval  ----";
lblOnlySelectInter.HorizontalAlignment = "center";
lblOnlySelectInter.VerticalAlignment = "top";
lblOnlySelectInter.FontSize = 10;
lblOnlySelectInter.FontWeight = "bold";
%lblOnlySelectInter.FontColor = [0.5, 0, 0];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build MCR Model for Selected Interval Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnMCROaTselInter = uibutton(glMCROaT);
% Position
btnMCROaTselInter.Layout.Row = 4;
btnMCROaTselInter.Layout.Column = [1 2];
% Style
btnMCROaTselInter.Text = "Build Model";
btnMCROaTselInter.FontSize = 10; 
btnMCROaTselInter.FontWeight = 'bold';
btnMCROaTselInter.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delete Components for Selected Interval Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnDelCompSelInter = uibutton(glMCROaT);
% Position
btnDelCompSelInter.Layout.Row = 4;
btnDelCompSelInter.Layout.Column = [3 4];
% Style
btnDelCompSelInter.Text = "Delete Comp.";
btnDelCompSelInter.FontSize = 10; 
btnDelCompSelInter.FontWeight = 'bold';
btnDelCompSelInter.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%
% Selecting MCR Mode %
%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%
% All-at-once Panel %
%%%%%%%%%%%%%%%%%%%%%%
% Create
pMCRAaO = uipanel(glMCRALS);
% Manage layout
glMCRAaO = uigridlayout(pMCRAaO, [3, 4]);
glMCRAaO.RowHeight = {'fit', 'fit', 'fit'};
glMCRAaO.ColumnWidth = {'1x', '1x', '1x', '1x'};
% Position
pMCRAaO.Layout.Row = [10 12];
pMCRAaO.Layout.Column = [1 2];
% Style
pMCRAaO.Title = 'All-at-Once';
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Number of Iteration % All-at-Once
%%%%%%%%%%%%%%%%%%%%%%%
%---------------%-------
% N° Iterations % Label % All-at-Once
%---------------%-------
% Create
lblIterMCRAaO = uilabel(glMCRAaO);
% Position
lblIterMCRAaO.Layout.Row = 1;
lblIterMCRAaO.Layout.Column = [1 2];
% Style
lblIterMCRAaO.Text = "n° of Iterations";
%lblIterations.HorizontalAlignment = "center";
lblIterMCRAaO.FontSize = 9;
lblIterMCRAaO.FontWeight = "bold";
lblIterMCRAaO.FontColor = [0.5, 0, 0];
%---------------%---------
% N° Iterations % Spinner % All-at-Once
%---------------%---------
% Create
sIterMCRAaO = uispinner(glMCRAaO);
% Position
sIterMCRAaO.Layout.Row = 1;
sIterMCRAaO.Layout.Column = [3 4];
% Style
sIterMCRAaO.Value = 100;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of MCR Components % All-at-Once
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------%-------
% N° MCR Components % Label % All-at-Once
%-------------------%-------
% Create
lblCompMCRAaO = uilabel(glMCRAaO);
% Position
lblCompMCRAaO.Layout.Row = 2;
lblCompMCRAaO.Layout.Column = [1 2];
% Style
lblCompMCRAaO.Text = "Components";
%lblIterations.HorizontalAlignment = "center";
lblCompMCRAaO.FontSize = 10;
lblCompMCRAaO.FontWeight = "bold";
lblCompMCRAaO.FontColor = [0, 0, 0.5];
%-------------------%---------
% N° MCR Components % Spinner % All-at-Once
%-------------------%---------
% Create
sCompMCRAaO = uispinner(glMCRAaO);
% Position
sCompMCRAaO.Layout.Row = 2;
sCompMCRAaO.Layout.Column = [3 4];
% Style
sCompMCRAaO.Value = 1;
sCompMCRAaO.Limits = [1 500];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build MCR AaO Model Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnMCRBuildMod = uibutton(glMCRAaO);
% Position
btnMCRBuildMod.Layout.Row = 3;
btnMCRBuildMod.Layout.Column = [2 3];
% Style
btnMCRBuildMod.Text = "Build Model";
btnMCRBuildMod.FontSize = 10; 
btnMCRBuildMod.FontWeight = 'bold';
btnMCRBuildMod.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%%%
% Export to CSV Button %
%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnExportModels = uibutton(glMCRALS);
% Position
btnExportModels.Layout.Row = 13;
btnExportModels.Layout.Column = 1;
% Style
btnExportModels.Text = "Export Models";
btnExportModels.FontSize = 10; 
btnExportModels.FontWeight = 'bold';
btnExportModels.Enable = 'on';
btnExportModels.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Proceed to PCA Button %
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnProceedToPCA = uibutton(glMCRALS);
% Position
btnProceedToPCA.Layout.Row = 13;
btnProceedToPCA.Layout.Column = 2;
% Style
btnProceedToPCA.Text = "Proceed";
btnProceedToPCA.FontSize = 10; 
btnProceedToPCA.FontWeight = 'bold';
btnProceedToPCA.Enable = 'on';
btnProceedToPCA.BackgroundColor = [0.7725, 1.0000, 0.5098];
btnProceedToPCA.Enable = "off";
%%
%%%%%%%%
% Axes %
%%%%%%%%
%------------------%
% Resonance Signal %
%------------------%
% Create
axSegment = uiaxes(glMCRALS);
% Positions
axSegment.Layout.Row = [1 7];
axSegment.Layout.Column = [3 8];
% Style
axSegment.XDir = 'reverse';
axSegment.Title.String = 'Resonance Signal';
axSegment.XLabel.String = 'δ^{1}H(ppm)';
axSegment.YLabel.String = 'Intensity';
%---------------------------%
% Resolved Spectral Profile %
%---------------------------%
% Create 
axSTprofile = uiaxes(glMCRALS);
% Position
axSTprofile.Layout.Row = [1 7];
axSTprofile.Layout.Column = [9 14];
% Style
axSTprofile.XDir = 'reverse';
axSTprofile.Title.String = 'Resolved Spectral Profiles (S^{T})';
axSTprofile.XLabel.String = 'δ^{1}H(ppm)';
axSTprofile.YLabel.String = 'Intensity';
%--------------------------------%
% Resolved Concentration Profile %
%--------------------------------%
% Create
axCprofile = uiaxes(glMCRALS);
% Position
axCprofile.Layout.Row = [8 13];
axCprofile.Layout.Column = [9 14];
% Style
axCprofile.Title.String = 'Resolved Concentration Profiles (C)';
axCprofile.XLabel.String = 'Sample';
axCprofile.YLabel.String = 'Profile';
%%
%%%%%%%%%%%%%%%%%%%
% Purest ST Panel %
%%%%%%%%%%%%%%%%%%%
% Create
pMCRpurestST = uipanel(glMCRALS);
% Manage layout
glMCRpurestST = uigridlayout(pMCRpurestST, [6, 6]);
glMCRpurestST.RowHeight = {'1x', '1x', 25, 30, ...
    30, '1x'};
% Position
pMCRpurestST.Layout.Row = [8 13];
pMCRpurestST.Layout.Column = [3 8];
% Style
pMCRpurestST.Title = 'Purest ST';
pMCRpurestST.TitlePosition = 'centertop';
%%
%%%%%%%%%%%%%%%%%%%%%
% One-at-Time Plots %
%%%%%%%%%%%%%%%%%%%%%
%---------------------------------%
% Eigenvalues-Initialization Plot %
%---------------------------------%
% Create 
axSVDinit = uiaxes(glMCRpurestST);
% Position
axSVDinit.Layout.Row = [1 6];
axSVDinit.Layout.Column = [3 6];
%axSVDinit.Layout.Row = [7 12];
%axSVDinit.Layout.Column = [5 8];
% Style
%axSVDinit.XDir = 'reverse';
axSVDinit.Title.String = 'Eigenvalues / Initialization Spectrum';
axSVDinit.XLabel.String = 'Component / ppm';
axSVDinit.YLabel.String = 'Magnitude / Intensity';
%-------------------------------------------%
% Eigenvalues-Initialization Plot Selection %
%-------------------------------------------%
%-------------
% Button Group
%-------------
bgPlotSVDinit = uibuttongroup(glMCRpurestST);
% Position
bgPlotSVDinit.Layout.Row = [1 2];
bgPlotSVDinit.Layout.Column = [1 2];
%bgPlotSVDinit.Layout.Row = [7 8];
%bgPlotSVDinit.Layout.Column = [3 4];
% Style
bgPlotSVDinit.BorderType = 'none';
bgPlotSVDinit.Title = 'Plot selection';
bgPlotSVDinit.TitlePosition = 'centertop';
%-------------
% Radio Button
%-------------
rbPlotSVD = uiradiobutton(bgPlotSVDinit);
% Position
rbPlotSVD.Position = [50 20 100 15];
% Style
rbPlotSVD.Text = 'Eigenvalues';
rbPlotSVD.Enable = 'off';
%--------------
% Radio Button
%--------------
% Create
rbPlotInit = uiradiobutton(bgPlotSVDinit);
% Position
rbPlotInit.Position = [50 1 100 15];
% Style
rbPlotInit.Text = 'Initial Spectrum';
rbPlotInit.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%%%
% Number of Components % One-at-Time
%%%%%%%%%%%%%%%%%%%%%%%%
%---------------%-------
% N° Components % Label % One-at-Time
%---------------%-------
% Create
lblCompMCROaT = uilabel(glMCRpurestST);
% Position
lblCompMCROaT.Layout.Row = 3;
lblCompMCROaT.Layout.Column = 1;
% Style
lblCompMCROaT.Text = "Components";
lblCompMCROaT.FontSize = 10;
lblCompMCROaT.FontWeight = "bold";
lblCompMCROaT.FontColor = [0, 0, 0.5];
%---------------%---------
% N° Components % Spinner % All-at-Once
%---------------%---------
% Create
sCompMCROaT = uispinner(glMCRpurestST);
% Position
sCompMCROaT.Layout.Row = 3;
sCompMCROaT.Layout.Column = 2;
% Style
sCompMCROaT.Value = 4;
sCompMCROaT.Limits = [1 20];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize MCR OaT Model Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnMCROaTinitialize = uibutton(glMCRpurestST);
% Position
btnMCROaTinitialize.Layout.Row = 4;
btnMCROaTinitialize.Layout.Column = [1 2];
%btnMCROaTinitialize.Layout.Row = 9;
%btnMCROaTinitialize.Layout.Column = [3 4];
% Style
btnMCROaTinitialize.Text = "Initialize with "+sCompMCROaT.Value+ ...
    " components";
btnMCROaTinitialize.FontSize = 10; 
btnMCROaTinitialize.FontWeight = 'bold';
btnMCROaTinitialize.Enable = 'off';
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize MCR OaT Model Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnMCROaTsaveComp = uibutton(glMCRpurestST);
% Position
btnMCROaTsaveComp.Layout.Row = 5;
btnMCROaTsaveComp.Layout.Column = [1 2];
% Style
btnMCROaTsaveComp.Text = "Save n° of components";
btnMCROaTsaveComp.FontSize = 10; 
btnMCROaTsaveComp.FontWeight = 'bold';
btnMCROaTsaveComp.Enable = 'off';

