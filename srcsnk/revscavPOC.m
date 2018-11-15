function [A,b,output] = revscavPOC(A,b,do);
%REVSCAVPOC scavenges your element downwards by reversible scavenging
%   This function adds reversible scavenging of your element. It is based
%   on the assumption that your element scavenges onto POC. Thus,
%   scavenging is set by the equilibrium constant multiplied by the POC
%   concentration. The sinking rate w and the equilibrium scavenging
%   constant K have an exact inverse impact on sinking rate; that is to say
%   that doubling K while halving w will result in the same overall sinking
%   of your element (because twice as much of the element is sinking half
%   as fast). Note that the adsorbed particulate concentration of your
%   element is implicit, but is not explicitly calculated by this function;
%   meaning that this function only concerns itself with the concentration
%   of dissolved species and the movement of dissolved species between grid
%   cells by scavenging, without ever creating an explicit tracer which
%   records the adsorbed concentration of your element. Sedremin determines
%   whether or not adsorbed element which sinks out of the bottom grid cell
%   is released from the sediments back into that grid cell.

fprintf('%s','revscavPOC...')

% load the grid and POC data (units of mmole m-3)
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/WJ18/POC_WJ18.mat'])

% unpack the scavenging rate constant
K = do.revscavPOC.K;
w = do.revscavPOC.w;
sedremin = do.revscavPOC.sedremin;

% get the POC concentrations from each grid cell
POC = POC_WJ18(ao.iocn);

% the amount of element E which sinks out depends on the equilibrium
% scavenging constant, multiplied by the POC concentration, times the
% sinking rate divided by the height of the grid cell
sinkout = K*POC.*(w./ao.Height);

% find the equation position (positions in the A matrix) of the grid cells
% which lie below each cell
EQNPOSBELOW = cat(3,ao.EQNPOS(:,:,2:ao.ndepth),zeros(ao.nlat,ao.nlon,1));

% define the equation positions that particles are sinking from, as well as
% the volumes and heights of those grid cells
frompos = ao.EQNPOS(EQNPOSBELOW~=0);
fromvol = ao.Vol(frompos);
fromheight = ao.Height(frompos);

% define the equation positions that particles are sinking to, as well as
% the volumes and heights of those grid cells
topos = EQNPOSBELOW(EQNPOSBELOW~=0);
tovol = ao.Vol(topos);

% create the sinkout A matrix, and fill in the diagonal with the magnitude
% of the sinking flux out
sinkoutA = speye(ao.nocn,ao.nocn);
sinkoutA(sinkoutA==1)=sinkout;

% calculate the amount of element transferred into each grid cell by
% sinking with K, the sinking rate devided by the grid cell height from
% which sinking occurs, and a correction for volume
sinkin = sinkout(frompos).*(fromvol./tovol);

% create the A matrix for sinking in
sinkinA = sparse(topos,frompos,sinkin,ao.nocn,ao.nocn);

% find the equation positions of cells which lie on the bottom, and the
% amount of reminerlization there is equal to the amount which sinks out of
% that grid cell
btmeqnpos = ao.EQNPOS(ao.ibtm);
sedreminA = sparse(btmeqnpos,btmeqnpos,sinkout(btmeqnpos),ao.nocn,ao.nocn);

% add the A matrix with the sinking matrices
A = A - sinkoutA + sinkinA;

% add sedimentary remineralization if switched on
if sedremin
    A = A + sedreminA;
end

% package outputs
output.K=K;
output.w=w;
output.sinkoutA=sinkoutA;
output.sinkinA=sinkinA;
if sedremin
    output.sedreminA=sedreminA;
end
output.citations=cell(1,1);