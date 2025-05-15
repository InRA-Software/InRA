function buildModelSelectedInterval_callback(src, ~, tgRegions, ...
    tabMCR, listRegion1, listRegion2, listRegion3, sIterMCR, ...
    axSTprofile, axCprofile, efLOfExp, efLOfExVa, ...
    efLOfStdRes)

% tabMCR.UserData contain a structure that contain Region1, Region2 ...
% and Region3
    % Each region contain a cell array where
    % 1st column: ppm of interval N
    % 2nd column: intensities of interval N
    % 3nd column: number of components selected of interval N
    % 4th column: eigenvalues of interval N
    % 5th column: initial spectrum of interval N
    % 6th column: resolved spectra of interval N
    % 7th column: resolved concentration of interval N
    % 8th column: figures of merit of interval N
    % 9th column: indexes for components of interval N
    % 10th column: Legends for Spectra and Concentrations plots
% Select listRegion and recover data depending on the tabRegion
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
    dataArray = tabMCR.UserData.Region1;
    listRegion = listRegion1;
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    dataArray = tabMCR.UserData.Region2;
    listRegion = listRegion2;
else 
    dataArray = tabMCR.UserData.Region3;
    listRegion = listRegion3;
end

% Obtain index of selected interval
selectedInterval =listRegion.Value;
% Number of components of selected interval
NumOfComp = dataArray{selectedInterval, 3};

% Number of iterations
NumOfIter = sIterMCR.Value;

% Progress message
fig = ancestor(src, 'figure', 'toplevel');
progressMsg = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Starting');
pause(0.5)

% Performing calculations message
progressMsg.Value = 0;
progressMsg.Message = "Performing MCR in "+tgRegions.SelectedTab.Title...
    +" interval "+ selectedInterval +" with "+ NumOfComp+" components";        

try
    % Calculations
    progressMsg.Value = 0.2; % Progress msg
    initialSpectrum = purestST(transpose(dataArray{selectedInterval,2}),...
            NumOfComp);
    progressMsg.Value = 0.4; % Progress msg
    [concentrations,spectra,fom,r2] = nuestroMCRALS(...
            transpose(dataArray{selectedInterval,2}), initialSpectrum, ...
            NumOfComp, NumOfIter);
catch
    close(progressMsg)
    % Warning alert
    fig = ancestor(src, 'figure', 'toplevel');
    uialert(fig, "Error performing MCR in "+tgRegions.SelectedTab.Title ...
        +" interval "+selectedInterval +" with "+ NumOfComp ...
        +" components." +newline+ "Try with more components", "Error");
    return
end
progressMsg.Value = 0.45; % Progress msg

% Store results in listRegion.UserData cell array
% and update data stored in tabMCR
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
    listRegion1.UserData{selectedInterval, 1} = initialSpectrum;
    listRegion1.UserData{selectedInterval, 2} = concentrations;
    listRegion1.UserData{selectedInterval, 3} = spectra;
    listRegion1.UserData{selectedInterval, 4} = fom;
    listRegion1.UserData{selectedInterval, 5} = r2;
            
    tabMCR.UserData.Region1{selectedInterval, 3} = NumOfComp;
    tabMCR.UserData.Region1{selectedInterval, 5} = initialSpectrum;
    tabMCR.UserData.Region1{selectedInterval, 6} = spectra;
    tabMCR.UserData.Region1{selectedInterval, 7} = concentrations;
    tabMCR.UserData.Region1{selectedInterval, 8} = [fom, r2];
        indexComponents = (1:NumOfComp)';
    tabMCR.UserData.Region1{selectedInterval, 9} = indexComponents;
    tabMCR.UserData.Region1{selectedInterval, 10} = "Comp. "+num2str(indexComponents);
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    listRegion2.UserData{selectedInterval, 1} = initialSpectrum;
    listRegion2.UserData{selectedInterval, 2} = concentrations;
    listRegion2.UserData{selectedInterval, 3} = spectra;
    listRegion2.UserData{selectedInterval, 4} = fom;
    listRegion2.UserData{selectedInterval, 5} = r2;

    tabMCR.UserData.Region2{selectedInterval, 3} = NumOfComp;
    tabMCR.UserData.Region2{selectedInterval, 5} = initialSpectrum;
    tabMCR.UserData.Region2{selectedInterval, 6} = spectra;
    tabMCR.UserData.Region2{selectedInterval, 7} = concentrations;
    tabMCR.UserData.Region2{selectedInterval, 8} = [fom, r2];
        indexComponents = (1:NumOfComp)';
    tabMCR.UserData.Region2{selectedInterval, 9} = indexComponents;
    tabMCR.UserData.Region2{selectedInterval, 10} = "Comp. "+num2str(indexComponents);
else 
    listRegion3.UserData{selectedInterval, 1} = initialSpectrum;
    listRegion3.UserData{selectedInterval, 2} = concentrations;
    listRegion3.UserData{selectedInterval, 3} = spectra;
    listRegion3.UserData{selectedInterval, 4} = fom;
    listRegion3.UserData{selectedInterval, 5} = r2;
    
    tabMCR.UserData.Region3{selectedInterval, 3} = NumOfComp;            
    tabMCR.UserData.Region3{selectedInterval, 5} = initialSpectrum;
    tabMCR.UserData.Region3{selectedInterval, 6} = spectra;
    tabMCR.UserData.Region3{selectedInterval, 7} = concentrations;
    tabMCR.UserData.Region3{selectedInterval, 8} = [fom, r2];
        indexComponents = (1:NumOfComp)';
    tabMCR.UserData.Region3{selectedInterval, 9} = indexComponents;
    tabMCR.UserData.Region3{selectedInterval, 10} = "Comp. "+num2str(indexComponents);
end

progressMsg.Value = 0.5; % Progress msg

% Recover data depending on the tabRegion
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
    dataArray = tabMCR.UserData.Region1;
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    dataArray = tabMCR.UserData.Region2;
else 
    dataArray = tabMCR.UserData.Region3;
end

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Spectral Profile of selected interval %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ppm of selected interval
selectedPpm = dataArray{selectedInterval, 1};
% Spectral profile of selected interval
selectedSpec = dataArray{selectedInterval, 6};
% Indices for components of selected interval
indComp = dataArray{selectedInterval, 9};
% Legends for plots of selected interval
lgdComp = dataArray{selectedInterval, 10};
% Plot
%plot(axSTprofile, selectedPpm, selectedSpec);
cla(axSTprofile)
hold(axSTprofile, 'on')
for i=1:size(indComp,1)
    plot(axSTprofile, selectedPpm, selectedSpec(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axSTprofile, 'off')
legend(axSTprofile, lgdComp(indComp))
axSTprofile.XLim = [min(selectedPpm), max(selectedPpm)];

progressMsg.Value = 0.7; % Progress msg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Concentration Profile of selected interval %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concentration profile of selected interval
selectedConc = dataArray{selectedInterval, 7};
% Plot
%plot(axCprofile, selectedConc);
cla(axCprofile)
hold(axCprofile, 'on')
for i=1:size(indComp,1)
    plot(axCprofile, selectedConc(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axCprofile, 'off')
legend(axCprofile, lgdComp(indComp))
if size(selectedConc,1)>1
    axCprofile.XLim = [1, size(selectedConc,1)];
end

progressMsg.Value = 0.9; % Progress msg

% Figure of merit values of selected interval
fomR2 = dataArray{selectedInterval, 8};

efLOfExp.Value = fomR2(2);
efLOfExVa.Value = fomR2(4);
efLOfStdRes.Value = fomR2(1);

progressMsg.Value = 1; % Progress msg

close(progressMsg)

end

         

