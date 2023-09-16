%==========================================================================
%
% Af2stm_fun  State transition matrix from continuous dynamics Jacobian and 
% continuous dynamics equation.
%
%   Phi = Af2stm_fun(A,f,dt)
%   Phi = Af2stm_fun(A,f,dt,method)
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
%   A       - (1×1 function_handle) continuous dynamics Jacobian, A(x,u,t)
%             (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 'RK4')
%
% -------
% OUTPUT:
% -------
%   Phi     - (1×1 function_handle) state transition matrix, 
%             Φ(t+Δt,t) = Φ(x,u,t) (Φ : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%
%==========================================================================
function Phi = Af2stm_fun(A,f,dt,method)
    
    % defaults method to 'RK4'
    if (nargin < 4) || isempty(method)
        method = 'RK4';
    end
    
    % function handle for Φ(t+Δt,t)
    Phi = @(x,u,t) Af2stm_num(A,f,x,u,t,dt,method);
    
end