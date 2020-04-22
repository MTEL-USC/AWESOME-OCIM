clear all; close all;
load GRID.mat;
load po4_REDI.mat;
load GTmasks.mat;

nocn = 200160; %total number of grid cells containing ocean
OCN=M3d;    %3d grid, with ones in each grid cell which is ocean, and zeros elsewhere
nanOCN=OCN; nanOCN(nanOCN==0)=NaN;  %ones for ocean, NaNs elsewhere
iocn=find(OCN==1);  %1d array including all of the indices (positions) within the 3d array which contain ocean

lat=grid.yt;    %1d array of the models lats
lon=grid.xt;    %1d array of the models lons
depth=grid.zt;  %1d array of the models depths
height=grid.dzt;    %Need to check this.

LAT=grid.YT3d;
LON=grid.XT3d;
DEPTH=grid.ZT3d;
HEIGHT=grid.DZT3d;
VOL=output.grid.VOL;

Lat = LAT(iocn);
Lon = LON(iocn);
Depth = DEPTH(iocn);
Height = HEIGHT(iocn);
Vol = VOL(iocn);

EQNPOS = OCN;
EQNPOS(EQNPOS==1)=1:nocn;

BTM=OCN(:,:,:)-cat(3,OCN(:,:,2:24),zeros(91,180)); 
nanBTM=BTM; nanBTM(nanBTM==0)=NaN;
ibtm=find(BTM==1);
nbtm=size(ibtm);

SURF=cat(3,OCN(:,:,1),zeros(91,180,23));
nanSURF=SURF; nanSURF(nanSURF==0)=NaN;
isurf=find(SURF==1);
nsurf=size(isurf);

% SHELF takes high-resolution bathymetry and uses it to calcualte the
% proportion of bottom in each box. For example, near a continent, the
% model grid might drop from land down to 3000m over the spatial distance
% of a single grid cell. Shelf will provide better resolution here, telling
% you that the bottom is apportioned over many different cells within a
% column, instead of having the 'bottom' occur only at the bottom of the
% grid-column.
SEAFLOOR = SHELF;
Seafloor = SHELF(iocn);

ATL=MSKS.ATL;
PAC=MSKS.PAC;
IND=MSKS.IND;
ARC=MSKS.ARC;
MED=MSKS.MED;

clear grid;
ao.nocn=nocn;
ao.iocn=iocn;
ao.OCN=OCN;
ao.nanOCN=nanOCN;
ao.EQNPOS = EQNPOS;
ao.nbtm=nbtm;
ao.ibtm=ibtm;
ao.BTM=BTM;
ao.nanBTM=nanBTM;
ao.SEAFLOOR=SEAFLOOR;
ao.Seafloor=Seafloor;
ao.nsurf=nsurf;
ao.isurf=isurf;
ao.SURF=SURF;
ao.nanSURF=nanSURF;
ao.lat=lat;
ao.Lat=Lat;
ao.LAT=LAT;
ao.lon=lon;
ao.Lon=Lon;
ao.LON=LON;
ao.depth=depth;
ao.Depth=Depth;
ao.DEPTH=DEPTH;
ao.height=height;
ao.Height=Height;
ao.HEIGHT=HEIGHT;
ao.Vol=Vol;
ao.VOL=VOL;
ao.ATL=ATL;
ao.PAC=PAC;
ao.IND=IND;
ao.ARC=ARC;
ao.MED=MED;
ao.GTmasks=GTmasks;

save ao.mat ao