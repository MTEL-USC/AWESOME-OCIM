function [A,b,output] = bioalpha(A,b,do)

%BIOALPHA sets biological uptake and remineralization
%   martinb is the Martin 'b-value'; alpha is the relative rate constant
%   for uptake of element E compared to P, similar to
%   Elderfield and Rickaby (2000); sedremin determines whether particles
%   which sink out of the bottom grid cell remineralize from the sediments
%   back into that grid cell

fprintf('%s','bioalpha...')

% unpack the key parameters
alpha = do.bioalpha.alpha;
martinb = do.bioalpha.martinb;
sedremin = do.bioalpha.sedremin;

% load the grid and the model output for P uptake (productivity)
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/WJ18/P_UP_WJ18.mat'])
load ([do.highestpath '/data/WJ18/PO4_WJ18.mat'])

% establishO9-P the rate constant for P uptake (where P uptake = KP*[P])
KP = P_UP_WJ18./PO4_WJ18;

% establish the relative uptake rate constant for element E (where E uptake
% is given by uptake = KPROD*[E])
KPROD = KP*alpha;
kprod = KPROD(ao.iocn);

% create the A matrix for loss of E by biological uptake
prodA = sparse(1:ao.nocn,1:ao.nocn,kprod,ao.nocn,ao.nocn);

% calculate the depth at the top and bottom of each grid cell
BOXTOP = ao.DEPTH-ao.HEIGHT/2;
BOXBOTTOM = ao.DEPTH+ao.HEIGHT/2;

% zc (compensation depth) is the depth at which particles start to
% remineralize; because the AO assumes productivity in the top two layers,
% there is no particle remineralization in the top two layers
zc = BOXTOP(1,1,3);

% make a new 'interface depth' shoebox which contains the depths at the
% tops and bottoms of each box (note that this matrix is nlat x nlon x (ndepth+1) because
% it contains the depth at the top of the top box and at the bottom of the
% bottom box)
INTDEPTH = cat(3,BOXTOP,BOXBOTTOM(:,:,length(ao.depth)));

% calculate the particle concentration profile as the fraction remaining
% compared to zc; this is the particle concentration at the interfaces
% between boxes so this matrix is also nlat x nlon x (ndepth+1)
PARTICLES = (INTDEPTH./zc).^-martinb;

% calculate the particle flux divergence (PFD), which is the difference
% between the amount of particles present at the top of the grid cell
% compared to at the bottom of the grid cell; this is of course equal to
% the particle dissolution which occurred within that grid cell; note that
% we are continuing to express everything about particles in terms of their
% fractional abundance compared to the abundance at zc
PFD = -diff(PARTICLES,1,3);

% no particles dissolve in the top two layers, so set the PFD here to zero
PFD(:,:,1:2)=0;

% set the PFD to zero wherever there is not ocean
PFD = PFD.*ao.OCN;

% because productivity occurs in the top two layers, we are going to
% calculate two different A matrices, one which describes the
% remineralization of element E based on biological productivity which
% occurred in the top layer, and then again similarly for the second layer

% create a shoebox containing the productivity rate constants to which
% remineralization is related; for example when considering the
% remineralization which occurs in grid-column (1,1,:), the
% remineralization at every depth within that grid-column will be related
% to the productivity which occurred in the top grid cell (1,1,1), and
% seprarately to the productivity which occurred in grid cell (1,1,2)
KPROD1 = repmat(KPROD(:,:,1),1,1,length(ao.depth)); KPROD2 = repmat(KPROD(:,:,2),1,1,length(ao.depth));

% similarly, the equation position (column in the A matrix) for every grid
% cell in the water column (1,1,:) will depend on the equation position of
% the top grid cell (1,1,1) from which particles originate
FROM1 = repmat(ao.EQNPOS(:,:,1),1,1,length(ao.depth)); FROM2 = repmat(ao.EQNPOS(:,:,2),1,1,length(ao.depth));
from1 = FROM1(ao.iocn); from2 = FROM2(ao.iocn);

% the equation position (row in the A matrix) in which we slot the
% remineralization depends on the equation position of the cell to which
% particles go
TO1 = ao.EQNPOS; TO2 = ao.EQNPOS;
to1 = TO1(ao.iocn); to2 = TO2(ao.iocn);

% the magnitude of the remineralization is the surface productivity,
% multiplied by the PFD (fraction of that productivity with remineralizes),
% corrected for the height different between the two grid cells
remin1 = KPROD1(ao.iocn).*PFD(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); remin2 = KPROD2(ao.iocn).*PFD(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);

% finally, we build the sparse A matrices for remineralization 
remin1A = sparse(to1,from1,remin1,ao.nocn,ao.nocn); remin2A = sparse(to2,from2,remin2,ao.nocn,ao.nocn);


% now we follow a similar process to determine how much of the surface
% productivity will reach the sediments, where it will be delivered back to
% the bottom grid cell if sedremin is turned on

% PBTM is the amount of particles at the bottom boundary of each grid cell
% (again defined as the fractionational amount compared to zc)
PBTM = PARTICLES(:,:,2:25);

% for cells which lie at the bottom of the ocean, the particles at the
% bottom boundary become the remineralization flux back into that cell
SEDREMIN = ao.nanOCN*0;
SEDREMIN(ao.ibtm)=PBTM(ao.ibtm);

% the magnitude of sedimentary remineralization depends on productivity in
% the top layer (or second layer) multiplied by the fractional amount of
% particles which reach the sediments, corrected for the difference in
% heights between the grid cells
sedremin1 = KPROD1(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); sedremin2 = KPROD2(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);

% and, now we build the A matrices
sedremin1A = sparse(to1,from1,sedremin1,ao.nocn,ao.nocn); sedremin2A = sparse(to2,from2,sedremin2,ao.nocn,ao.nocn);

% modify the A matrix for productivity and water-column remineralization
A = A - prodA + remin1A + remin2A;

% modify the A matrix again for sedimentary remineralization if switched on 
if sedremin;
    A = A + sedremin1A + sedremin2A;
end

% package outputs
output.alpha=alpha;
output.martinb=martinb;
output.sedremin=sedremin;
output.prodA=prodA;
output.remin1A=remin1A;
output.remin2A=remin2A;
if sedremin
    output.sedremin1A=sedremin1A;
    output.sedremin2A=sedremin2A;
end
output.citations={'biological cycling parameters derived from Thomas Weber, Seth John, Alessandro Tagliabue, and Tim DeVries, Biological uptake and reversible scavenging of zinc in the global ocean, Science, 2018, DOI: 10.1126/science.aap8532.'};