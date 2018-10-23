function D = det2(y,Gamma)
% D = det2(y,Gamma)
%
% y     : Vector of data samples. Each row corresponds to a separate
%         observation.
% Gamma : Vector of thresholds.
%
% D     : Matrix of output decisions. Each row is a data point and each
%         column corresponds to a different threshold. A value of 0
%         corresponds to deciding hypothesis #0 and a value of 1 corresponds
%         to deciding hypothesis #1. D(i,j) contains the output of the
%         detector applied to y(i) at threshold Gamma(j).
%
% This detector compares the power in the data (y^2) to the threshold
%
%        H1
%   y^2  >  Gamma
%        <
%        H0


% W. C. Karl 2/24/98

if min(size(y)) > 1
  error('y must be a vector of data')
end;

if min(size(Gamma)) > 1
  error('Gamma must be a vector of thresholds')
end;

y = y(:);
Gamma = Gamma(:)';

Ny = length(y);
Ng = length(Gamma);

% Apply detection rule
D = (y.^2)*ones(1,Ng) > ones(Ny,1)*Gamma;
