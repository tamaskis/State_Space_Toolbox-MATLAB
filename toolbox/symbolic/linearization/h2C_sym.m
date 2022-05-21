%==========================================================================
%
% h2C_sym  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   C = h2C_sym(h,x)
%   C = h2C_sym(h,x,xe)
%   C = h2C_sym(h,x,xe,u,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (p×1 sym) continuous measurement equation
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   C       - (p×n sym) continuous measurement Jacobian
%
%==========================================================================
function C = h2C_sym(h,x,xe,u,ue)
    
    % Jacobian of h w.r.t. x
    C = simplify(jacobian(h,x),'Steps',100);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(x)
            C = simplify(subs(C,x(i),xe(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(u)
            C = simplify(subs(C,u(i),ue(i)),'Steps',100);
        end
    end
    
end