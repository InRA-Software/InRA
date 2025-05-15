function listRegion_callback(src, event, tabMCR, ...
    axSegment, axSVDinit, axSTprofile, axCprofile, ...
    sCompMCROaT, btnMCROaTinitialize, rbPlotSVD,...
    efLOfExp, efLOfExVa, efLOfStdRes)
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

% Recover data in tabMCR depending of the selected Region
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
if strcmp(src.Tag,"Min")
    dataArray = tabMCR.UserData.Region1;
elseif strcmp(src.Tag,"Mid")
    dataArray = tabMCR.UserData.Region2;
else 
    dataArray = tabMCR.UserData.Region3;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select Eigenvalues Radio Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rbPlotSVD.Value = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update n° of components %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
NumOfComp = dataArray{event.Value, 3};
sCompMCROaT.Value =  NumOfComp;
btnMCROaTinitialize.Text = "Initialize with "+NumOfComp+ ...
    " components";

% In case that MCR it has been done
MCRdone = efLOfExp.UserData;

if ~MCRdone
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot selected interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Ppm and intensities of original samples for selected interval
    selectedPpm = dataArray{event.Value,1};
    selectedInterval = dataArray{event.Value,2};

    % Plot original samples
    plot(axSegment, selectedPpm, selectedInterval);
    axSegment.XLim = [min(selectedPpm), max(selectedPpm)];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot Eigenvalues of selected interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Eigenvalues of selected interval
    selectedEigenvalues = dataArray{event.Value,4};
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

else
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot selected interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Ppm and intensities of original samples for selected interval
    selectedPpm = dataArray{event.Value,1};
    selectedInterval = dataArray{event.Value,2};

    % Plot original samples
    plot(axSegment, selectedPpm, selectedInterval);
    axSegment.XLim = [min(selectedPpm), max(selectedPpm)];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot Eigenvalues of selected interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Eigenvalues of selected interval
    selectedEigenvalues = dataArray{event.Value,4};
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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot Spectral Profile of selected interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Spectral profile of selected interval
    selectedSpec = dataArray{event.Value,6};
    % Indices for components of selected interval
    indComp = dataArray{event.Value, 9};
    % Legends for plots of selected interval
    lgdComp = dataArray{event.Value, 10};

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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot Concentration Profile of first interval %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Concentration profile of selected interval
    selectedConc = dataArray{event.Value,7};
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
    
    fomR2 = dataArray{event.Value, 8};

    % Default Figure of merit values
    efLOfExp.Value = fomR2(2);
    efLOfExVa.Value = fomR2(4);
    efLOfStdRes.Value = fomR2(1);



end

