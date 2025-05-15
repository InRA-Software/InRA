function detectionSettings_callback(src, ~)

% Create figure window
figDetectionSettings = uifigure('Name', 'Detection Settings');
figDetectionSettings.Position = [300 500 340 140];
figDetectionSettings.WindowStyle = 'modal';
figDetectionSettings.Resize = 'off';

glfigSetteings = uigridlayout(figDetectionSettings);
glfigSetteings.RowHeight = {'fit', 'fit', 'fit', 'fit'};
glfigSetteings.ColumnWidth = {'fit', 'fit', 'fit', 'fit'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Label: Detection Window %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblDetectionWindow = uilabel(glfigSetteings);
% Position
lblDetectionWindow.Layout.Row = 1;
lblDetectionWindow.Layout.Column = [1 3];
% Style
lblDetectionWindow.Text = "Detection Window (D) [ppm]";
lblDetectionWindow.HorizontalAlignment = "Left";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spinner: Detection Window %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
sDetectionWindow = uispinner(glfigSetteings);
% Position
sDetectionWindow.Layout.Row = 1;
sDetectionWindow.Layout.Column = 4;
% Style
sDetectionWindow.Limits = [0.001 1];
sDetectionWindow.Value = src.UserData.D;
sDetectionWindow.Step = 0.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Label: Distance Consecutive Maxima %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblDistanceMaxima = uilabel(glfigSetteings);
% Position
lblDistanceMaxima.Layout.Row = 2;
lblDistanceMaxima.Layout.Column = [1 3];
% Style
lblDistanceMaxima.Text = "Distance Consecutive Maxima (L) [ppm]";
lblDistanceMaxima.HorizontalAlignment = "Left";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spinner: Distance Consecutive Maxima %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
sDistanceMaxima = uispinner(glfigSetteings);
% Position
sDistanceMaxima.Layout.Row = 2;
sDistanceMaxima.Layout.Column = 4;
% Style
sDistanceMaxima.Limits = [0.001 1];
sDistanceMaxima.Value = src.UserData.L;
sDistanceMaxima.Step = 0.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Label: Separation Distance %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblSeparationDistance = uilabel(glfigSetteings);
% Position
lblSeparationDistance.Layout.Row = 3;
lblSeparationDistance.Layout.Column = [1 3];
% Style
lblSeparationDistance.Text = "Separation Distance (H) [ppm]";
lblSeparationDistance.HorizontalAlignment = "Left";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spinner: Separation Distance %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
sSeparationDistance = uispinner(glfigSetteings);
% Position
sSeparationDistance.Layout.Row = 3;
sSeparationDistance.Layout.Column = 4;
% Style
sSeparationDistance.Limits = [0.001 1];
sSeparationDistance.Value = src.UserData.H;
sSeparationDistance.Step = 0.001;

%%%%%%%%%%%%%%%%%%%
% Button: Default %
%%%%%%%%%%%%%%%%%%%
% Create
btnDefault = uibutton(glfigSetteings);
% Position
btnDefault.Layout.Row = 4;
btnDefault.Layout.Column = 2;
% Style
btnDefault.Text = "Default Values";

%%%%%%%%%%%%%%%%
% Button: Save %
%%%%%%%%%%%%%%%%
% Create
btnSave = uibutton(glfigSetteings);
% Position
btnSave.Layout.Row = 4;
btnSave.Layout.Column = 3;
% Style
btnSave.Text = "Save";
btnSave.Enable = "off";

%%%%%%%%%%%%%%
% Behaviours %
%%%%%%%%%%%%%%
% Enable Save Button
sDetectionWindow.ValueChangedFcn = {@enableSave_callback, btnSave};
sDistanceMaxima.ValueChangedFcn = {@enableSave_callback, btnSave};
sSeparationDistance.ValueChangedFcn = {@enableSave_callback, btnSave};

% Default Values
btnDefault.ButtonPushedFcn = {@defaultValues_callback, btnSave, ...
    sDetectionWindow, sDistanceMaxima, sSeparationDistance};
% Save Values
btnSave.ButtonPushedFcn = {@saveValues_callback, src, ...
    sDetectionWindow, sDistanceMaxima, sSeparationDistance};


end


function enableSave_callback(~, ~, btnSave)
    btnSave.Enable = "on";
end


function defaultValues_callback(~, ~, btnSave, sDetectionWindow, ...
    sDistanceMaxima, sSeparationDistance)

    sDetectionWindow.Value = 0.01;
    sDistanceMaxima.Value = 0.03;
    sSeparationDistance.Value = 0.005;
    btnSave.Enable = "on";
end

function saveValues_callback(src, ~, settings, sDetectionWindow, ...
    sDistanceMaxima, sSeparationDistance)

    settings.UserData.D = sDetectionWindow.Value;
    settings.UserData.L = sDistanceMaxima.Value;
    settings.UserData.H = sSeparationDistance.Value;
    src.Enable = "off";

end


