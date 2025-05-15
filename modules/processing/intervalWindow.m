function intervalWindow(~,~,axPre,ddIcoshiftOption2)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Min and max ppm values
minPpm = min(Cut_ppm_axis);
maxPpm = max(Cut_ppm_axis);

% Min and max intesitie values
minIntensity = min(Cut_1HNMR_Data, [], "all");
maxIntensity = max(Cut_1HNMR_Data, [], "all");

% Create figure window
figIcoInter = uifigure('Name', 'Icoshift: Intervals');
figIcoInter.WindowStyle = 'modal';
figIcoInter.Resize = 'on';

gfigIcoInter = uigridlayout(figIcoInter);
gfigIcoInter.RowHeight = {'1x', 14, 'fit', 'fit'};
gfigIcoInter.ColumnWidth = {160, '1x', '1x', '1x'};

%%%%%%%%%%%%%%
% axIcoInter %
%%%%%%%%%%%%%%
% Create
axIcoInter = uiaxes(gfigIcoInter);
% Positions
axIcoInter.Layout.Row = 1;
axIcoInter.Layout.Column = [2 4];
% Style
% Axes Interval
axIcoInter.XDir = 'reverse';
axIcoInter.XLabel.String = 'δ^{1}H (ppm)';
axIcoInter.YLabel.String = 'Intensity';
axIcoInter.XLim = [minPpm, maxPpm];
axIcoInter.YLim = [minIntensity, maxIntensity];
% User Data
axIcoInter.UserData = [minPpm, maxPpm; minIntensity, maxIntensity];

% Plot the data
plot(axIcoInter, Cut_ppm_axis, Cut_1HNMR_Data);

%%%%%%%%%%%
% Sliders %
%%%%%%%%%%%
% Create
sldLowIco = uislider(gfigIcoInter);
sldHighIco = uislider(gfigIcoInter);
% Positions
sldLowIco.Layout.Row = 3;
sldLowIco.Layout.Column = [2 4];
%
sldHighIco.Layout.Row = 4;
sldHighIco.Layout.Column = [2 4];
% Style
sldLowIco.Limits = [min(Cut_ppm_axis), max(Cut_ppm_axis)];
sldLowIco.MajorTicks = linspace(min(sldLowIco.Limits), max(sldLowIco.Limits), 9);
sldLowIco.MajorTickLabels = string(flip(sldLowIco.MajorTicks));
sldLowIco.Value = maxPpm;
%{
Internally, the numerical values of sldLow are the high ones, and those of 
sldHigh are the low ones.
The magic is in the callback functions.
%}
sldHighIco.Limits = sldLowIco.Limits;
sldHighIco.MajorTicks = sldLowIco.MajorTicks;
sldHighIco.MajorTickLabels = sldLowIco.MajorTickLabels;
sldHighIco.Value = minPpm;

sldLowIco.Enable = "on";
sldHighIco.Enable = "on";

%% LEFT GRID LAYOUT
%%%%%%%%%%%%%%%%%%%%
% Left Grid LayOut % 
%%%%%%%%%%%%%%%%%%%%
% Create
gOptIcoInter = uigridlayout(gfigIcoInter,[2,6]);
% Position
gOptIcoInter.Layout.Row = [1 4];
gOptIcoInter.Layout.Column = 1;
% Style
gOptIcoInter.RowHeight = {'1x', 'fit','fit','fit', 'fit', 'fit'};
gOptIcoInter.ColumnWidth = {70, 70};

%%%%%%%%
% List %
%%%%%%%%
% Create
listIcoInter = uilistbox(gOptIcoInter);
% Positions
listIcoInter.Layout.Row = 1;
listIcoInter.Layout.Column = [1 2];
% Style
listIcoInter.Items = "None";

%%%%%%%%%%
% Labels %
%%%%%%%%%%
%-----------
% Lower ppm 
%-----------
% Create
lblLowIcoInter = uilabel(gOptIcoInter);
% Position
lblLowIcoInter.Layout.Row = 2;
lblLowIcoInter.Layout.Column = 1;
% Style
lblLowIcoInter.Text = "Lower ppm";
lblLowIcoInter.HorizontalAlignment = "center";
lblLowIcoInter.VerticalAlignment = "center";
lblLowIcoInter.FontSize = 10;
lblLowIcoInter.FontWeight = "bold";
%-----------
% Higher ppm
%-----------
% Create
lblHighIcoInter = uilabel(gOptIcoInter);
% Position
lblHighIcoInter.Layout.Row = 2;
lblHighIcoInter.Layout.Column = 2;
% Style
lblHighIcoInter.Text = "Higher ppm";
lblHighIcoInter.HorizontalAlignment = "center";
lblHighIcoInter.VerticalAlignment = "center";
lblHighIcoInter.FontSize = 10;
lblHighIcoInter.FontWeight = "bold";

%%%%%%%%%%%%
% Spinners %
%%%%%%%%%%%%
%-----------
% Lower ppm
%-----------
% Create 
sLowIcoInter = uispinner(gOptIcoInter);
% Position
sLowIcoInter.Layout.Row = 3;
sLowIcoInter.Layout.Column = 1;
% Style
sLowIcoInter.Limits = [minPpm, maxPpm];
sLowIcoInter.Step = 0.01;
sLowIcoInter.Value = minPpm; 
%-----------
% Higher ppm
%-----------
% Create 
sHighIcoInter = uispinner(gOptIcoInter);
% Position
sHighIcoInter.Layout.Row = 3;
sHighIcoInter.Layout.Column = 2;
% Style
sHighIcoInter.Limits = [minPpm, maxPpm];
sHighIcoInter.Step = 0.01;
sHighIcoInter.Value = maxPpm;

%%%%%%%%%%%%%%
% Add button %
%%%%%%%%%%%%%%
% Create 
btnAddIcoInter = uibutton(gOptIcoInter);
% Position
btnAddIcoInter.Layout.Row = 4;
btnAddIcoInter.Layout.Column = 2;
% Style
btnAddIcoInter.Text = "Add";

%%%%%%%%%%%%%%%%%
% Delete button %
%%%%%%%%%%%%%%%%%
% Create 
btnDeleteIcoInter = uibutton(gOptIcoInter);
% Position
btnDeleteIcoInter.Layout.Row = 4;
btnDeleteIcoInter.Layout.Column = 1;
% Style
btnDeleteIcoInter.Text = "Delete";
btnDeleteIcoInter.Enable = "off";

%%%%%%%%%%%%%
% Check Box %
%%%%%%%%%%%%%
% Create
cbxEditIco = uicheckbox(gOptIcoInter);
% Positions
cbxEditIco.Layout.Row = 5;
cbxEditIco.Layout.Column = 1;
% Style
cbxEditIco.Text = "Edit Interval";
cbxEditIco.FontSize = 10;
cbxEditIco.Enable = "off";

%%%%%%%%%%%%%%%%%%%
% Continue button %
%%%%%%%%%%%%%%%%%%%
% Create 
btnContinueIcoInter = uibutton(gOptIcoInter);
% Position
btnContinueIcoInter.Layout.Row = 5;
btnContinueIcoInter.Layout.Column = 2;
% Style
btnContinueIcoInter.Text = "Continue";
btnContinueIcoInter.FontSize = 9.5;
btnContinueIcoInter.Enable = "off";

%% OBJECT BEHAVIOURS
%%%%%%%%%%%%%%
% Behaviours %
%%%%%%%%%%%%%%

% Add Interval
btnAddIcoInter.ButtonPushedFcn = {@addInterval_IcoInter, sLowIcoInter, ...
    sHighIcoInter, listIcoInter, axIcoInter, sldLowIco, sldHighIco, ...
    btnDeleteIcoInter, btnContinueIcoInter, cbxEditIco};

% Update Spinners with Sliders
sldLowIco.ValueChangingFcn = {@updateLower, sldHighIco, ...
    sLowIcoInter, axIcoInter, listIcoInter, cbxEditIco};
sldHighIco.ValueChangingFcn = {@updateHigher, sldLowIco, ...
    sHighIcoInter, axIcoInter, listIcoInter, cbxEditIco};

% Update Sliders with Spinners
sLowIcoInter.ValueChangingFcn = {@updateSpnLower, ...
    sldLowIco, sldHighIco, sHighIcoInter, axIcoInter, listIcoInter, cbxEditIco};
sHighIcoInter.ValueChangingFcn = {@updateSpnHigher, ...
    sldLowIco, sldHighIco, sLowIcoInter, axIcoInter, listIcoInter, cbxEditIco};

% Select Interval
listIcoInter.ValueChangedFcn = {@selectInterval_IcoInter, axIcoInter, ...
    sldLowIco, sldHighIco, sLowIcoInter, sHighIcoInter};

% Delete Interval
btnDeleteIcoInter.ButtonPushedFcn  = {@deleteInterval_IcoInter, ...
    listIcoInter, axIcoInter, sLowIcoInter, sHighIcoInter, ...
    sldLowIco, sldHighIco, axPre, btnContinueIcoInter, cbxEditIco};

% Check Edit Interval
cbxEditIco.ValueChangedFcn = {@checkEditInterval_IcoInter, listIcoInter, ...
    btnAddIcoInter, sLowIcoInter, sHighIcoInter, btnDeleteIcoInter, ...
    btnContinueIcoInter, sldLowIco, sldHighIco};

% Continue
btnContinueIcoInter.ButtonPushedFcn  = {@continueInterval_IcoInter, ...
    listIcoInter, ddIcoshiftOption2, axPre};

% Close window
figIcoInter.CloseRequestFcn = {@my_closereq, ddIcoshiftOption2};



% Pause until figIcoInter is closed
waitfor(figIcoInter);

end


%%      Update Spinner Lower ppm and Edit Interval

%{
        Update Spinner Lower ppm and Edit Interval
%}
function updateSpnLower(src, event, sldLowIco, sldHighIco, sHighIcoInter, ...
    axIcoInter, listIcoInter, cbxEditIco)

if cbxEditIco.Value
    try
        % Selected interval in listIcoInter
        selectedInterval = listIcoInter.Value;

        % Recover data in xr.UserData
        xrY1 = axIcoInter.UserData(2,1);
        xrY2 = axIcoInter.UserData(2,2);
        xrHeight = xrY2 - xrY1;

        % Check if the lower slider is to close to the higher slider
        if abs(event.Value-sHighIcoInter.Value) <= 0.05
            % Update High Slider Value
            sldHighIco.Value = sldHighIco.Value - 0.2;
            
            % Update High Spinner Value
            sHighIcoInter.Value = sHighIcoInter.Value + 0.2;

            % Update Selected Region
            xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
            xrSelectedIco.Position = [event.Value, xrY1, ...
            sHighIcoInter.Value - event.Value, xrHeight];

             % Plot
            xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
                {'Tag',"Interval "+num2str(selectedInterval)});
            xrIco.Position = [event.Value, xrY1, ...
                sHighIcoInter.Value - event.Value, xrHeight];

            % Update intervals
            intervals(selectedInterval, 1) = event.Value;
            intervals(selectedInterval, 2) = sHighIcoInter.Value;

            % Store new interval value in listIcoInter
            listIcoInter.UserData = intervals; 

        end

        % Update Selected Region
        xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
        xrSelectedIco.Position = [event.Value, xrY1, ...
            sHighIcoInter.Value - event.Value, xrHeight];

        % Plot
        xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
            {'Tag',"Interval "+num2str(selectedInterval)});
        xrIco.Position = [event.Value, xrY1, ...
            sHighIcoInter.Value - event.Value, xrHeight];

        % Update values of low slider
        sldLowIco.Value = sum(sldLowIco.Limits)-event.Value;

        % Recover data in listIcoInter
        intervals = listIcoInter.UserData;

        % Update intervals
        intervals(selectedInterval, 1) = event.Value;

        % Store new interval value in listIcoInter
        listIcoInter.UserData = intervals; 

    catch
        % Error alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Exceeded the higher limit.", "Error");
    end

else
    % Update values of low slider
    sldLowIco.Value = sum(sldLowIco.Limits)-event.Value;
end

end

%%      Update Slider Lower ppm and Edit Interval

%{
        Update Slider Lower ppm and Edit Interval
%}
function updateLower(src, event, sldHighIco, sLowIcoInter, ...
    axIcoInter, listIcoInter, cbxEditIco)
% Reverse the slider values.
% Initially, was written like this: 
% max(src.Limits) - event.Value + min(src.Limits)
% It's the same logic for the other callbacks
auxLimits = sum(src.Limits);
valLow = auxLimits - event.Value;
valHigh = auxLimits - sldHighIco.Value;

if cbxEditIco.Value
    
    try
        % Check if the lower slider is to close to the higher slider
        if abs(event.Value-sldHighIco.Value) <= 0.05
            sldHighIco.Value = sldHighIco.Value - 0.2;
        end

        % Selected interval in listIcoInter
        selectedInterval = listIcoInter.Value;

        % Recover data in xr.UserData
        xrY1 = axIcoInter.UserData(2,1);
        xrY2 = axIcoInter.UserData(2,2);
        xrHeight = xrY2 - xrY1;

        % Update Selected Region
        xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
        xrSelectedIco.Position = [valLow, xrY1, ...
            valHigh - valLow, xrHeight];

        % Plot
        xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
            {'Tag',"Interval "+num2str(selectedInterval)});
        xrIco.Position = [valLow, xrY1, ...
            valHigh - valLow, xrHeight];

        % Recover data in listIcoInter
        intervals = listIcoInter.UserData;

        % Update intervals
        intervals(selectedInterval, 1) = valLow;

        % Store new interval value in listIcoInter
        listIcoInter.UserData = intervals; 

    catch
        % Error alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Exceeded the higher limit.", "Error");
    end

else

    % Check if the lower slider is to close to the higher slider
    if abs(event.Value-sldHighIco.Value) <= 0.05
        sldHighIco.Value = sldHighIco.Value - 0.2;
    end

end

% Update Spinner value
sLowIcoInter.Value = valLow;
end


%%      Update Spinner Higher ppm and Edit Interval

%{
        Update Spinner Higher ppm and Edit Interval
%}
function updateSpnHigher(src, event, sldLowIco, sldHighIco, ...
    sLowIcoInter, axIcoInter, listIcoInter, cbxEditIco)

if cbxEditIco.Value
    try
        % Selected interval in listIcoInter
        selectedInterval = listIcoInter.Value;

        % Recover data in xr.UserData
        xrY1 = axIcoInter.UserData(2,1);
        xrY2 = axIcoInter.UserData(2,2);
        xrHeight = xrY2 - xrY1;

        % Check if the lower slider is to close to the higher slider
        if abs(event.Value-sLowIcoInter.Value) <= 0.05
            % Update Low Slider Value
            sldLowIco.Value = sldLowIco.Value + 0.2;
            
            % Update Low Spinner Value
            sLowIcoInter.Value = sLowIcoInter.Value - 0.2;

            % Update Selected Region
            xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
            xrSelectedIco.Position = [sLowIcoInter.Value, xrY1, ...
                event.Value - sLowIcoInter.Value, xrHeight];

            % Plot
            xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
                {'Tag',"Interval "+num2str(selectedInterval)});
            xrIco.Position = [sLowIcoInter.Value, xrY1, ...
                event.Value - sLowIcoInter.Value, xrHeight];

            % Update intervals
            intervals(selectedInterval, 1) = sLowIcoInter.Value;
            intervals(selectedInterval, 2) = event.Value;

            % Store new interval value in listIcoInter
            listIcoInter.UserData = intervals; 

        end

        % Update Selected Region
        xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
        xrSelectedIco.Position = [sLowIcoInter.Value, xrY1, ...
            event.Value - sLowIcoInter.Value, xrHeight];

        % Plot
        xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
            {'Tag',"Interval "+num2str(selectedInterval)});
        xrIco.Position = [sLowIcoInter.Value, xrY1, ...
             event.Value - sLowIcoInter.Value, xrHeight];

        % Update values of high slider
        sldHighIco.Value = sum(sldHighIco.Limits)-event.Value;

        % Recover data in listIcoInter
        intervals = listIcoInter.UserData;

        % Update intervals
        intervals(selectedInterval, 2) = event.Value;

        % Store new interval value in listIcoInter
        listIcoInter.UserData = intervals; 

    catch
        % Error alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Exceeded the higher limit.", "Error");
    end

else
    % Update values of low slider
    sldHighIco.Value = sum(sldHighIco.Limits)-event.Value;
end

end


%%      Update Higher ppm

%{
        Update Higher ppm
%}
function updateHigher(src, event, sldLowIco, sHighIcoInter, ...
    axIcoInter, listIcoInter, cbxEditIco)
% Reverse the sliders values
auxLimits = sum(src.Limits);
valLow = auxLimits - sldLowIco.Value;
valHigh = auxLimits - event.Value;

if cbxEditIco.Value

    try
        % Check if the lower slider is to close to the lower slider
        if abs(event.Value-sldLowIco.Value) <= 0.05
            sldLowIco.Value = sldLowIco.Value + 0.2;
        end

        % Selected interval in listIcoInter
        selectedInterval = listIcoInter.Value;

        % Recover data in xr.UserData
        xrY1 = axIcoInter.UserData(2,1);
        xrY2 = axIcoInter.UserData(2,2);
        xrHeight = xrY2 - xrY1;

        % Update Selected Region
        xrSelectedIco =  findobj(axIcoInter, 'Tag', 'thisLine');
        xrSelectedIco.Position = [valLow, xrY1, ...
            valHigh - valLow, xrHeight];

        % Plot
        xrIco = findobj(axIcoInter,'Type','rectangle','-and', ...
            {'Tag',"Interval "+num2str(selectedInterval)});
        xrIco.Position = [valLow, xrY1, ...
            valHigh - valLow, xrHeight];

        % Recover data in listIcoInter
        intervals = listIcoInter.UserData;

        % Update intervals
        intervals(selectedInterval, 2) = valHigh;

        % Store new interval value in listIcoInter
        listIcoInter.UserData = intervals; 

    catch

        % Error alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Exceeded the lower limit.", "Error");

    end

else

    % Check if the lower slider is to close to the lower slider
    if abs(event.Value-sldLowIco.Value) <= 0.05
        sldLowIco.Value = sldLowIco.Value + 0.2;
    end

end

% Update spinner value
sHighIcoInter.Value = valHigh;
end

%%      Add Interval Ver.2

%{
        Add Interval 222222
%}
function addInterval_IcoInter(src, ~, sLowIcoInter, ...
    sHighIcoInter, listIcoInter, axIcoInter, sldLowIco, sldHighIco, ...
    btnDeleteIcoInter, btnContinueIcoInter, cbxEditIco)

% Check if interval is valid
if sHighIcoInter.Value > sLowIcoInter.Value

    % Recover data in listInterval
    intervals = listIcoInter.UserData;

    % Obtain number of intervals
    n = size(intervals, 1);

    % Check if the values in Edit Field already exist in intervals
    if strcmp(listIcoInter.Items,"None")
        % Enable Edit Check box, Delete and Conitnue Button 
        btnDeleteIcoInter.Enable = "on";
        btnContinueIcoInter.Enable = "on";
        cbxEditIco.Enable = "on";

        % Create new item in listInterval
        listIcoInter.Items(n+1) = {append('Interval ', num2str(n+1))};
        listIcoInter.ItemsData(n+1) = n+1;

        % Add new interval to array's intervals
        intervals(n+1,:) = [sLowIcoInter.Value sHighIcoInter.Value];

        % Sort interval array
        intervals = sortrows(intervals,1);

        % Find index of new interval
        indNewInterval = find(intervals==sLowIcoInter.Value);

        % Delete all rectangles
        toBeDeleted = findobj(axIcoInter,'Type','rectangle');
        delete(toBeDeleted)

        % Values to plot intervals Regions
        xrY1 = axIcoInter.UserData(2,1);
        xrY2 = axIcoInter.UserData(2,2);
        xrWidth = intervals(:,2) - intervals(:,1);
        xrHeight = xrY2 - xrY1;

        % Plot interval regions
        for k = 1:size(intervals,1)
            xrInter(k) = rectangle(axIcoInter);
            xrInter(k).Position = [intervals(k,1), xrY1, ...
                xrWidth(k), xrHeight];
            xrInter(k).EdgeColor = 'none';
            xrInter(k).Tag = listIcoInter.Items{k};
            if mod(k,2)==1
                xrInter(k).FaceColor = [0.39, 0.83, 0.07, 0.25];
            else
                xrInter(k).FaceColor = [0.39, 0.83, 0.27, 0.25];
            end
        end 

        % Plot selected new interval
        xrInterDefault = rectangle(axIcoInter);
        xrInterDefault.Position = [intervals(indNewInterval,1), xrY1, ...
            xrWidth(indNewInterval), xrHeight];
        xrInterDefault.EdgeColor = 'none';
        xrInterDefault.FaceColor = [1 0 0 0.3]; % red
        xrInterDefault.Tag = "thisLine";

        % Select added interval in listIcoInter and sliders
        listIcoInter.Value = indNewInterval;

        % Update sliders values
        sldLowIco.Value = sum(sldLowIco.Limits)-intervals(indNewInterval,1);
        sldHighIco.Value = sum(sldLowIco.Limits)- intervals(indNewInterval,2);

        % Store ppm data in listIcoInter object
        listIcoInter.UserData = intervals;
    else
        % Check if overlap interval
        if  any(intervals(:,1)<=sLowIcoInter.Value & ...
            sLowIcoInter.Value<=intervals(:,2)) || ...
            any(intervals(:,1)<=sHighIcoInter.Value & ...
            sLowIcoInter.Value<=intervals(:,2))

            % Warning alert
            fig = ancestor(src, 'figure', 'toplevel');
            uialert(fig, "Can't add an existing interval "+...
                "nor overlap intervals", "Warning", ...
                "Icon","warning");
        else
            % Create new item in listInterval
            listIcoInter.Items(n+1) = {append('Interval ', num2str(n+1))};
            listIcoInter.ItemsData(n+1) = n+1;

            % Add new interval to array's intervals
            intervals(n+1,:) = [sLowIcoInter.Value sHighIcoInter.Value];

            % Sort interval array
            intervals = sortrows(intervals,1);

            % Find index of new interval
            indNewInterval = find(intervals==sLowIcoInter.Value);

            % Delete all rectangles
            toBeDeleted = findobj(axIcoInter,'Type','rectangle');
            delete(toBeDeleted)

            % Values to plot intervals Regions
            xrY1 = axIcoInter.UserData(2,1);
            xrY2 = axIcoInter.UserData(2,2);
            xrWidth = intervals(:,2) - intervals(:,1);
            xrHeight = xrY2 - xrY1;

            % Plot interval regions
            for k = 1:size(intervals,1)
                xrInter(k) = rectangle(axIcoInter);
                xrInter(k).Position = [intervals(k,1), xrY1, ...
                    xrWidth(k), xrHeight];
                xrInter(k).EdgeColor = 'none';
                xrInter(k).Tag = listIcoInter.Items{k};
                if mod(k,2)==1
                    xrInter(k).FaceColor = [0.39, 0.83, 0.07, 0.25];
                else
                    xrInter(k).FaceColor = [0.39, 0.83, 0.27, 0.25];
                end
            end 

            % Plot selected new interval
            xrInterDefault = rectangle(axIcoInter);
            xrInterDefault.Position = [intervals(indNewInterval,1), xrY1, ...
                xrWidth(indNewInterval), xrHeight];
            xrInterDefault.EdgeColor = 'none';
            xrInterDefault.FaceColor = [1 0 0 0.3]; % red
            xrInterDefault.Tag = "thisLine";

            % Select added interval in listIcoInter and sliders
            listIcoInter.Value = indNewInterval;

            % Update sliders values
            sldLowIco.Value = sum(sldLowIco.Limits)-intervals(indNewInterval,1);
            sldHighIco.Value = sum(sldLowIco.Limits)- intervals(indNewInterval,2);

            % Store ppm data in listIcoInter object
            listIcoInter.UserData = intervals;
        end      
    end
else
        % Warning alert
        fig = ancestor(src, 'figure', 'toplevel');
        uialert(fig, "Lower ppm can't be greater or equal than " ...
            + "Higher ppm", "Warning", "Icon","warning");
end

end


%%      Check Edit Interval

%{
        Check Edit Interval
%}
function checkEditInterval_IcoInter(~, event, listIcoInter, ...
    btnAddIcoInter, sLowIcoInter, sHighIcoInter, btnDeleteIcoInter, ...
    btnContinueIcoInter, sldLowIco, sldHighIco)

val = ~event.Value;

% Disable/Enable buttons
listIcoInter.Enable = val;
btnAddIcoInter.Enable = val;
btnContinueIcoInter.Enable = val;
if strcmp(listIcoInter.Items,"None")
    btnDeleteIcoInter.Enable = "off";
else
    btnDeleteIcoInter.Enable = val;
end

% Recover data in listIcoInter
intervals = listIcoInter.UserData;

% Selected interval
selectedInterval = listIcoInter.Value;

% Update values of sliders to selected intervals
sldLowIco.Value = sum(sldLowIco.Limits) - intervals(selectedInterval,1);
sldHighIco.Value = sum(sldLowIco.Limits) - intervals(selectedInterval,2);

% Update values of spinners to selected intervals
sLowIcoInter.Value = intervals(selectedInterval,1);
sHighIcoInter.Value = intervals(selectedInterval,2);

end


%%      Select Interval

%{
        Select Interval
%}
function selectInterval_IcoInter(src, event, axIcoInter, ...
    sldLowIco, sldHighIco, sLowIcoInter, sHighIcoInter)

% Recover data in listIcoInter
intervals = src.UserData;

% Delete previous selected range
delete(findobj(axIcoInter, 'Tag', 'thisLine'));

% Values to plot selected interval
xrY1 = axIcoInter.UserData(2,1);
xrY2 = axIcoInter.UserData(2,2);
xrWidth = intervals(event.Value,2) - intervals(event.Value,1);
xrHeight = xrY2 - xrY1;

% Plot selected interval
xrInterDefault = rectangle(axIcoInter);
xrInterDefault.Position = [intervals(event.Value,1), xrY1, ...
    xrWidth, xrHeight];
xrInterDefault.EdgeColor = 'none';
xrInterDefault.FaceColor = [1 0 0 0.3]; % red
xrInterDefault.Tag = "thisLine";

% Update Spinners Values
sLowIcoInter.Value = intervals(event.Value,1);
sHighIcoInter.Value = intervals(event.Value,2);

% Update Sliders Values
sldLowIco.Value = sum(sldLowIco.Limits)-intervals(event.Value,1);
sldHighIco.Value = sum(sldLowIco.Limits)- intervals(event.Value,2);

end


%%      Delete Interval

%{
        Delete Interval
%}
function deleteInterval_IcoInter(src, ~, listIcoInter, axIcoInter, ...
     sLowIcoInter, sHighIcoInter, sldLowIco, sldHighIco, axPre, ...
     btnContinueIcoInter, cbxEditIco)

% Recover data in listInterval
intervals = listIcoInter.UserData;

% Delete selected interval
intervals(listIcoInter.Value,:) = [];

% Delete selected interval region
delRegion = findobj(axIcoInter, 'Type', 'rectangle');
delete(delRegion);

if ~isempty(intervals)
    %%%%%%%%%%%%%%%%%%%%%%%%
    % Update List Interval %
    %%%%%%%%%%%%%%%%%%%%%%%%
    % Delete the Items and ItemData in listIcoInter
    listIcoInter.Items = {};
    listIcoInter.ItemsData = [];
    % Create an array of numbers with the new size of
    % array of intervals and create an array of strings to put in Items
    updatedNintervals = (1:(size(intervals,1)));
    updatedIntervalItems = "Interval " + updatedNintervals; 
    % Update List Iterval Items and ItemsData
    listIcoInter.Items = cellstr(updatedIntervalItems);
    listIcoInter.ItemsData = updatedNintervals;

    % Values to plot Selected Region
    xrY1 = axIcoInter.UserData(2,1);
    xrY2 = axIcoInter.UserData(2,2);
    xrWidth = intervals(:,2) - intervals(:,1);
    xrHeight = xrY2 - xrY1;

    % Plot first interval
    xrSelected = rectangle(axIcoInter);
    xrSelected.Position = [intervals(1,1), xrY1, ...
        xrWidth(1), xrHeight];
    xrSelected.EdgeColor = 'none';
    xrSelected.FaceColor = [1 0 0 0.3]; % red
    xrSelected.Tag = "thisLine";

    % Plot interval regions
    for k = 1:size(intervals,1)
        xrInter(k) = rectangle(axIcoInter);
        xrInter(k).Position = [intervals(k,1), xrY1, xrWidth(k), xrHeight];
        xrInter(k).EdgeColor = 'none';
        xrInter(k).Tag = listIcoInter.Items{k};
        if mod(k,2)==1
            xrInter(k).FaceColor = [0.39, 0.83, 0.07, 0.25];
        else
            xrInter(k).FaceColor = [0.39, 0.83, 0.27, 0.25];
        end
    end 

    % Update Spinners Values
    sLowIcoInter.Value = intervals(1,1);
    sHighIcoInter.Value = intervals(1,2);

    % Update Sliders Values
    sldLowIco.Value = sum(sldLowIco.Limits)-intervals(1,1);
    sldHighIco.Value = sum(sldLowIco.Limits)- intervals(1,2);
    
    % Update List Item Selected
    listIcoInter.Value = 1;

else
    % Recover data in axPre
    data = axPre.UserData;
    Cut_ppm_axis = data.CutPpm;

    % Min and max ppm values
    minPpm = min(Cut_ppm_axis);
    maxPpm = max(Cut_ppm_axis);

    listIcoInter.Items = "None";
    % Update Spinners Values
    sLowIcoInter.Value = minPpm;
    sHighIcoInter.Value = maxPpm;

    % Update Sliders Values
    sldLowIco.Value = maxPpm;
    sldHighIco.Value = minPpm;

    % Disable Delete Button
    src.Enable = "off";
    % Disable Check Box
    cbxEditIco.Enable = "off";
    % Disable Continue Button
    btnContinueIcoInter.Enable = "off";

end

% Store ppm data in listInterval object
listIcoInter.UserData = intervals;
end


%%      Continue

%{
        Continue
%}
function continueInterval_IcoInter(src, ~, listIcoInter, ...
    ddIcoshiftOption2, axPre)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;

% Recover data in listIcoInter
intervals = listIcoInter.UserData;

% Number of intervals
nIntervals = size(intervals,1);

% To save indices
indIntervals = [];

% Convert ppm to indices and save it in a row array
for i=1:nIntervals
    [firstInd, lastInd] = findIndex(intervals(i,1), ...
        intervals(i,2), Cut_ppm_axis);
    indIntervals = [indIntervals, firstInd, lastInd];
end

% Store intervals in ddIcoshiftOption2
ddIcoshiftOption2.UserData = indIntervals;

% Close window
figWindow = ancestor(src, 'figure', 'toplevel');
delete(figWindow)
end

function [firstInd, lastInd] = findIndex(firstPPM, lastPPM, ppmVector)

% Counting digits after dot
strPPM = num2str(firstPPM);
dot_pos = find(strPPM == '.');
numDeci = length(strPPM) - dot_pos;

% Tolerance to find index
tolerance = 5*10^(-numDeci);

% Find first index
firstInd = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + tolerance), 1, 'first');
% Find last index
lastInd = find(ppmVector >= lastPPM & ...
    ppmVector < (lastPPM + tolerance), 1, 'first');

end


%%      Close Window

%{
        Close Window
%}
function my_closereq(src, ~, ddIcoshiftOption2)
    selection = uiconfirm(src,'It will be use Whole Mode',...
        'Confirmation');
    switch selection
        case 'OK'
            ddIcoshiftOption2.UserData = 'whole';
            delete(src)
        case 'Cancel'
            return
   end
end
