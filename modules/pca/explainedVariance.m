function [exVar] = explainedVariance(S)

variance = diag(S).^2;
exVar = (variance/sum(variance)) *100;

end