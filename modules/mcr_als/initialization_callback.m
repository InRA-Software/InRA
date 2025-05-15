function initialization_callback(~, ~, tabMCR, axSVDinit, tgRegions, ...
    listRegion1, listRegion2, listRegion3, rbPlotInit, sCompMCROaT)

% Select listRegion and recover data in tabMCR depending of the selected 
% Region
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
%  depending on the tabRegion
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

% Data to use
selectedInterval = listRegion.Value;
ppm = dataArray{selectedInterval,1};
spectra = dataArray{selectedInterval,2};
nComponents = sCompMCROaT.Value;

% Purest ST
initSpec = purestST(spectra',nComponents);

% Plot Initial Spectrum
plot(axSVDinit, ppm, initSpec)
axSVDinit.XDir = 'reverse';
axSVDinit.Title.String = 'Initialization Spectrum';
axSVDinit.XLabel.String = 'ppm';
axSVDinit.YLabel.String = 'Intensity';
axSVDinit.XLim = [min(ppm), max(ppm)];

% Select Initial Spectrum Radio Button
rbPlotInit.Value = true;

% Store Initial Spectrum depending of the selected Region
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
    listRegion1.UserData{selectedInterval,1} = initSpec;
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    listRegion2.UserData{selectedInterval,1} = initSpec;
else 
    listRegion3.UserData{selectedInterval,1} = initSpec;
end

end

