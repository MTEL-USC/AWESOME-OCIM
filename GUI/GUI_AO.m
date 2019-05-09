function varargout = GUI_AO(varargin)
% GUI_AO MATLAB code for GUI_AO.fig
%
%      GUI_AO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_AO.M with the given input arguments.
%
%      GUI_AO('Property','Value',...) creates a new GUI_AO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_AO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_AO_OpeningFcn via varargin.
%



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_AO_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_AO_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_AO is made visible.
function GUI_AO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_AO (see VARARGIN)

% Choose default command line output for GUI_AO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_AO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_AO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Set ocean mean concentration (y/n)
function checkbox1_Callback(hObject, eventdata, handles)

% Input ocean mean concentration of your element (μmole m-3)
function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Run boundary condition based on GEOTRACES sections (y/n)
function checkbox2_Callback(hObject, eventdata, handles)

% Set a tracer to use as a boundary condition
% Input the tracer name
function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Choose a mask to define the GEOTRACES section of interest as boundary condition
% Input the GEOTRACES section masks' name
function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set radioactive decay (y/n)
function checkbox3_Callback(hObject, eventdata, handles)

% Input the half-life of your element
function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set hydrothermal source (y/n)
function checkbox4_Callback(hObject, eventdata, handles)

% Input the E/He ratio
function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set bio_alpha : biological uptake and remineralization (y/n)
function checkbox5_Callback(hObject, eventdata, handles)

% Do alpha (alpha is the relative rate constant for uptake of element E compared to P)
% Set alpha value
function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set Martin 'b-value'
function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Whether particles which sink out of the bottom grid cell remineralize from the sediments back into that grid cell (y/n)
% Set bioalpha.sedremin
% on
function radiobutton16_Callback(hObject, eventdata, handles)
set(handles.radiobutton16,'value',1);
set(handles.radiobutton17,'value',0);
% off
function radiobutton17_Callback(hObject, eventdata, handles)
set(handles.radiobutton16,'value',0);
set(handles.radiobutton17,'value',1);

% Set Bio_Redfield (y/n)
function checkbox6_Callback(hObject, eventdata, handles)

% Do Rep (the ratio of uptake of element E compared to P) (y/n)
function edit9_Callback(hObject, eventdata, handles)

function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set Martin 'b-value'
function edit10_Callback(hObject, eventdata, handles)

function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set bioredfield.sedremin
% on
function radiobutton18_Callback(hObject, eventdata, handles)
set(handles.radiobutton18,'value',1);
set(handles.radiobutton19,'value',0);
% off
function radiobutton19_Callback(hObject, eventdata, handles)
set(handles.radiobutton18,'value',0);
set(handles.radiobutton19,'value',1);

% Add reversible scavenging of your element (y/n)
function checkbox7_Callback(hObject, eventdata, handles)

% Set scavenging equilibrium constant (fraction adsorbed from 0 to 1)
function edit12_Callback(hObject, eventdata, handles)

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set sinking rate (m/y)
function edit13_Callback(hObject, eventdata, handles)

function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Do remineralization from sediments 
% on
function radiobutton22_Callback(hObject, eventdata, handles)
set(handles.radiobutton22,'value',1);
set(handles.radiobutton23,'value',0);
% off
function radiobutton23_Callback(hObject, eventdata, handles)
set(handles.radiobutton22,'value',0);
set(handles.radiobutton23,'value',1);

% Do reversible scavenging when your element scavenges onto POC. (y/n)
% Thus, scavenging is set by the equilibrium constant multiplied by the POC concentration.
function checkbox8_Callback(hObject, eventdata, handles)

% Set scavenging equilibrium constant K (fraction adsorbed from 0 to 1)
function edit15_Callback(hObject, eventdata, handles)

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set sinking rate (m/y)
function edit16_Callback(hObject, eventdata, handles)

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Do remineralization from sediments
% on
function radiobutton20_Callback(hObject, eventdata, handles)
set(handles.radiobutton20,'value',1);
set(handles.radiobutton21,'value',0);
% off
function radiobutton21_Callback(hObject, eventdata, handles)
set(handles.radiobutton20,'value',0);
set(handles.radiobutton21,'value',1);

% Do irreversible scavenging onto POC (y/n)
function checkbox9_Callback(hObject, eventdata, handles)

% Do scavenging equilibrium constant (fraction adsorbed from 0 to 1)
function edit18_Callback(hObject, eventdata, handles)

function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Do nepheloid source (y/n)
function checkbox10_Callback(hObject, eventdata, handles)

% Set the E/He input ratio
function edit19_Callback(hObject, eventdata, handles)
    
function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Do dust: adds a source of your element from aerosols (y/n)
function checkbox11_Callback(hObject, eventdata, handles)

% Add a source from fire (y/n)
function checkbox12_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total fire aerosols (μmole/mg)
function edit20_Callback(hObject, eventdata, handles)

function edit20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from biofuel (y/n)
function checkbox13_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total biofuel aerosols (μmole/mg)
function edit21_Callback(hObject, eventdata, handles)

function edit21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from fossile fuel (y/n)
function checkbox14_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total fossil fuel aerosols (μmole/mg)
function edit22_Callback(hObject, eventdata, handles)

function edit22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from mineral dust (y/n)
function checkbox15_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total mineral aerosols (μmole/mg)
function edit23_Callback(hObject, eventdata, handles)

function edit23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from seasalt (y/n)
function checkbox16_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total seasalt aerosols (μmole/mg)
function edit24_Callback(hObject, eventdata, handles)

function edit24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from plants (y/n)
function checkbox17_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total plant aerosols (μmole/mg)
function edit25_Callback(hObject, eventdata, handles)

function edit25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Add a source from volcanic aerosols (y/n)
function checkbox18_Callback(hObject, eventdata, handles)

% Set the ratio of your element to total volcanic aerosols (μmole/mg)
function edit26_Callback(hObject, eventdata, handles)

function edit26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Plot the distribution at a certain depth
function edit27_Callback(hObject, eventdata, handles)

function edit27_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Input filename
function edit28_Callback(hObject, eventdata, handles)

function edit28_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Run AwesomeOCIM based on all these conditions
function pushbutton1_Callback(hObject, eventdata, handles)
do.conc.on=get(handles.checkbox1,'value');
do.boundcon.on=get(handles.checkbox2,'value');
do.decay.on=get(handles.checkbox3,'value');
do.hydrothermal.on=get(handles.checkbox4,'value');
do.bioalpha.on=get(handles.checkbox5,'value');
do.bioredfield.on=get(handles.checkbox6,'value');
do.revscav.on=get(handles.checkbox7,'value');
do.revscavPOC.on=get(handles.checkbox8,'value');
do.nonrevscavPOC.on=get(handles.checkbox9,'value');
do.nephloid.on=get(handles.checkbox10,'value');
do.dust.on=get(handles.checkbox11,'value');

if get(handles.checkbox1,'value')
    do.conc.c=str2double(get(handles.edit1,'String'));
end
if get(handles.checkbox2,'value')
    tracer=get(handles.edit2,'String');
    do.boundcon.tracer=strcat('GT',tracer);
    do.boundcon.masknames = {get(handles.edit3,'String')};
end
if get(handles.checkbox3,'value')
    do.decay.halflife=str2double(get(handles.edit4,'String'));
end
if get(handles.checkbox4,'value')
    do.hydrothermal.K=str2double(get(handles.edit5,'String'));
end
if get(handles.checkbox5,'value')
    do.bioalpha.alpha=str2double(get(handles.edit6,'String'));
    do.bioalpha.martinb=str2double(get(handles.edit7,'String'));
    % if sedremin is not on (off or none), then the value is 0
    do.bioalpha.sedremin=get(handles.radiobutton16,'value');
end
if get(handles.checkbox6,'value')
    do.bioredfield.Rep=str2double(get(handles.edit9,'String'));
    do.bioredfield.martinb=str2double(get(handles.edit10,'String'));
    do.bioredfield.sedremin=get(handles.radiobutton18,'value');
end
if get(handles.checkbox7,'value')
    do.revscav.K=str2double(get(handles.edit12,'String'));
    do.revscav.w=str2double(get(handles.edit13,'String'));
    do.revscav.sedremin=get(handles.radiobutton22,'value');
end
if get(handles.checkbox8,'value')
    do.revscavPOC.K=str2double(get(handles.edit15,'String'));
    do.revscavPOC.w=str2double(get(handles.edit16,'String'));
    do.revscavPOC.sedremin=get(handles.radiobutton20,'value');
end
if get(handles.checkbox9,'value')
    do.nonrevscavPOC.K=str2double(get(handles.edit18,'String'));
end
if get(handles.checkbox10,'value')
    do.nephloid.K=str2double(get(handles.edit19,'String'));
end
do.dust.fire=get(handles.checkbox12,'value');
do.dust.Rfire=str2double(get(handles.edit20,'String'));
do.dust.biofuel=get(handles.checkbox13,'value');
do.dust.Rbiofuel=str2double(get(handles.edit21,'String'));
do.dust.fossilfuel=get(handles.checkbox14,'value');
do.dust.Rfossilfuel=str2double(get(handles.edit22,'String'));
do.dust.mineral=get(handles.checkbox15,'value');
do.dust.Rmineral=str2double(get(handles.edit23,'String'));
do.dust.seasalt=get(handles.checkbox16,'value');
do.dust.Rseasalt=str2double(get(handles.edit24,'String'));
do.dust.plants=get(handles.checkbox17,'value');
do.dust.Rplants=str2double(get(handles.edit25,'String'));
do.dust.volcanic=get(handles.checkbox18,'value');
do.dust.Rvolcanic=str2double(get(handles.edit26,'String'));

filename=get(handles.edit28,'String');
if ~isdir('output')
    error('You are now in the wrong directory.You should run the GUI from the AO main folder');
end
do.highestpath=pwd;
addpath srcsnk; addpath GUI;
load data/ao
Awesome (filename,do);

% Now switch to the plotting GUI
% Make each radiobutton exclusive so that only one button can be active. 

% Choose: plot model output
function radiobutton24_Callback(hObject, eventdata, handles)
set(handles.radiobutton24,'value',1);
set(handles.radiobutton25,'value',0);

% Choose: plot GEOTRACES data
function radiobutton25_Callback(hObject, eventdata, handles)
set(handles.radiobutton24,'value',0);
set(handles.radiobutton25,'value',1);

% Input GEOTRACES tracer name for plotting
function edit37_Callback(hObject, eventdata, handles)

function edit37_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Composite profile
function radiobutton1_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',1);
set(handles.radiobutton5,'value',0);
for i=9:13
    id=strcat('radiobutton',int2str(i)); set(handles.(id),'value',0);
end

% Composite profile -- Atlantic
function radiobutton2_Callback(hObject, eventdata, handles)
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',0);

% Composite profile -- Pacific
function radiobutton3_Callback(hObject, eventdata, handles)
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);

% Composite profile -- Global
function radiobutton4_Callback(hObject, eventdata, handles)
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',1);

% Composite section
function radiobutton5_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',1);
for i=9:13
    id=strcat('radiobutton',int2str(i)); set(handles.(id),'value',0);
end

% Composite section -- Atlantic
function radiobutton6_Callback(hObject, eventdata, handles)
set(handles.radiobutton6,'value',1);
set(handles.radiobutton7,'value',0);
set(handles.radiobutton8,'value',0);

% Composite section -- Pacific
function radiobutton7_Callback(hObject, eventdata, handles)
set(handles.radiobutton6,'value',0);
set(handles.radiobutton7,'value',1);
set(handles.radiobutton8,'value',0);

% Composite section -- Global
function radiobutton8_Callback(hObject, eventdata, handles)
set(handles.radiobutton6,'value',0);
set(handles.radiobutton7,'value',0);
set(handles.radiobutton8,'value',1);

% Meridional section
function radiobutton9_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',0);
set(handles.radiobutton9,'value',1);
for i=10:13
    id=strcat('radiobutton',int2str(i)); set(handles.(id),'value',0);
end

% Input a longitude for plotting meridional section
function edit29_Callback(hObject, eventdata, handles)

function edit29_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Zonal section
function radiobutton10_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',0);
set(handles.radiobutton9,'value',0);
set(handles.radiobutton10,'value',1);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton12,'value',0);
set(handles.radiobutton13,'value',0);

% Input a latitude for plotting zonal section
function edit30_Callback(hObject, eventdata, handles)

function edit30_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Single lat/lon profile
function radiobutton11_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',0);
set(handles.radiobutton9,'value',0);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton11,'value',1);
set(handles.radiobutton12,'value',0);
set(handles.radiobutton13,'value',0);

% Input a latitude for plotting lat/lon profile
function edit31_Callback(hObject, eventdata, handles)

function edit31_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Input a longitude for plotting lat/lon profile
function edit32_Callback(hObject, eventdata, handles)

function edit32_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Plot the distribution from above at a certain depth
function radiobutton12_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',0);
set(handles.radiobutton9,'value',0);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton12,'value',1);
set(handles.radiobutton13,'value',0);

% Input a depth (in meters) to view distribution
function edit33_Callback(hObject, eventdata, handles)

function edit33_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Plot GEOTRACES section
function radiobutton13_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton5,'value',0);
set(handles.radiobutton9,'value',0);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton12,'value',0);
set(handles.radiobutton13,'value',1);

% Input a GEOTRACES section name 
function edit34_Callback(hObject, eventdata, handles)

function edit34_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Choose GT section orientation -- NS
function radiobutton14_Callback(hObject, eventdata, handles)
set(handles.radiobutton14,'value',1);
set(handles.radiobutton15,'value',0);

% Choose GT section orientation -- EW
function radiobutton15_Callback(hObject, eventdata, handles)
set(handles.radiobutton14,'value',0);
set(handles.radiobutton15,'value',1);

% Set limits range for plotting 
function checkbox19_Callback(hObject, eventdata, handles)

% Set the minimum limit
function edit35_Callback(hObject, eventdata, handles)

function edit35_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set the maximum limit
function edit36_Callback(hObject, eventdata, handles)

function edit36_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Do the plotting GUI
function pushbutton2_Callback(hObject, eventdata, handles)
highestpath = pwd;
addpath(genpath(pwd));
load data/ao
if ~isdir('output')
    error('You are now in the wrong directory.You should run the GUI from the AO main folder');
end
tracer=get(handles.edit2,'String');
GTtracer=get(handles.edit37,'String');
filename=get(handles.edit28,'String');
doLIMITS=get(handles.checkbox19,'value');
lowlim=str2double(get(handles.edit35,'String'));
highlim=str2double(get(handles.edit36,'String'));

if get(handles.radiobutton24,'value')
    modelDATA=importdata([highestpath '/output/' filename '.mat']);
    DATA=modelDATA.E;
elseif get(handles.radiobutton25,'value')
    GTtracer=strcat('GT',GTtracer);
    DATA=importdata([highestpath '/data/GEOTRACES_2017_IDP/' GTtracer '.mat']);
end

figure(2);clf;
% Composite profile
if get(handles.radiobutton1,'value')
    if get(handles.radiobutton2,'value')
        GUIplotting(DATA,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    elseif get(handles.radiobutton3,'value')
        GUIplotting(DATA,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    elseif get(handles.radiobutton4,'value')
        GUIplotting(DATA,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    end
end
% Composite section
if get(handles.radiobutton5,'value')
    if get(handles.radiobutton6,'value')
        GUIplotting(DATA,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    elseif get(handles.radiobutton7,'value')
        GUIplotting(DATA,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    elseif get(handles.radiobutton8,'value')
        GUIplotting(DATA,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim);
    end
end
% Meridional section
if get(handles.radiobutton9,'value')
    meridion=str2double(get(handles.edit29,'String'));
    GUIplotting(DATA,0,0,0,0,0,0,0,0,0,1,meridion,0,0,0,0,0,doLIMITS,lowlim,highlim);
end
% Zonal section
if get(handles.radiobutton10,'value')
    zone=str2double(get(handles.edit30,'String'));
    GUIplotting(DATA,0,0,0,0,0,0,0,0,0,0,0,1,zone,0,0,0,doLIMITS,lowlim,highlim);
end
% Single lat/lon profile
if get(handles.radiobutton11,'value')
    lat=str2double(get(handles.edit31,'String'));
    lon=str2double(get(handles.edit32,'String'));
    GUIplotting(DATA,0,0,0,1,lat,lon,0,0,0,0,0,0,0,0,0,0,doLIMITS,lowlim,highlim)
end
% View distribution plot at a certain depth
if get(handles.radiobutton12,'value')
    depthAT=str2double(get(handles.edit33,'String'));
    ALLtop=ao.depth-ao.height/2;
    ALLbtm=ao.depth+ao.height/2;
    for i=1:length(ao.depth)
        if depthAT>=ALLtop(i) && depthAT<ALLbtm(i)
            layer=i;
        end
    end
    pcolor(ao.lon,ao.lat,DATA(:,:,layer)); shading flat;
    if get(handles.checkbox19,'value')
        caxis([lowlim,highlim]);
    end
    colorbar;
end
% GEOTRACES section
if get(handles.radiobutton13,'value')
    sectionname=get(handles.edit34,'String');
    if get(handles.radiobutton14,'value'); orientation=1;
    elseif get(handles.radiobutton15,'value'); orientation=2; end
    GUIplotting(DATA,0,0,0,0,0,0,0,0,0,0,0,0,0,1,sectionname,orientation,doLIMITS,lowlim,highlim);
end

% Add logo picture and sets it transparent
function axes1_CreateFcn(hObject, eventdata, handles)
X=imread('AO logo.png');
h=imshow(X);
F=size(X);
G=ones(F(1),F(2));
G(X(:,:,1)<1)=0;
set(gca,'visible','off','color','none');
set(h, 'AlphaData', G);
