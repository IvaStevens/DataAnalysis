function [out, trialParams] = plotRasters4Channel(DataF, Data, channel, unit, timeRange)
% [out, trialParams] = plotRasters4Channel(DataF, Data, channel, unit, timeRange)
% 
% Inputs
% DataF: formatted data
% Data: Intermdiate data
% channel: 
% unit:
%
% Outputs
% out: matrix of something...
% trial params: mapping of trial type to parameters

if nargin < 5
    timeRange = .5;
if nargin < 4
    unit = 0;
end


transitions = zeros(1,length(DataF.Time));

masks = fields(DataF.TaskStateMasks);

for i=1:length(masks)
transitions = transitions + i*DataF.TaskStateMasks.(masks{i});
end

[~, trialParams, allTrialTypes ] = unique(DataF.TaskJudging.Target','rows');

%split up different task types
for trialType = 1:6
    
    isTrialType = allTrialTypes == trialType;
    
    % Find where id == 3 (eg: when in forceRamp task state)
    forceTaskState = transitions == 3;

    % Find where id+1 == 4 (eg: sucessful forceRamp to Move progression)
    nextTaskState = [diff(transitions), 0] == 1;
    force2move = forceTaskState.*nextTaskState.*isTrialType';


    % Find the timestamps for these events (in spike time)
    finishedTrial  = force2move == 1;
    successfulTrial = DataF.TaskStateOutcomeMasks.Success;

    successTimes = DataF.SpikeTimestamp(finishedTrial & successfulTrial);

    channelData = getSpikesByChannel(Data.QL.Data.SPIKE_SNIPPET, channel, unit);

    % You want a matrix of cell arrays, that contain spiketimes for each trial
    % aligned by the transition from force to move
    out{trialType} = formatSpikes4Rasters(channelData, successTimes, timeRange);
    title(sprintf('Raster for channel %d unit %d: trial Type %d', channel, unit, trialType));

end

end %End funciton