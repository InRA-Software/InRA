function comparativePretreatment_callback(src, ~, ffig, Transf1, Gra1, ...
    Gra5, listComponentST)

% Create figure window
figCPre = uifigure('Name', 'Select Spectra');
figCPre.WindowStyle = "modal";
figCPre.WindowState = "normal";
figCPre.Position = [500 500 150 110];
figCPre.Resize = 'off';

%%%%%%%%%%%%%%%%%
% Figure Layout %
%%%%%%%%%%%%%%%%%
glCPre = uigridlayout(figCPre,[2,1]);
glCPre.RowHeight = {'fit', 'fit'};

%%%%%%%%%%%%%%%%
% Spectra List %
%%%%%%%%%%%%%%%%
% Create
listSpectra = uilistbox(glCPre);
% Position
listSpectra.Layout.Row = 1;
listSpectra.Layout.Column = 1;
listSpectra.Items = ["Original Processed","Bucket Spectra","C Features"];
listSpectra.ItemsData = [1,2,3];
listSpectra.Value = src.UserData.InUse;

%%%%%%%%%%%%%%
% Use Button %
%%%%%%%%%%%%%%
% Create
btnCUse = uibutton(glCPre);
% Position
btnCUse.Layout.Row = 2;
btnCUse.Layout.Column = 1;
% Style
btnCUse.Text = "Use";
if src.UserData.InUse == listSpectra.Value
    btnCUse.Enable = 'off';
else
    btnCUse.Enable = 'on';
end

%%%
% Behaviours
%%%

% Use Spectra
btnCUse.ButtonPushedFcn = {@useSpectra_callback, src, listSpectra, ...
    ffig, figCPre, Transf1, Gra1, Gra5, listComponentST};

% Select Spectra
listSpectra.ValueChangedFcn = {@listSelecSpectra_callback, src, btnCUse};

end

%%
% Use Spectra callback
%%%
function useSpectra_callback(~, ~, btnPre, listSpectra, ffig, ...
    figCPre, Transf1, Gra1, Gra5, listComponentST)

% Save number corresponding to selected spectra
btnPre.UserData.InUse = listSpectra.Value;

if listSpectra.Value == 1 || listSpectra.Value == 2
% Spectra with and without binning
    % Select None Transformation
    Transf1.Value = true;
    % Select Explained Variance
    Gra1.Value = true;
    % Disable MCR Component
    listComponentST.Enable = "off";
    % Disable Resolved ST
    Gra5.Enable = "off";
else
% C-Features
    Gra5.Enable = "on";
end

% Information Message
uialert(ffig, "There's no need to coloring samples again","Info", ...
    'icon', 'info');

% Close window
delete(figCPre)
end


%%
% Selecting Spectra Callback
%%%
function listSelecSpectra_callback(~, event, btnPre, btnCUse)
if event.Value == btnPre.UserData.InUse
    btnCUse.Enable = "off";
else 
    btnCUse.Enable = "on";
end

end





