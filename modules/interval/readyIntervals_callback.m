function readyIntervals_callback(src, ~, axPre, tabMCR, btnMCRBuildMod, ...
    listInterRngMin, listInterRngMdd, listInterRngMax, ...
    listRegion1, listRegion2, listRegion3, tgRegions, tabRegion1, ...
    btnMCROaTinitialize, btnMCROaTsaveComp, rbPlotSVD, rbPlotInit, ...
    btnMCROaTBuildMod, axSTprofile, axCprofile, btnDelCompSelInter, ...
    btnMCROaTselInter, btnProceedToPCA, efLOfExp, ...
    axSegment, axSVDinit, sCompMCROaT, efLOfExVa, efLOfStdRes, ...
    btnExportModels)

% Loading window
fig = ancestor(src, 'figure', 'toplevel');
loadingWindow = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Proceding . . .', 'Indeterminate','on');

% Delete previous data in tabMCR, listRegions and axes STprofe - Cprofile
tabMCR.UserData = [];
listRegion1.UserData = [];
listRegion2.UserData = [];
listRegion3.UserData = [];
efLOfExVa.Value = 0;
efLOfStdRes.Value = 0;
efLOfExp.Value = 0;
cla(axSTprofile)
cla(axCprofile)
% To use as a confirmation that MCR was not done
efLOfExp.UserData = 0;

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Recover data in listInterval
intervals = {listInterRngMin.UserData, listInterRngMdd.UserData, ...
    listInterRngMax.UserData};

if size(intervals,2)==3
    for i=1:3
        % Number of intervals to save
        nSave = size(intervals{i},1);

        % Create empty cell array to save ppm and intensities for each interval
        PpmIntCompSpec = cell(nSave,10);

        % Save ppm and intesities for each non empty interval
        for k = 1:nSave
            % Find indices of Interval k
            [lowInd, highInd] = findIndex(intervals{i}(k,1), ...
                intervals{i}(k,2), Cut_ppm_axis);

            % Save ppm, intensities, number of componentes, eigenvalues 
            % and empty-cell for future spectra
            PpmIntCompSpec(k,1) = {Cut_ppm_axis(lowInd:highInd)};
            PpmIntCompSpec(k,2) = {Cut_1HNMR_Data(:,lowInd:highInd)};
            PpmIntCompSpec(k,3) = {1}; % Number of components
                % Singular Values Decomposition to obtaing eigenvalues
                [~, S, ~] = svd(PpmIntCompSpec{k,2},'econ');
            PpmIntCompSpec(k,4) = {nonzeros(S)};
            PpmIntCompSpec(k,5) = {[]}; % Initial Spectrum
            PpmIntCompSpec(k,6) = {[]}; % Resolved Spectral Profile
            PpmIntCompSpec(k,7) = {[]}; % Resolved Concentration Profile
            PpmIntCompSpec(k,8) = {[]}; % Figures of Merit
            PpmIntCompSpec(k,9) = {[]}; % Index array for the components
            PpmIntCompSpec(k,10) = {[]}; % Legends for Spectra and 
                                         % Concentrations plots
        end
        % Store ppm-intensity cell array in tabMCR
        if i==1
            tabMCR.UserData.Region1 = PpmIntCompSpec;
        elseif i==2
            tabMCR.UserData.Region2 = PpmIntCompSpec;
        else
            tabMCR.UserData.Region3 = PpmIntCompSpec;
        end
    end
end

% Enable buttons in Resonance Integration tab
btnMCRBuildMod.Enable = 'on';
btnMCROaTinitialize.Enable = "on";
btnMCROaTsaveComp.Enable = "on";
rbPlotSVD.Enable = "on";
rbPlotInit.Enable = "on";
btnMCROaTBuildMod.Enable = "on";
% Disable buttons in Resonance Integration tab 
btnDelCompSelInter.Enable = "off";
btnMCROaTselInter.Enable = "off";
btnProceedToPCA.Enable = "off";
btnExportModels.Enable = "off";

% Change "None" to Intervals detected in listRegion
listRegion1.Items = replace(listInterRngMin.Items, "R1 - ", "");
listRegion1.Items = listRegion1.Items + " | 1 comp.";
listRegion1.ItemsData = (1:size(listRegion1.Items,2));

listRegion2.Items = replace(listInterRngMdd.Items, "R2 - ", "");
listRegion2.Items = listRegion2.Items + " | 1 comp.";
listRegion2.ItemsData = (1:size(listRegion2.Items,2));

listRegion3.Items = replace(listInterRngMax.Items, "R3 - ", "");
listRegion3.Items = listRegion3.Items + " | 1 comp.";
listRegion3.ItemsData = (1:size(listRegion3.Items,2));

% Default Region and listRegion's Item value
tgRegions.SelectedTab = tabRegion1;
listRegion1.Value = 1; 
listRegion2.Value = 1; 
listRegion3.Value = 1;

% Plot Default Interval
listRegion_callback(listRegion1, listRegion1, tabMCR, ...
        axSegment, axSVDinit, axSTprofile, axCprofile, ...
        sCompMCROaT, btnMCROaTinitialize, rbPlotSVD,...
        efLOfExp, efLOfExVa, efLOfStdRes);


% Close loading windows and delete corresponding object
close(loadingWindow)
delete(loadingWindow)

end


function [firstInd, lastInd] = findIndex(firstPPM, lastPPM, ppmVector)

% Find first index
firstInd = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + 0.01), 1, 'first');
% Find last index
lastInd = find(ppmVector >= lastPPM & ...
    ppmVector < (lastPPM + 0.01), 1, 'first');

end
