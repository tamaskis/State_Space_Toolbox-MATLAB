%==========================================================================
%
% t2k_fun  Sample number as a function of time.
%
%   k = t2k_fun(dt)
%   k = t2k_fun(dt,t0)
%
% See also k2t_fun.
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
%   k       - (1×1 function_handle) current sample number as a function of
%             time, k = k(t) (k : ℝ → ℤ)
%
% -----
% NOTE:
% -----
%   --> This function assumes that t-t₀ is divisible by Δt (otherwise, the
%       sample number, k, will not be an integer). However, this is not
%       enforced; if t-t₀ is NOT divisible by Δt, then k(t) will return a
%       rational number.
%
%==========================================================================
function k = t2k_fun(dt,t0)
    if (nargin == 2) && ~isempty(t0)
        k = @(t) (t-t0)/dt;
    else
        k = @(t) t/dt;
    end
end