%%%%%%%%%%%%%%%%%
% Export Models %
%%%%%%%%%%%%%%%%%
function exportModels_callback(src, ~, tabMCR)

dataToPCA = {tabMCR.UserData.Region1, tabMCR.UserData.Region2, ...
    tabMCR.UserData.Region3};

for i=1:3
    numIntervals = size(dataToPCA{:,i},1);
    components = cell(1,numIntervals);
    resolvedST = cell(1,numIntervals);
    concentrations = cell(1,numIntervals);
    LoFExp = cell(1,numIntervals);
    ExpVar = cell(1,numIntervals);
    StdRes = cell(1,numIntervals);

    for k=1:numIntervals
        resolvedSTAux = dataToPCA{i}{k,6};
        concentrationsAux = dataToPCA{i}{k,7};
        indComp = dataToPCA{i}{k,9};
        % Store only concentrations and spectra corresponding to components 
        % after deleting some of them
        resolvedST{k} = resolvedSTAux(:,indComp);
        concentrations{k} = concentrationsAux(:,indComp);
        components{k} = indComp;

        FoM = dataToPCA{i}{k,8};

        % Figure of merit
        LoFExp{k} = FoM(2);
        ExpVar{k} = FoM(4);
        StdRes{k} = FoM(1);

    end

    if i==1
        ModelsRegion1.ppm = transpose(dataToPCA{1}(:,1));        
        ModelsRegion1.Concentrations = concentrations;
        ModelsRegion1.resolvedST = resolvedST;
        ModelsRegion1.Components = components;        
        ModelsRegion1.LackOfFitExp = LoFExp;
        ModelsRegion1.ExplainedVariance = ExpVar;
        ModelsRegion1.StdRes = StdRes;
    elseif i==2
        ModelsRegion2.ppm = transpose(dataToPCA{2}(:,1));        
        ModelsRegion2.Concentrations = concentrations;
        ModelsRegion2.resolvedST = resolvedST;
        ModelsRegion2.Components = components;
        ModelsRegion2.LackOfFitExp = LoFExp;
        ModelsRegion2.ExplainedVariance = ExpVar;
        ModelsRegion2.StdRes = StdRes;
    else
        ModelsRegion3.ppm = transpose(dataToPCA{3}(:,1));
        ModelsRegion3.Concentrations = concentrations;
        ModelsRegion3.resolvedST = resolvedST;
        ModelsRegion3.Components = components;
        ModelsRegion3.LackOfFitExp = LoFExp;
        ModelsRegion3.ExplainedVariance = ExpVar;
        ModelsRegion3.StdRes = StdRes;
    end
end

assignin("base", "ModelsRegion1", ModelsRegion1);
assignin("base", "ModelsRegion2", ModelsRegion2);
assignin("base", "ModelsRegion3", ModelsRegion3);

fig = ancestor(src, 'figure', 'toplevel');

uialert(fig,"The Models were successfully exported to Workspace as "+...
    "structure arrays." +newline + newline +...
    "Each field contains cell arrays." + newline +...
    "Each column of cell arrays corresponds to an interval.", ...
    "Info", "Icon","info");

end

