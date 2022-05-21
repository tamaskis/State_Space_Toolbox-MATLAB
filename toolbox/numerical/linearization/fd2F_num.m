%==========================================================================
%
% fd2F_num  Discrete dynamics Jacobian from discrete dynamics equation.
%
%   Fk = fd2F_num(fd,x)
%   Fk = fd2F_num(fd,x,u)
%   Fk = fd2F_num(fd,x,[],k)
%   Fk = fd2F_num(fd,x,u,k)
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
%   u       - (m×1 double) (OPTIONAL) control input to linearize about
%   k       - (1×1 double) (OPTIONAL) sample number at linearization
%
% -------
% OUTPUT:
% -------
%   Fk      - (n×n double) discrete dynamics Jacobian at kth sample time
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
function Fk = fd2F_num(fd,x,u,k)
    
    % defaults control input to empty vector if not specified
    if (nargin < 3)
        u = [];
    end
    
    % defaults sample number to empty vector if not specified
    if (nargin < 4)
        k = [];
    end

    % discrete dynamics Jacobian
    Fk = ijacobian(@(x)fd(x,u,k),x);
    
end