function [] = get_missing_values( A, type_opt, type_cmd )
[n,d] = size(A);
missing_values_location = zeros(size(A));
%find the missing values in the raw data
if strcmp(type_opt,'FIND')
    missing_values_location = A==0;
else if strcmp(type_opt,'FILL')
        %fill some features with zeros
        instance_id = 1:type_cmd;
        missing_values_location(instance_id,:) = 1;
    end
end

