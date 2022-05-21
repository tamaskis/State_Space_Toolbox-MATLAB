%==========================================================================
%
% C2H_fun  Discrete measurement Jacobian from continuous measurement 
% Jacobian.
%
%   H = C2H_fun(C,dt)
%   H = C2H_fun(C,dt,t0)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   C       - (1×1 function_handle) continuous measurement Jacobian, can 
%             have 2 or 3 input arguments:
%               --> C(t) = C(x,t) (C : ℝⁿ×ℝ → ℝᵖˣⁿ)
%               --> C(t) = C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   H       - (1×1 function_handle) discrete measurement Jacobian, with
%             same number of input arguments as C
%               --> Hₖ = H(xₖ,k) (H : ℝⁿ×ℤ → ℝᵖˣⁿ) if C(x,t) input
%               --> Hₖ = H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ) if C(x,u,t) input
%
%==========================================================================
function H = C2H_fun(C,dt,t0)
    
    % t as a function of k
    if nargin == 3
        t = k2t_fun(dt,t0);
    else
        t = k2t_fun(dt);
    end
    
    % assume C has three input arguments (i.e. C(x,u,t))
    num_arg = 3;
    
    % update "num_arg" to 2 if C is really input as C(x,t)
    try
        C(0,0,0);
    catch
        num_arg = 2;
    end
    
    % function handle for H(xₖ,k)
    if num_arg == 2
        H = @(xk,k) C(xk,t(k));
    
    % function handle for H(xₖ,uₖ,k)
    else
        H = @(xk,uk,k) C(xk,uk,t(k));
    
    end
    
end