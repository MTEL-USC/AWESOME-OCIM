load Hydrothermal_He_flux
load ../../data/ao

flux = zeros(ao.nocn,1);
flux(Hecells) = Heflux;

% convert from mole m-3 y-1 to mmole m-3 y-1
flux = flux*1000;

HEFLUX = ao.nanOCN*0;
HEFLUX(HEFLUX==0) = flux;

save HEFLUX.mat HEFLUX