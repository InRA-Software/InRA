function newInterval_callback(src, ~, listInter, axInter, ...
    efLowLim, efHighLim, uitAdded)

% Check if interval is valid
if efHighLim.Value > efLowLim.Value
    % Select region and colors
    if strcmp(listInter.Tag,"Max")
        ppmRegion = "R3 - ";
        color1 = [0, 0, 128/255, 0.3]; % azul
        color2 = [0.2, 0, 128/255, 0.3];
        ppmRegionAux = 'R3 - ';
    elseif strcmp(listInter.Tag,"Min")
        ppmRegion = "R1 - ";
        color1 = [128/255, 0, 128/255, 0.3]; %morado
        color2 = [128/255, 0.2, 128/255, 0.3];
        ppmRegionAux = 'R1 - ';
    else
        ppmRegion = "R2 - ";
        color1 = [0, 128/255, 0, 0.3]; % verde
        color2 = [0, 128/255, 0.2, 0.3];
        ppmRegionAux = 'R2 - ';
    end

    % Recover data in listInterval
    intervals = listInter.UserData;

    % Obtain number of intervals
    n = size(listInter.Items, 2);

    % For to check if the values in Edit Field already exist in intervals
    [row1, ~] = find(intervals==efLowLim.Value);
    [row2, ~] = find(intervals==efHighLim.Value);

    % Check if the values in Edit Field already exist in intervals
    if ~isempty(row1) || ~isempty(row2)
        % Warning alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Can't add an existing interval", "Warning", ...
            "Icon","warning");
    else
        % Create new item in listInterval
        listInter.Items(n+1) = {append(ppmRegionAux, 'Interval ', num2str(n+1))};
        listInter.ItemsData(n+1) = n+1;

        % Recover data in uitAdded Table
        addedIntervals = uitAdded.UserData;
        % Add new interval and store it in Table User's Data
        addedIntervals = [addedIntervals; ...
            efLowLim.Value, efHighLim.Value];
        uitAdded.UserData = addedIntervals;
        % Refresh Added Table
        uitAdded.Data = addedIntervals;

        % Add new interval to array's intervals
        intervals(n+1,:) = [efLowLim.Value efHighLim.Value];

        % Sort interval array
        intervals = sort(intervals,1);

        % Find index of new interval
        indNewInterval = find(intervals==efLowLim.Value);

        % Delete all rectangles with Tag = "ppmRegion"+Interval+"number" 
        % and selected region
        toBeDeleted = findobj(axInter,'Type','rectangle','-and',...
            {'-regexp','Tag',ppmRegion + "\w*"});
        delete(toBeDeleted)
        delete(findobj(axInter, 'Tag','thisLine'));

        % Values to plot intervals Regions
        xrY1 = axInter.UserData(2,1);
        xrY2 = axInter.UserData(2,2);
        xrWidth = intervals(:,2) - intervals(:,1);
        xrHeight = xrY2 - xrY1;

        % Plot interval regions
        for k = 1:size(intervals,1)
            xrInter(k) = rectangle(axInter);
            xrInter(k).Position = [intervals(k,1), xrY1, ...
                xrWidth(k), xrHeight];
            xrInter(k).EdgeColor = 'none';
            xrInter(k).Tag = listInter.Items{k};
            if mod(k,2)==1
                xrInter(k).FaceColor = color1;
            else
                xrInter(k).FaceColor = color2;
            end
        end 

        % Plot selected new interval
        xrInterDefault = rectangle(axInter);
        xrInterDefault.Position = [intervals(indNewInterval,1), xrY1, ...
            xrWidth(indNewInterval), xrHeight];
        xrInterDefault.EdgeColor = 'none';
        xrInterDefault.FaceColor = [1 0 0 0.3]; % red
        xrInterDefault.Tag = "thisLine";

        % Select new interval in listInterval
        listInter.Value = indNewInterval;

        % Store ppm data in listInterval object
        listInter.UserData = intervals;
   end
else
    % Warning alert
    fig = ancestor(src, 'figure', 'toplevel');
    uialert(fig, "Lower ppm can't be greater than Higher ppm", ...
        "Warning", "Icon","warning");
end

end
