%==========================================================================
%
% f2stm_fun  State transition matrix from continuous dynamics equation.
%
%   Phi = f2stm_fun(f,dt)
%   Phi = f2stm_fun(f,dt,method)
%
% Author: Tamas Kis
% Last Update: 2022-03-28
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 
%             'Euler')
%
% -------
% OUTPUT:
% -------
%   Phi     - (1×1 function_handle) state transition matrix, Φ(x,u,t)
%             (Φ : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%
%==========================================================================
function Phi = f2stm_fun(f,dt,method)
    
    % defaults method to 'Euler' if not specified
    if (nargin < 3) || isempty(method)
        method = 'Euler';
    end
    
    % function handle for Φ(t+Δt,t)
    Phi = @(x,u,t) f2stm_num(f,x,u,t,dt,method);
    
end