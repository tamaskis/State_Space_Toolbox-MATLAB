%==========================================================================
%
% fd2G_sym  Discrete input Jacobian from discrete dynamics equation.
%
%   G = fd2G_sym(fd,uk)
%   G = fd2G_sym(fd,uk,ue)
%   G = fd2G_sym(fd,uk,ue,xk,xe)
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
%   uk      - (m×1 sym) control input at kth sample time
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%   xk      - (n×1 sym) (OPTIONAL) state vector at kth sample time
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%
% -------
% OUTPUT:
% -------
%   G       - (n×m sym) discrete input Jacobian at kth sample time
%
%==========================================================================
function G = fd2G_sym(fd,uk,ue,xk,xe)
    
    % Jacobian of fd w.r.t. uk
    G = simplify(jacobian(fd,uk),'Steps',100);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(uk)
            G = simplify(subs(G,uk(i),ue(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(xk)
            G = simplify(subs(G,xk(i),xe(i)),'Steps',100);
        end
    end
    
end