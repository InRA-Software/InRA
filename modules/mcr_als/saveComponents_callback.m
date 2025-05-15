function saveComponents_callback(~, ~, tgRegions, tabMCR, ...
    listRegion1, listRegion2, listRegion3,...
    sCompMCROaT)

% Select region to save number of Components
if strcmp(tgRegions.SelectedTab.Title,"Region 1")

%-- Region 1 --
    % Selected interval
    nInterval = listRegion1.Value;
    % Save the number of components selected for selected interval
    tabMCR.UserData.Region1{nInterval,3} = sCompMCROaT.Value;
    % Save initial spectrum of selected interval
    if size(listRegion1.UserData,1)>=nInterval
        tabMCR.UserData.Region1{nInterval,5}=listRegion1.UserData{nInterval,1};
    end
    % Actualize the number of components in listRegion
    listRegion1.Items(nInterval) = cellstr("Interval " + ...
    nInterval+" | "+ sCompMCROaT.Value+" comp.");

elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")

%-- Region 2 --
    % Selected interval
    nInterval = listRegion2.Value;
    % Save the number of components selected for selected interval
    tabMCR.UserData.Region2{nInterval,3} = sCompMCROaT.Value;
    % Save initial spectrum of selected interval
    if size(listRegion2.UserData,1)>=nInterval
        tabMCR.UserData.Region2{nInterval,5}=listRegion2.UserData{nInterval,1};
    end
    % Actualize the number of components in listRegion
    listRegion2.Items(nInterval) = cellstr("Interval " + ...
    nInterval+" | "+ sCompMCROaT.Value+" comp.");
else

%-- Region 3 --
    % Selected interval
    nInterval = listRegion3.Value;
    % Save the number of components selected for selected interval
    tabMCR.UserData.Region3{nInterval,3} = sCompMCROaT.Value;
    % Save initial spectrum of selected interval
    if size(listRegion3.UserData,1)>=nInterval
        tabMCR.UserData.Region3{nInterval,5}=listRegion3.UserData{nInterval,1};
    end
    % Actualize the number of components in listRegion
    listRegion3.Items(nInterval) = cellstr("Interval " + ...
    nInterval+" | "+ sCompMCROaT.Value+" comp.");
end

end

