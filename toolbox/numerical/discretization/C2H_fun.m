%==========================================================================
%
% C2H_fun  Discrete measurement Jacobian from continuous measurement 
% Jacobian.
%
%   H = C2H_fun(C,dt)
%   H = C2H_fun(C,dt,t0)
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
% -------
%   C       - (1×1 function_handle) continuous measurement Jacobian, 
%             C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   H       - (1×1 function_handle) discrete measurement Jacobian, 
%             Hₖ = H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ)
%
%==========================================================================
function H = C2H_fun(C,dt,t0)
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % t as a function of k
    t = k2t_fun(dt,t0);
    
    % function handle for H(xₖ,uₖ,k)
    H = @(xk,uk,k) C(xk,uk,t(k));
    
end