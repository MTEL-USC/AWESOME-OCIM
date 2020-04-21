% This script takes data from the Mahowald lab about deposition of various
% types of aerosols, and re-grids them as input functions for the AO.
% According to the readme provided with this data:
%
% Description
% 
% Deposition by month for aerosols used in Brahney et al., 2015; Chien et al., 2016
% 
% there are 7 types of aerosols:
% 1: Fires (Black Carbon)
% 2: Biofuels (Black Carbon)
% 3: Fossil Fuel (Black Carbon)
% 4. Dust
% 5. Seasalts
% 6. primary biogenic particles
% 7. Volcanoes (S)
% 
% Deposition for each month is in units of kg/m2/s

% ncdisp('post.aerosols.2x2.seasonal.nc');

lat_mahowald = ncread('post.aerosols.2x2.seasonal.nc','lat');
lon_mahowald = ncread('post.aerosols.2x2.seasonal.nc','lon');
dep = ncread('post.aerosols.2x2.seasonal.nc','dep');

% convert to units of mg/m3/y over the surface box
load ../../data/ao.mat
dep = dep*60*60*24*365.25; %kg m-2 y-1
dep = dep*1e6; %mg m-2 y-1
dep = dep/ao.height(1); %mg m-3 y-1

% add in another row of data to Mahowald data at a longitude of 360 (which
% is identical to the data which was at 0) so that interp2 can interpolate
% at the highest longitude
lon_mahowald = [lon_mahowald;360];
dep = cat(1,dep,dep(1,:,:));

dust_dep_fire = dep(:,:,1)';
dust_dep_biofuel = dep(:,:,2)';
dust_dep_fossilfuel = dep(:,:,3)';
dust_dep_mineraldust = dep(:,:,4)';
dust_dep_seasalt = dep(:,:,5)';
dust_dep_plants = dep(:,:,6)';
dust_dep_volcanic = dep(:,:,7)';

% interpolate onto the AO grid
% first, we need to take the lat and lon vectors, and turn them into square
% matrices the same size as the eke data
[LON_mahowald, LAT_mahowald] = meshgrid(lon_mahowald,lat_mahowald);

% now, same for the AO grid we need square matrices
[LON_AO, LAT_AO] =  meshgrid(ao.lon,ao.lat);

% re-grid for the AO using the interp2 interpolation function
dust_dep_fire = interp2(LON_mahowald,LAT_mahowald,dust_dep_fire,LON_AO,LAT_AO);
dust_dep_biofuel = interp2(LON_mahowald,LAT_mahowald,dust_dep_biofuel,LON_AO,LAT_AO);
dust_dep_fossilfuel = interp2(LON_mahowald,LAT_mahowald,dust_dep_fossilfuel,LON_AO,LAT_AO);
dust_dep_mineraldust = interp2(LON_mahowald,LAT_mahowald,dust_dep_mineraldust,LON_AO,LAT_AO);
dust_dep_seasalt = interp2(LON_mahowald,LAT_mahowald,dust_dep_seasalt,LON_AO,LAT_AO);
dust_dep_plants = interp2(LON_mahowald,LAT_mahowald,dust_dep_plants,LON_AO,LAT_AO);
dust_dep_volcanic = interp2(LON_mahowald,LAT_mahowald,dust_dep_volcanic,LON_AO,LAT_AO);

% make the shoeboxes (dust only goes into the top layer)
FIRE = ao.OCN*0; FIRE(:,:,1) = dust_dep_fire;
BIOFUEL = ao.OCN*0; BIOFUEL(:,:,1) = dust_dep_biofuel;
FOSSILFUEL = ao.OCN*0; FOSSILFUEL(:,:,1) = dust_dep_fossilfuel;
MINERAL = ao.OCN*0; MINERAL(:,:,1) = dust_dep_mineraldust;
SEASALT = ao.OCN*0; SEASALT(:,:,1) = dust_dep_seasalt;
PLANTS = ao.OCN*0; PLANTS(:,:,1) = dust_dep_plants;
VOLCANIC = ao.OCN*0; VOLCANIC(:,:,1) = dust_dep_volcanic;

AEROSOLDEP.FIRE = FIRE;
AEROSOLDEP.BIOFUEL = BIOFUEL;
AEROSOLDEP.FOSSILFUEL = FOSSILFUEL;
AEROSOLDEP.MINERAL = MINERAL;
AEROSOLDEP.SEASALT = SEASALT;
AEROSOLDEP.PLANTS = PLANTS;
AEROSOLDEP.VOLCANIC = VOLCANIC;

save AEROSOLDEP.mat AEROSOLDEP

figure(1); clf;
papersize = [40 20]; screenpos = [0 0 1000 400];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits', 'centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition', [1 1 papersize(1)-1 papersize(2)-1],'position', [screenpos(1) screenpos(2) screenpos(3) screenpos(4)]);

subplot(2,4,1)
pcolor(ao.lon,ao.lat,log10(dust_dep_fire.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('fire')

subplot(2,4,2)
pcolor(ao.lon,ao.lat,log10(dust_dep_biofuel.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('biofuel')

subplot(2,4,3)
pcolor(ao.lon,ao.lat,log10(dust_dep_fossilfuel.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('fossilfuel')

subplot(2,4,4)
pcolor(ao.lon,ao.lat,log10(dust_dep_mineraldust.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('mineraldust')

subplot(2,4,5)
pcolor(ao.lon,ao.lat,log10(dust_dep_seasalt.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('seasalt')

subplot(2,4,6)
pcolor(ao.lon,ao.lat,log10(dust_dep_plants.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar
title('plants')

subplot(2,4,7)
pcolor(ao.lon,ao.lat,log10(dust_dep_volcanic.*ao.nanOCN(:,:,1))); shading flat;
set(gca,'Clim',[-3 4]); colorbar,
title('volcanic')

subplot(2,4,8)
set(gca,'xcolor','none','ycolor','none')
text(0,0.5, {'log 10 of dust';'deposition rates';'(mg/m3/y)'},'Color','red','FontSize',18)


% pdfname=['/Users/Seth/Desktop/temp/dustmaps.pdf' ]; print('-dpdf','-r300',pdfname); open (pdfname)
