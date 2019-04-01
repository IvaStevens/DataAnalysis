function plotRasters4Channel(DataF, Data, channel, unit)

transitions = zeros(1,length(DataF.Time));

masks = fields(DataF.TaskStateMasks);

for i=1:length(masks)
transitions = transitions + i*DataF.TaskStateMasks.(masks{i});
end

% Find where id == 3 (eg: when in forceRamp task state)
forceTaskState = transitions == 3;

% Find where id+1 == 4 (eg: sucessful forceRamp to Move progression)
nextTaskState = [diff(transitions), 0] == 1;
force2move = forceTaskState.*nextTaskState;

% Find the timestamps where the trial succeeded
nextTaskState = [nextTaskState(3:end), 0, 0];
force2end = force2move.*nextTaskState;


% Find the timestamps for these events (in spike time)
finishedTrial  = force2end == 1;
successfulTrial = DataF.TaskStateOutcomeMasks.Success;

successTimes = DataF.SpikeTimestamp(finishedTrial & successfulTrial);

channelData = getSpikesByChannel(Data.QL.Data.SPIKE_SNIPPET, channel, unit);

% You want a matrix of cell arrays, that contain spiketimes for each trial
% aligned by the transition from force to move

end




end