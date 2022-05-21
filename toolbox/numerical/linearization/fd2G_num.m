%==========================================================================
%
% fd2G_num  Discrete input Jacobian from discrete dynamics equation.
%
%   Gk = fd2G_num(fd,x,u)
%   Gk = fd2G_num(fd,x,u,k)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) control input to linearize about
%   k       - (1×1 double) (OPTIONAL) sample number at linearization
%
% -------
% OUTPUT:
% -------
%   Gk      - (n×m double) discrete input Jacobian at kth sample time
%
% -----
% NOTE:
% -----
%   --> If linearizing about equilibrium point (xₑ,uₑ), input xₑ for x and
%       uₑ for u.
%   --> If linearizing about reference trajectory (xᵣ,uᵣ), input xᵣ at
%       sample k for x and uᵣ at sample k for u.
%
%==========================================================================
function Gk = fd2G_num(fd,x,u,k)
    
    % defaults sample number to empty vector if not specified
    if (nargin < 4)
        k = [];
    end

    % evaluates discrete input Jacobian
    Gk = ijacobian(@(u)fd(x,u,k),u);
    
end