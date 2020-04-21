close all; clear all;

load ../../data/ao.mat;
load PO4_CTL;

P_UP_WJ18 = ao.OCN;
P_UP_WJ18(ao.iocn)=output.Flux.Jup;

P_REM_WJ18 = ao.OCN;
P_REM_WJ18(ao.iocn)=output.Flux.Jrem;

PO4_WJ18 = ao.OCN;

PO4_WJ18(ao.iocn)=output.po4;

DOP_WJ18 = ao.OCN;

DOP_WJ18(ao.iocn)=output.dop;

save P_UP_WJ18.mat P_UP_WJ18

save P_REM_WJ18.mat P_REM_WJ18

save PO4_WJ18.mat PO4_WJ18

save DOP_WJ18.mat DOP_WJ18