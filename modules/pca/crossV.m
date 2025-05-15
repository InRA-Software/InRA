function [rmsec_values, rmsecv_values] = crossV(X, numComponents)
 
% Storage RMSEC and RMSECV
rmsec_values = zeros(numComponents, 1);
rmsecv_values = zeros(numComponents, 1);

% Parámetros de Venetian Blinds Cross-Validation
num_blocks = 10;
num_samples = size(X, 1);

% Crear los índices para Venetian Blinds Cross-Validation
folds = cell(num_blocks, 1);
for i = 1:num_samples
    folds{mod(i-1, num_blocks) + 1} = [folds{mod(i-1, num_blocks) + 1}; i];
end

% Realizar Venetian Blinds Cross-Validation
explained_variance = zeros(num_blocks, size(X, 2));
for i = 1:num_blocks
    % Crear conjuntos de entrenamiento y validación
    test_indices = folds{i};
    train_indices = setdiff(1:num_blocks, test_indices);
    X_train = X(train_indices, :);
    X_test = X(test_indices, :);
    
    % Realizar PCA utilizando SVD en el conjunto de entrenamiento
    [U, S, V] = svd(X_train, 'econ');
    % Calcular varianza explicada
    eigenvalues = diag(S).^2 / (size(X_train, 1) - 1);
    total_variance = sum(eigenvalues);
    explained_variance(i, :) = eigenvalues / total_variance * 100;
end

end

