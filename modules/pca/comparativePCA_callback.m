function comparativePCA_callback(src, ~, ffig)

% Check if Models were built
if ~isfield(src.UserData, 'OriginalData')
    uialert(ffig, 'You need to Build Model with Original Processed Spectra to use this option', ...
        'Error', 'Icon', 'error');
elseif ~isfield(src.UserData, 'BinnedData')
    uialert(ffig, 'You need to Build Model with Bucket Spectra to use this option', ...
        'Error', 'Icon', 'error');
else

% Create figure window
figCPCA = uifigure('Name', 'Comparative PCA');
figCPCA.WindowStyle = "modal";
figCPCA.WindowState = "normal";
figCPCA.Position = [50 50 1200 620];
figCPCA.Resize = 'on';

%%%%%%%%%%%%%%%%%
% Figure Layout %
%%%%%%%%%%%%%%%%%
glCPCA = uigridlayout(figCPCA,[2,4]);
glCPCA.ColumnWidth = {150, '1x', '1x', '1x'};

%%%%%%%%%%%%%%%%%%%
% Left-Top layout %
%%%%%%%%%%%%%%%%%%%
glLeftTop = uigridlayout(glCPCA, [2, 1]);
glLeftTop.RowHeight = {'1x', 'Fit'};
% Style
glLeftTop.Layout.Row = 1;
glLeftTop.Layout.Column = 1;
%%%%%%%%%%%%%%%%%%
% PCs List Panel %
%%%%%%%%%%%%%%%%%%
% Create
pLeftPC = uipanel(glLeftTop);
% Manage layout
glpLeftPC = uigridlayout(pLeftPC, [3, 1]);
glpLeftPC.RowHeight = {'fit', 'fit', 'fit'};
% Style
pLeftPC.Title = 'PCs List';
pLeftPC.TitlePosition = 'centertop';
pLeftPC.Layout.Row = 1;
pLeftPC.Layout.Column = 1;
%{
%%%%%%%%%%%%%%
% Score List %
%%%%%%%%%%%%%%
% Create
listScores_CPCA = uilistbox(glpLeftPC);
% Position
listScores_CPCA.Layout.Row = 1;
listScores_CPCA.Layout.Column = 1;
listScores_CPCA.Items = "None";
%}
%%%%%%%%%%%%%%%%%
% Score Buttons %
%%%%%%%%%%%%%%%%%
%-----------
% Original 
%-----------
% Create
btnScoresO = uibutton(glpLeftPC);
% Position
btnScoresO.Layout.Row = 1;
btnScoresO.Layout.Column = 1;
% Style
btnScoresO.Text = "Original Processed";
btnScoresO.FontSize = 11;
btnScoresO.UserData = 1;
%---------
% Res Int 
%---------
% Create
btnScoresRI = uibutton(glpLeftPC);
% Position
btnScoresRI.Layout.Row = 2;
btnScoresRI.Layout.Column = 1;
% Style
btnScoresRI.Text = "C-Features";
btnScoresRI.FontSize = 11;
btnScoresRI.UserData = 2;
%---------
% Binned 
%---------
% Create
btnScoresB = uibutton(glpLeftPC);
% Position
btnScoresB.Layout.Row = 3;
btnScoresB.Layout.Column = 1;
% Style
btnScoresB.Text = "Bucket Spectra";
btnScoresB.FontSize = 11;
btnScoresB.UserData = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw Ellipse Check Box %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
cbxEllipse = uicheckbox(glLeftTop);
% Position
cbxEllipse.Layout.Row = 2;
cbxEllipse.Layout.Column = 1;
% Style
cbxEllipse.Text = "  95% ellipse";
cbxEllipse.Enable = "on";

%%%%%%%%%%%%%%%%%%%%%%
% Left-Bottom layout %
%%%%%%%%%%%%%%%%%%%%%%
glLeftBottom = uigridlayout(glCPCA, [1, 1]);
glLeftBottom.RowHeight = {'1x'};
% Style
glLeftBottom.Layout.Row = 2;
glLeftBottom.Layout.Column = 1;
%%%%%%%%%%%%%%%%%%%%%
% Loading List Panel %
%%%%%%%%%%%%%%%%%%%%%
% Create
pLeftLoading = uipanel(glLeftBottom);
% Manage layout
glpLeftLoading = uigridlayout(pLeftLoading, [1, 1]);
% Style
pLeftLoading.Title = 'Loading List';
pLeftLoading.TitlePosition = 'centertop';
pLeftLoading.Layout.Row = 1;
pLeftLoading.Layout.Column = 1;
%%%%%%%%%%%%%%
% Score List %
%%%%%%%%%%%%%%
% Create
listLoading_CPCA = uilistbox(glpLeftLoading);
% Position
listLoading_CPCA.Layout.Row = 1;
listLoading_CPCA.Layout.Column = 1;
listLoading_CPCA.Items = "None";

%%%%%%%%%%%%%%%%%
% Score Plot O %
%%%%%%%%%%%%%%%%%
% Create
axScoresO = uiaxes(glCPCA);
% Positions
axScoresO.Layout.Row = 1;
axScoresO.Layout.Column = 2;
% Style
axScoresO.InnerPosition = [0 0 1 1];
axScoresO.XLabel.String = 'PC';
axScoresO.YLabel.String = 'PC';
axScoresO.Title.String = 'Scores Plot Original Processed';
axScoresO.Title.FontWeight = 'bold';
axScoresO.Title.FontSize = 12;
axScoresO.XGrid = 'on';
axScoresO.YGrid = 'on';
yline(axScoresO, 0,'Color','black', 'Alpha', 0.4)
%%%%%%%%%%%%%%%%%%%%%%
% Tab Group Original %
%%%%%%%%%%%%%%%%%%%%%%
% Create
tabgpOri = uitabgroup(glCPCA);
% Positions
tabgpOri.Layout.Row = 2;
tabgpOri.Layout.Column = 2;
tabStatsOriginal = uitab(tabgpOri,"Title","Statistics Results");
tabLoadingOriginal = uitab(tabgpOri,"Title","Loading Plot");
%%%%%%%%%%%%%%%%%%%%%%%%
% Tab Loading Original %
%%%%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabLoadOri = uigridlayout(tabLoadingOriginal,[1,1]);
%-----------------
% Loading Plot O 
%-----------------
% Create
axLoadingO = uiaxes(glTabLoadOri);
% Positions
axLoadingO.Layout.Row = 1;
axLoadingO.Layout.Column = 1;
% Style
axLoadingO.InnerPosition = [0 0 1 1];
axLoadingO.XLabel.String = 'δ^{1}H(ppm)';
axLoadingO.YLabel.String = 'Loading';
axLoadingO.Title.String = 'Loading Plot';
axLoadingO.Title.FontWeight = 'bold';
axLoadingO.Title.FontSize = 12;
axLoadingO.XGrid = 'on';
axLoadingO.YGrid = 'on';
axLoadingO.XAxis.Direction = 'reverse';
%axLoadingO.XLim = [Ppm(1), Ppm(end)];
%%%%%%%%%%%%%%%%%%%%%%
% Tab Stats Original %
%%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabStatsOri = uigridlayout(tabStatsOriginal,[1,1]);
%---------------------
% Statistics Original 
%---------------------
%%
% Create
tableOriginal = uitable(glTabStatsOri);
% Position
tableOriginal.Layout.Row = 1;
tableOriginal.Layout.Column = 1;
% Style
tableOriginal.ColumnName = {"Explained"+newline+"Variance (%)"; ...
    "Cumulative"+newline+"Variance (%)"; "RMSEC"; "RMSECV"};
tableOriginal.ColumnWidth = "fit";
%%
%%%%%%%%%%%%%%%%%
% Score Plot RI %
%%%%%%%%%%%%%%%%%
% Create
axScoresRI = uiaxes(glCPCA);
% Positions
axScoresRI.Layout.Row = 1;
axScoresRI.Layout.Column = 3;
% Style
axScoresRI.InnerPosition = [0 0 1 1];
axScoresRI.XLabel.String = 'PC';
axScoresRI.YLabel.String = 'PC';
axScoresRI.Title.String = 'Scores Plot C-Features';
axScoresRI.Title.FontWeight = 'bold';
axScoresRI.Title.FontSize = 12;
axScoresRI.XGrid = 'on';
axScoresRI.YGrid = 'on';
yline(axScoresRI, 0,'Color','black', 'Alpha', 0.4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tab Group Resonance Integration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
tabgpResInt = uitabgroup(glCPCA);
% Positions
tabgpResInt.Layout.Row = 2;
tabgpResInt.Layout.Column = 3;
tabStatsResInt = uitab(tabgpResInt,"Title","Statistics Results");
tabLoadingResInt = uitab(tabgpResInt,"Title","Loading Plot");
%%%%%%%%%%%%%%%%%%%%%%%
% Tab Loading Res Int %
%%%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabLoadResInt = uigridlayout(tabLoadingResInt,[1,1]);
%-----------------
% Loading Plot RI 
%-----------------
% Create
axLoadingRI = uiaxes(glTabLoadResInt);
% Positions
axLoadingRI.Layout.Row = 1;
axLoadingRI.Layout.Column = 1;
% Style
axLoadingRI.InnerPosition = [0 0 1 1];
axLoadingRI.XLabel.String = 'C-Profiles';
axLoadingRI.YLabel.String = 'Loading';
axLoadingRI.Title.String = 'Loading Plot';
axLoadingRI.Title.FontWeight = 'bold';
axLoadingRI.Title.FontSize = 12;
axLoadingRI.XGrid = 'on';
axLoadingRI.YGrid = 'on';
%%%%%%%%%%%%%%%%%%%%%
% Tab Stats Res Int %
%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabStatsResInt = uigridlayout(tabStatsResInt,[1,1]);
%---------------------
% Statistics Res Int 
%---------------------
%%
% Create
tableResInt = uitable(glTabStatsResInt);
% Position
tableResInt.Layout.Row = 1;
tableResInt.Layout.Column = 1;
% Style
tableResInt.ColumnName = {"Explained"+newline+"Variance (%)"; ...
    "Cumulative"+newline+"Variance (%)"; "RMSEC"; "RMSECV"};
tableResInt.ColumnWidth = "fit";
%%%%%%%%%%%%%%%%%%%%%%
% Score Plot Binning %
%%%%%%%%%%%%%%%%%%%%%%
% Create
axScoresB = uiaxes(glCPCA);
% Positions
axScoresB.Layout.Row = 1;
axScoresB.Layout.Column = 4;
% Style
axScoresB.InnerPosition = [0 0 1 1];
axScoresB.XLabel.String = 'PC';
axScoresB.YLabel.String = 'PC';
axScoresB.Title.String = 'Scores Plot Bucket Spectra';
axScoresB.Title.FontWeight = 'bold';
axScoresB.Title.FontSize = 12;
axScoresB.XGrid = 'on';
axScoresB.YGrid = 'on';
yline(axScoresB, 0,'Color','black', 'Alpha', 0.4)
%%%%%%%%%%%%%%%%%%%%%
% Tab Group Binning %
%%%%%%%%%%%%%%%%%%%%%
% Create
tabgpBinning = uitabgroup(glCPCA);
% Positions
tabgpBinning.Layout.Row = 2;
tabgpBinning.Layout.Column = 4;
tabStatsBinning = uitab(tabgpBinning,"Title","Statistics Results");
tabLoadingBinning = uitab(tabgpBinning,"Title","Loading Plot");
%%%%%%%%%%%%%%%%%%%%%%%
% Tab Loading Binning %
%%%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabLoadBinning = uigridlayout(tabLoadingBinning,[1,1]);
%----------------------
% Loading Plot Binning 
%----------------------
% Create
axLoadingB = uiaxes(glTabLoadBinning);
% Positions
axLoadingB.Layout.Row = 1;
axLoadingB.Layout.Column = 1;
% Style
axLoadingB.InnerPosition = [0 0 1 1];
axLoadingB.XLabel.String = 'δ^{1}H(ppm)';
axLoadingB.YLabel.String = 'Loading';
axLoadingB.Title.String = 'Loading Plot';
axLoadingB.Title.FontWeight = 'bold';
axLoadingB.Title.FontSize = 12;
axLoadingB.XGrid = 'on';
axLoadingB.YGrid = 'on';
axLoadingB.XAxis.Direction = 'reverse';
%axLoadingB.XLim = [Ppm(1), Ppm(end)];
%%%%%%%%%%%%%%%%%%%%%
% Tab Stats Binning %
%%%%%%%%%%%%%%%%%%%%%
% Manage tab layout
glTabStatsBinning = uigridlayout(tabStatsBinning,[1,1]);
%---------------------
% Statistics Res Int 
%---------------------
%%
% Create
tableBinning = uitable(glTabStatsBinning);
% Position
tableBinning.Layout.Row = 1;
tableBinning.Layout.Column = 1;
% Style
tableBinning.ColumnName = {"Explained"+newline+"Variance (%)"; ...
    "Cumulative"+newline+"Variance (%)"; "RMSEC"; "RMSECV"};
tableBinning.ColumnWidth = "fit";

%%
%% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting Score Results %
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Recover data in Comparative PCA Button
selectedColors = src.UserData.selectedColors;
selectedSamples =src.UserData.selectedSamples;
scoresO = src.UserData.OriginalData.Scores;
scoresRI = src.UserData.CFeatures.Scores;
scoresB = src.UserData.BinnedData.Scores;

%------------------------------
% Plot Scores Original Spectra
%------------------------------
cla(axScoresO)
hold(axScoresO,"on")

for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    s = scatter(axScoresO,scoresO(firstS:lastS,1), ...
        scoresO(firstS:lastS,2), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresO.XLabel.String = 'PC1';
axScoresO.YLabel.String = 'PC2';

% Draw the 95% error ellipse
[XXO, YYO] = ellipse(scoresO(:,1), scoresO(:,2));
plot(axScoresO, XXO, YYO, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisO = findobj(axScoresO, "Type", "line");
if cbxEllipse.Value 
    ellipseVisO.Visible = "on";
else
    ellipseVisO.Visible = "off";
end

hold(axScoresO, "off")

%---------------------
% Plot Scores Res Int
%---------------------
cla(axScoresRI)
hold(axScoresRI,"on")

for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    s = scatter(axScoresRI,scoresRI(firstS:lastS,1), ...
        scoresRI(firstS:lastS,2), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresRI.XLabel.String = 'PC1';
axScoresRI.YLabel.String = 'PC2';

% Draw the 95% error ellipse
[XXRI, YYRI] = ellipse(scoresRI(:,1), scoresRI(:,2));
plot(axScoresRI, XXRI, YYRI, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisRI = findobj(axScoresRI, "Type", "line");
if cbxEllipse.Value 
    ellipseVisRI.Visible = "on";
else
    ellipseVisRI.Visible = "off";
end

hold(axScoresRI, "off")

%---------------------
% Plot Scores Binned
%---------------------
cla(axScoresB)
hold(axScoresB,"on")

for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    s = scatter(axScoresB,scoresB(firstS:lastS,1), ...
        scoresB(firstS:lastS,2), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresB.XLabel.String = 'PC1';
axScoresB.YLabel.String = 'PC2';

% Draw the 95% error ellipse
[XXB, YYB] = ellipse(scoresB(:,1), scoresB(:,2));
plot(axScoresB, XXB, YYB, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisB = findobj(axScoresB, "Type", "line");
if cbxEllipse.Value 
    ellipseVisB.Visible = "on";
else
    ellipseVisB.Visible = "off";
end

hold(axScoresB, "off")

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filling Statistics Tables with Results %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Recover data in Comparative PCA Button
explained_varianceO = src.UserData.OriginalData.explained_variance;
cumulative_varianceO = src.UserData.OriginalData.cumulative_variance;
rmsec_valuesO = src.UserData.OriginalData.rmsec_values;
rmsecv_valuesO = src.UserData.OriginalData.rmsecv_values;
numComponentsO = src.UserData.OriginalData.numComponents;
explained_varianceRI = src.UserData.CFeatures.explained_variance;
cumulative_varianceRI = src.UserData.CFeatures.cumulative_variance;
rmsec_valuesRI = src.UserData.CFeatures.rmsec_values;
rmsecv_valuesRI = src.UserData.CFeatures.rmsecv_values;
numComponentsRI = src.UserData.CFeatures.numComponents;
explained_varianceB = src.UserData.BinnedData.explained_variance;
cumulative_varianceB = src.UserData.BinnedData.cumulative_variance;
rmsec_valuesB = src.UserData.BinnedData.rmsec_values;
rmsecv_valuesB = src.UserData.BinnedData.rmsecv_values;
numComponentsB = src.UserData.BinnedData.numComponents;

%------------------------------
% Stats Table Original Spectra
%------------------------------ 
tableOriginal.Data = [explained_varianceO(1:numComponentsO), ...
    cumulative_varianceO, rmsec_valuesO, rmsecv_valuesO];

%---------------------
% Stats Table Res Int
%--------------------- 
tableResInt.Data = [explained_varianceRI(1:numComponentsRI), ...
    cumulative_varianceRI, rmsec_valuesRI, rmsecv_valuesRI];

%----------------------------
% Stats Table Binned Spectra
%---------------------------- 
tableBinning.Data = [explained_varianceB(1:numComponentsB), ...
    cumulative_varianceB, rmsec_valuesB, rmsecv_valuesB];

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting Loading Results %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recover data in Comparative PCA Button
loadingsO = src.UserData.OriginalData.Loadings;
PpmO = src.UserData.OriginalData.Ppm;   
loadingsReg1O = src.UserData.OriginalData.loadingsReg1;
loadingsReg2O = src.UserData.OriginalData.loadingsReg2;
loadingsReg3O = src.UserData.OriginalData.loadingsReg3;
%
loadingsRI = src.UserData.CFeatures.Loadings;
NumConcReg1RI = src.UserData.CFeatures.numConcReg1;
NumConcReg2RI = src.UserData.CFeatures.numConcReg2;
NumConcReg3RI = src.UserData.CFeatures.numConcReg3;    
loadingsReg1RI = src.UserData.CFeatures.loadingsReg1;
loadingsReg2RI = src.UserData.CFeatures.loadingsReg2;
loadingsReg3RI = src.UserData.CFeatures.loadingsReg3;
%
loadingsB = src.UserData.BinnedData.Loadings;
PpmB = src.UserData.BinnedData.Ppm;   
loadingsReg1B = src.UserData.BinnedData.loadingsReg1;
loadingsReg2B = src.UserData.BinnedData.loadingsReg2;
loadingsReg3B = src.UserData.BinnedData.loadingsReg3;

loadings_listItemDataO = src.UserData.OriginalData.loadings_listItemData;
loadings_listItemDataRI = src.UserData.CFeatures.loadings_listItemData;
loadings_listItemDataB = src.UserData.BinnedData.loadings_listItemData;

sizeO = size(loadings_listItemDataO,2);
sizeRI = size(loadings_listItemDataRI,2);
sizeB = size(loadings_listItemDataB,2);

if sizeO >= sizeRI
    if sizeO >= sizeB
        loadings_list = src.UserData.OriginalData.loadings_list;
        loadings_listItemData = loadings_listItemDataO;
    else
        loadings_list = src.UserData.BinnedData.loadings_list;
        loadings_listItemData = loadings_listItemDataB;
    end
else 
    if sizeRI >= sizeB
        loadings_list = src.UserData.CFeatures.loadings_list;
        loadings_listItemData = loadings_listItemDataRI;
    else
        loadings_list = src.UserData.BinnedData.loadings_list;
        loadings_listItemData = loadings_listItemDataB;
    end
end

% Add items to list Loading
listLoading_CPCA.Items = loadings_list;
listLoading_CPCA.ItemsData = loadings_listItemData;

% Colors region
    colorReg1 = [128/255, 0, 128/255]; %morado
    colorReg2 = [0, 128/255, 0]; % verde
    colorReg3 = [0, 0, 128/255]; % azul

%--------------------------------
% Plot Loadings Original Spectra
%--------------------------------
cla(axLoadingO)
axLoadingO.Title.String = "Loading Plot  -  PC"+num2str(1);
hold(axLoadingO, "on")
plot(axLoadingO, PpmO(loadingsReg1O), ...
        loadingsO(loadingsReg1O,1), 'Color', colorReg1);
plot(axLoadingO, PpmO(loadingsReg2O), ...
        loadingsO(loadingsReg2O,1), 'Color', colorReg2);
plot(axLoadingO, PpmO(loadingsReg3O), ...
        loadingsO(loadingsReg3O,1), 'Color', colorReg3);
axLoadingO.XLim = [PpmO(1), PpmO(end)];
hold(axLoadingO, "off")

%-----------------------
% Plot Loadings Res Int
%-----------------------
cla(axLoadingRI)
axLoadingRI.Title.String = "Loading Plot  -  PC"+num2str(1);
hold(axLoadingRI, "on")
b = bar(axLoadingRI, loadingsRI(:,1));
b.FaceColor = 'flat';
% Coloring regions
b.CData(loadingsReg1RI,:) = repmat(colorReg1, NumConcReg1RI, 1);
b.CData(loadingsReg2RI,:) = repmat(colorReg2, NumConcReg2RI, 1);
b.CData(loadingsReg3RI,:) = repmat(colorReg3, NumConcReg3RI, 1);
axLoadingRI.XLim = [0, size(loadingsRI(:,1),1)];
hold(axLoadingRI, "off")

%------------------------------
% Plot Loadings Binned Spectra
%------------------------------
cla(axLoadingB)
axLoadingB.Title.String = "Loading Plot  -  PC"+num2str(1);
hold(axLoadingB, "on")
plot(axLoadingB, PpmB(loadingsReg1B), ...
        loadingsB(loadingsReg1B,1), 'Color', colorReg1);
plot(axLoadingB, PpmB(loadingsReg2B), ...
        loadingsB(loadingsReg2B,1), 'Color', colorReg2);
plot(axLoadingB, PpmB(loadingsReg3B), ...
        loadingsB(loadingsReg3B,1), 'Color', colorReg3);
axLoadingB.XLim = [PpmB(1), PpmB(end)];
hold(axLoadingB, "off")

%%
%%
%%                              BEHAVIORS
%%
%%
%%

% Draw ellipse?
cbxEllipse.ValueChangedFcn = {@drawEllipseCPCA_callback, axScoresO, ...
    axScoresRI, axScoresB};

%{
% List' Scores
listScores_CPCA.ValueChangedFcn = {@listScoresCPCA_callback, cbxEllipse, ...
    axScoresO, axScoresRI, axScoresB, src};
%}
% Select PC to Plot Scores
btnScoresO.ButtonPushedFcn = {@selectWindowCPCA_callback, src, ...
    cbxEllipse, axScoresO};
btnScoresRI.ButtonPushedFcn = {@selectWindowCPCA_callback, src, ...
    cbxEllipse, axScoresRI};
btnScoresB.ButtonPushedFcn = {@selectWindowCPCA_callback, src, ...
    cbxEllipse, axScoresB};

% List's Loadings
listLoading_CPCA.ValueChangedFcn = {@listLoadingCPCA_callback, ...
    axLoadingO, axLoadingRI, axLoadingB, src};


end % end if of beggining

end


%%
%%
%%                              CALLBACKS
%%
%%
%%

%%%%%%%%%%%%%%%%
% Draw Ellipse %
%%%%%%%%%%%%%%%%
function drawEllipseCPCA_callback(~, event, axScoresO, axScoresRI, ...
    axScoresB)

ellipseVisO = findobj(axScoresO, "Type", "line");
ellipseVisRI = findobj(axScoresRI, "Type", "line");
ellipseVisB = findobj(axScoresB, "Type", "line");

if event.Value 
    ellipseVisO.Visible = "on";
    ellipseVisRI.Visible = "on";
    ellipseVisB.Visible = "on";
else
    ellipseVisO.Visible = "off";
    ellipseVisRI.Visible = "off";
    ellipseVisB.Visible = "off";
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selecting PC to Plot Score %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ScoresCPCA_callback(~, ~, boton, data, cbxEllipse, axPlotSc, ...
    listPC)

% Recover data
selectedColors = data.UserData.selectedColors;
selectedSamples = data.UserData.selectedSamples;

switch boton.UserData

case 1 % Original Processed
scoresO = data.UserData.OriginalData.Scores;
%------------------------------
% Plot Scores Original Spectra
%------------------------------
cla(axPlotSc)
hold(axPlotSc,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axPlotSc,scoresO(firstS:lastS,1), ...
        scoresO(firstS:lastS,listPC.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axPlotSc.YLabel.String = "PC"+num2str(listPC.Value);

% Draw the 95% error ellipse
[XXO, YYO] = ellipse(scoresO(:,1), scoresO(:,listPC.Value));
plot(axPlotSc, XXO, YYO, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisO = findobj(axPlotSc, "Type", "line");
if cbxEllipse.Value 
    ellipseVisO.Visible = "on";
else
    ellipseVisO.Visible = "off";
end

hold(axPlotSc,'off')

case 2 % C-Features
scoresRI = data.UserData.CFeatures.Scores;
%------------------------------
% Plot Scores Res Int Spectra
%------------------------------
cla(axPlotSc)
hold(axPlotSc,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axPlotSc,scoresRI(firstS:lastS,1), ...
        scoresRI(firstS:lastS,listPC.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axPlotSc.YLabel.String = "PC"+num2str(listPC.Value);

% Draw the 95% error ellipse
[XXRI, YYRI] = ellipse(scoresRI(:,1), scoresRI(:,listPC.Value));
plot(axPlotSc, XXRI, YYRI, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisRI = findobj(axPlotSc, "Type", "line");
if cbxEllipse.Value 
    ellipseVisRI.Visible = "on";
else
    ellipseVisRI.Visible = "off";
end

hold(axPlotSc,'off')

case 3 % Bucket Spectra
scoresB = data.UserData.BinnedData.Scores;
%----------------------------
% Plot Scores Binned Spectra
%----------------------------
cla(axPlotSc)
hold(axPlotSc,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axPlotSc,scoresB(firstS:lastS,1), ...
        scoresB(firstS:lastS,listPC.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axPlotSc.YLabel.String = "PC"+num2str(listPC.Value);

% Draw the 95% error ellipse
[XXB, YYB] = ellipse(scoresB(:,1), scoresB(:,listPC.Value));
plot(axPlotSc, XXB, YYB, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisB = findobj(axPlotSc, "Type", "line");
if cbxEllipse.Value 
    ellipseVisB.Visible = "on";
else
    ellipseVisB.Visible = "off";
end

hold(axPlotSc,'off')

end

end

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selecting PC in listScore %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function listScoresCPCA_callback(~, event, cbxEllipse, axScoresO, ...
    axScoresRI, axScoresB, data)

% Recover data
selectedColors = data.UserData.selectedColors;
selectedSamples =data.UserData.selectedSamples;
scoresO = data.UserData.OriginalData.Scores;
scoresRI = data.UserData.CFeatures.Scores;
scoresB = data.UserData.BinnedData.Scores;

%------------------------------
% Plot Scores Original Spectra
%------------------------------
cla(axScoresO)
hold(axScoresO,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axScoresO,scoresO(firstS:lastS,1), ...
        scoresO(firstS:lastS,event.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresO.YLabel.String = "PC"+num2str(event.Value);

% Draw the 95% error ellipse
[XXO, YYO] = ellipse(scoresO(:,1), scoresO(:,event.Value));
plot(axScoresO, XXO, YYO, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisO = findobj(axScoresO, "Type", "line");
if cbxEllipse.Value 
    ellipseVisO.Visible = "on";
else
    ellipseVisO.Visible = "off";
end

hold(axScoresO,'off')

%------------------------------
% Plot Scores Res Int Spectra
%------------------------------
cla(axScoresRI)
hold(axScoresRI,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axScoresRI,scoresRI(firstS:lastS,1), ...
        scoresRI(firstS:lastS,event.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresRI.YLabel.String = "PC"+num2str(event.Value);

% Draw the 95% error ellipse
[XXRI, YYRI] = ellipse(scoresRI(:,1), scoresRI(:,event.Value));
plot(axScoresRI, XXRI, YYRI, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisRI = findobj(axScoresRI, "Type", "line");
if cbxEllipse.Value 
    ellipseVisRI.Visible = "on";
else
    ellipseVisRI.Visible = "off";
end

hold(axScoresRI,'off')

%----------------------------
% Plot Scores Binned Spectra
%----------------------------
cla(axScoresB)
hold(axScoresB,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axScoresB,scoresB(firstS:lastS,1), ...
        scoresB(firstS:lastS,event.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScoresB.YLabel.String = "PC"+num2str(event.Value);

% Draw the 95% error ellipse
[XXB, YYB] = ellipse(scoresB(:,1), scoresB(:,event.Value));
plot(axScoresB, XXB, YYB, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVisB = findobj(axScoresB, "Type", "line");
if cbxEllipse.Value 
    ellipseVisB.Visible = "on";
else
    ellipseVisB.Visible = "off";
end

hold(axScoresB,'off')

end
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selecting PC in listLoading %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function listLoadingCPCA_callback(~, event, axLoadingO, ...
    axLoadingRI, axLoadingB, data)

% Recover data
loadingsO = data.UserData.OriginalData.Loadings;
PpmO = data.UserData.OriginalData.Ppm;   
loadingsReg1O = data.UserData.OriginalData.loadingsReg1;
loadingsReg2O = data.UserData.OriginalData.loadingsReg2;
loadingsReg3O = data.UserData.OriginalData.loadingsReg3;
numCompO = data.UserData.OriginalData.numComponents;
%
loadingsRI = data.UserData.CFeatures.Loadings;
NumConcReg1RI = data.UserData.CFeatures.numConcReg1;
NumConcReg2RI = data.UserData.CFeatures.numConcReg2;
NumConcReg3RI = data.UserData.CFeatures.numConcReg3;    
loadingsReg1RI = data.UserData.CFeatures.loadingsReg1;
loadingsReg2RI = data.UserData.CFeatures.loadingsReg2;
loadingsReg3RI = data.UserData.CFeatures.loadingsReg3;
numCompRI = data.UserData.CFeatures.numComponents;
%
loadingsB = data.UserData.BinnedData.Loadings;
PpmB = data.UserData.BinnedData.Ppm;   
loadingsReg1B = data.UserData.BinnedData.loadingsReg1;
loadingsReg2B = data.UserData.BinnedData.loadingsReg2;
loadingsReg3B = data.UserData.BinnedData.loadingsReg3;
numCompB = data.UserData.BinnedData.numComponents;

% Colors region
    colorReg1 = [128/255, 0, 128/255]; %morado
    colorReg2 = [0, 128/255, 0]; % verde
    colorReg3 = [0, 0, 128/255]; % azul

% Check if selected PC is valid
if event.Value <= numCompO
%--------------------------------
% Plot Loadings Original Spectra
%--------------------------------
cla(axLoadingO)
axLoadingO.Title.String = "Loading Plot  -  PC"+num2str(event.Value);
hold(axLoadingO, "on")
    plot(axLoadingO, PpmO(loadingsReg1O), ...
        loadingsO(loadingsReg1O,event.Value), 'Color', colorReg1);
    plot(axLoadingO, PpmO(loadingsReg2O), ...
        loadingsO(loadingsReg2O,event.Value), 'Color', colorReg2);
    plot(axLoadingO, PpmO(loadingsReg3O), ...
        loadingsO(loadingsReg3O,event.Value), 'Color', colorReg3);

hold(axLoadingO, "off")
end

% Check if selected PC is valid
if event.Value <= numCompRI
%--------------------------------
% Plot Loadings Res Int Spectra
%--------------------------------
cla(axLoadingRI)
axLoadingRI.Title.String = "Loading Plot  -  PC"+num2str(event.Value);
hold(axLoadingRI, "on")

b = bar(axLoadingRI, loadingsRI(:,event.Value));
b.FaceColor = 'flat';
% Coloring regions
b.CData(loadingsReg1RI,:) = repmat(colorReg1, NumConcReg1RI, 1);
b.CData(loadingsReg2RI,:) = repmat(colorReg2, NumConcReg2RI, 1);
b.CData(loadingsReg3RI,:) = repmat(colorReg2, NumConcReg3RI, 1);

hold(axLoadingRI, "off")
end

% Check if selected PC is valid
if event.Value <= numCompB
%--------------------------------
% Plot Loadings Binned Spectra
%--------------------------------
cla(axLoadingB)
axLoadingB.Title.String = "Loading Plot  -  PC"+num2str(event.Value);
hold(axLoadingB, "on")
    plot(axLoadingB, PpmB(loadingsReg1B), ...
        loadingsB(loadingsReg1B,event.Value), 'Color', colorReg1);
    plot(axLoadingB, PpmB(loadingsReg2B), ...
        loadingsB(loadingsReg2B,event.Value), 'Color', colorReg2);
    plot(axLoadingB, PpmB(loadingsReg3B), ...
        loadingsB(loadingsReg3B,event.Value), 'Color', colorReg3);

hold(axLoadingB, "off")
end

end


%%%%%%%%%%%%%%%%%%%%%%%
% Window to select PC %
%%%%%%%%%%%%%%%%%%%%%%%
function selectWindowCPCA_callback(src, ~, data, cbxEllipse, axPlotSc)

% Recover data
switch src.UserData
    case 1 % Original Processed
        scores_list = data.UserData.OriginalData.scores_list;
        scores_listItemData = data.UserData.OriginalData.scores_listItemData;
    case 2 % C-Features
        scores_list = data.UserData.CFeatures.scores_list;
        scores_listItemData = data.UserData.CFeatures.scores_listItemData;
    case 3 % Bucket Spectra
        scores_list = data.UserData.BinnedData.scores_list;
        scores_listItemData = data.UserData.BinnedData.scores_listItemData;
end

plotTitle = src.Text;
% Create figure window
figScoreCPCA = uifigure('Name', "Select PC - Scores Plot " + plotTitle);
figScoreCPCA.WindowStyle = "modal";
figScoreCPCA.WindowState = "normal";
figScoreCPCA.Position = [250 250 100 200];
figScoreCPCA.Resize = 'off';

%%%%%%%%%%%%%%%%%
% Figure Layout %
%%%%%%%%%%%%%%%%%
glfigSco = uigridlayout(figScoreCPCA,[3,2]);
glfigSco.RowHeight = {'fit', '1x', 'fit'};
glfigSco.ColumnWidth = {'fit', '1x'};

%{
%%%%%%%%%%%%
% X - axis %
%%%%%%%%%%%%
%----------------
% Label X - axis
%----------------
% Create
lblXaxis = uilabel(glfigSco);
% Position
lblXaxis.Layout.Row = 1;
lblXaxis.Layout.Column = 1;
% Style
lblXaxis.Text = "X - axis";
%---------
% PC list
%---------
% Create
listScores_X = uilistbox(glfigSco);
% Position
listScores_X.Layout.Row = 2;
listScores_X.Layout.Column = 1;
% Add items to list Scores
listScores_X.Items = scores_list;
listScores_X.ItemsData = scores_listItemData;
%}

%%%%%%%%%%%%
% Y - axis %
%%%%%%%%%%%%
%----------------
% Label Y - axis
%----------------
% Create
lblYaxis = uilabel(glfigSco);
% Position
lblYaxis.Layout.Row = 1;
lblYaxis.Layout.Column = 2;
% Style
lblYaxis.Text = "Y - axis";
%---------
% PC list
%---------
% Create
listScores_Y = uilistbox(glfigSco);
% Position
listScores_Y.Layout.Row = 2;
listScores_Y.Layout.Column = 2;
% Add items to list Scores
listScores_Y.Items = scores_list;
listScores_Y.ItemsData = scores_listItemData;

%%%%%%%%%%%%%%%%%
% Select Button %
%%%%%%%%%%%%%%%%%
% Create
btnSelectPC = uibutton(glfigSco);
% Position
btnSelectPC.Layout.Row = 3;
btnSelectPC.Layout.Column = [1 2];
% Style
btnSelectPC.Text = "Select";
btnSelectPC.Enable = 'on';

% Select Button Pushed
btnSelectPC.ButtonPushedFcn = {@ScoresCPCA_callback, src, data, ...
    cbxEllipse, axPlotSc, listScores_Y};


end
