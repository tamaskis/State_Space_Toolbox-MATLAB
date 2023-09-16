%==========================================================================
%
% equil_d_sym  Finds an equilibrium point of a discrete dynamics equation 
% (symbolic).
%
%   [xe,ue] = equil_d_sym(fd,xk,uk)
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
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   fd      - (n×1 sym) discrete dynamics equation
%   xk      - (n×1 sym) state vector, xₖ
%   uk      - (m×1 sym) control input, uₖ
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 sym) equilibrium state vector, xₑ
%   ue      - (m×1 sym) equilibrium control input, uₑ
%
%==========================================================================
function [xe,ue] = equil_d_sym(fd,xk,uk)
    
    % state (n) and input (m) dimensions
    n = length(xk);
    m = length(uk);
    
    % defines z
    z = [xk;
         uk];
    
    % finds equilibrium point zₑ
    ze = solve(fd == zeros(n,1),z);
    
    % converts result from structure to symbolic array
    ze = cell2sym(struct2cell(ze));
    
    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end