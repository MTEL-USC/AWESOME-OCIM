% Originally written by Francois Primeau. Used for putting data onto the
% Awesome OCIM model grid.

function [mu,var,n,Q] = bin3d(x,y,z,d,derr,X,Y,Z)
% [mu,var] = bin3d(x,y,z,d,derr,X,Y,Z)
% bins data on a 3-d grid with [X,Y,Z] coordinates
% returns mu, the mean of observations at each grid point and var, the
% variance of observations at each grid point
% X, Y, and Z are 3-d matrices produced by meshgrid
% x, y, z, are 1-d objects with the x, y, and z coordinates of the
% original data, d (also a 1-d object) and derr, the 1 std. dev. estimate
% of each data point

% total number of observations
nobs = length(d);

% grid size
[ny,nx,nz] = size(X);
m = prod(size(X));

% bin indices in the vertical
ilev = 1:nz;
zt = squeeze(Z(1,1,:));
Q.ilev = zeros(nobs,1);
Q.ilev = interp1(zt(:),ilev(:),z,'nearest');

% fix the points that lie outside the domain (i.e. surface and bottom pts)
ii = find(isnan(Q.ilev));
isurf = find(z(ii)<zt(1));
ibot = find(z(ii)>zt(end));
Q.ilev(ii(isurf)) = 1;
Q.ilev(ii(ibot)) = nz;

% bin indices in the horizontal
indx = zeros(ny,nx,nz);
indx(:) = 1:m;
Q.indx = zeros(nobs,1)+NaN;
% bin data onto grid
for k = 1:nz
  lev = find(Q.ilev==k);
  ix = indx(:,:,k);
  Q.indx(lev) = interp2(X(:,:,k),Y(:,:,k),ix,x(lev),y(lev),'nearest');
end

% make binning operator
ikeep = find(~isnan(Q.indx));
BIN = sparse(Q.indx(ikeep),ikeep,ones(length(ikeep),1),m,length(Q.indx));
Q.BIN = BIN;

% set up variables to receive binned data
mu = zeros(ny,nx,nz);
n = zeros(ny,nx,nz);
var = zeros(ny,nx,nz);

% bin the data
n(:) = Q.BIN*ones(nobs,1);
mu(:) = Q.BIN*d./n(:);
var(:) = Q.BIN*derr.^2./n(:).^2 + (Q.BIN*(d.^2)./n(:) - mu(:).^2);

% flag grid boxes without data with -9
mu(n==0) = -9;
var(n==0) = -9;
