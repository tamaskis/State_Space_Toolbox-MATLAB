%==========================================================================
%
% stm2F_fun  Discrete dynamics Jacobian from state transition matrix.
%
%   F = stm2F_fun(Phi,dt)
%   F = stm2F_fun(Phi,dt,t0)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Phi     - (1×1 function_handle) state transition matrix, 
%             Φ(t+Δt,t) = Φ(x,u,t) (Φ : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   F       - (1×1 function_handle) discrete dynamics Jacobian, 
%             Fₖ = F(xₖ,uₖ,k) (F : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣⁿ)
%
%==========================================================================
function F = stm2F_fun(Phi,dt,t0)

    % t as a function of k
    if nargin == 3
        t = k2t_fun(dt,t0);
    else
        t = k2t_fun(dt);
    end

    % function handle for F(xₖ,uₖ,k)
    F = @(xk,uk,k) Phi(xk,uk,t(k));

end