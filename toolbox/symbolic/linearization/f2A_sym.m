%==========================================================================
%
% f2A_sym  Continuous dynamics Jacobian from continuous dynamics equation.
%
%   A = f2A_sym(f,x)
%   A = f2A_sym(f,x,xe)
%   A = f2A_sym(f,x,xe,u,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (n×1 sym) continuous dynamics equation
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   A       - (n×n sym) continuous dynamics Jacobian
%
%==========================================================================
function A = f2A_sym(f,x,xe,u,ue)
    
    % Jacobian of f w.r.t. x
    A = simplify(jacobian(f,x),'Steps',100);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(x)
            A = simplify(subs(A,x(i),xe(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(u)
            A = simplify(subs(A,u(i),ue(i)),'Steps',100);
        end
    end
    
end