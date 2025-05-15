function plotPurestST_callback(src, event, tabMCR, axSVDinit, tgRegions, ...
    listRegion1, listRegion2, listRegion3, sCompMCROaT, btnMCROaTinitialize)

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
    selectedInterval = listRegion1.Value;
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    dataArray = tabMCR.UserData.Region2;
    selectedInterval = listRegion2.Value;
else 
    dataArray = tabMCR.UserData.Region3;
    selectedInterval = listRegion3.Value;
end

% Number of components of selected interval
NumOfComp = dataArray{selectedInterval, 3};

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update n° of components %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
sCompMCROaT.Value =  NumOfComp;
btnMCROaTinitialize.Text = "Initialize with "+NumOfComp+ ...
        " components";

if ~isempty(dataArray{selectedInterval,5})
switch event.NewValue.Text
    case "Eigenvalues"
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Plot Eigenvalues of selected interval %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eigenvalues of selected interval
        selectedEigenvalues = dataArray{selectedInterval,4};
        % Choose only the first eigenvalues
        numSelectEigenvalues = size(selectedEigenvalues,1);
        if numSelectEigenvalues<10
            selectedEigenvalues = selectedEigenvalues(1:numSelectEigenvalues);
        else
            selectedEigenvalues = selectedEigenvalues(1:10);
        end
        % Plot
        plot(axSVDinit, selectedEigenvalues, 'o-')
        axSVDinit.Title.String = 'Eigenvalues';
        axSVDinit.XLabel.String = 'Component';
        axSVDinit.YLabel.String = 'Magnitude';
        if size(selectedEigenvalues,1)>1
            axSVDinit.XLim = [1, size(selectedEigenvalues,1)];
        end
        if strcmp(axSVDinit.XAxis.Direction, 'reverse')
            axSVDinit.XAxis.Direction = 'normal';
        end

    case "Initial Spectrum"
        % PPM of selected interval
        ppm = dataArray{selectedInterval,1};
        % Initial Spectrum of selected interval
        initialSpectrum = dataArray{selectedInterval,5};
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Plot Initial Spectrum of selected interval %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        plot(axSVDinit, ppm, initialSpectrum)
        axSVDinit.Title.String = 'Initialization Spectrum';
        axSVDinit.XLabel.String = 'ppm';
        axSVDinit.YLabel.String = 'Intensity';
        axSVDinit.XLim = [min(ppm), max(ppm)];
        if strcmp(axSVDinit.XAxis.Direction, 'normal')
            axSVDinit.XAxis.Direction = 'reverse';
        end
end
else
    % Warning alert
    fig = ancestor(src, 'figure', 'toplevel');
    uialert(fig, "There is no Initial Spectrum saved", ...
        "No Initial Spectrum", "Icon","info");

    % Return to Eigenvalues Radio Button
    src.Buttons(1).Value = true;
end

