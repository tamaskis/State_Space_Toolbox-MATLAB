%==========================================================================
%
% equil_c_num  Numerically solves for an equilibrium point of a 
% continuous-time system.
%
%   [xe,ue] = equil_c_num(f,x0,u0)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-06-16
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
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x0      - (1×1 double) initial guess for equilibrium state vector, x₀
%   u0      - (1×1 double) initial guess for equilibrium control input, u₀
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%
%==========================================================================
function [xe,ue] = equil_c_num(f,x0,u0)
    
    % state (n) and input (m) dimensions
    n = length(x0);
    m = length(u0);
    
    % redefines f as a function of a single variable, z
    g = @(z) f(z(1:n),z((n+1):(n+m)),0);
    
    % initial guess for solution of g(z) = 0
    z0 = [x0;
          u0];
    
    % finds equilibrium point zₑ
    ze = newtons_method_n(g,z0);
    
    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end