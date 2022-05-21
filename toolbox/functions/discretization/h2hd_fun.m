%==========================================================================
%
% h2hd_fun  Discrete nonlinear measurement equation from continuous 
% nonlinear measurement equation.
%
%   hd = h2hd_fun(h,dt)
%   hd = h2hd_fun(h,dt,t0)
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
%   hd      - (1×1 function_handle) discrete measurement equation, with
%             same number of input arguments as h:
%               --> yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ) if h(x,t) input
%               --> yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ) if h(x,u,t) input
%
%==========================================================================
function hd = h2hd_fun(h,dt,t0)
    
    % t as a function of k
    if (nargin == 3) && ~isempty(t0)
        t = k2t_fun(dt,t0);
    else
        t = k2t_fun(dt);
    end

    % assumes h has three input arguments (i.e. h(x,u,t))
    num_arg = 3;
    
    % updates "num_arg" to 2 if h is really input as h(x,t)
    try
        h(0,0,0);
    catch
        num_arg = 2;
    end

    % function handle for hd(xₖ,k)
    if num_arg == 2
        hd = @(xk,k) h(xk,t(k));
    
    % function handle for hd(xₖ,uₖ,k)
    else
        hd = @(xk,uk,k) h(xk,uk,t(k));
    
    end
    
end