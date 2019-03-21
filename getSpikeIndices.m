function spikeInd = getSpikeIndices(timeInd, spikeTimes, epsilon)
% getSpikeIndices(indices, timeData, spikeTimes) 
% 
% Returns the indices of Spike data that occurs at/just before the times 
% listed by indices of the timeData.
%
% so like spikeData(spikeInd) ~= timeData(timeInd)
%
% If max timeInd, or min timeInd not within spiktTimes, a nan is returned
%
% getSpikeIndices(indices, timeData, spikeTimes, epsilon)
% epsilon is the minimum difference between the spikeTime and the timeData.
% If not defined, it is set to like 0.0000001...

% Requires that the indices are increasing
% if min(diff(timeData) < 0) || min(diff(timeInd) < 0) ||...
%         min(diff(spikeTimes) < 0)
%     error('Error: timeData, and timeInd should be increasing');
% end

if nargin < 3
    epsilon = 0.00000001;
end

timeSamples = timeInd;
spikeInd = nan(length(timeInd), 1);

% Binary search for each index? 
% this may take forever...

rightInd = length(spikeTimes);
leftInd = 1;

for sample = 1:length(timeSamples)
    searchValue = timeSamples(sample);
    while leftInd <= rightInd
        middleInd = ceil((leftInd + rightInd)/2);
        spikeValue = spikeTimes(middleInd);
        
        if abs(searchValue - spikeValue) < epsilon
            spikeInd(sample) = middleInd;
            break;
        elseif leftInd == rightInd -1 
            spikeInd(sample) = middleInd;
            break;
        elseif spikeValue < searchValue
            leftInd = middleInd;
        elseif spikeValue > searchValue
            rightInd = middleInd;
        end
        
    end
    rightInd = length(spikeTimes);
end


end