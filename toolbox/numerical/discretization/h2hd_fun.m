%==========================================================================
%
% h2hd_fun  Discrete measurement equation from continuous measurement 
% equation.
%
%   hd = h2hd_fun(h,dt)
%   hd = h2hd_fun(h,dt,t0)
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   hd      - (1×1 function_handle) discrete measurement equation, 
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%
%==========================================================================
function hd = h2hd_fun(h,dt,t0)
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % t as a function of k
    t = k2t_fun(dt,t0);
    
    % function handle for hd(xₖ,uₖ,k)
    hd = @(xk,uk,k) h(xk,uk,t(k));
    
end