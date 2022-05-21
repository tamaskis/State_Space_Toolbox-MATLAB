%==========================================================================
%
% h2D_sym  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_sym(h,u)
%   D = h2D_sym(h,u,ue)
%   D = h2D_sym(h,u,ue,x,xe)
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
%   u       - (m×1 sym) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%   x       - (n×1 sym) (OPTIONAL) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%
% -------
% OUTPUT:
% -------
%   D       - (p×m sym) continuous feedforward Jacobian
%
%==========================================================================
function D = h2D_sym(h,u,ue,x,xe)
    
    % Jacobian of h w.r.t. u
    D = simplify(jacobian(h,u),'Steps',100);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(u)
            C = simplify(subs(C,u(i),ue(i)),'Steps',100);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(x)
            C = simplify(subs(C,x(i),xe(i)),'Steps',100);
        end
    end
    
end