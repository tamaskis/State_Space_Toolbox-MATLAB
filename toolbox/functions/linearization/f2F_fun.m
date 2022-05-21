%==========================================================================
%
% f2F_fun  Discrete dynamics Jacobian from continuous dynamics equation.
%
%   F = f2F_fun(f,dt)
%   F = f2F_fun(f,dt,t0,method)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 
%             'Euler')
%
% -------
% OUTPUT:
% -------
%   F       - (1×1 function_handle) discrete dynamics Jacobian,
%             Fₖ = F(xₖ,uₖ,k) (F : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣⁿ)
%
%==========================================================================
function F = f2F_fun(f,dt,t0,method)
    
    % defaults initial time to 0 if not specified
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % defaults method to 'Euler' if not specified
    if (nargin < 4) || isempty(method)
        method = 'Euler';
    end
    
    % t as a function of k
    t = k2t_fun(dt,t0);
    
    % function handle for F(xₖ,uₖ,k)
    F = @(xk,uk,k) f2stm_num(f,xk,uk,t(k),dt,method);
    
end