% This script loads eddy kinetic energy data and converts it into a
% predicted benthic nephloid layer input, then it loads observations of
% nepheloid layer intensity from Alexey Mishonov for a different approach
% to estimating nepheloid layer intensity.

% The EKE data was provided by Yannice Faugere at CLS in France, with
% assistance from Marie-Isabelle Pujol (also at CLS), and Prof. Dudley
% Chelton at OSU. The EKE field will soon be published as: "DUACS DT-2018 :
% 25 years of reprocessed sea level altimeter products." , Taburet et al,
% in prep. This script and any following work which draws heavily upon this
% eke field should also acknowledge CMEMS for the data from which this mean
% were derived as follows: "This study has been conducted using E.U.
% Copernicus Marine Service Information?."

load ../../data/ao

% display all the parameters available in the eke file
% ncdisp('dt_global_allsat_meaneke.nc')

% load the original eke data from CMEMS (in units of cm2 s-2)
eke_DT2018 = ncread('dt_global_allsat_meaneke.nc','mean_eke');
lat_DT2018 = ncread('dt_global_allsat_meaneke.nc','latitude');
lon_DT2018 = ncread('dt_global_allsat_meaneke.nc','longitude');

% first, we need to take the lat and lon vectors, and turn them into square
% matrices the same size as the eke data
[LON_DT2018, LAT_DT2018] = meshgrid(lon_DT2018,lat_DT2018);

% now, same for the AO grid we need square matrices
[LON_AO, LAT_AO] =  meshgrid(ao.lon,ao.lat);

% re-grid for the AO using the interp2 interpolation function, remember
% that data is for surface EKE
eke_surf = interp2(LON_DT2018,LAT_DT2018,eke_DT2018',LON_AO,LAT_AO);

% turn all NaN values in the EKE_surf matrix to zero; it's true that this
% will 'create' EKEs of 0 over land, but more importantly it will fill in
% zero values in places where there is ocean but EKE was not calculated,
% such as near the north pole
eke_surf(isnan(eke_surf))=0;

% propogate the surface eke over the entire water column
EKE_column = repmat(eke_surf,[1,1,24]);

% and now apportion the EKE into the water column according the fractional
% amount of seafloor 
EKE_benthic = EKE_column.*ao.SEAFLOOR;

% and finally convert the units, first by converting cm to m, then by
% multiplying by the area of the grid cell to get the total energy input
% over the column, then dividing by the volume of the grid cell. Benthic
% input is then in weird units of (cm2  calculate the benthic input as
% directly proportional to the EKE divided by the height of the grid cell

% cm to m
EKE_benthic = EKE_benthic/100/100;

% total input per square area
EKE_benthic = EKE_benthic.*(ao.VOL./ao.HEIGHT);

% convert to the flux per volume
NEPH.EKE = EKE_benthic./ao.VOL;




% Now load and process the observational nepheloid concentration data,
% given as the integrated particle concentration over the entire water
% column in units of ug cm-2.

lat_neph = ncread('Net_PM_Integration_over20_-320_720_4Seth_rad25_grid2.nc','Y');
lon_neph = ncread('Net_PM_Integration_over20_-320_720_4Seth_rad25_grid2.nc','X');
neph =  ncread('Net_PM_Integration_over20_-320_720_4Seth_rad25_grid2.nc','Uniform Lattice #0');

% delete the sides of the data (below 0 and above 360)
lon_neph = lon_neph(181:361);
neph = neph(:,181:361);

% delete placeholder values
neph(neph>20000)=0;

% convert from ug cm-2 to ug m-2
neph = neph*100*100;

% interpolate onto the AO grid
% first, we need to take the lat and lon vectors, and turn them into square
% matrices the same size as the eke data
[LON_neph, LAT_neph] = meshgrid(lon_neph,lat_neph);

% now, same for the AO grid we need square matrices
[LON_AO, LAT_AO] =  meshgrid(ao.lon,ao.lat);

% re-grid for the AO using the interp2 interpolation function
obs_surf = interp2(LON_neph,LAT_neph,neph,LON_AO,LAT_AO);

% propogate the surface obs over the entire water column
OBS_column = repmat(obs_surf,[1,1,24]);

% and now apportion the particles into the water column according the
% fractional amount of seafloor
OBS_benthic = OBS_column.*ao.SEAFLOOR;

% and finally calculate the benthic input as directly proportional to
% average flux divided by the box height, for final units of ug m-3
NEPH.OBS = OBS_benthic./ao.HEIGHT;

save NEPH.mat NEPH

figure(1); clf; papersize = [30 10];
set(gcf,'Renderer','opengl', 'color', 'w','InvertHardcopy','off','PaperUnits', 'centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition', [.5 .5 papersize(1)-.5 papersize(2)-.5],'position', [000 800 800 400]);

subplot(1,2,1)
pcolor(ao.lon,ao.lat,obs_surf.*ao.nanOCN(:,:,1)); shading flat; hold on;
set(gca,'color',[0.8 0.8 0.8],'Clim',[0 50000000],'fontsize',10); colorbar
ylabel(colorbar,'Particle concentration (\mug m^{-2})','FontSize',12); xlabel('Longitude'); ylabel('Latitude')

subplot(1,2,2)
pcolor(ao.lon,ao.lat,eke_surf.*ao.nanOCN(:,:,1)); shading flat;
set(gca,'color',[0.8 0.8 0.8],'Clim',[0 2000],'fontsize',10); colorbar
ylabel(colorbar,'Surface EKE (cm^2 s^-2)','FontSize',12); xlabel('Longitude'); ylabel('Latitude')

% pdfname=['/Users/Seth/Desktop/temp/fig.pdf' ]; print('-dpdf','-r600',pdfname); open (pdfname)

figure(2); clf; papersize = [30 10];
set(gcf,'Renderer','opengl', 'color', 'w','InvertHardcopy','off','PaperUnits', 'centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition', [.5 .5 papersize(1)-.5 papersize(2)-.5],'position', [000 800 800 400]);

subplot(1,2,1)
pcolor(ao.lon,ao.lat,nansum(NEPH.OBS,3).*ao.nanOCN(:,:,1)); shading flat; 
set(gca,'color',[0.8 0.8 0.8],'Clim',[0 200000],'fontsize',10);
ylabel(colorbar,'NEPH.OBS (\mug m^{-3})','FontSize',12); xlabel('Longitude'); ylabel('Latitude')

subplot(1,2,2)
pcolor(ao.lon,ao.lat,nansum(NEPH.EKE,3).*ao.nanOCN(:,:,1)); shading flat; 
set(gca,'color',[0.8 0.8 0.8],'Clim',[0 5e-4],'fontsize',10);
colorbar;
ylabel(colorbar,'NEPH.EKE ((m^2 cm^2 s^{-2}) m^{-3})','FontSize',12); xlabel('Longitude'); ylabel('Latitude')

% pdfname=['/Users/Seth/Desktop/temp/fig2.pdf' ]; print('-dpdf','-r600',pdfname); open (pdfname)