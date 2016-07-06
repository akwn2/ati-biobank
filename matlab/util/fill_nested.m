function [data, names] = fill_nested(varargin)
% FILL_NESTED Fills in the missing data due to nested queries in
% the biobank (that is, missing data in variables that only occur
% when you supply a specific answer in a parent question).
%
% USAGE: data = fill_nested(data, parents, rule, params)
% 
% where:
%     data: is a N subjects x  M variables data matrix.
%     parent: is a 1 x M vector indicating the parents of a given
%              variable (0 if root parent).
%     rule: is a 1 x M vector with the encoded treatment following
%     params: is a M x 1 additional parameter cell array for each
%     variable (empty when no action should be taken).
%
% See also: fix_encodings.

    % Retrieve input parameters
    data = varargin{1}
    names = varargin{2};
    parent1 = varargin{3};
    parent2 = varargin{4};
    parval1 = varargin{5};
    parval2 = varargin{6};
    bbuk_levels = varargin{7};
    new_levels = varargin{8};
    processing = varargin{9};
    
    [n_subs, n_vars] = size(data);
    
    for var = 1:n_vars
        if processing(var) == 1 % Only gaussianise
            
            % Get parent information
            data = inherit(data, var, parent1, parent2, ...
                           parval1, parval2);

            % Change levels if needed
            data(:, :, var) = change_encoding(data(:, :, var), ...
                                              bbuk_levels{var},...
                                              new_levels{var});
            
        elseif processing(var) == 2 % Remove
            
            % Remove variable
            data = data(:,:, 1:n_vars ~= var);
            names = names(1:n_vars ~= var);
            
        elseif processing(var) == 3 % Set Missing to 0 and gaussianise
            
            % Get parent information
            data = inherit(data, var, parent1, parent2, ...
                           parval1, parval2);

            % Change levels if needed
            data(:, :, var) = change_encoding(data(:, :, var), ...
                                              bbuk_levels{var},...
                                              new_levels{var});
            % Set missing to zero
            aux = data(:, :, var);
            aux(isnan(aux)) = 0;
            data(:, :, var) = aux;
        else
            Error = MException('fill_nested:InvalidAction',...
                               'Unkown processing value %d.', ...
                               processing(var));
            throw(Error);
        end
    end
end
