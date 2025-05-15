function init = purestST(data,nComp)

[nRow, nCol] = size(data); 
noisePctg = 0.001;
sigma = std(data,1);
mu = mean(data,1);
alpha = max(mu)*noisePctg;
beta = mu+alpha;
SB = sigma.^2+beta.^2;

Iota = sqrt(nRow*SB);
NN = repmat(Iota,nRow,1);
dataNN = data./NN;

p = sigma./beta;

idx = [];
pw = zeros(nCol, nComp);
sw = zeros(nCol, nComp);
    
for i = 1:nCol  
    auxP = [dataNN(:, idx) dataNN(:,i)];
    cm = transpose(transpose(auxP)*auxP);
    w(i) = det(cm);
end

pw(:,1) = transpose(p.*w); 
sw(:,1) = transpose(sigma.*w); 

maxVal = max(pw(:,1));
maxPtIdx = find(pw(:,1)==maxVal); 
idx = [idx maxPtIdx]; 

if nComp>1
    for j = 2:nComp
        for i = 1:nCol  
            auxP = [dataNN(:, idx) dataNN(:,i)];
            cm = transpose(transpose(auxP)*auxP);
            w(i) = det(cm);
        end
 
        pw(:,j) = transpose(p.*w); 
        sw(:,j) = transpose(sigma.*w); 
 
        maxVal = max(pw(:,j));
        maxPtIdx = find(pw(:,j)==maxVal); 
        idx = [idx maxPtIdx]; 
    end
end

init = dataNN(:,idx);


end

