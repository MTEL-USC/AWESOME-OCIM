function [A,b,output] = conc(A,b,do);
%CONC sets the mean ocean concentration of an element
%   This function sets the mean ocean concentration of your element. The
%   trick here is that you very slowly bleed your element into every box in
%   the ocean on a 'geological' timescale which is much longer than the
%   mixing time of the ocean, such as one million years. Then, you also
%   specify a loss of your element from the ocean with a time constant
%   (decay rate) of the same time constant. The input is so slow that it
%   has no effect on the distribution of your element, but it does set the
%   mean element concentration. A simple example which illustrates this is
%   that if you add 1 mole/year to a 1L  bucket, then lose your element
%   with a decay constant of 1 (mole-1/year), then the concentration in the
%   bucket would have to be 1 mole/L to achieve steady-state. Note that the
%   mathematical approach here is similar to the math for imposing boundary
%   conditions. Also note that this only works if you have no external
%   sources or sinks for your eleemnt, since these would presumably
%   overwhelm this slow geological-timescale input and thus set the mean
%   ocean concentration.

%   Finally, there are very rare cases where this can get you into trouble.
%   Specifically I've found that it's possible to overwhelm other
%   biogeochemical processes which are only represented in the b matrix.
%   For example, if you only have bioredfield uptake/remineralization, and
%   then you choose a concentration of 1,000,000,000,000,000 mmole m-3, the
%   b matrix flux represented below by inputb will overwhelm the changes to
%   b represnted by biolgical uptake and remineralization and result in a
%   nearly homogeneous concentration distribution in the ocean.

fprintf('%s','conc...')

% unpack the mean ocean concentration of your element
c = do.conc.c;

% set the timescale (tau) for input and loss of the element from the ocean (because this input
% occurs on geological timescales we refer to it as taug
taug = 1e6;

% calculate the input of your element to every box at a rate set by the
% concentration divided by a million years
inputb = ones(size(b))*c/taug;

    
% calculate the loss of your element from each box with a decay timescale of a
% million years
lossA = speye(size(A))/taug;

% modify the A abd b matrices
b = b - inputb;
A = A - lossA;

% package outputs
output.c=c;
output.inputb=inputb;
output.lossA=lossA;
output.citations=cell(1,1);
