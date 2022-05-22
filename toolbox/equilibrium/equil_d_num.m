%==========================================================================
%
% equil_d_num  Finds an equilibrium point of a discrete dynamics equation 
% (numerical).
%
%   [xe,ue] = equil_d_num(fd,x0,u0)
%   [xe,ue] = equil_d_num(fd,x0,u0,ke)
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
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   x0      - (1×1 double) initial guess for equilibrium state vector, x₀
%   u0      - (1×1 double) initial guess for equilibrium control input, u₀
%   ke      - (1×1 double) (OPTIONAL) sample number at which to solve for
%             equilibrium, kₑ (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%
%==========================================================================
function [xe,ue] = equil_d_num(fd,x0,u0,ke)
    
    % defaults ke to 0
    if (nargin < 4) || isempty(ke)
        ke = 0;
    end
    
    % state (n) and input (m) dimensions
    n = length(x0);
    m = length(u0);
    
    % redefines fd as a function of a single variable, z
    g = @(z) fd(z(1:n),z((n+1):(n+m)),ke);
    
    % initial guess for solution of g(z) = 0
    z0 = [x0;
          u0];
    
    % finds equilibrium point zₑ
    ze = newtons_method_n(g,z0);
    
    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end