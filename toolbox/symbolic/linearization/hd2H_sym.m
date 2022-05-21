%==========================================================================
%
% hd2H_sym  Discrete measurement Jacobian from discrete nonlinear 
% measurement.
%
%   H = hd2H_sym(hd,xk)
%   H = hd2H_sym(hd,xk,xeq)
%   H = hd2H_sym(hd,xk,xeq,uk,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hd      - (p×1 sym) discrete nonlinear measurement equation
%   xk      - (n×1 sym) state vector at kth sample time
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   uk      - (m×1 sym) (OPTIONAL) control input at kth sample time
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   H       - (p×n sym) discrete measurement Jacobian at kth sample time
%
%==========================================================================
function H = hd2H_sym(hd,xk,xe,uk,ue)
    
    % Jacobian of hd w.r.t. xk
    H = simplify(jacobian(hd,xk),'Steps',100);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(xk)
            H = simplify(subs(H,xk(i),xe(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(uk)
            H = simplify(subs(H,uk(i),ue(i)),'Steps',100);
        end
    end
    
end