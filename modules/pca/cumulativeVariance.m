function [cumVar] = cumulativeVariance(data, numComponents)
    variance = diag(data).^2;
    exVar = (variance/sum(variance)) *100;

    cumVar = cumsum(exVar(1:numComponents));
end

