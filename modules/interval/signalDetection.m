function [maxVal, minVal, intervalsIndex]=signalDetection(y, ppm, ...
    threshold, DLH)

y = y(:); 
ppm = ppm(:); 
ind = (1:length(y))';

u = y;
thresholdIndex = u <= threshold;
u(thresholdIndex) = threshold;

%DD = 0.01;
%HH = 0.005;
%LL = 0.03;
DD = DLH(1);
LL = DLH(2);
HH = DLH(3);

%{
    Interval delimitation algorithm 
%}

% Search index that satisfy p(1+d)-p(1) ~ D
d = 0;
while ppm(1+d)-ppm(1)<=DD
    d = 1 + d;
end
d = 1 + d;

intervalsIndex = [];
SearchStart = 1;

% Sequential scan across the components of the vector u
for i=(1+d):(length(u)-d) 
    % Define the beginning and end points of an interval
    if SearchStart
        if u(i)>threshold && u(i-d)==threshold
            beginning = ind(i-d);
            SearchStart = 0;
        end
    else
        if u(i)==threshold && u(i-d)>threshold
            endd = ind(i+d);
            intervalsIndex = [intervalsIndex; beginning endd];
            SearchStart = 1;
        end
    end
end

% Discarding intervals that do  not contain maxlocal
intervalsNumber = [];

for i = 1:size(intervalsIndex,1)

    y1 = y(intervalsIndex(i,1));
    maxtemp = y1;
    MaxLocal = [];

    for j = intervalsIndex(i,1):intervalsIndex(i,2)
        yj = y(j);
    
        if yj > maxtemp 
            maxtemp = yj; 
            idxMax = ind(j); 
        end

        if maxtemp - yj > threshold
            MaxLocal = [MaxLocal; idxMax maxtemp];
        end
    end
    % Store the interval's number that do not contain maximums
    if isempty(MaxLocal) 
        intervalsNumber = [intervalsNumber, i];
    end
end

intervalsIndex(intervalsNumber,:) = [];

%{
    Interval correction algorithm 
%}

indexes = [];

% To avoid errors in case it finds two or less intervals
if size(intervalsIndex,1)==2
    for i=2:size(intervalsIndex,1)
        if intervalsIndex(1,2)>=intervalsIndex(2,1)
            intervalsIndex(2,1)=intervalsIndex(1,1);
            indexes = [indexes, 1];
        end
    end
end

if size(intervalsIndex,1)>2
    for i=2:size(intervalsIndex,1)
        if intervalsIndex(i-1,2)>=intervalsIndex(i,1)
            intervalsIndex(i,1)=intervalsIndex(i-1,1);
            indexes = [indexes, i-1];
        end
    end
end
% Delete overlaps
intervalsIndex(indexes,:)=[];

% Searching indexes of maximums and minimums in the i-th interval

maxVal = [];
minVal = [];

for i = 1:size(intervalsIndex,1)
    SearchMax = 1;
    
    y1 = y(intervalsIndex(i,1));
    maxtemp = y1;
    mintemp = y1; 

    iMaxLocal = [];
    iMinLocal = [];

    for j = intervalsIndex(i,1):intervalsIndex(i,2)
        yj = y(j);
    
        if yj > maxtemp
            maxtemp = yj; 
            idxMax = ind(j); 
        end
        if yj < mintemp
            mintemp = yj; 
            idxMin = ind(j); 
        end

        if SearchMax
            if maxtemp-yj > threshold
                iMaxLocal = [iMaxLocal; i idxMax maxtemp];
                mintemp = yj; 
                idxMin = ind(j);
                SearchMax = 0;
            end
        else
            if yj - mintemp > threshold
                iMinLocal = [iMinLocal; i idxMin mintemp];
                maxtemp = yj; 
                idxMax = ind(j);
                SearchMax = 1;
            end
        end
    end
    if isempty(iMinLocal)
        % Stores values of maximums. If no minimums are found, set to 0.
        maxVal = [maxVal ; iMaxLocal];
        minVal = [minVal ; i 1 0];
    else
        % Stores values of maximums and minimums
        maxVal = [maxVal ; iMaxLocal];
        minVal = [minVal ; iMinLocal];
    end
end

% Search index that satisfy p(1+h)-p(1) ~ H
h = 0; 
while ppm(1+h)-ppm(1)<=HH
    h = 1 + h;
end
h = 1 + h;

indexes = [];

N = size(intervalsIndex,1);

for i = 1:N
    % Select maxima and minima corresponding to interval i
    condMax = maxVal(:,1)==i;
    condMin = minVal(:,1)==i;
    idxMaxi = maxVal(condMax, 2);
    idxMini = minVal(condMin, 2);

    newInterval = [];
    deleteInterval = 0;

   % Verify that there are at least two maximums
    if size(idxMaxi,1)>=2
        for k = 1:size(idxMaxi,1)-1 
            % If the distance between consecutive maxima exceeds 
            % L ppm, the interval is split at the position of the minlocal
            % located between the two consecutive maxima
            if ppm(idxMaxi(k+1))-ppm(idxMaxi(k))>=LL
                % In case no splitting have been made at interval
                if isempty(newInterval)
                    newInterval = [newInterval; intervalsIndex(i,1) idxMini(k)];
                    newInterval = [newInterval; ...
                        idxMini(k)+h intervalsIndex(i,2)];
                    deleteInterval = 1;
                % In case the interval has more than one splitting
                else
                    newInterval(end,:) = [newInterval(end,1) idxMini(k)];
                    newInterval(end+1,:) = [idxMini(k)+h ...
                        intervalsIndex(i,2)];
                end
            end
        end
        if deleteInterval
            indexes = [indexes; i];
            intervalsIndex = [intervalsIndex; newInterval];
        end
    end
end

% The original intervals that were split are deleted
intervalsIndex(indexes,:) = [];

% Sort the intervals from smallest to largest
intervalsIndex = sort(intervalsIndex,1);

% Deletes information corresponding to the interval number. Leaves only 
% the information of the maximums and minimums.
maxVal = maxVal(:,[2 3]);
minVal = minVal(:,[2 3]);
end