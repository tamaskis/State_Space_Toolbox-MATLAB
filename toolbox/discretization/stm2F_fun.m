%==========================================================================
%
% stm2F_fun  Discrete dynamics Jacobian from state transition matrix.
%
%   F = stm2F_fun(Phi,dt)
%   F = stm2F_fun(Phi,dt,t0)
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
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % t as a function of k
    t = k2t_fun(dt,t0);
    
    % function handle for F(xₖ,uₖ,k)
    F = @(xk,uk,k) Phi(xk,uk,t(k));
    
end