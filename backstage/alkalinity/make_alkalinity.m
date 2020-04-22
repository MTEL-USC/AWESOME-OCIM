% alkalinity data originally from glodap, then gridded to the OCIM grid by
% Tom Weber; here I'm just re-naming few of the variables; the 'filled' in
% Alk_filled refers to the fact that the original glodap data sometimes did
% not have data in places where the OCIM has ocean (for example near
% continental margins), so the filled data just extrapolates into those
% boxes so that every ocean box of the OCIM has Alk data

load glodap_carbon_ocim

GLODAPALK = Alk_filled;

GLODAPDIC = Dic_filled;

save GLODAPALK.mat GLODAPALK
save GLODAPDIC.mat GLODAPDIC