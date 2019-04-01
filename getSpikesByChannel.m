function out = getSpikesByChannel(SpikeSnippets, channel, unit)
% getSpikesByChannel(SpikeSnippets, channel, unit)
% Gets the timestamps for spikes at a ceterain channel and unit.
%
% SpikeSnippets.ss is struct of the form: 
%        source_index: [1×N int32]
%             channel: [1×N int32]
%                unit: [1×N int32]
%            reserved: [1×N int32]
%    source_timestamp: [1×N double]
%            fPattern: [3×N double]
%               nPeak: [1×N int32]
%             nValley: [1×N int32]
%             snippet: [48×N int16]
%

isChannel = SpikeSnippets.ss.channel == channel;
if nargin == 3
    isUnit = SpikeSnippets.ss.unit == unit;
    isChannel = isChannel & isUnit;    
end

out = SpikeSnippets.ss.source_timestamp(isChannel);
end