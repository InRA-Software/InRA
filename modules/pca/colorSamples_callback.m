function colorSamples_callback(~, ~, tabPCA, ...
    Transf1, Transf2, Mc1, Mc2, Sc1, Sc2, Sc3, ...
    Gra1, Gra2, Gra3, Gra5, sPCAComponents, btnPCA, cbxDrawEllipse)

NumOfSamples = size(tabPCA.UserData.Region1.Concentrations,1);

% Create Figure
figColorSamples = uifigure();
figColorSamples.Position = [300 500 300 250];
figColorSamples.Resize = 'off';
figColorSamples.WindowStyle = "modal";
figColorSamples.Name = 'Coloring Samples';
% Manage layout
glColorSamples = uigridlayout(figColorSamples,[8,4]);
glColorSamples.RowHeight = {20, 20, 20, 20, 20, 20, 20, 20};
glColorSamples.ColumnWidth = {15, 80, 80, 80};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Label: Number of Samples %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblNumOfSamples = uilabel(glColorSamples);
% Position
lblNumOfSamples.Layout.Row = 1;
lblNumOfSamples.Layout.Column = [1 4];
% Style
lblNumOfSamples.Text = "You have "+ NumOfSamples + " samples";
lblNumOfSamples.HorizontalAlignment = "center";
%%%%%%%%%%%%%%%%%%%%%%%
% Label: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%
% Create
lblFirstSample = uilabel(glColorSamples);
% Position
lblFirstSample.Layout.Row = 2;
lblFirstSample.Layout.Column = 2;
% Style
lblFirstSample.Text = "First Sample";
lblFirstSample.FontWeight = "bold";
lblFirstSample.HorizontalAlignment = "center";
%%%%%%%%%%%%%%%%%%%%%%
% Label: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%
% Create
lblLastSample = uilabel(glColorSamples);
% Position
lblLastSample.Layout.Row = 2;
lblLastSample.Layout.Column = 3;
% Style
lblLastSample.Text = "Last Sample";
lblLastSample.FontWeight = "bold";
lblLastSample.HorizontalAlignment = "center";

%% First Color
%%%%%%%%%%%%%%%
% Check Box 1 %
%%%%%%%%%%%%%%%
% Create
cbx1 = uicheckbox(glColorSamples);
% Position
cbx1.Layout.Row = 3;
cbx1.Layout.Column = 1;
% Stlye
cbx1.Text = "";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 1: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef1First = uieditfield(glColorSamples,"numeric");
% Position
ef1First.Layout.Row = 3;
ef1First.Layout.Column = 2;
% Stlye
ef1First.RoundFractionalValues = 'on';
ef1First.Limits = [1, NumOfSamples];
ef1First.Enable = 'off';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 1: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef1Last = uieditfield(glColorSamples,"numeric");
% Position
ef1Last.Layout.Row = 3;
ef1Last.Layout.Column = 3;
% Stlye
ef1Last.RoundFractionalValues = 'on';
ef1Last.Limits = [1, NumOfSamples];
ef1Last.Enable = 'off';
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button 1: Select Color %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btn1 = uibutton(glColorSamples);
% Position
btn1.Layout.Row = 3;
btn1.Layout.Column = 4;
% Stlye
btn1.Text = "Select Color";
btn1.Enable = 'off';

%% Second Color
%%%%%%%%%%%%%%%
% Check Box 2 %
%%%%%%%%%%%%%%%
% Create
cbx2 = uicheckbox(glColorSamples);
% Position
cbx2.Layout.Row = 4;
cbx2.Layout.Column = 1;
% Stlye
cbx2.Text = "";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 2: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef2First = uieditfield(glColorSamples,"numeric");
% Position
ef2First.Layout.Row = 4;
ef2First.Layout.Column = 2;
% Stlye
ef2First.RoundFractionalValues = 'on';
ef2First.Limits = [1, NumOfSamples];
ef2First.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 2: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef2Last = uieditfield(glColorSamples,"numeric");
% Position
ef2Last.Layout.Row = 4;
ef2Last.Layout.Column = 3;
% Stlye
ef2Last.RoundFractionalValues = 'on';
ef2Last.Limits = [1, NumOfSamples];
ef2Last.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button 2: Select Color %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btn2 = uibutton(glColorSamples);
% Position
btn2.Layout.Row = 4;
btn2.Layout.Column = 4;
% Stlye
btn2.Text = "Select Color";
btn2.Enable = "off";
%% Third Color
%%%%%%%%%%%%%%%
% Check Box 3 %
%%%%%%%%%%%%%%%
% Create
cbx3 = uicheckbox(glColorSamples);
% Position
cbx3.Layout.Row = 5;
cbx3.Layout.Column = 1;
% Stlye
cbx3.Text = "";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 3: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef3First = uieditfield(glColorSamples,"numeric");
% Position
ef3First.Layout.Row = 5;
ef3First.Layout.Column = 2;
% Stlye
ef3First.RoundFractionalValues = 'on';
ef3First.Limits = [1, NumOfSamples];
ef3First.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 3: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef3Last = uieditfield(glColorSamples,"numeric");
% Position
ef3Last.Layout.Row = 5;
ef3Last.Layout.Column = 3;
% Stlye
ef3Last.RoundFractionalValues = 'on';
ef3Last.Limits = [1, NumOfSamples];
ef3Last.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button 3: Select Color %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btn3 = uibutton(glColorSamples);
% Position
btn3.Layout.Row = 5;
btn3.Layout.Column = 4;
% Stlye
btn3.Text = "Select Color";
btn3.Enable = "off";
%% Fourth Color
%%%%%%%%%%%%%%%
% Check Box 4 %
%%%%%%%%%%%%%%%
% Create
cbx4 = uicheckbox(glColorSamples);
% Position
cbx4.Layout.Row = 6;
cbx4.Layout.Column = 1;
% Stlye
cbx4.Text = "";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 4: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef4First = uieditfield(glColorSamples,"numeric");
% Position
ef4First.Layout.Row = 6;
ef4First.Layout.Column = 2;
% Stlye
ef4First.RoundFractionalValues = 'on';
ef4First.Limits = [1, NumOfSamples];
ef4First.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 4: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef4Last = uieditfield(glColorSamples,"numeric");
% Position
ef4Last.Layout.Row = 6;
ef4Last.Layout.Column = 3;
% Stlye
ef4Last.RoundFractionalValues = 'on';
ef4Last.Limits = [1, NumOfSamples];
ef4Last.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button 4: Select Color %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btn4 = uibutton(glColorSamples);
% Position
btn4.Layout.Row = 6;
btn4.Layout.Column = 4;
% Stlye
btn4.Text = "Select Color";
btn4.Enable = "off";
%% Fifth Color
%%%%%%%%%%%%%%%
% Check Box 5 %
%%%%%%%%%%%%%%%
% Create
cbx5 = uicheckbox(glColorSamples);
% Position
cbx5.Layout.Row = 7;
cbx5.Layout.Column = 1;
% Stlye
cbx5.Text = "";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 5: First Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef5First = uieditfield(glColorSamples,"numeric");
% Position
ef5First.Layout.Row = 7;
ef5First.Layout.Column = 2;
% Stlye
ef5First.RoundFractionalValues = 'on';
ef5First.Limits = [1, NumOfSamples];
ef5First.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Field 5: Last Sample %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
ef5Last = uieditfield(glColorSamples,"numeric");
% Position
ef5Last.Layout.Row = 7;
ef5Last.Layout.Column = 3;
% Stlye
ef5Last.RoundFractionalValues = 'on';
ef5Last.Limits = [1, NumOfSamples];
ef5Last.Enable = "off";
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button 5: Select Color %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
btn5 = uibutton(glColorSamples);
% Position
btn5.Layout.Row = 7;
btn5.Layout.Column = 4;
% Stlye
btn5.Text = "Select Color";
btn5.Enable = "off";

%%%%%%%%%%%%%%%%%%%
% Continue Button %
%%%%%%%%%%%%%%%%%%%
% Create
btnContinueWithColors = uibutton(glColorSamples);
% Position
btnContinueWithColors.Layout.Row = 8;
btnContinueWithColors.Layout.Column = 3;
% Stlye
btnContinueWithColors.Text = "Continue";
btnContinueWithColors.Enable = "off";

%%%%%%%%%%%%%%
% Behaviours %
%%%%%%%%%%%%%%

% Activate to select color
cbx1.ValueChangedFcn={@checkBoxChanged_callback, ef1First, ef1Last, ...
    btn1, btnContinueWithColors};
cbx2.ValueChangedFcn={@checkBoxChanged_callback, ef2First, ef2Last, ...
    btn2, btnContinueWithColors};
cbx3.ValueChangedFcn={@checkBoxChanged_callback, ef3First, ef3Last, ...
    btn3, btnContinueWithColors};
cbx4.ValueChangedFcn={@checkBoxChanged_callback, ef4First, ef4Last, ...
    btn4, btnContinueWithColors};
cbx5.ValueChangedFcn={@checkBoxChanged_callback, ef5First, ef5Last, ...
    btn5, btnContinueWithColors};

% Select color
btn1.ButtonPushedFcn = {@selectColor_callback};
btn2.ButtonPushedFcn = {@selectColor_callback};
btn3.ButtonPushedFcn = {@selectColor_callback};
btn4.ButtonPushedFcn = {@selectColor_callback};
btn5.ButtonPushedFcn = {@selectColor_callback};

% Continue 
btnContinueWithColors.ButtonPushedFcn = {@continueWithColors_callback, ...
    tabPCA, ...
    cbx1, ef1First, ef1Last, btn1, ...
    cbx2, ef2First, ef2Last, btn2, ...
    cbx3, ef3First, ef3Last, btn3, ...
    cbx4, ef4First, ef4Last, btn4, ...
    cbx5, ef5First, ef5Last, btn5, ...
    Transf1, Transf2, Mc1, Mc2, Sc1, Sc2, Sc3, ...
    Gra1, Gra2, Gra3, Gra5, sPCAComponents, btnPCA, figColorSamples, ...
    cbxDrawEllipse};

% Store selected colors
figColorSamples.CloseRequestFcn = {@storeColors_callback, tabPCA, ...
    cbx1, ef1First, ef1Last, btn1, ...
    cbx2, ef2First, ef2Last, btn2, ...
    cbx3, ef3First, ef3Last, btn3, ...
    cbx4, ef4First, ef4Last, btn4, ...
    cbx5, ef5First, ef5Last, btn5};

end

%% Activate select color
function checkBoxChanged_callback(~, ~, efFirst, efLast, btn, ...
    btnContinueWithColors)
    if strcmp(efFirst.Enable,"off")
        efFirst.Enable = "on";
        efLast.Enable = "on"; 
        btn.Enable = "on";
        btnContinueWithColors.Enable = "on";
    else
        efFirst.Enable = "off";
        efLast.Enable = "off"; 
        btn.Enable = "off";
        btnContinueWithColors.Enable = "off";
    end
end

%% Select color
function selectColor_callback(src, ~)
    uisetcolor(src, 'Select a color');
end

%% Continue
function continueWithColors_callback(~, ~, tabPCA, ...
    cbx1, ef1First, ef1Last, btn1, ...
    cbx2, ef2First, ef2Last, btn2, ...
    cbx3, ef3First, ef3Last, btn3, ...
    cbx4, ef4First, ef4Last, btn4, ...
    cbx5, ef5First, ef5Last, btn5, ...
    Transf1, Transf2, Mc1, Mc2, Sc1, Sc2, Sc3, ...
    Gra1, Gra2, Gra3, Gra5, sPCAComponents, btnPCA, figColorSamples, ...
    cbxDrawEllipse)

% Enable PCA Options
Transf1.Enable = "on";
Transf2.Enable = "on"; 
Mc1.Enable = "on"; 
Mc2.Enable = "on";
Sc1.Enable = "on"; 
Sc2.Enable = "on";
Sc3.Enable = "on";
Gra1.Enable = "on"; 
Gra2.Enable = "on"; 
Gra3.Enable = "on";
%Gra4.Enable = "on";
Gra5.Enable = "on"; 
sPCAComponents.Enable = "on"; 
btnPCA.Enable = "on";
cbxDrawEllipse.Enable = "on";

storeColors_callback(figColorSamples, [], tabPCA, ...
    cbx1, ef1First, ef1Last, btn1, ...
    cbx2, ef2First, ef2Last, btn2, ...
    cbx3, ef3First, ef3Last, btn3, ...
    cbx4, ef4First, ef4Last, btn4, ...
    cbx5, ef5First, ef5Last, btn5)

end

%% Store Changes
function storeColors_callback(src, ~, tabPCA, ...
    cbx1, ef1First, ef1Last, btn1, ...
    cbx2, ef2First, ef2Last, btn2, ...
    cbx3, ef3First, ef3Last, btn3, ...
    cbx4, ef4First, ef4Last, btn4, ...
    cbx5, ef5First, ef5Last, btn5)

    selectedColors = [];
    selectedSamples = [];

    if cbx1.Value
        selectedSamples = [selectedSamples; [ef1First.Value, ef1Last.Value]];
        selectedColors = [selectedColors; btn1.BackgroundColor];
    end

    if cbx2.Value
        selectedSamples = [selectedSamples; [ef2First.Value, ef2Last.Value]];
        selectedColors = [selectedColors; btn2.BackgroundColor];
    end

    if cbx3.Value
        selectedSamples = [selectedSamples; [ef3First.Value, ef3Last.Value]];
        selectedColors = [selectedColors; btn3.BackgroundColor];
    end

    if cbx4.Value
        selectedSamples = [selectedSamples; [ef4First.Value, ef4Last.Value]];
        selectedColors = [selectedColors; btn4.BackgroundColor];
    end

    if cbx5.Value
        selectedSamples = [selectedSamples; [ef5First.Value, ef5Last.Value]];
        selectedColors = [selectedColors; btn5.BackgroundColor];
    end

    tabPCA.UserData.selectedColors = selectedColors;
    tabPCA.UserData.selectedSamples = selectedSamples;

    delete(src);
end


