%==========================================================================
%
% find_equil_num  Numerically solve for the equilibrium point of the
% continuous time dynamics dx/dt = f(x,u,t).
%
%   [xe,ue] = find_equil_num(f,x0,u0)
%
% Author: Tamas Kis
% Last Update: 2022-03-29
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous-time nonlinear dynamics 
%             equation dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x0      - (1×1 double) initial guess for equilibrium state, x₀
%   u0      - (1×1 double) initial guess for equilibrium input, u₀
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 double) equilibrium state, xₑ
%   ue      - (m×1 double) equilibrium input, uₑ
%
%==========================================================================
function [xe,ue] = find_equil_num(f,x0,u0,t0)
    
    % defaults t0 to 0 if not input
    if nargin == 3
        t0 = 0;
    end

    % state (n) and input (m) dimensions
    n = length(x0);
    m = length(u0);

    % redefines f as a function of a single variable, z
    g = @(z) f(z(1:n),z((n+1):(n+m)),t0);

    % initial guess for solution of g(z) = 0
    z0 = [x0;
          u0];
    
    % finds equilibrium point zₑ
    ze = fsolve_newton(g,z0);

    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end