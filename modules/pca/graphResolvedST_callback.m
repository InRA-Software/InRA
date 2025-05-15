function graphResolvedST_callback(~, event, tabPCA, axVariance)
%%%%%%%%%%
% Colors %
%%%%%%%%%%
specColors = [0 0.4470 0.7410;
              0.8500 0.3250 0.0980;	
              0.9290 0.6940 0.1250;	
              0.4940 0.1840 0.5560;
              0.4660 0.6740 0.1880;
              0.3010 0.7450 0.9330;
              0.6350 0.0780 0.1840];

% Recover indices per region
indRegion1 = tabPCA.UserData.Region1.indicesIntervals;
indRegion2 = tabPCA.UserData.Region2.indicesIntervals;
indRegion3 = tabPCA.UserData.Region3.indicesIntervals;
% Recover ppm per region
ppmRegion1 = tabPCA.UserData.Region1.ppm;
ppmRegion2 = tabPCA.UserData.Region2.ppm;
ppmRegion3 = tabPCA.UserData.Region3.ppm;
% Recover componentes per region
compRegion1 = tabPCA.UserData.Region1.Components;
compRegion2 = tabPCA.UserData.Region2.Components;
compRegion3 = tabPCA.UserData.Region3.Components;
% Recover resolved ST per region
resolvedSTRegion1 = tabPCA.UserData.Region1.resolvedST;
resolvedSTRegion2 = tabPCA.UserData.Region2.resolvedST;
resolvedSTRegion3 = tabPCA.UserData.Region3.resolvedST;

% Calculate bounds indices in each region
% It uses parentheses to avoid dimension problems
Reg1First = indRegion1{1}(1);
Reg1Last = indRegion1{end}(1);
%
Reg2First = Reg1Last + 1;
Reg2Last = Reg2First -1 + indRegion2{end}(end);
%
Reg3First = Reg2Last + 1;
Reg3Last = Reg3First - 1 + indRegion3{end}(end);

if (event.Value(1)>=Reg1First(1)) && (event.Value(1)<=Reg1Last(1))
    % Selected loading-component
    localIndex = event.Value(1);

    % Find the cell index where is the corresponding interval and the 
    % internal index corresponding to component of resolved spectrum 
    [cellInd, arrayInd] = InOutInd(localIndex,indRegion1);
    
    cla(axVariance)
    plot(axVariance,ppmRegion1{cellInd}, ...
        resolvedSTRegion1{cellInd}(:,arrayInd), ...
        'color', specColors(compRegion1{cellInd}(arrayInd),:));

    axVariance.Title.String = "Resolved Spectral Profile S^{T}";
    axVariance.Subtitle.String = "Region 1 - Interval "+ num2str(cellInd);
    axVariance.XLabel.String = "δ^{1}H (ppm)";
    axVariance.YLabel.String = "Intensity";
    legend(axVariance, "Comp. "+num2str(compRegion1{cellInd}(arrayInd)))

    axVariance.XLim = [min(ppmRegion1{cellInd}) max(ppmRegion1{cellInd})];
    if strcmp(axVariance.XAxis.Direction, 'normal')
        axVariance.XAxis.Direction = 'reverse';
    end


elseif (event.Value(1)>=Reg2First(1)) && (event.Value(1)<=Reg2Last(1))
    % Selected loading-component
    localIndex = event.Value(1) + 1 - Reg2First(1);

    % Find the cell index where is the corresponding interval and the 
    % internal index corresponding to component of resolved spectrum 
    [cellInd, arrayInd] = InOutInd(localIndex, indRegion2);
    
    cla(axVariance)
    plot(axVariance,ppmRegion2{cellInd}, ...
        resolvedSTRegion2{cellInd}(:,arrayInd), ...
        'color', specColors(compRegion2{cellInd}(arrayInd),:));

    axVariance.Title.String = "Resolved Spectral Profile S^{T}";
    axVariance.Subtitle.String = "Region 2 - Interval "+ num2str(cellInd);
    axVariance.XLabel.String = "δ^{1}H (ppm)";
    axVariance.YLabel.String = "Intensity";
    legend(axVariance, "Comp. "+num2str(compRegion2{cellInd}(arrayInd)))

    axVariance.XLim = [min(ppmRegion2{cellInd}) max(ppmRegion2{cellInd})];
    if strcmp(axVariance.XAxis.Direction, 'normal')
        axVariance.XAxis.Direction = 'reverse';
    end

elseif (event.Value(1)>=Reg3First(1)) && (event.Value(1)<=Reg3Last(1))
    % Selected loading-component
    localIndex = event.Value(1) + 1 - Reg3First(1);

    % Find the cell index where is the corresponding interval and the 
    % internal index corresponding to component of resolved spectrum 
    [cellInd, arrayInd] = InOutInd(localIndex, indRegion3);
    
    cla(axVariance)
    plot(axVariance,ppmRegion3{cellInd}, ...
        resolvedSTRegion3{cellInd}(:,arrayInd), ...
        'color', specColors(compRegion3{cellInd}(arrayInd),:));

    axVariance.Title.String = "Resolved Spectral Profile S^{T}";
    axVariance.Subtitle.String = "Region 3 - Interval "+ num2str(cellInd);
    axVariance.XLabel.String = "δ^{1}H (ppm)";
    axVariance.YLabel.String = "Intensity";
    legend(axVariance, "Comp. "+num2str(compRegion3{cellInd}(arrayInd)))

    axVariance.XLim = [min(ppmRegion3{cellInd}) max(ppmRegion3{cellInd})];
    if strcmp(axVariance.XAxis.Direction, 'normal')
        axVariance.XAxis.Direction = 'reverse';
    end
end

end


%% 
function [cellInd, arrayInd] = InOutInd(localIndex, indRegion)
    % Creates an empty cell array except where localIndex is
    auxCell = cellfun(@(x) find(x==localIndex), indRegion, ...
        'UniformOutput', false);
    % Find the index where cell array is non-empty
    cellInd = find(~cellfun(@isempty,auxCell));
    % In the matrix inside the non-empty cell, find the index where is
    % localIndex
    arrayInd = auxCell{cellInd};
end

