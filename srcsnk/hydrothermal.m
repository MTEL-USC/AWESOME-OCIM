function [A,b,output] = hydrothermal(A,b,do);
%HYDROTHERMAL adds a flux of your element from hydrothermal vents
%   This creates a flux of your element into the ocean in proportion to
%   the flux of hydrothermal He into the ocean. The flux of He into the
%   ocean was determined by OCIM inverse modeling as outlined in DeVries and Holzer (in prep).
%   Units of He flux are mmole m-3 y-1, and thus the flux of element E is
%   is set by K, the ratio of E input to He input in units of (mmole m-1
%   y-1)(mmole m-1 y-1)-1.

fprintf('%s','hydrothermal...')

% load the grid and the He flux data
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/HEFLUX.mat'])

% unpack the E/He input ratio
K = do.hydrothermal.K;

% calculate the hydrothermal flux of your element in each grid cell
SOURCE = HEFLUX*K;

% turn the shoebox into a linear vector
sourceb = SOURCE(ao.iocn);

% add the hydrothermal flux (remember, when something is added to the rhs
% of an equation, it winds up subtraced from the lhs)
b = b - sourceb;

% package outputs
output.K=K;
output.sourceb=sourceb;
output.citations={'hydrothermal input fields from DeVries and Holzer, in prep.'};
