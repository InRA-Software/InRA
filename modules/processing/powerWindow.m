function powerWindow(~, ~, ddIcoshiftOption1)
% Create figure
figPower = uifigure('Name', "Multiplier");
figPower.WindowStyle = 'modal';
figPower.Position = [500 500 360 40];
figPower.Resize = 'on';

% Manage figPower layout
glPowerFig = uigridlayout(figPower,[1,3]);
glPowerFig.RowHeight = {"fit"};
glPowerFig.ColumnWidth = {"fit", "1x", "fit"};

% Create Label
lblPowerAvg2 = uilabel(glPowerFig);
% Positions
lblPowerAvg2.Layout.Row = 1;
lblPowerAvg2.Layout.Column = 1;
% Style
lblPowerAvg2.Text = "Input multiplier for the 2nd average:";
lblPowerAvg2.FontWeight = "bold";
lblPowerAvg2.FontSize = 14;

% Create spinner
sPowerAvg2 = uispinner(glPowerFig);
% Positions
sPowerAvg2.Layout.Row = 1;
sPowerAvg2.Layout.Column = 2;
% Style
sPowerAvg2.Value = 3;
sPowerAvg2.Limits = [1 100];

% Create button
btnPowerAvg2 = uibutton(glPowerFig);
% Positions
btnPowerAvg2.Layout.Row = 1;
btnPowerAvg2.Layout.Column = 3;
% Style
btnPowerAvg2.Text = "Ok";

% Behaviours
btnPowerAvg2.ButtonPushedFcn = {@saveMultiplier, ...
    figPower, ddIcoshiftOption1, sPowerAvg2};

% Close window
figPower.CloseRequestFcn = {@my_closereq, ddIcoshiftOption1};

% Pause until figPower is closed
waitfor(figPower);

end

function saveMultiplier(~, ~, figPower, ddIcoshiftOption1, sPowerAvg2)
    ddIcoshiftOption1.UserData = {'average2', sPowerAvg2.Value, 'default'};
    delete(figPower)
end

%%      Close Window

%{
        Close Window
%}
function my_closereq(src, ~, ddIcoshiftOption1)
%    selection = uiconfirm(src,'It will be use Average Reference',...
%        'Confirmation');
%    switch selection
%        case 'OK'
            ddIcoshiftOption1.Value = "Average";
            ddIcoshiftOption1.UserData = {'average', 1, 'closed'};
            delete(src)
%        case 'Cancel'
%            return
%   end
end