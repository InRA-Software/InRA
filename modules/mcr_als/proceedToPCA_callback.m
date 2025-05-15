function proceedToPCA_callback(~, ~, tabMCR, tabPCA, btnColorSamples, ...
    btnPCA, btnComparativePre, btnComparativePCA)

% Enable and disable buttons in Unsupervised Analysis
btnColorSamples.Enable = "on";
btnPCA.Enable = "off";
btnComparativePre.Enable = "off"; 
btnComparativePCA.Enable = "off";

tabPCA.UserData = [];

dataToPCA = {tabMCR.UserData.Region1, tabMCR.UserData.Region2, ...
    tabMCR.UserData.Region3};

for i=1:3
    concentrations = [];

    numIntervals = size(dataToPCA{:,i},1);
    components = cell(1,numIntervals);
    indicesIntervals = cell(1,numIntervals);
    resolvedST = cell(1,numIntervals);

    for k=1:numIntervals
        resolvedSTAux = dataToPCA{i}{k,6};
        concentrationsAux = dataToPCA{i}{k,7};
        indComp = dataToPCA{i}{k,9};
        % Store only concentrations and spectra corresponding to components 
        % after deleting some of them
        resolvedST{k} = resolvedSTAux(:,indComp);
        concentrations = [concentrations, concentrationsAux(:,indComp)];

        % Quantity of components to store
        quantComp = size(concentrationsAux(:,indComp),2);
        % To store the indices corresponding to each interval. For 
        % instance: the interval 5 with 3 components, may correspond to 
        % columns 9, 10 and 11 in the concentrations array
        if k==1
            indIntervals = (1:quantComp);
        else
            indIntervals = ( (indIntervals(end)+1) ...
                :(indIntervals(end)+quantComp) );
        end
        components{k} = indComp;
        indicesIntervals{k} = indIntervals;
    end

    if i==1
        tabPCA.UserData.Region1.Concentrations = concentrations;
        tabPCA.UserData.Region1.Components = components;
        tabPCA.UserData.Region1.indicesIntervals = indicesIntervals;
        tabPCA.UserData.Region1.ppm = transpose(dataToPCA{1}(:,1));
        tabPCA.UserData.Region1.resolvedST = resolvedST;
    elseif i==2
        tabPCA.UserData.Region2.Concentrations = concentrations;
        tabPCA.UserData.Region2.Components = components;
        tabPCA.UserData.Region2.indicesIntervals = indicesIntervals;
        tabPCA.UserData.Region2.ppm = transpose(dataToPCA{2}(:,1));
        tabPCA.UserData.Region2.resolvedST = resolvedST;
    else
        tabPCA.UserData.Region3.Concentrations = concentrations;
        tabPCA.UserData.Region3.Components = components;
        tabPCA.UserData.Region3.indicesIntervals = indicesIntervals;
        tabPCA.UserData.Region3.ppm = transpose(dataToPCA{3}(:,1));
        tabPCA.UserData.Region3.resolvedST = resolvedST;
    end
end

end

