%==========================================================================
%
% fd2F_sym  Discrete dynamics Jacobian from discrete dynamics equation.
%
%   F = fd2F_sym(fd,xk)
%   F = fd2F_sym(fd,xk,xe)
%   F = fd2F_sym(fd,xk,xe,uk,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   fd      - (n×1 sym) discrete dynamics equation
%   xk      - (n×1 sym) state vector at kth sample time
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   uk      - (m×1 sym) (OPTIONAL) control input at kth sample time
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample time
%
%==========================================================================
function F = fd2F_sym(fd,xk,xe,uk,ue)
    
    % Jacobian of fd w.r.t. xk
    F = simplify(jacobian(fd,xk),'Steps',100);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(xk)
            F = simplify(subs(F,xk(i),xe(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(uk)
            F = simplify(subs(F,uk(i),ue(i)),'Steps',100);
        end
    end
    
end