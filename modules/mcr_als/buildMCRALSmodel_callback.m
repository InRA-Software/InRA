function buildMCRALSmodel_callback(src, ~, tabMCR, sCompMCRAaO, ...
    sIterMCR, listRegion1, listRegion2, listRegion3, tgRegions,...
    axSVDinit, axSegment, axSTprofile, axCprofile, rbPlotSVD, ...
    efLOfExp, efLOfExVa, efLOfStdRes, btnMCROaTselInter, ...
    btnDelCompSelInter, btnProceedToPCA, btnExportModels)

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
dataArray = {tabMCR.UserData.Region1, tabMCR.UserData.Region2, ...
    tabMCR.UserData.Region3};

% Obtain number of total signals
totalSignals = size(dataArray{1},1)+size(dataArray{2},1) ...
    +size(dataArray{3},1);
% Number of components if OaT is pressed
if ~isempty(sCompMCRAaO)
    NumOfComp = sCompMCRAaO.Value;
end
% Number of iterations
NumOfIter = sIterMCR.Value;

% Progress message
fig = ancestor(src, 'figure', 'toplevel');
progressMsg = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Starting');
pause(0.5)
% Progress counter
progCount = 0;

for i=1:3
    % Obtain number of signals in Region i
    nMCR = size(dataArray{i},1);
    for k = 1:nMCR
        % Number of components when OaT is pressed
        if isempty(sCompMCRAaO)
            NumOfComp = dataArray{i}{k,3};
        end

        % Performing calculations message
        progCount = progCount + 1;
        progressMsg.Value = progCount/totalSignals;
        progressMsg.Message = "Performing MCR in Region "+i+" interval "...
            +k +" with "+ NumOfComp+" components";        

        try
        % Calculations
        initialSpectrum = purestST(transpose(dataArray{i}{k,2}), ...
            NumOfComp);
        [concentrations,spectra,fom,r2] = nuestroMCRALS(...
            transpose(dataArray{i}{k,2}), initialSpectrum, ...
            NumOfComp, NumOfIter);
        catch
            close(progressMsg)
            % Warning alert
            fig = ancestor(src, 'figure', 'toplevel');
            uialert(fig, "Error performing MCR in Region "+i+" interval "...
            +k +" with "+ NumOfComp+" components." +newline+ ...
            "Try with more components", "Error");
            return
        end
    
        % Store results in listRegion.UserData cell array
          % 1st column: initial spectrum
          % 2nd column: resolved concentrations
          % 3rd column: resolved spectra
          % 4th column: sigma and lack of fit with experimental matrix
          % 5th column: percent of variance explained
        % and update initial spectrum and number of components stored in
        % tabMCR
        if i==1
            listRegion1.UserData{k, 1} = initialSpectrum;
            listRegion1.UserData{k, 2} = concentrations;
            listRegion1.UserData{k, 3} = spectra;
            listRegion1.UserData{k, 4} = fom;
            listRegion1.UserData{k, 5} = r2;
            
            % Store components when OaT is pressed
            if ~isempty(sCompMCRAaO)
                tabMCR.UserData.Region1{k, 3} = NumOfComp;
            end
            tabMCR.UserData.Region1{k, 5} = initialSpectrum;
            tabMCR.UserData.Region1{k, 6} = spectra;
            tabMCR.UserData.Region1{k, 7} = concentrations;
            tabMCR.UserData.Region1{k, 8} = [fom, r2];
                indexComponents = (1:NumOfComp)';
            tabMCR.UserData.Region1{k, 9} = indexComponents;
            tabMCR.UserData.Region1{k, 10} = "Comp. "+num2str(indexComponents);
        elseif i==2
            listRegion2.UserData{k, 1} = initialSpectrum;
            listRegion2.UserData{k, 2} = concentrations;
            listRegion2.UserData{k, 3} = spectra;
            listRegion2.UserData{k, 4} = fom;
            listRegion2.UserData{k, 5} = r2;

            % Store components when OaT is pressed
            if ~isempty(sCompMCRAaO)
                tabMCR.UserData.Region2{k, 3} = NumOfComp;
            end
            tabMCR.UserData.Region2{k, 5} = initialSpectrum;
            tabMCR.UserData.Region2{k, 6} = spectra;
            tabMCR.UserData.Region2{k, 7} = concentrations;
            tabMCR.UserData.Region2{k, 8} = [fom, r2];
                indexComponents = (1:NumOfComp)';
            tabMCR.UserData.Region2{k, 9} = indexComponents;
            tabMCR.UserData.Region2{k, 10} = "Comp. "+num2str(indexComponents);
        else
            listRegion3.UserData{k, 1} = initialSpectrum;
            listRegion3.UserData{k, 2} = concentrations;
            listRegion3.UserData{k, 3} = spectra;
            listRegion3.UserData{k, 4} = fom;
            listRegion3.UserData{k, 5} = r2;

            % Store components when OaT is pressed
            if ~isempty(sCompMCRAaO)
                tabMCR.UserData.Region3{k, 3} = NumOfComp;
            end
            tabMCR.UserData.Region3{k, 5} = initialSpectrum;
            tabMCR.UserData.Region3{k, 6} = spectra;
            tabMCR.UserData.Region3{k, 7} = concentrations;
            tabMCR.UserData.Region3{k, 8} = [fom, r2];
                indexComponents = (1:NumOfComp)';
            tabMCR.UserData.Region3{k, 9} = indexComponents;
            tabMCR.UserData.Region3{k, 10} = "Comp. "+num2str(indexComponents);
        end
    end
end
close(progressMsg)

% Store components when OaT is pressed
if ~isempty(sCompMCRAaO)
    % Update Intervals detected in listRegion
    expression = '\d* comp.';
    replace = NumOfComp + " comp.";

    str = listRegion1.Items;
    listRegion1.Items = regexprep(str,expression,replace);

    str = listRegion2.Items;
    listRegion2.Items = regexprep(str,expression,replace);

    str = listRegion3.Items;
    listRegion3.Items = regexprep(str,expression,replace);
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

%%%%%%%%%%%%%%%%%%%%%%%
% Plot first interval %
%%%%%%%%%%%%%%%%%%%%%%%
% Ppm and intensities of first interval in Region 1
firstPpm = tabMCR.UserData.Region1{1, 1};
firstInterval = tabMCR.UserData.Region1{1, 2};
% Plot original samples
plot(axSegment, firstPpm, firstInterval);
axSegment.XLim = [min(firstPpm), max(firstPpm)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Eigenvalues of first interval %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eigenvalues of first interval in Region 1
firstEigenvalues = tabMCR.UserData.Region1{1, 4};
% Choose only the first eigenvalues
numEigenvalues = size(firstEigenvalues,1);
if numEigenvalues<10
    firstEigenvalues = firstEigenvalues(1:numEigenvalues);
else
    firstEigenvalues = firstEigenvalues(1:10);
end
% Plot
plot(axSVDinit, firstEigenvalues, 'o-')
axSVDinit.Title.String = 'Eigenvalues';
axSVDinit.XLabel.String = 'Component';
axSVDinit.YLabel.String = 'Magnitude';
if size(firstEigenvalues,1)>1
    axSVDinit.XLim = [1, size(firstEigenvalues,1)];
end
if strcmp(axSVDinit.XAxis.Direction, 'reverse')
    axSVDinit.XAxis.Direction = 'normal';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Spectral Profile of first interval %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spectral profile of first interval in Region 1
firstSpec = tabMCR.UserData.Region1{1, 6};
% Indices for components of first interval in Region 1
indComp = tabMCR.UserData.Region1{1, 9};
% Legends for plots of first interval in Region 1
lgdComp = tabMCR.UserData.Region1{1, 10};

% Plot
%plot(axSTprofile, firstPpm, firstSpec);
cla(axSTprofile)
hold(axSTprofile, 'on')
for i=1:size(indComp,1)
    plot(axSTprofile, firstPpm, firstSpec(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axSTprofile, 'off')
legend(axSTprofile, lgdComp(indComp))
axSTprofile.XLim = [min(firstPpm), max(firstPpm)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Concentration Profile of first interval %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concentration profile of first interval in Region 1
firstConc = tabMCR.UserData.Region1{1, 7};
% Plot
%plot(axCprofile, firstConc);
cla(axCprofile)
hold(axCprofile, 'on')
for i=1:size(indComp,1)
    plot(axCprofile, firstConc(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axCprofile, 'off')
legend(axCprofile, lgdComp(indComp))
if size(firstConc,1)>1
    axCprofile.XLim = [1, size(firstConc,1)];
end

% Default Region Tab
tgRegions.SelectedTab = tgRegions.Children(1);

% Default value in listRegion1
listRegion1.Value = 1;

% Default option in Plot selection
rbPlotSVD.Value = true;

fom = listRegion1.UserData{1, 4};
r2 = listRegion1.UserData{1, 5};
% Default Figure of merit values
efLOfExp.Value = fom(3);
efLOfExVa.Value = r2;
efLOfStdRes.Value = fom(1);

% To use as a confirmation that MCR was done
efLOfExp.UserData = 1;

% Enable buttons of section "Only for selected interval"
btnDelCompSelInter.Enable = "on";
btnMCROaTselInter.Enable = "on";
% Enable Export Models
btnExportModels.Enable = "on";
% Enable button Proceed
btnProceedToPCA.Enable = "on";
end

         
