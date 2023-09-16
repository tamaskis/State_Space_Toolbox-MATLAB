%==========================================================================
%
% LTI  Class defining a continous-time linear time-invariant (LTI) state 
% space system.
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
%--------------------------------------------------------------------------
%
% The LTI class defines a continuous-time linear time-invariant (LTI) state
% space system of the form
%
%   d(δx)/dt = Aδx + Bδu
%   δy = Cδx + Dδu
%
% where the error variables (δx, δu, and δy) are defined as
%
%   δx = x - xₑ
%   δu = u - uₑ
%   δy = y - yₑ
%
% In the special case that xₑ = uₑ = 0 (but yₑ ≠ 0), the system becomes
%
%   dx/dt = Ax + Bu
%   δy = Cx + Du
%
% In the special case that xₑ = uₑ = yₑ = 0, the system becomes
%
%   dx/dt = Ax + Bu
%   y = Cx + Du
%
%==========================================================================

classdef LTI
    
    properties
        A       % (n×n double) continuous dynamics matrix
        B       % (n×m double) continuous input matrix
        C       % (p×n double) continuous measurement matrix
        D       % (p×m double) continuous feedforward matrix
        xe      % (n×1 double) equilibrium state
        ue      % (m×1 double) equilibrium input
        ye      % (p×1 double) equilibrium measurement
    end
    
    
    
    
    
    methods
        
        
        
        function obj = LTI(A,B,C,D,xe,ue,ye)
            %==============================================================
            % obj = LTI(A,B,C,D)
            %
            % Constructor.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   A       - (n×n double) continuous dynamics matrix
            %   B       - (n×m double) continuous input matrix
            %   C       - (p×n double) continuous measurement matrix
            %   D       - (p×m double) continuous feedforward matrix
            %   xe      - (OPTIONAL) (n×1 double) equilibrium state
            %   ue      - (OPTIONAL) (m×1 double) equilibrium input
            %   ye      - (OPTIONAL) (p×1 double) equilibrium measurement
            %
            % -------
            % OUTPUT:
            % -------
            %   obj     - (1×1 LTI) LTI object
            %
            %==============================================================
            
            % system matrices
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.D = D;
            
            % obtains state (n), input (m), and measurement (p) dimensions
            n = size(obj.A,1);
            m = size(obj.B,2);
            p = size(obj,C,1);
            
            % defaults equilibrium state to 0 if not input
            if (nargin < 5) || isempty(xe)
                obj.xe = zeros(n,1);
            end
            
            % defaults equilibrium input to 0 if not input
            if (nargin < 6) || isempty(ue)
                obj.ue = zeros(m,1);
            end
            
            % defaults equilibrium measurement to 0 if not input
            if (nargin < 7) || isempty(ye)
                obj.ye = zeros(p,1);
            end
            
        end
        
        
        
    end

end