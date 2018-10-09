function [A,b,output] = nonrevscavPOC(A,b,do);
%NONREVSCAVPOC irreversibly scavenges your element onto POC
%   This function will lead to irreversible loss of your element in
%   proportion to the scavenging contant K and the concentration of POC.

fprintf('%s','nonrevscavPOC...')

% load the grid and POC data (units of mmole m-3)
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/WJ18/POC_WJ18.mat'])

% unpack the scavenging equilibrium constant (fraction adsorbed from 0 to 1)
K = do.nonrevscavPOC.K;

% get the POC concentrations from each grid cell
POC = POC_WJ18(ao.iocn);

% calculate the loss of your element as a function of K and POC
loss = K*POC;

% create the A matrix
lossA = speye(ao.nocn,ao.nocn);
lossA(lossA==1)=loss;

% add the A matrix with the new loss to POC
A = A - lossA;

% package outputs
output.K=K;
output.lossA=lossA;
output.citations=cell(1,1);