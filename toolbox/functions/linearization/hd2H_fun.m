%==========================================================================
%
% hd2H_fun  Discrete measurement Jacobian from discrete measurement
% equation.
%
%   H = hd2H_fun(hd)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hd      - (1×1 function_handle) discrete measurement equation, can 
%             have 2 or 3 input arguments:
%               --> yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ)
%               --> yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%
% -------
% OUTPUT:
% -------
%   H       - (1×1 function_handle) discrete measurement Jacobian, with
%             same number of input arguments as hd:
%               --> Hₖ = H(xₖ,k) (H : ℝⁿ×ℤ → ℝᵖˣⁿ) if hd(xₖ,k) input
%               --> Hₖ = H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ) if hd(xₖ,uₖ,k) input
%
%==========================================================================
function H = hd2H_fun(hd)
    
    % assumes hd has three input arguments (i.e. hd(xₖ,uₖ,k))
    num_arg = 3;
    
    % updates "num_arg" to 2 if hd is really input as hd(xₖ,k)
    try
        hd(0,0,0);
    catch
        num_arg = 2;
    end
    
    % function handle for H(xₖ,k)
    if num_arg == 2
        H = @(xk,k) hd2H_num(hd,xk,[],k);
    
    % function handle for H(xₖ,uₖ,k)
    else
        H = @(xk,uk,k) hd2H_num(hd,xk,uk,k);
    
    end
    
end