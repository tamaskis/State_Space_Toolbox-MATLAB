%==========================================================================
%
% h2H_fun  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2H_fun(h,dt)
%   H = h2H_fun(h,dt,t0)
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
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
function H = h2H_fun(h,dt,t0)
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % function handle for C(x,u,t)
    C = h2C_fun(h);
    
    % function handle for H(xₖ,uₖ,k)
    H = C2H_fun(C,dt,t0);
    
end