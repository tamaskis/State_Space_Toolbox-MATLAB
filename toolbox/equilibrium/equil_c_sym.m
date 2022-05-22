%==========================================================================
%
% equil_c_sym  Finds an equilibrium point of a continuous dynamics equation
% (symbolic).
%
%   [xe,ue] = equil_c_sym(f,x,u)
%
% See also TODO.
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
% https://tamaskis.github.io/documentation/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (n×1 sym) continuous dynamics equation
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 sym) equilibrium state vector, xₑ
%   ue      - (m×1 sym) equilibrium control input, uₑ
%
%==========================================================================
function [xe,ue] = equil_c_sym(f,x,u)
    
    % state (n) and input (m) dimensions
    n = length(x);
    m = length(u);
    
    % defines z
    z = [x;
         u];
    
    % finds equilibrium point zₑ
    ze = solve(f == zeros(n,1),z);
    
    % converts result from structure to symbolic array
    ze = cell2sym(struct2cell(ze));
    
    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end