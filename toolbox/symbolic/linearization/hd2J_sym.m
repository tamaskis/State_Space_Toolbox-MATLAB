%==========================================================================
%
% hd2J_sym  Discrete feedforward Jacobian from discrete measurement
% equation.
%
%   J = hd2J_sym(hd,uk)
%   J = hd2J_sym(hd,uk,ue)
%   J = hd2J_sym(hd,uk,ue,xk,xe)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hd      - (p×1 sym) discrete measurement equation
%   uk      - (m×1 sym) control input at kth sample time
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%   xk      - (n×1 sym) (OPTIONAL) state vector at kth sample time
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%
% -------
% OUTPUT:
% -------
%   J       - (p×n sym) discrete feedforward Jacobian at kth sample time
%
%==========================================================================
function J = hd2J_sym(hd,uk,ue,xk,xe)
    
    % Jacobian of hd w.r.t. uk
    J = simplify(jacobian(hd,uk),'Steps',100);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(uk)
            H = simplify(subs(H,uk(i),ue(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(xk)
            H = simplify(subs(H,xk(i),xe(i)),'Steps',100);
        end
    end
    
end