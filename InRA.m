%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Interval Resonance Analysis (InRA)                                      %
% Version: 1.0                                                            %
% Oficial site: https://github.com/InRA-Software/InRA                     %
% Oficial email: inrasoftware@gmail.com                                   %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% InRA GUI consists of .m files developed under MATLAB R2023b.            %
% The current version of InRA is compatible with MATLAB R2020b and later. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Authors:                                                                %
%                                                                         %
% David Montoya                                                           %
%      - Department of Physics, Faculty of Physics and Mathematics        %
%      - Laboratory of Biospectroscopy and Chemometrics (BioSpeQ)         %
%          Biotechnology Center                                           %
%      University of Concepción - Chile                                   %
%      email: davmontoya@udec.cl                                          %
%                                                                         %
% Cristian Fuentes                                                        %
%      - Department of Instrumental Analysis, Faculty of Pharmacy         %
%      - Laboratory of Biospectroscopy and Chemometrics (BioSpeQ)         %
%          Biotechnology Center                                           %
%      University of Concepción - Chile                                   %
%      email: crisfuentes@udec.cl                                         %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function InRA
addpath(genpath('functions'))
addpath(genpath('scripts'))
addpath(genpath('modules'))

% Create figure window
fig = uifigure('Name', ['Interval Resonance Analysis (InRA) Toolbox ' ...
    'Version 1.0']);
fig.WindowStyle = 'normal';
fig.WindowState = "normal";
fig.Position = [75 75 1200 620];
fig.Resize = 'on';
fig.CloseRequestFcn = {@my_closereq};
%%
%%%%
% Groups
%%%%%%
tabgp = uitabgroup(fig);
tabgp.Position = [0 0 1200 620];
tabProcessing = uitab(tabgp,"Title","Processing");
tabInterval = uitab(tabgp,"Title","Interval-Based Detection");
tabMCR= uitab(tabgp,"Title","Resonance Integration");
tabPCA = uitab(tabgp,"Title","Unsupervised Analysis");

%%
tab_ProcessingScript
%%
tab_IntervalScript
%%
tab_MCRALSScript
%%
tab_PCAScript
%%

%%%
% Behaviours Scripts
%%%
BS_Processing
%%
BS_Interval
%%
BS_MCRALS
%%
BS_PCA

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Close window confirmation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function my_closereq(src, ~)
    selection = uiconfirm(src,'Do you want to close InRA?',...
        'Confirmation');
    switch selection
        case 'OK'
            delete(src)
        case 'Cancel'
            return
   end
end






