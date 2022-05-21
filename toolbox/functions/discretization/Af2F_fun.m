%==========================================================================
%
% Af2F_fun  Discrete dynamics Jacobian from continuous dynamics Jacobian 
% and continuous dynamics equation.
%
%   F = Af2F(A,f,dt)
%   F = Af2F(A,f,dt,t0,method)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   A       - (1×1 function_handle) continuous dynamics Jacobian, 
%             A(t) = A(x,u,t) (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
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
function F = Af2F_fun(A,f,dt,t0,method)

    % function handle for Φ(x,u,t)
    if (nargin == 5) && ~isempty(method)
        Phi = Af2stm_fun(A,f,dt,method);
    else
        Phi = Af2stm_fun(A,f,dt);
    end

    % function handle for F(xₖ,uₖ,k)
    if (nargin == 4) && ~isempty(t0)
        F = stm2F_fun(Phi,dt,t0);
    else
        F = stm2F_fun(Phi,dt);
    end

end