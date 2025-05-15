function listInterval_callback(src, event, axInter, ...
    efLowLim, efHighLim)

% Recover data in listInterval
intervals = src.UserData;

% Update Edit Field Values
efLowLim.Value = intervals(event.Value,1);
efHighLim.Value = intervals(event.Value,2);

% Delete previous selected range
delete(findobj(axInter, 'Tag', 'thisLine'));

% Values to plot selected interval
xrY1 = axInter.UserData(2,1);
xrY2 = axInter.UserData(2,2);
xrWidth = intervals(event.Value,2) - intervals(event.Value,1);
xrHeight = xrY2 - xrY1;

% Plot selected interval
xrInterDefault = rectangle(axInter);
xrInterDefault.Position = [intervals(event.Value,1), xrY1, ...
    xrWidth, xrHeight];
xrInterDefault.EdgeColor = 'none';
xrInterDefault.FaceColor = [1 0 0 0.3]; % red
xrInterDefault.Tag = "thisLine";
end

