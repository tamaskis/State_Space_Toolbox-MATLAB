%==========================================================================
%
% subscript_k  Adds the subscript "k" to a symbolic variable.
%
%   var_k = subscript_k(var)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-22
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
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