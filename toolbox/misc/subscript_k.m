%==========================================================================
%
% subscript_k  Adds the subscript "k" to a symbolic variable.
%
%   var_k = subscript_k(var)
%
% Author: Tamas Kis
% Last Update: 2022-03-29
%
% REFERENCES:
%   [1] https://stackoverflow.com/questions/57613210/rename-symbolic-variable-matlab
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   var     - (n×1 sym) symbolic variable (can be a scalar or vector)
%
% -------
% OUTPUT:
% -------
%   var_k   - (n×1 sym) symbolic variable with subscript of "k" added
%
%==========================================================================
function var_k = subscript_k(var)
    var_k = var;
    for i = 1:length(var)
        var_k(i) = sym([char(var(i)),'_k']);
    end
end