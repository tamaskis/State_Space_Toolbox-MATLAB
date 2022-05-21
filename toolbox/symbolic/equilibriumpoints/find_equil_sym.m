%==========================================================================
%
% find_equil_sym  Symbolically solves for the equilibrium point of the
% continuous time dynamics dx/dt = f(x,u,t).
%
%   [xe,ue] = find_equil_sym(f,x,u)
%
% Author: Tamas Kis
% Last Update: 2022-05-03
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (n×1 sym) continuous-time nonlinear dynamics equation
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%
% -------
% OUTPUT:
% -------
%   xe      - (n×1 sym) equilibrium state, xₑ
%   ue      - (m×1 sym) equilibrium input, uₑ
%
%==========================================================================
function [xe,ue] = find_equil_sym(f,x,u)

    % state (n) and input (m) dimensions
    n = length(x);
    m = length(u);

    % defines z
    z = [x;
         u];
    
    % finds equilibrium point zₑ
    ze = solve(f == zeros(n,1),z);

    % converts result from structure to symbolic array
    ze = cell2sym(struct2cell(ze));

    % extracts xₑ and uₑ from zₑ
    xe = ze(1:n);
    ue = ze((n+1):(n+m));
    
end