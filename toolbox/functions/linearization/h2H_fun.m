%==========================================================================
%
% h2H_fun  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2H_fun(h,dt)
%   H = h2H_fun(h,dt,t0)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (1×1 function_handle) continuous measurement equation, can 
%             have 2 or 3 input arguments:
%               --> y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%               --> y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   H       - (1×1 function_handle) discrete measurement Jacobian, with
%             same number of input arguments as h:
%               --> Hₖ = H(xₖ,k) (H : ℝⁿ×ℤ → ℝᵖˣⁿ) if h(x,t) input
%               --> Hₖ = H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ) if h(x,u,t) input
%
%==========================================================================
function H = h2H_fun(h,dt,t0)

    % function handle for continuous measurement Jacobian, C
    C = h2C_fun(h);

    % function handle for discrete measurement Jacobian, H
    if nargin == 3
        H = C2H_fun(C,dt,t0);
    else
        H = C2H_fun(C,dt);
    end
    
end