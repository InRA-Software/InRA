%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Principal Component Analysis Layout %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Manage app layout
glPCA = uigridlayout(tabPCA,[12,14]);
%%
%%%%%%%%%%%%%%%%%%%%
% Coloring Samples %
%%%%%%%%%%%%%%%%%%%%
% Create
btnColorSamples = uibutton(glPCA);
% Position
btnColorSamples.Layout.Row = 1;
btnColorSamples.Layout.Column = 1;
% Style
btnColorSamples.Text = "Coloring"+newline+"Samples";
btnColorSamples.Enable = 'off';
btnColorSamples.FontSize = 11;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comparative Pretreatment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnComparativePre = uibutton(glPCA);
% Position
btnComparativePre.Layout.Row = 1;
btnComparativePre.Layout.Column = 2;
% Style
btnComparativePre.Text = "Comparative"+newline+"Pretreatment";
btnComparativePre.Enable = 'off';
btnComparativePre.FontSize = 11;
%%
%%%%%%%%%%
% Panels %
%%%%%%%%%%
% Create
pPreprocessing = uipanel(glPCA);
% Manage layout
glPre = uigridlayout(pPreprocessing, [13, 10]);
glPre.RowHeight = {16, 40, 16, 60, 16, 40, 16, 20, 16, 80};
% Style
pPreprocessing.Title = 'PCA Model Settings';
pPreprocessing.Layout.Row = [2 13];
pPreprocessing.Layout.Column = [1 2];
%%
%%%%%%%%%%%%%%%%%%%%%%
% PCA Model Settings %
%%%%%%%%%%%%%%%%%%%%%%
%% 
%%%%%%%%%%%%%%%%%%%
% Transformations %
%%%%%%%%%%%%%%%%%%%
% Create
lblTransformations = uilabel(glPre);
% Position
lblTransformations.Layout.Row = 1;
lblTransformations.Layout.Column = [1 10];
% Style
lblTransformations.FontSize = 13;
lblTransformations.FontWeight = "bold";
lblTransformations.FontColor = [0.5, 0.2, 0.5];
lblTransformations.HorizontalAlignment = "left";
lblTransformations.VerticalAlignment = "top";
lblTransformations.Text = "Transformations";
%%
%-------------------------
% Transformations options 
%-------------------------
% Create Transformations Options
ddTransformations = uibuttongroup(glPre);
ddTransformations.Layout.Row = 2;
ddTransformations.Layout.Column = [1 10];
ddTransformations.BorderType = 'none';
% Position
Transf1 = uiradiobutton(ddTransformations, 'Position', [5 25 101 15]);
Transf1.Text = 'None';
Transf1.Enable = "off";
Transf2 = uiradiobutton(ddTransformations, 'Position', [5 5 101 15]);
Transf2.Text = 'Log10';
Transf2.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%
% Scaling Options %
%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%
% Title Scaling %
%%%%%%%%%%%%%%%%%
% Create
lblScalingOptions = uilabel(glPre);
% Position
lblScalingOptions.Layout.Row = 3;
lblScalingOptions.Layout.Column = [1 10]; 
% Style
lblScalingOptions.FontSize = 13;
lblScalingOptions.FontWeight = "bold";
lblScalingOptions.FontColor = [0, 0.2, 0];
lblScalingOptions.HorizontalAlignment = "left";
lblScalingOptions.VerticalAlignment = "top";
lblScalingOptions.Text = "Scaling Options";

% Create Scaling Options
ddPCAScaling = uibuttongroup(glPre);
ddPCAScaling.Layout.Row = 4;
ddPCAScaling.Layout.Column = [1 10];
ddPCAScaling.BorderType = 'none';
% Position
Sc1 = uiradiobutton(ddPCAScaling, 'Position', [5 45 100 15]);
Sc1.Text = 'None';
Sc1.Enable = "off";
Sc2 = uiradiobutton(ddPCAScaling, 'Position', [5 25 100 15]);
Sc2.Text = 'Pareto Scaling';
Sc2.Enable = "off";
Sc3 = uiradiobutton(ddPCAScaling, 'Position', [5 5 110 15]);
Sc3.Text = 'Variance Scaling';
Sc3.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Title Mean Centered %
%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblMeanCentered = uilabel(glPre);
% Position
lblMeanCentered.Layout.Row = 5;
lblMeanCentered.Layout.Column = [1 10];
% Style
lblMeanCentered.FontSize = 13;
lblMeanCentered.FontWeight = "bold";
lblMeanCentered.FontColor = [0.5, 0.2, 0.5];
lblMeanCentered.HorizontalAlignment = "left";
lblMeanCentered.VerticalAlignment = "top";
lblMeanCentered.Text = "Mean Centered";
%%
%%%%%%%%%%%%%%%%%
% Mean Centered %
%%%%%%%%%%%%%%%%%
% Create Mean Center Options
ddPCAMean = uibuttongroup(glPre);
ddPCAMean.Layout.Row = 6;
ddPCAMean.Layout.Column = [1 10];
ddPCAMean.BorderType = 'none';
% Position
Mc1 = uiradiobutton(ddPCAMean, 'Position', [5 25 101 15]);
Mc1.Text = 'None';
Mc1.Enable = "off";
Mc2 = uiradiobutton(ddPCAMean, 'Position', [5 5 101 15]);
Mc2.Text = 'Mean Center';
Mc2.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selection of Principal Components %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%
% Title Selection PCs %
%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblSelectPC = uilabel(glPre);
% Position
lblSelectPC.Layout.Row = 7;
lblSelectPC.Layout.Column = [1 10]; 
% Style
lblSelectPC.FontSize = 13;
lblSelectPC.FontWeight = "bold";
lblSelectPC.FontColor = [0, 0, 0.5];
lblSelectPC.HorizontalAlignment = "left";
lblSelectPC.VerticalAlignment = "top";
lblSelectPC.Text = "Selection of PCs";

% Create Spinner for PCA Components 
sPCAComponents = uispinner(glPre);
% Create Labels for Spinners
labelPCAComponents = uilabel(glPre, 'Text', 'Number of PCs');
labelPCAComponents.FontWeight = 'bold';
labelPCAComponents.FontSize = 10;
labelPCAComponents.HorizontalAlignment = "right";
% Position Labels
labelPCAComponents.Layout.Row = 8;
labelPCAComponents.Layout.Column = [1 6];
% Position
sPCAComponents.Layout.Row = 8;
sPCAComponents.Layout.Column = [7 10];
% Style
sPCAComponents.Limits = [2 20];
sPCAComponents.Step = 1;
sPCAComponents.Value = 5;
sPCAComponents.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%
% Graphical Outputs %
%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Graphical Outputs %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblGraphicalOut = uilabel(glPre);
% Position
lblGraphicalOut.Layout.Row = 9;
lblGraphicalOut.Layout.Column = [1 10]; 
% Style
lblGraphicalOut.FontSize = 13;
lblGraphicalOut.FontWeight = "bold";
lblGraphicalOut.FontColor = [0.5, 0, 0];
lblGraphicalOut.HorizontalAlignment = "left";
lblGraphicalOut.VerticalAlignment = "top";
lblGraphicalOut.Text = "Graphical Outputs";

% Create Graphical Outputs Options
ddGraOut = uibuttongroup(glPre);
ddGraOut.Layout.Row = 10;
ddGraOut.Layout.Column = [1 10];
ddGraOut.BorderType = 'none';
% Position
Gra1 = uiradiobutton(ddGraOut, 'Position', [5 65 150 15]);
Gra1.Text = 'Explained Variance';
Gra1.Enable = "off";
Gra2 = uiradiobutton(ddGraOut, 'Position', [5 45 150 15]);
Gra2.Text = 'Cumulative Variance';
Gra2.Enable = "off";
Gra3 = uiradiobutton(ddGraOut, 'Position', [5 25 150 15]);
Gra3.Text = 'RMSEC/RMSECV';
Gra3.Enable = "off";
%Gra4 = uiradiobutton(ddGraOut, 'Position', [5 25 150 15]);
%Gra4.Text = 'Q Contributions';
%Gra4.Enable = "off";
Gra5 = uiradiobutton(ddGraOut, 'Position', [5 5 150 15]);
Gra5.Text = 'Resolved ST';
Gra5.Enable = "off";

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build PCA Model Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnPCA = uibutton(glPCA);
% Position
btnPCA.Layout.Row = 14;
btnPCA.Layout.Column = 1;
% Style
btnPCA.Text = 'Build Model';
btnPCA.FontSize = 11; 
btnPCA.FontWeight = 'bold';
btnPCA.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comparative PCA Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnComparativePCA = uibutton(glPCA);
% Position
btnComparativePCA.Layout.Row = 14;
btnComparativePCA.Layout.Column = 2;
% Style
btnComparativePCA.Text = "Comparative"+newline+"PCA";
btnComparativePCA.FontSize = 11; 
btnComparativePCA.FontWeight = 'bold';
btnComparativePCA.Enable = "off";
%%
%%%%%%%%%%%%%%
% Score Plot %
%%%%%%%%%%%%%%
% Create
axScores = uiaxes(glPCA);
% Positions
axScores.Layout.Row = [1 7];
axScores.Layout.Column = [3 8];
% Style
axScores.InnerPosition = [0 0 1 1];
axScores.XLabel.String = 'PC';
axScores.YLabel.String = 'PC';
axScores.Title.String = 'Scores Plot';
axScores.Title.FontWeight = 'bold';
axScores.Title.FontSize = 12;
axScores.XGrid = 'on';
axScores.YGrid = 'on';
yline(axScores, 0,'Color','black', 'Alpha', 0.4)
%%
%%%%%%%%%%%%%%%%%%%%
% Title Score List %
%%%%%%%%%%%%%%%%%%%%
% Create
lblPCsList = uilabel(glPCA);
% Position
lblPCsList.Layout.Row = 1;
lblPCsList.Layout.Column = 9;
% Style
lblPCsList.Text = "PCs List";
lblPCsList.FontSize = 12;
lblPCsList.FontWeight = "bold";
lblPCsList.HorizontalAlignment = "center";
lblPCsList.VerticalAlignment = "bottom";
%%%%%%%%%%%%%%
% Score List %
%%%%%%%%%%%%%%
% Create
listScores = uilistbox(glPCA);
% Position
listScores.Layout.Row = [2 3];
listScores.Layout.Column = 9;
listScores.Items = "None";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw Ellipse Check Box %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
cbxDrawEllipse = uicheckbox(glPCA);
% Position
cbxDrawEllipse.Layout.Row = 5;
cbxDrawEllipse.Layout.Column = 9;
% Style
cbxDrawEllipse.Text = "  95%"+newline+"ellipse";
cbxDrawEllipse.Enable = "off";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STATISTICS RESULTS Panel %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
pStatisticsRes = uipanel(glPCA);
% Manage layout
glStatisticsRes = uigridlayout(pStatisticsRes, [6, 6]);
%glStatisticsRes.RowHeight = {'1x', '1x', 25, 30, ...
%    30, '1x'};
% Position
pStatisticsRes.Layout.Row = [1 6];
pStatisticsRes.Layout.Column = [11 14];
% Style
pStatisticsRes.Title = 'STATISTICS RESULTS';
pStatisticsRes.TitlePosition = 'centertop';
%%
%%%%%%%%%%%%%%%%%%
% Variance Table %
%%%%%%%%%%%%%%%%%%
%%
% Create
VarianceTable = uitable(glStatisticsRes);
% Position
VarianceTable.Layout.Row = [1 6];
VarianceTable.Layout.Column = [1 6];%[11 13];
% Style
VarianceTable.ColumnName = {"Explained"+newline+"Variance (%)"; ...
    "Cumulative"+newline+"Variance (%)"; "RMSEC"; "RMSECV"};
VarianceTable.ColumnWidth = "fit";
%%
%%%%%%%%%%%%%%%%
% Loading Plot %
%%%%%%%%%%%%%%%%
% Create
axLoading = uiaxes(glPCA);
% Positions
axLoading.Layout.Row = [8 14];
axLoading.Layout.Column = [3 8];
% Style
axLoading.InnerPosition = [0 0 1 1];
axLoading.XLabel.String = 'C-Profiles';
axLoading.YLabel.String = 'Loading';
axLoading.Title.String = 'Loading Plot';
axLoading.Title.FontWeight = 'bold';
axLoading.Title.FontSize = 12;
axLoading.XGrid = 'on';
axLoading.YGrid = 'on';
%%
%%%%%%%%%%%%%%%%%%%%%%
% Title Loading List %
%%%%%%%%%%%%%%%%%%%%%%
% Create
lblLoadingList = uilabel(glPCA);
% Position
lblLoadingList.Layout.Row = 8;
lblLoadingList.Layout.Column = 9;
% Style
lblLoadingList.Text = "Loading List";
lblLoadingList.FontSize = 12;
lblLoadingList.FontWeight = "bold";
lblLoadingList.HorizontalAlignment = "center";
lblLoadingList.VerticalAlignment = "bottom";
%%%%%%%%%%%%%%%%
% Loading List %
%%%%%%%%%%%%%%%%
% Create
listLoading = uilistbox(glPCA);
% Position
listLoading.Layout.Row = [9 10];
listLoading.Layout.Column = 9;
listLoading.Items = "None";
%%
%%%%%%%%%%%%%%%%%%%%%%%%
% Title Component-ST List %
%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblComponentST = uilabel(glPCA);
% Position
lblComponentST.Layout.Row = 11;
lblComponentST.Layout.Column = 9;
% Style
lblComponentST.Text = "MCR"+newline+ "Component";
lblComponentST.FontSize = 12;
lblComponentST.FontWeight = "bold";
lblComponentST.HorizontalAlignment = "center";
lblComponentST.VerticalAlignment = "bottom";
%%%%%%%%%%%%%%%%%%%%%
% Component-ST List %
%%%%%%%%%%%%%%%%%%%%%
% Create
listComponentST = uilistbox(glPCA);
% Position
listComponentST.Layout.Row = [12 13];
listComponentST.Layout.Column = 9;
listComponentST.Items = "None";
listComponentST.Enable = "off";
%%
%%%%%%%%%%%%%%%%
% Variance Plot %
%%%%%%%%%%%%%%%%
% Create
axVariance= uiaxes(glPCA);
% Positions
axVariance.Layout.Row = [7 14];
axVariance.Layout.Column = [10 14];
% Style
axVariance.InnerPosition = [0 0 1 1];
axVariance.XGrid = 'on';
axVariance.YGrid = 'on';
%axVariance.XLabel.String = 'Number of Principal Components';
%axVariance.YLabel.String = 'Variance (%)';
