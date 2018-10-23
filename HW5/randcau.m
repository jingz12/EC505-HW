function y = randcau(m,n,a)
% y = randcau([m,n],a)
% y = randcau(m,n,a)
%
%       m,n     : Dimensions of matrix generated (mxn).
%       a       : Parameter of Cauchy pdf. Optional. Default: a=1.
%
%       Produces variates from the Cauchy PDF defined by:
%
%                 1       a
%       F_X(x) =  - * ---------
%                 pi  a^2 + x^2
%
%       Here a is the spread of the distribution. Generates an mxn matrix of
%       Cauchy random variates.
%
%       The random numbers are generated using the transform method.

% W. C. Karl 1/6/98

if max(size(m))>1 & nargin == 1
  a = 1;
  n = m(2);
  m = m(1);
elseif max(size(m))>1 & nargin == 2  
  a = n;
  n = m(2);
  m = m(1);
elseif max(size(m))==1 & nargin == 2
  a = 1;
elseif max(size(m))==1 & nargin == 3
else
  error(['Unrecognized input configuration'])
end;

% Generate uniform random variates
x = rand(m,n);

% Perform Transformation
y = a*tan(pi*(x-.5));
