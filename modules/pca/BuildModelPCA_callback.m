%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build PCA Model Button   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function BuildModelPCA_callback(src, ~, ddPCAMean, ddPCAScaling, ...
    axScores, axLoading, axVariance, sPCAComponents, VarianceTable, ...
    listLoading, listScores, tabPCA, ddGraOut, ddTransformations, ...
    listComponentST, cbxDrawEllipse, btnComparativePre, ...
    btnComparativePCA, btnReadyIntervals)

% Enable Comparative PCA
btnComparativePre.Enable = "on";
btnComparativePCA.Enable = "on";

% Loading Window for PCA Model 
%L4 = msgbox('Building PCA Model . . . ','Loading', 'help','modal');
% Loading Window for PCA Model 
fig = ancestor(src, 'figure', 'toplevel');
progressMsg = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Building PCA Model . . . ');

% Recover data
if btnComparativePre.UserData.InUse == 3
% C-Features
    concRegion1 = tabPCA.UserData.Region1.Concentrations;
    concRegion2 = tabPCA.UserData.Region2.Concentrations;
    concRegion3 = tabPCA.UserData.Region3.Concentrations;

    concentrations = [concRegion1, concRegion2, concRegion3];
elseif btnComparativePre.UserData.InUse == 2
% Binned Spectra
    concentrations = btnComparativePre.UserData.BinnedData;
else
% Original Spectra
    concentrations = btnComparativePre.UserData.OriginalData;
end

% Working data
workingData = concentrations;

progressMsg.Value = 0.1;
%%%%%%%%%%%%%%%%%%%%%
% PCA Preprocessing %
%%%%%%%%%%%%%%%%%%%%%
% Transformations
switch ddTransformations.SelectedObject.Text
    case 'None'
        workingData = concentrations;
    case 'Log10'
        % Negative values to 0
        concentrations(concentrations<0) = 0;
        % Add an offset to avoid problems with 0
        offsetData = concentrations+(1e-5);
        % Apply log10
        workingData = log10(offsetData);
end

progressMsg.Value = 0.2;
% Scaling Methods
switch  ddPCAScaling.SelectedObject.Text
    case 'None'
        %workingData = workingData;
    case 'Pareto Scaling'
        m = size(workingData,1);
        % Calculate the mean and standard deviation for each column
        mean_centered_1HNMR_Data = mean(workingData,1);
        var_mean_centered_1HNMR_Data = std(workingData,1);
        % Pareto scaling
        Pareto_Scaling_1HNMR_Data = (workingData - ...
            repmat(mean_centered_1HNMR_Data,m,1)) ./ sqrt( ...
            repmat(var_mean_centered_1HNMR_Data,m,1));
        workingData = Pareto_Scaling_1HNMR_Data; 
    case 'Variance Scaling'
        m = size(workingData,1);
        % Calculate the mean and standard deviation for each column
        mean_1HNMR_Data = mean(workingData,1);
        var_1HNMR_Data = var(workingData,1);
        % Variance Scaling
        Variance_Scaling_1HNMR_Data = (workingData - ...
            repmat(mean_1HNMR_Data,m,1)) ./ sqrt(... 
        repmat(var_1HNMR_Data,m,1));
        workingData = Variance_Scaling_1HNMR_Data;
end 

progressMsg.Value = 0.3;

% Mean Centered
switch ddPCAMean.SelectedObject.Text
    case 'None'
        %workingData = 1*workingData;
    case 'Mean Center'
        m = size(workingData, 1);
        % Calculate mean of the Spectra
        mean_1HNMR_Data = mean(workingData,1);
        workingData = (workingData-repmat(mean_1HNMR_Data,m,1));
end

progressMsg.Value = 0.4;

% If "Mean Center" is selected ddPCAMean.Buttons(2).Value is True
drawVerticalLine = ddPCAMean.Buttons(2).Value;
% Store this value in listScores object
listScores.UserData.drawVerticalLine = drawVerticalLine;

mbx = workingData;

%%%%%%%%%%%%%
% PCA Model %
%%%%%%%%%%%%%

numComponents = sPCAComponents.Value;
progressMsg.Value = 0.5;
% Singular Values Decomposition (SVD)
[U, S, V] = svd(mbx,'econ');

% Obtain Scores
scores = U(:, 1:numComponents) * S(1:numComponents, 1:numComponents);

progressMsg.Value = 0.6;

% List of Scores
% Create a empty array string
PCstring = strings(1,numComponents-1);
% Full PCstring with de string "PC"
PCstring = append("PC",PCstring);
% Create an array number from 2 to nComponents
scores_listItemData = 2:numComponents;
% Create a cell array where every cell is a string of number from 2 to 
% nComponents
numberString = arrayfun(@num2str, scores_listItemData, 'UniformOutput',false);
% Create an array of "PC"+NUMBER
scores_list = append(PCstring,numberString);

% Add items to list Scores
listScores.Items = scores_list;
listScores.ItemsData = scores_listItemData;

progressMsg.Value = 0.7;

% Plot Scores
selectedColors = tabPCA.UserData.selectedColors;
selectedSamples = tabPCA.UserData.selectedSamples;
cla(axScores)
hold(axScores,"on")
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    s = scatter(axScores,scores(firstS:lastS,1), ...
        scores(firstS:lastS,2), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
hold(axScores, "off")
axScores.XLabel.String = 'PC1';
axScores.YLabel.String = 'PC2';

hold(axScores,'on')
% Axis at (0,0)
if drawVerticalLine
    xline(axScores, 0,'Color','black', 'Alpha', 0.4)
end
yline(axScores, 0,'Color','black', 'Alpha', 0.4)

% Draw the 95% error ellipse
[XX, YY] = ellipse(scores(:,1), scores(:,2));
plot(axScores, XX, YY, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVis = findobj(axScores, "Type", "line");
if cbxDrawEllipse.Value 
    ellipseVis.Visible = "on";
else
    ellipseVis.Visible = "off";
end

hold(axScores,'off')

progressMsg.Value = 0.8;

% Store Scores array in listScores
listScores.UserData.scores = scores;
listScores.UserData.selectedColors = selectedColors;
listScores.UserData.selectedSamples = selectedSamples;

% Return the selected item in listScores to the default value: "PC2"
listScores.Value = 2;

% Obtained Loadings
loadings = V(:, 1:numComponents);

% Use the previous list of Score to build list of Loadings
loadings_list = ["PC1", scores_list];
loadings_listItemData = [1, scores_listItemData];

% Add items to list Loading
listLoading.Items = loadings_list;
listLoading.ItemsData = loadings_listItemData;


% Number of concentrations of each region
if btnComparativePre.UserData.InUse == 3
% C-Features
    NumConcReg1 = size(tabPCA.UserData.Region1.Concentrations,2);
    NumConcReg2 = size(tabPCA.UserData.Region2.Concentrations,2);
    NumConcReg3 = size(tabPCA.UserData.Region3.Concentrations,2);
elseif btnComparativePre.UserData.InUse == 2
% Binned Spectra    
    % Saved region bounds
    regionBound_3 = btnReadyIntervals.UserData(2);
    regionBound_6 = btnReadyIntervals.UserData(3);

    Ppm = btnComparativePre.UserData.BinnedPpm;
    % Search for indexes of each region's bound
    IndRegionBound_3 = findIndex(regionBound_3, Ppm);
    IndRegionBound_6 = findIndex(regionBound_6, Ppm);
    % Number of loadings of each region
    NumConcReg1 = size(Ppm(1:IndRegionBound_3),2);
    NumConcReg2 = size(Ppm(IndRegionBound_3+1:IndRegionBound_6),2);
    NumConcReg3 = size(Ppm(IndRegionBound_6+1:end),2);
else
% Original Spectra
    % Saved region bounds
    regionBound_3 = btnReadyIntervals.UserData(2);
    regionBound_6 = btnReadyIntervals.UserData(3);

    Ppm = btnComparativePre.UserData.OriginalPpm;
    % Search for indexes of each region's bound
    IndRegionBound_3 = findIndex(regionBound_3, Ppm);
    IndRegionBound_6 = findIndex(regionBound_6, Ppm);
    % Number of loadings of each region
    NumConcReg1 = size(Ppm(1:IndRegionBound_3),2);
    NumConcReg2 = size(Ppm(IndRegionBound_3+1:IndRegionBound_6),2);
    NumConcReg3 = size(Ppm(IndRegionBound_6+1:end),2);
end

% Plot default loading
% Colors region
    colorReg1 = [128/255, 0, 128/255]; %morado
    colorReg2 = [0, 128/255, 0]; % verde
    colorReg3 = [0, 0, 128/255]; % azul
cla(axLoading)
axLoading.Title.String = "Loading Plot  -  PC"+num2str(1);
hold(axLoading, "on")

% C-Features
if btnComparativePre.UserData.InUse == 3
    b = bar(axLoading, loadings(:,1));
    b.FaceColor = 'flat';
    % Coloring regions
    loadingsReg1 = 1:NumConcReg1;
    b.CData(loadingsReg1,:) = repmat(colorReg1, NumConcReg1, 1);
        aux = NumConcReg1;
        loadingsReg2 = (aux+1):(aux+NumConcReg2);
    b.CData(loadingsReg2,:) = repmat(colorReg2, NumConcReg2, 1);
        aux = aux + NumConcReg2;
        loadingsReg3 = (aux+1):(aux+NumConcReg3);
    b.CData(loadingsReg3,:) = repmat(colorReg3, NumConcReg3, 1);
    % Plot Style
    axLoading.XAxis.Direction = 'normal';
    axLoading.XLabel.String = 'C-Profile';
    axLoading.XLim = [0, size(loadings(:,1),1)];
else
% Original Spectra or Binned Spectra
    % Plot each region with its corresponding color
    loadingsReg1 = 1:NumConcReg1;
    plot(axLoading, Ppm(loadingsReg1), ...
        loadings(loadingsReg1,1), 'Color', colorReg1);
    aux = NumConcReg1;
    loadingsReg2 = aux:(aux+NumConcReg2);
    plot(axLoading, Ppm(loadingsReg2), ...
        loadings(loadingsReg2,1), 'Color', colorReg2);
    aux = aux + NumConcReg2 ;
    loadingsReg3 = aux:(NumConcReg1+NumConcReg2+NumConcReg3);
    plot(axLoading, Ppm(loadingsReg3), ...
        loadings(loadingsReg3,1), 'Color', colorReg3);
    % Plot Style
    axLoading.XAxis.Direction = 'reverse';
    axLoading.XLabel.String = 'δ^{1}H(ppm)';
    axLoading.XLim = [Ppm(1), Ppm(end)];
end
hold(axLoading, "off")

% Store loading array in listLoading
listLoading.UserData = [];
listLoading.UserData.loadings = loadings;
listLoading.UserData.colorsRegion = {colorReg1, colorReg2, colorReg3};
listLoading.UserData.concentrationsRegion = {NumConcReg1, NumConcReg2, ...
        NumConcReg3};
listLoading.UserData.loadingsRegion = {loadingsReg1, ...
        loadingsReg2, loadingsReg3};

progressMsg.Value = 0.9;

% Return the selected item in listLoading to the default value: "PC1"
listLoading.Value = 1;

% Update list Component-Resolved ST (only with C-Features)
if btnComparativePre.UserData.InUse == 3
    numberCompSt = (1:size(loadings,1));
    listComponentST.Items = " "+ numberCompSt;
    listComponentST.ItemsData = numberCompSt;
end

% Clean axes
cla(axVariance);
axVariance.Subtitle.String = "";
% Deactivate legend
legend(axVariance, 'off');
if strcmp(axVariance.XAxis.Direction, 'reverse')
    axVariance.XAxis.Direction = 'normal';
end
axVariance.XLim = [1, numComponents];
switch ddGraOut.SelectedObject.Text
%%%%%%%%%%%%%%%%%%%%%%
% Explained Variance %
%%%%%%%%%%%%%%%%%%%%%%
    case "Explained Variance"
        % Explained Variance
        explained_variance = explainedVariance(S);
        % Plot Explained Variance
        plot(axVariance, explained_variance(1:numComponents,:),'o-', ...
            'LineWidth', 2);
        title(axVariance, 'Explained Variance vs Number of PCs', ...
            'FontSize', 12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'Explained Variance (%)');
        grid (axVariance,'on');
%%%%%%%%%%%%%%%%%%%%%%%
% Cumulative Variance %
%%%%%%%%%%%%%%%%%%%%%%%
    case "Cumulative Variance"
         % Cumulative Variance
        cumulative_variance = cumulativeVariance(S, numComponents);

        % Plot Cumulative Variance
        plot(axVariance, cumulative_variance(1:numComponents,:),'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        title(axVariance, 'Cumulative Variance vs Number of PCs', ...
            'FontSize', 12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'Cumulative Variance (%)');
        grid (axVariance,'on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cross-Validation by Venetian-Blinds %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case "RMSEC/RMSECV"

        [rmsec_values, rmsecv_values] = crossValidation(mbx, numComponents);

        % Plot RMSEC and RMSECV 
        cla(axVariance)
        % Find and delete the legend
        lgdAxVariance = findobj(axVariance, 'type', 'legend');
        delete(lgdAxVariance)
        if strcmp(axVariance.XAxis.Direction, 'reverse')
            axVariance.XAxis.Direction = 'normal';
        end

        plot(axVariance, 1:numComponents, rmsec_values,'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        hold(axVariance,'on');
        plot(axVariance, 1:numComponents, rmsecv_values,'o-', ...
            'LineWidth', 2, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
            'Markersize', 8);
        title(axVariance, 'RMSEC/RMSECV vs Number of PCs', 'FontSize', ...
            12, 'FontWeight','bold');
        xlabel(axVariance,'Number of Principal Components');
        ylabel(axVariance,'RMSEC and RMSECV');
        grid (axVariance,'on');
        hold(axVariance,'off');
end


%%%%%%%%%%%%%%%%%%%%%
% Table Information %
%%%%%%%%%%%%%%%%%%%%%
explained_variance = explainedVariance(S);
cumulative_variance = cumulativeVariance(S, numComponents);
[rmsec_values, rmsecv_values] = crossValidation(mbx, numComponents);

% Table with Variance Information 
VarianceTable.Data = [explained_variance(1:numComponents), ...
    cumulative_variance, rmsec_values, rmsecv_values];

progressMsg.Value = 1;

% Store Variance and the other stuffs
axVariance.UserData.explained_variance = explained_variance;
axVariance.UserData.cumulative_variance = cumulative_variance;
axVariance.UserData.rmsec_values = rmsec_values;
axVariance.UserData.rmsecv_values = rmsecv_values;
axVariance.UserData.numComponents = numComponents;

%%
%% Store data in btnComparativePCA for Comparative PCA
%%

btnComparativePCA.UserData.selectedColors = selectedColors;
btnComparativePCA.UserData.selectedSamples = selectedSamples;
btnComparativePCA.UserData.loadings_list = loadings_list;
btnComparativePCA.UserData.loadings_listItemData = loadings_listItemData;

if btnComparativePre.UserData.InUse == 3
% C-Features
    btnComparativePCA.UserData.CFeatures.Scores = scores;
    btnComparativePCA.UserData.CFeatures.Loadings = loadings;
    btnComparativePCA.UserData.CFeatures.explained_variance = explained_variance;
    btnComparativePCA.UserData.CFeatures.cumulative_variance = cumulative_variance;
    btnComparativePCA.UserData.CFeatures.rmsec_values = rmsec_values;
    btnComparativePCA.UserData.CFeatures.rmsecv_values = rmsecv_values;
    btnComparativePCA.UserData.CFeatures.numComponents = numComponents;
    btnComparativePCA.UserData.CFeatures.numConcReg1 = NumConcReg1;
    btnComparativePCA.UserData.CFeatures.numConcReg2 = NumConcReg2;
    btnComparativePCA.UserData.CFeatures.numConcReg3 = NumConcReg3;
    btnComparativePCA.UserData.CFeatures.loadingsReg1 = loadingsReg1;
    btnComparativePCA.UserData.CFeatures.loadingsReg2 = loadingsReg2;
    btnComparativePCA.UserData.CFeatures.loadingsReg3 = loadingsReg3;
    btnComparativePCA.UserData.CFeatures.scores_list = scores_list;
    btnComparativePCA.UserData.CFeatures.scores_listItemData = scores_listItemData;
    btnComparativePCA.UserData.CFeatures.loadings_list = loadings_list;
    btnComparativePCA.UserData.CFeatures.loadings_listItemData = loadings_listItemData;
elseif btnComparativePre.UserData.InUse == 2
% Binned Spectra
    btnComparativePCA.UserData.BinnedData.Scores = scores;
    btnComparativePCA.UserData.BinnedData.Loadings = loadings;
    btnComparativePCA.UserData.BinnedData.Ppm = Ppm;
    btnComparativePCA.UserData.BinnedData.explained_variance = explained_variance;
    btnComparativePCA.UserData.BinnedData.cumulative_variance = cumulative_variance;
    btnComparativePCA.UserData.BinnedData.rmsec_values = rmsec_values;
    btnComparativePCA.UserData.BinnedData.rmsecv_values = rmsecv_values;
    btnComparativePCA.UserData.BinnedData.numComponents = numComponents;
    btnComparativePCA.UserData.BinnedData.numConcReg1 = NumConcReg1;
    btnComparativePCA.UserData.BinnedData.numConcReg2 = NumConcReg2;
    btnComparativePCA.UserData.BinnedData.numConcReg3 = NumConcReg3;    
    btnComparativePCA.UserData.BinnedData.loadingsReg1 = loadingsReg1;
    btnComparativePCA.UserData.BinnedData.loadingsReg2 = loadingsReg2;
    btnComparativePCA.UserData.BinnedData.loadingsReg3 = loadingsReg3;
    btnComparativePCA.UserData.BinnedData.scores_list = scores_list;
    btnComparativePCA.UserData.BinnedData.scores_listItemData = scores_listItemData;
    btnComparativePCA.UserData.BinnedData.loadings_list = loadings_list;
    btnComparativePCA.UserData.BinnedData.loadings_listItemData = loadings_listItemData;
else
% Original Spectra
    btnComparativePCA.UserData.OriginalData.Scores = scores;
    btnComparativePCA.UserData.OriginalData.Loadings = loadings;
    btnComparativePCA.UserData.OriginalData.Ppm = Ppm;
    btnComparativePCA.UserData.OriginalData.explained_variance = explained_variance;
    btnComparativePCA.UserData.OriginalData.cumulative_variance = cumulative_variance;
    btnComparativePCA.UserData.OriginalData.rmsec_values = rmsec_values;
    btnComparativePCA.UserData.OriginalData.rmsecv_values = rmsecv_values;
    btnComparativePCA.UserData.OriginalData.numComponents = numComponents;
    btnComparativePCA.UserData.OriginalData.numConcReg1 = NumConcReg1;
    btnComparativePCA.UserData.OriginalData.numConcReg2 = NumConcReg2;
    btnComparativePCA.UserData.OriginalData.numConcReg3 = NumConcReg3;    
    btnComparativePCA.UserData.OriginalData.loadingsReg1 = loadingsReg1;
    btnComparativePCA.UserData.OriginalData.loadingsReg2 = loadingsReg2;
    btnComparativePCA.UserData.OriginalData.loadingsReg3 = loadingsReg3;
    btnComparativePCA.UserData.OriginalData.scores_list = scores_list;
    btnComparativePCA.UserData.OriginalData.scores_listItemData = scores_listItemData;
    btnComparativePCA.UserData.OriginalData.loadings_list = loadings_list;
    btnComparativePCA.UserData.OriginalData.loadings_listItemData = loadings_listItemData;
end
% Close the Loading Window for PCA Model
delete(progressMsg);

end


function Ind = findIndex(firstPPM, ppmVector)
% Search for minimum distance
d = ppmVector(3)-ppmVector(1);

% Find index
Ind = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + d), 1, 'first');
end
