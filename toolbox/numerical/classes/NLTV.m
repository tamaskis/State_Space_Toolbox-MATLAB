%==========================================================================
%
% NLTV  Class defining a continuous-time, nonlinear, time-variant (NLTV) 
% state space system.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-08-27
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%==========================================================================

classdef NLTV
    
    % -----------
    % Properties.
    % -----------

    properties
        f       % (1×1 function_handle) continuous dynamics equation, dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
        h       % (1×1 function_handle) continuous measurement equation, y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
    end
    
    % --------
    % Methods.
    % --------
    
    methods
        
        % ------------
        % Constructor.
        % ------------
        
        function obj = NLTV(f,h)
            % obj = NLTV(f,h)
            %
            % Constructor.
            %
            % -------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   f       - (1×1 function_handle) continuous dynamics 
            %             equation, dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
            %   h       - (1×1 function_handle) continuous measurement 
            %             equation, y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
            %
            % -------
            % OUTPUT:
            % -------
            %   obj     - (1×1 NLTV) NLTV object
            %
            % -------------------------------------------------------------
            
            obj.f = f;
            obj.h = h;
            
        end
        
        % -----------------------------------------------------------
        % Linearize about reference trajectory to produce LTV system.
        % -----------------------------------------------------------
        
        function ltv_obj = linearize_ref(obj)
            % ltv_obj = nltv_obj.linearize_ref
            %
            % Linearizes a continuous-time nonlinear time-variant (NLTV) 
            % system about a reference trajectory to produce a
            % continuous-time linear time-variant (LTV) system.
            %
            % -------------------------------------------------------------
            %
            % -------
            % OUTPUT:
            % -------
            %   ltv_obj - (1×1 LTV) LTV object
            %
            % -------------------------------------------------------------
            
            % system Jacobians
            A = f2A_fun(obj.f);
            B = f2B_fun(obj.f);
            C = h2C_fun(obj.h);
            D = h2D_fun(obj.h);
            
            % constructs LTV object
            ltv_obj = LTV(A,B,C,D);
            
        end
        
        % -----------------------------------------------------------
        % Linearize about equilibrium point to produce LTV system.
        % -----------------------------------------------------------
        
        function lti_obj = linearize_eq(obj,xe,ue)
            % lti_obj = nltv_obj.linearize_eq(xe,ue)
            %
            % Linearizes a continuous-time nonlinear time-variant (NLTV) 
            % system about an equilibrium point to produce a
            % continuous-time linear time-invariant (LTI) system.
            %
            % -------------------------------------------------------------
            %
            % -------
            % OUTPUT:
            % -------
            %   lti_obj - (1×1 LTI) LTI object
            %
            % -------------------------------------------------------------
            
            % defaults "ue" to empty vector if not input
            if (nargin < 2)
                ue = [];
            end
            
            % system Jacobians
            A = f2A_lti(obj.f,xe,ue);
            B = f2B_lti(obj.f,xe,ue);
            C = h2C_lti(obj.h,xe,ue);
            D = h2D_lti(obj.h,xe,ue);
            
            % constructs LTV object
            lti_obj = LTV(A,B,C,D);
            
        end

        % -----------------------------------------------------------
        % Discretize to produce discrete-time NLTV system.
        % -----------------------------------------------------------
        
        function nltv_obj = discretize(obj,integrator)
            % lti_obj = nltv_obj.linearize_eq(xe,ue)
            %
            % Linearizes a continuous-time nonlinear time-variant (NLTV) 
            % system about an equilibrium point to produce a
            % continuous-time linear time-invariant (LTI) system.
            %
            % -------------------------------------------------------------
            %
            % -------
            % OUTPUT:
            % -------
            %   lti_obj - (1×1 LTI) LTI object
            %
            % -------------------------------------------------------------
            
            % defaults "ue" to empty vector if not input
            if (nargin < 2)
                ue = [];
            end
            
            % system Jacobians
            A = f2A_lti(obj.f,xe,ue);
            B = f2B_lti(obj.f,xe,ue);
            C = h2C_lti(obj.h,xe,ue);
            D = h2D_lti(obj.h,xe,ue);
            
            % constructs LTV object
            lti_obj = LTV(A,B,C,D);
            
        end
        
    end
    
end