function output = separateTrialType(targets, formattedSpikes)
% Split data by trial type.
% so N {MnxP} matrix where n is the number of trial types
% Mn is the number of trials of this type
% P is the length of the rastervalues.
% Returns an 1xN cell of (Mn x P) matrices.

[~, ~, types] = unique( targets', 'rows');
nTypes = max(types);
output = cell(1,nTypes);

for mi = 1 : nTypes
    indices = types == mi;
    output{mi} = formattedSpikes(indices,:,:);
end