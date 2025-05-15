function deleteInterval_callback(src, ~, listInter, axInter, ...
     efLowLim, efHighLim, uitDeleted)
% Recover data in listInterval
intervals = listInter.UserData;

% Recover data in uitDeleted Table
deletedIntervals = uitDeleted.UserData;
% Add deleted interval and store it in Table User's Data
deletedIntervals = [deletedIntervals; intervals(listInter.Value,:)];
uitDeleted.UserData = deletedIntervals;
% Refresh Deleted Table
uitDeleted.Data = deletedIntervals;

% Delete selected interval
intervals(listInter.Value,:) = [];

% Select region and colors
if strcmp(listInter.Tag,"Max")
    ppmRegion = "R3 - ";
    color1 = [0, 0, 128/255, 0.3]; % azul
    color2 = [0.2, 0, 128/255, 0.3];
elseif strcmp(listInter.Tag,"Min")
    ppmRegion = "R1 - ";
    color1 = [128/255, 0, 128/255, 0.3]; %morado
    color2 = [128/255, 0.2, 128/255, 0.3];
else 
    ppmRegion = "R2 - ";
    color1 = [0, 128/255, 0, 0.3]; % verde
    color2 = [0, 128/255, 0.2, 0.3];
end

% Delete selected interval region
delRegion = findobj(axInter, 'Tag', ...
    ppmRegion+ "Interval " + num2str(listInter.Value));
delete(delRegion);

% Update Interval Limits Edit Fields
efLowLim.Value = [];
efHighLim.Value = [];

%%%%%%%%%%%%%%%%%%%%%%%%
% Update List Interval %
%%%%%%%%%%%%%%%%%%%%%%%%
% Delete the last Item and ItemData in listInterval to match dimension with
% array of intervals
listInter.Items = {};
listInter.ItemsData = [];
% Create an array of numbers with the new size of
% array of intervals and create an array of strings to put in Items
updatedNintervals = (1:(size(intervals,1)));
updatedIntervalItems = ppmRegion + "Interval " + updatedNintervals; 
% Update List Iterval Items and ItemsData
listInter.Items = cellstr(updatedIntervalItems);
listInter.ItemsData = updatedNintervals;

% Values to plot Selected Region
xrY1 = axInter.UserData(2,1);
xrY2 = axInter.UserData(2,2);
xrWidth = intervals(:,2) - intervals(:,1);
xrHeight = xrY2 - xrY1;

% Update Selected Region
xrSelected =  findobj(axInter, 'Tag', 'thisLine');
xrSelected.Position = [intervals(1,1), xrY1, ...
            xrWidth(1), xrHeight];

% Deleted all rectangles with Tag = Interval + "number"
toBeDeleted = findobj(axInter,'Type','rectangle','-and', ...
    {'-regexp','Tag',ppmRegion+"Interval\s\w*"});
delete(toBeDeleted)

% Plot interval regions
for k = 1:size(intervals,1)
    xrInter(k) = rectangle(axInter);
    xrInter(k).Position = [intervals(k,1), xrY1, xrWidth(k), xrHeight];
    xrInter(k).EdgeColor = 'none';
    xrInter(k).Tag = listInter.Items{k};
    if mod(k,2)==1
        xrInter(k).FaceColor = color1;
    else
        xrInter(k).FaceColor = color2;
    end
end 

% Store ppm data in listInterval object
listInter.UserData = intervals;
end