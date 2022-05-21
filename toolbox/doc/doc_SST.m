%==========================================================================
%
% doc_SST  Opens the documentation for the Numerical Differentiation 
% Toolbox.
%
%   doc_SST
%   doc_SST function_name
%   doc_SST tech
%
% Copyright © 2021 Tamas Kis
% Last Update: 2022-05-02
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   name   - (char) name of the function
%               --> using "tech" opens the technical documentation
%
%==========================================================================
function doc_SST(name)

    % opens index if no function name specified
    if nargin == 0
        web('html_NDT/index.html');

    % opens technical documentation
    elseif strcmpi(name,'tech')
        open(strcat('State_Space_Systems_Linearization_Discretization_',...
            '_and_Simulation.pdf'));
        
    % opens specified function documentation
    else
        web(strcat('html_NDT/',name,'_doc.html'));

    end
end