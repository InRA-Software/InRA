function [rmsec_values, rmsecv_values] = crossValidation(data, numComponents, num_blocks)
% Obtain Data 
num_samples = size(data,1);

if nargin < 3
% Number of Blocks for cross-validation
    num_blocks = 10;
end
 

% Storage RMSEC and RMSECV
rmsec_values = zeros(numComponents, 1);
rmsecv_values = zeros(numComponents, 1);

% Venetian Blinds Cross-Validation
for i = 1:numComponents
    for j = 1:num_blocks
        % Test and Calibration Index 
        test_indexQ = floor((j-1) * num_samples / num_blocks)  ...
            + 1 : floor(j * num_samples / num_blocks);
        calibration_indexQ = setdiff(1:num_samples, test_indexQ);

        % Train and Test Set
        X_Train = data(calibration_indexQ, :);
        X_Test = data(test_indexQ, :);

        % SVD applied to the Train Test
        [U_train, S_train, V_train] = svd(X_Train, 'econ');

        % Check if "i" it is not higher than the number of components
        current_components = min(i, min(size(U_train, 2), ...
            size(V_train, 2))); 

        % Calculate RMSEC
        residuals_train = X_Train - U_train(:, 1:current_components)  ...
            *S_train(1:current_components, 1:current_components)...
            *V_train(:, 1:current_components)'; 
        rmsec_values(i) = rmsec_values(i) + norm(residuals_train, 'fro')...
            /sqrt(numel(residuals_train));

        % Project the Test Set into the Principal Components
        X_Test_Projected = X_Test * V_train(:, 1:current_components);

        % Reconstruct the Test Set
        X_Test_Reconstructed = X_Test_Projected ...
            * V_train(:, 1:current_components)';    

        % Calculate RMSECV
        residuals_test = X_Test - X_Test_Reconstructed;
        rmsecv_values(i) = rmsecv_values(i)+norm(residuals_test, 'fro') ... 
            / sqrt(numel(residuals_test));
    end 

    % Average of the errors
    rmsec_values(i) = rmsec_values(i) / num_blocks;
    rmsecv_values(i) = rmsecv_values(i) / num_blocks;
end

end

