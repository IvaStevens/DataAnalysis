function out = findIfSuccessful(trials, successes, timeStamps)
% findIfSuccessful(trials)
% Returns a 1 X N logical array denoting which trials given by "trials" 
% were successful, where N is the number of trials. 
% Inputs are: 
% Trials: 1xN array of trials, were each input is a timepoint during that
%       trial.
% successes: 1xM logical array where M is the number of timestamps
% timesStamps: 1xM double array of timestamps.
%
% If a trial is contained within the times specefied as successful, then
% the output at that time: out(i) = 1. otherwise out(i)=0, for i=1:N
% Assumes 'trials' and 'timeStamps' are monotonically increasing

nTrials = length(trials);
out = zeros(1,nTrials);

% Separate out the beginning an the end of successful times
successChunks = successes.*timeStamps;

fails = ~successes;
% Note: 8 is chosen as random large number place holder, these are
% otherwise logical arrays
startInds = successChunks(diff([8, successes]) == 1);
endInds = successChunks(diff([successes, 8]) == -1);

indices = [startInds ; endInds];

% Assert that the endInds(i) >= startInds(i);
%max(indices,2)
%assert(true, "");
assert(length(startInds) == length(endInds), "Error, index array lengths")

mInds = length(startInds);

for iTrial = 1:nTrials
    trialTime = trials(iTrial);
    
    % Find the 1st endInds that is > trialTime
    lastStart = find(endInds >= trialTime, 1);
    
    if startInds(lastStart) <= trialTime
        out(iTrial) = 1;
        continue;
    end
        
    % If the trial exceeds successful trials, break early
    if(trialTime > endInds(mInds))
        break;
    end
end


end