function [A,b,output] = boundcon(A,b,do);
%BOUNDCON sets a boundary condition based on GEOTRACES sections
%   This function sets boundary conditions based on GEOTRACES observations.
%   For each grid cell which contains GEOTRACES data, the concentration of
%   the element within that grid cell is set equal to the observed
%   concentration. These observed concentrations then propagate outwards
%   from the boundary conditions based on circulation, and they can be
%   modified outside of the boundary conditions by other biogeochemical
%   processes. The mechanism by which boundary conditions are set is
%   similar to how the global ocean concentration is set in the function
%   'conc'. Briefly, a massive flux of the element is specified into the
%   boundary condition grid cells, while the element is lost from those
%   grid cells by extremely rapid decay. This source and decay balance each
%   other exactly so that the concentration within the grid cell matches
%   observations. By setting this source and decay to be very large, they
%   overwhelm any other processes which might influence concentrations
%   within that grid cell.

fprintf('%s','boundcon...')

% load the model grid
load ([do.highestpath '/data/ao.mat'])

% unpack the observed tracer to use as a boundary condition and the mask
% defining the section of interest
tracer = do.boundcon.tracer;
masknames = do.boundcon.masknames;

% load the tracer data
load ([do.highestpath '/data/GEOTRACES_2017_IDP/' tracer '.mat'])
DATA = eval(tracer);
data = DATA(ao.iocn);

% load the GEOTRACES section masks
allmasks = zeros(ao.nocn,1);
for masknames = masknames;
    name = genvarname(char(masknames(1)));
    MASK = eval(['ao.GTmasks.' name]);
    mask = MASK(ao.iocn);
    allmasks = allmasks + mask;
end

% find the positions of grid cells which contain the boundary condition
idata=find(~isnan(data)&allmasks>0);
alldata = data(idata);

% set the timescale (tau) for input and loss of the element from the ocean;
% because this input occurs at fast timescales compared to any other
% process in the ocean, 1 million per year, we refer to it as tauf
tauf=1e-6;

fluxinb = zeros(ao.nocn,1);
fluxinb(idata) = alldata/tauf;

fluxoutA = sparse(idata,idata,1/tauf,ao.nocn,ao.nocn);

b = b - fluxinb;

A = A - fluxoutA;

% package outputs
output.tracer=tracer;
output.masknames=masknames;
output.fluxinb=fluxinb;
output.fluxoutA=fluxoutA;
output.citations={'based on GEOTRACES 2017 Intermediate Data Product observations, please cite accordingly.'};
