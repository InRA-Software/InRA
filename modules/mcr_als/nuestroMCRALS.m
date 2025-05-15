function [resolvedConc, resolvedSpec, fom, r2] = nuestroMCRALS(data, ...
    initSpec, nComp, iters)

C_init = initSpec;

% Singular Values Decomposition (SVD)
[U, Z, V] = svd(data,'econ');

% Obtain Scores
C_PCA = U(:, 1:nComp) * Z(1:nComp, 1:nComp);

% Obtained Loadings
S_PCA = V(:, 1:nComp);

dataPCA = C_PCA*S_PCA';

%%%%%%%%%%%%
% tnt nnls %
%%%%%%%%%%%%
[nSpec, nVar] = size(dataPCA);
solST = zeros(nComp,nVar);
solC = C_init;

% Previous values of sigmaPCA and stopCount
previousSigma = 0;
stopCount = 0;

for i = 1:iters
    % Encontrar ST
    for k = 1:nVar
        solST(:,k) = tntnn(solC,dataPCA(:,k));
    end

    % Encontrar C
    %solCT = zeros(nComp,nSpec);
    dataPCAT = dataPCA';
    for k = 1:nSpec
        solCT(:,k) = tntnn(solST',dataPCAT(:,k));
    end
    solC = solCT';

    % Reconstruir data
    dataALS = solC*solST;

    % Residual and sigma with reconstructed PCA matrix
    e2PCA = sum((dataALS-dataPCA).^2,"all");
    sigmaPCA = sqrt( e2PCA/numel(dataPCA) );

    sigmaChange = (previousSigma-sigmaPCA)/sigmaPCA;
    
    previousSigma = sigmaPCA;

    % Stop counter
    if sigmaChange >= 0
        % Improving
        stopCount = 0;
    else
        % Not improving
        stopCount = stopCount + 1;
    end

    % Criterio de parada en relación al porcentaje de cambio
    if abs(sigmaChange) < 0.001
        break
    end

    % Criterio de parada en relación a que no hay cambios
    if stopCount > 25
        break
    end

end

% Figures of Merit with experimental matrix
e2 = sum((dataALS-data).^2,"all");
d2 = sum(data.^2,"all");
sigma = sqrt( e2/numel(data) );
LoF = 100*sqrt(e2/d2);
r2 = 100 * (1 - e2/d2);

% Figures of Merit with reconstructed PCA matrix
e2PCA = sum((dataALS-dataPCA).^2,"all");
d2PCA = sum(dataPCA.^2,"all");
lofPCA = 100*sqrt(e2PCA/d2PCA);

% Store in fom array
fom(1) = sigma;
fom(2) = LoF;
fom(3) = lofPCA;
   
resolvedSpec = solC;
resolvedConc = solST';
    
end
