%==========================================================================
%
% k2t_fun  Time as a function of sample number.
%
%   t = k2t_fun(dt)
%   t = k2t_fun(dt,t0)
%
% See also t2k_fun.
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
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   t       - (1×1 function_handle) time as a function of sample number,
%             tₖ = t(k) (tₖ : ℤ → ℝ)
%
%==========================================================================
function t = k2t_fun(dt,t0)
    if (nargin == 2) && ~isempty(t0)
        t = @(k) t0+k*dt;
    else
        t = @(k) k*dt;
    end
end