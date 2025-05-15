%--------
% PCA Tab
%--------

% Coloring Samples
btnColorSamples.ButtonPushedFcn = {@colorSamples_callback, tabPCA, ...
    Transf1, Transf2, Mc1, Mc2, Sc1, Sc2, Sc3, ...
    Gra1, Gra2, Gra3, Gra5, sPCAComponents, btnPCA, cbxDrawEllipse};

% Selecting Spectra
ffig = ancestor(tabPCA, 'figure', 'toplevel');
btnComparativePre.ButtonPushedFcn = {@comparativePretreatment_callback, ...
    ffig, Transf1, Gra1, Gra5, listComponentST};

% Build Model PCA
btnPCA.ButtonPushedFcn = {@BuildModelPCA_callback, ddPCAMean, ... 
   ddPCAScaling, axScores, axLoading, axVariance, sPCAComponents, ...
   VarianceTable, listLoading, listScores, tabPCA, ddGraOut, ...
   ddTransformations, listComponentST, cbxDrawEllipse, ...
   btnComparativePre, btnComparativePCA, btnReadyIntervals};

% Comparative PCA
ffig = ancestor(tabPCA, 'figure', 'toplevel');
btnComparativePCA.ButtonPushedFcn = {@comparativePCA_callback, ffig};

% Draw ellipse?
cbxDrawEllipse.ValueChangedFcn = {@drawEllipse_callback, axScores};

% Loading List
listLoading.ValueChangedFcn = {@listLoading_callback, axLoading, ...
    btnComparativePre};

% Loading Scores
listScores.ValueChangedFcn = {@listScores_callback, axScores, ...
    cbxDrawEllipse};

% Graphical Output
ddGraOut.SelectionChangedFcn = {@graphOutputs_callback, axVariance, ...
    listComponentST};

% Resolved ST
listComponentST.ValueChangedFcn = {@graphResolvedST_callback, tabPCA, ...
    axVariance};


