function [A,b,output] = bioredfield(A,b,do)

%BIOREDFIELD sets biological uptake and remineralization
%   Rep is the ratio of uptake of element e compared to P; martinb is the
%   Martin 'b-value'; sedremin determines whether particles which sink out
%   of the bottom grid cell remineralize from the sediments back into that
%   grid cell

fprintf('%s','bioredfield...')

% unpack the key parameters
martinb = do.bioredfield.martinb;
Rep = do.bioredfield.Rep;
sedremin = do.bioredfield.sedremin;

% load the grid and the model output for P uptake (productivity)
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/WJ18/P_UP_WJ18.mat'])

% get the productivity of P (P uptake rate in mmole m-3 y-1)
PPROD = P_UP_WJ18;

% determine the uptake rate of your element
EPROD = PPROD * Rep;
eprod = EPROD(ao.iocn);

% create the b matrix for loss of E by biological uptake
prodb = eprod;

% calculate the depth at the top and bottom of each grid cell
BOXTOP = ao.DEPTH-ao.HEIGHT/2;
BOXBOTTOM = ao.DEPTH+ao.HEIGHT/2;

% zc (compensation depth) is the depth at which particles start to
% remineralize; because the AO assumes productivity in the top two layers,
% there is no particle remineralization in teh top two layers
zc = BOXTOP(1,1,3);

% make a new 'interface depth' shoebox which contains the depths at the
% tops and bottoms of each box (note that this matrix is 91x180x25 because
% it contains the depth at the top of the top box and at the bottom of the
% bottom box)
INTDEPTH = cat(3,BOXTOP,BOXBOTTOM(:,:,24));

% calculate the particle concentration profile as the fraction remaining
% compared to zc; this is the particle concentration at the interfaces
% between between boxes so this matrix is also 91x180x25
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
% to the productivity which occurred in the top grid cell (1,1,1)
EPROD1 = repmat(EPROD(:,:,1),1,1,24); EPROD2 = repmat(EPROD(:,:,2),1,1,24);

% the magnitude of the remineralization is the surface productivity,
% multiplied by the PFD (fraction of that productivity with remineralizes),
% corrected for the height different between the two grid cells
remin1 = EPROD1(ao.iocn).*PFD(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); remin2 = EPROD2(ao.iocn).*PFD(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);

% finally, we build the b matrices for remineralization
reminb = remin1 + remin2;

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
% the top layer (or second layer) multiplied by the fractional amount of particles
% which reach the sediments, corrected for the difference in heights
% between the grid cells
sedremin1 = EPROD1(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); sedremin2 = EPROD2(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);

% and, now we build the b matrices
sedreminb = sedremin1 + sedremin2;

% modify the b matrix for productivity and water-column remineralization
b = b + prodb - reminb;

% modify the b matrix again for sedimentary remineralization if switched on 
if sedremin;
    b = b - sedreminb;
end

% package outputs
output.martinb=martinb;
output.Rep=Rep;
output.sedremin=sedremin;
output.prodb=prodb;
output.reminb=reminb;
if sedremin
    output.sedreminb=sedreminb;
end
output.citations={'biological cycling parameters derived from Thomas Weber, Seth John, Alessandro Tagliabue, and Tim DeVries, Biological uptake and reversible scavenging of zinc in the global ocean, Science, 2018, DOI: 10.1126/science.aap8532.'};