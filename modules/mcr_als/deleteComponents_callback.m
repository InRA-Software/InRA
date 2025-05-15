function deleteComponents_callback(~, ~, tabMCR, tgRegions, ...
    listRegion1, listRegion2, listRegion3, axSTprofile, axCprofile)

figDelComp = uifigure('Name', 'Delete Components');
figDelComp.Position = [580 210 180 200];
figDelComp.WindowStyle = 'modal';
figDelComp.Resize = 'off';
glDelComp = uigridlayout(figDelComp);
glDelComp.RowHeight = {'1x', 20};
glDelComp.ColumnWidth = {10, 120, 10};

% Recover data
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
%-- Region 1 --
    % Selected interval
    selectedInterval = listRegion1.Value;
    % Selected indices for components
    indComp = tabMCR.UserData.Region1{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region1{selectedInterval,10};

elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
%-- Region 2 --
    % Selected interval
    selectedInterval = listRegion2.Value;
    % Selected indices for components
    indComp = tabMCR.UserData.Region2{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region2{selectedInterval,10};

else
%-- Region 3 --
    % Selected interval
    selectedInterval = listRegion3.Value;
    % Selected indices for components
    indComp = tabMCR.UserData.Region3{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region3{selectedInterval,10};
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delete Component Button %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btnDelComp = uibutton(glDelComp);
% Positions
btnDelComp.Layout.Row = 2;
btnDelComp.Layout.Column = 2;
% Style
btnDelComp.Text = "Delete Component";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of components to delete %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
listDelComp = uilistbox(glDelComp);
% Position
listDelComp.Layout.Row = 1;
listDelComp.Layout.Column = [1 3];
listDelComp.Items = lgdComp(indComp);
listDelComp.ItemsData = indComp;

%%%%%%%%%%%%%
% Behaviour %
%%%%%%%%%%%%%
btnDelComp.ButtonPushedFcn = {@delComp_figDelComp_callback, ...
    selectedInterval, listDelComp, ...
    axSTprofile, axCprofile, tabMCR, tgRegions};

%figDelComp.CloseRequestFcn = {@my_closereq, selectedInterval, tabMCR, ...
%    tgRegions};

end


%% Delete Components Callback
function delComp_figDelComp_callback(~, ~, selectedInterval, ...
    listDelComp, axSTprofile, axCprofile, tabMCR, tgRegions)
% Colors
specColors = [0 0.4470 0.7410;
              0.8500 0.3250 0.0980;	
              0.9290 0.6940 0.1250;	
              0.4940 0.1840 0.5560;
              0.4660 0.6740 0.1880;
              0.3010 0.7450 0.9330;
              0.6350 0.0780 0.1840];

% Recover data
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
%-- Region 1 --
    % Selected ppm
    selectedPpm = tabMCR.UserData.Region1{selectedInterval,1};
    % Selected Resolved Spectral Profile
    selectedSpec = tabMCR.UserData.Region1{selectedInterval,6};
    % Selected Resolved Concentration Profile
    selectedConc = tabMCR.UserData.Region1{selectedInterval,7};
    % Selected indices for components
    indComp = tabMCR.UserData.Region1{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region1{selectedInterval,10};
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
%-- Region 2 --
    % Selected ppm
    selectedPpm = tabMCR.UserData.Region2{selectedInterval,1};
    % Selected Resolved Spectral Profile
    selectedSpec = tabMCR.UserData.Region2{selectedInterval,6};
    % Selected Resolved Concentration Profile
    selectedConc = tabMCR.UserData.Region2{selectedInterval,7};
    % Selected indices for components
    indComp = tabMCR.UserData.Region2{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region2{selectedInterval,10};
else
%-- Region 3 --
    % Selected ppm
    selectedPpm = tabMCR.UserData.Region3{selectedInterval,1};
    % Selected Resolved Spectral Profile
    selectedSpec = tabMCR.UserData.Region3{selectedInterval,6};
    % Selected Resolved Concentration Profile
    selectedConc = tabMCR.UserData.Region3{selectedInterval,7};
    % Selected indices for components
    indComp = tabMCR.UserData.Region3{selectedInterval,9};
    % Selected legends
    lgdComp = tabMCR.UserData.Region3{selectedInterval,10};
end

% Selected component to delete
selectedComp = listDelComp.Value;

% Delete index component
indComp(indComp==selectedComp) = [];

% Update list
listDelComp.Items = lgdComp(indComp);
listDelComp.ItemsData = indComp;

% Update Spectral Profile
cla(axSTprofile)
hold(axSTprofile, 'on')
for i=1:size(indComp,1)
    plot(axSTprofile, selectedPpm, selectedSpec(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axSTprofile, 'off')
legend(axSTprofile, lgdComp(indComp))

% Update Concentration Profile
cla(axCprofile)
hold(axCprofile, 'on')
for i=1:size(indComp,1)
    plot(axCprofile, selectedConc(:,indComp(i)), ...
        'color', specColors(indComp(i),:))
end
hold(axCprofile, 'off')
legend(axCprofile, lgdComp(indComp))
axCprofile.XLim = [1, size(selectedConc,1)];


% Store changes in index matrix
if strcmp(tgRegions.SelectedTab.Title,"Region 1")
    tabMCR.UserData.Region1{selectedInterval,9} = indComp;
elseif strcmp(tgRegions.SelectedTab.Title,"Region 2")
    tabMCR.UserData.Region2{selectedInterval,9} = indComp;
else
    tabMCR.UserData.Region3{selectedInterval,9} = indComp;
end

end
