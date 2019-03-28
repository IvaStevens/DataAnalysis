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
% if a trial is contained within the times specefied as successful, then
% the output at that time: out(i) = 1. otherwise out(i)=0, for i=1:N

nTrials = length(trials);
out = zeros(1,nTrials);

% Separate out the beginning an the end of successful times
successChunks = successes.*timeStamps;

fails = ~successes;
% Note: 8 is chosen as random large number place holder, these are
% otherwise logical arrays
startInds = successChunks(diff([8, fails]) == 1);
endInds = successChunks(diff([fails, 8]) == -1);

indices = [startInds ; endInds];

% Assert that the endInds(i) >= startInds(i);
max(indices,2)
assert(true, "");




end