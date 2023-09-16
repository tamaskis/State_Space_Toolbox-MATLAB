%==========================================================================
%
% f2F_fun  Discrete dynamics Jacobian from continuous dynamics equation.
%
%   F = f2F_fun(f,dt)
%   F = f2F_fun(f,dt,t0,method)
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
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 'RK4')
%
% -------
% OUTPUT:
% -------
%   F       - (1×1 function_handle) discrete dynamics Jacobian, 
%             Fₖ = F(xₖ,uₖ,k) (F : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣⁿ)
%
%==========================================================================
function F = f2F_fun(f,dt,t0,method)
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % defaults method to 'RK4'
    if (nargin < 4) || isempty(method)
        method = 'RK4';
    end
    
    % function handle for state transition matrix
    Phi = f2stm_fun(f,dt,method);
    
    % function handle for F(xₖ,uₖ,k)
    F = stm2F_fun(Phi,dt,t0);
    
end