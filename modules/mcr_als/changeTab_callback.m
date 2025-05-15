function changeTab_callback(~, event, tabMCR, listRegion1, listRegion2, ...
    listRegion3, axSegment, axSVDinit, axSTprofile, axCprofile, ...
    btnMCROaTinitialize, sCompMCROaT, rbPlotSVD, efLOfExp, ...
    efLOfExVa, efLOfStdRes)


% Select listRegion depending on the tabRegion
if strcmp(event.NewValue.Title,"Region 1")
    listRegion = listRegion1;
elseif strcmp(event.NewValue.Title,"Region 2")
    listRegion = listRegion2;
else 
    listRegion = listRegion3;
end

if ~strcmp(listRegion.Value,'None')
    % Plot and change information according to selected interval ...
    % and selected region
    listRegion_callback(listRegion, listRegion, tabMCR, ...
        axSegment, axSVDinit, axSTprofile, axCprofile, ...
        sCompMCROaT, btnMCROaTinitialize, rbPlotSVD,...
        efLOfExp, efLOfExVa, efLOfStdRes);
end

end

