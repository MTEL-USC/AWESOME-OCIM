function [A,b,output] = decay(A,b,do);
%DECAY removes an element by radioactive decay
%   The decay rate is input in terms of half-life, which is then converted
%   to a first-order decay rate constant according to the radioactive decay
%   equations.

fprintf('%s','decay...')

% load the grid
load ([do.highestpath '/data/ao.mat'])

% unpack the decay constant for your element
halflife = do.decay.halflife;

% convert the half-life into a decay constant
lambda=log(2)/halflife;

% decay your element according to lambda
decayA = speye(ao.nocn,ao.nocn)*lambda;

% make the new A matrix
A = A - decayA;

% package outputs
output.halflife=halflife;
output.decayA=decayA;
output.citations=cell(1,1);