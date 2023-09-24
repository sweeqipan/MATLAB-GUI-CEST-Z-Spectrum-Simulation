% 27/06/2012


% Known Issues
% 1) Problem with the negative magnetization

% Notes
% 1) Set the relaxation values for different B0
% 2) Assuming all the transverse magnetizations (x & y) are set to zero during the readout/delay.
% 3) 


function varargout = ParametricStudy(varargin)
% PARAMETRICSTUDY MATLAB code for ParametricStudy.fig
%      PARAMETRICSTUDY, by itself, creates a new PARAMETRICSTUDY or raises the existing
%      singleton*.
%
%      H = PARAMETRICSTUDY returns the handle to a new PARAMETRICSTUDY or the handle to
%      the existing singleton*.
%
%      PARAMETRICSTUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETRICSTUDY.M with the given input arguments.
%
%      PARAMETRICSTUDY('Property','Value',...) creates a new PARAMETRICSTUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ParametricStudy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ParametricStudy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to menu_about ParametricStudy

% Last Modified by GUIDE v2.5 12-Sep-2014 13:48:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ParametricStudy_OpeningFcn, ...
                   'gui_OutputFcn',  @ParametricStudy_OutputFcn, ...
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


% --- Executes just before ParametricStudy is made visible.
function ParametricStudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ParametricStudy (see VARARGIN)

% Choose default command line output for ParametricStudy
handles.output = hObject;
handles.B0 = 3; handles.B1 = 0; handles.time = 0; handles.count = 0;
handles.dimension = '3D';
% Update handles structure
guidata(hObject, handles);

UpdatePulsePlot(handles);
% UIWAIT makes ParametricStudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = ParametricStudy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in uipanelB0.
function uipanelB0_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelB0 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton3_0T'
        handles.B0 = 3;
    case 'radiobutton4_7T'
        handles.B0 = 4.7;
    case 'radiobutton7_0T'
        handles.B0 = 7;
    case 'radiobutton9_4T'
        handles.B0 = 9.4;
end
guidata(handles.figure1,handles)
if(handles.B0>3)
    questdlg({'Do not forget to set the relaxation times accordingly!';' ';...
        'These values are magnetic field strength dependent!'},...
        '!! Warning !!','Ok','Ok');
end


function editTransverseRelaxationTimesValues_Callback(hObject, eventdata, handles)
% hObject    handle to editTransverseRelaxationTimesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTransverseRelaxationTimesValues as text
%        str2double(get(hObject,'String')) returns contents of editTransverseRelaxationTimesValues as a double


% --- Executes during object creation, after setting all properties.
function editTransverseRelaxationTimesValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTransverseRelaxationTimesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInitialMagnetizationValues_Callback(hObject, eventdata, handles)
% hObject    handle to editInitialMagnetizationValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInitialMagnetizationValues as text
%        str2double(get(hObject,'String')) returns contents of editInitialMagnetizationValues as a double


% --- Executes during object creation, after setting all properties.
function editInitialMagnetizationValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInitialMagnetizationValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editExchangeRatesValues_Callback(hObject, eventdata, handles)
% hObject    handle to editExchangeRatesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editExchangeRatesValues as text
%        str2double(get(hObject,'String')) returns contents of editExchangeRatesValues as a double


% --- Executes during object creation, after setting all properties.
function editExchangeRatesValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editExchangeRatesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSaturationOffsetsValues_Callback(hObject, eventdata, handles)
% hObject    handle to editSaturationOffsetsValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSaturationOffsetsValues as text
%        str2double(get(hObject,'String')) returns contents of editSaturationOffsetsValues as a double


% --- Executes during object creation, after setting all properties.
function editSaturationOffsetsValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSaturationOffsetsValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSaturationTimeValue_Callback(hObject, eventdata, handles)
% hObject    handle to editSaturationTimeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSaturationTimeValue as text
%        str2double(get(hObject,'String')) returns contents of editSaturationTimeValue as a double
UpdatePulsePlot(handles);

% --- Executes during object creation, after setting all properties.
function editSaturationTimeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSaturationTimeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editFlipAngleValue_Callback(hObject, eventdata, handles)
% hObject    handle to editFlipAngleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFlipAngleValue as text
%        str2double(get(hObject,'String')) returns contents of editFlipAngleValue as a double
UpdatePulsePlot(handles);

% --- Executes during object creation, after setting all properties.
function editFlipAngleValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFlipAngleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDutyCycleValue_Callback(hObject, eventdata, handles)
% hObject    handle to editDutyCycleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDutyCycleValue as text
%        str2double(get(hObject,'String')) returns contents of editDutyCycleValue as a double
UpdatePulsePlot(handles);

% --- Executes during object creation, after setting all properties.
function editDutyCycleValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDutyCycleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPulseDurationValue_Callback(hObject, eventdata, handles)
% hObject    handle to editPulseDurationValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPulseDurationValue as text
%        str2double(get(hObject,'String')) returns contents of editPulseDurationValue as a double
UpdatePulsePlot(handles);

% --- Executes during object creation, after setting all properties.
function editPulseDurationValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPulseDurationValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanelPulseType.
function uipanelPulseType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelPulseType 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobuttonContinuous'
        OffVisibility(handles.uipanelPulseProperties)
        SetVisibility([handles.textB1,handles.editB1Value])
    case 'radiobuttonPulses'
        SetVisibility(handles.uipanelPulseProperties)
        OffVisibility([handles.textB1,handles.editB1Value])
end
UpdatePulsePlot(handles);

function UpdatePulsePlot(handles)
type = 'Pulsed_Gaussian';
if(get(handles.radiobuttonContinuous,'Value'))
    type = 'Continuous';
end

if(strcmp(type,'Pulsed_Gaussian'))
    n = 64;
    FA = str2double(get(handles.editFlipAngleValue,'String'));
    Tp = str2double(get(handles.editPulseDurationValue,'String'))/1000;
    DC = str2double(get(handles.editDutyCycleValue,'String'))/100;
    Tpd = Tp/DC;
    [B1,t,AP]= Discretize_GaussianPulses(n,FA,Tpd,DC);
    plot(handles.axesPulsePlot,t,B1.*1e6,t,AP.*ones(size(t))*1e6);
    set(handles.axesPulsePlot,'XLim',[0 Tpd]);
    legend(handles.axesPulsePlot,'Gaussian Pulse','Avg. Power, AP')
    text(0.7*Tpd,1.2e6*AP,[sprintf('AP = %.2f',AP*1e6) ' \muT'],'Parent',handles.axesPulsePlot)
elseif(strcmp(type,'Continuous'))
    gama = 2*pi*42.576e6;
    t = str2double(get(handles.editSaturationTimeValue,'String'));
    B1 = str2double(get(handles.editB1Value,'String'));
    FA = B1*t*gama*180/pi;
    plot(handles.axesPulsePlot,[0 t],[B1 B1].*1e6);
    tmp = get(handles.axesPulsePlot,'YLim');
    text(0.6*t,B1*1e6 + (diff(tmp)/10),...
        [sprintf('FA = %.1f',FA) ' \circ'],'Parent',handles.axesPulsePlot)
end
ylabel(handles.axesPulsePlot,'B_1, (\muT)'); 
xlabel(handles.axesPulsePlot,'time, (s)');
handles.B1 = B1; handles.time = t;
guidata(handles.figure1,handles)



function DisableButton (handles)
    set(handles,'Enable','Off');
    
function EnableButton (handles)
    set(handles,'Enable','On');

function SetVisibility (handles)
    set(handles, 'visible', 'on');
    
function OffVisibility (handles)
    set(handles, 'visible', 'off');

% --- Executes on button press in checkboxFatSaturation.
function checkboxFatSaturation_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFatSaturation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFatSaturation



function editLongitudinalRelaxationTimesValues_Callback(hObject, eventdata, handles)
% hObject    handle to editLongitudinalRelaxationTimesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLongitudinalRelaxationTimesValues as text
%        str2double(get(hObject,'String')) returns contents of editLongitudinalRelaxationTimesValues as a double


% --- Executes during object creation, after setting all properties.
function editLongitudinalRelaxationTimesValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLongitudinalRelaxationTimesValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPlot.
function pushbuttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

T1 = (eval(get(handles.editLongitudinalRelaxationTimesValues,'String')))';
T2 = (eval(get(handles.editTransverseRelaxationTimesValues,'String')))';
M0 = (eval(get(handles.editInitialMagnetizationValues,'String')))';
W = (eval(get(handles.editChemicalShiftsValues,'String')))';
% If there is only water pool, dont find CESTR
if(length(W)==1)
    handles.CESTR_ppm(handles.count +1) = 0;
else
    handles.CESTR_ppm(handles.count +1) = round(W(2)*10)/10;
end
C = (eval(get(handles.editExchangeRatesValues,'String')))';
ppm = round(eval(get(handles.editSaturationOffsetsValues,'String')).*10)./10;
Tsat = str2double(get(handles.editSaturationTimeValue,'String'));

switch get(handles.uipanelB0,'SelectedObject') % Get Tag of selected object.
    case handles.radiobutton3_0T
        handles.B0 = 3;
    case handles.radiobutton4_7T
        handles.B0 = 4.7;
    case handles.radiobutton7_0T
        handles.B0 = 7;
    case handles.radiobutton9_4T
        handles.B0 = 9.4;
end

Res_F = handles.B0*42.58;
w = ppm.*Res_F*2*pi;
W = W.*Res_F*2*pi;
W1 = handles.B1.*42.58e6*2*pi;

MT_Lineshape = 'L';
handles.count = handles.count +1;

% To check whether the number of input parameters are tally with the number
% of pools simulated.
npools = length(M0);
if(npools ~= length(T1))
    errordlg(sprintf('The number of T1 parameters (%i) is different from the initial magnetization parameters (%i).',length(T1),npools),...
        '!! ERROR !!','modal');
    return
elseif (npools ~= length(T2))
    errordlg(sprintf('The number of T2 parameters (%i) is different from the initial magnetization parameters (%i).',length(T2),npools),...
        '!! ERROR !!','modal')
    return;
elseif (npools ~= length(W))
    errordlg(sprintf('The number of chemical shift parameters (%i) is different from the initial magnetization parameters (%i).',length(W),npools),...
        '!! ERROR !!','modal')
    return;
elseif (npools ~= length(C))
    errordlg(sprintf('The number of exchange rate parameters (%i) is different from the initial magnetization parameters (%i).',length(C),npools),...
        '!! ERROR !!','modal');
    return;
end

% The 1st pool must be water protons. The remaining pools are assumed to
% have negligible interaction between each other, except with the water
% pool. Then the equilibrium exchange rate can be calculated as below:
C(1) = sum(M0(2:end)./M0(1).*C(2:end));
T = [];
for i = 1:length(T1)
   T = [T T1(i) T2(i)];
end
T = [T Tsat];

DisableButton([handles.pushbuttonPlot handles.pushbuttonClear])
pause(0.00000001)

tic
 %handles.Mz(handles.count,:) = SimplifiedPulsedCESTZ_Spectrum3pool(T,W,M0,C,w,...
   %W1,handles.time,MT_Lineshape,handles.dimension)./M0(1);
 handles.Mz(handles.count,:) = BlochEquations_nPools(T,W,M0,C,w,...
     W1,handles.time,handles.dimension)./M0(1);
 
 handles.Mz_NoW(handles.count,:) = BlochEquations_nPools([T(1:2) T(end)],W(1),M0(1),0,w,...
      W1,handles.time,handles.dimension)./M0(1) - handles.Mz(handles.count,:);
toc
writematrix(handles.Mz , 'C:\Users\sweeq\OneDrive - Universiti Tunku Abdul Rahman\Documents\UTAR_PhD\z_simulation\comparison\Tee_Mz_D')
color = ['ro-';'bo-';'go-';'mo-';'co-';'ko-'];
hold(handles.axesZSpectraPlot,'off')
leg_msg = [];
for i = 1:handles.count
    plot(handles.axesZSpectraPlot,ppm,handles.Mz(i,:),color(i,:));
    hold(handles.axesZSpectraPlot,'on')
    % If the CESTR is negative, the array will have different size.
    % Temporary measure - when it is negative, display only up to 4 decimal
    % places.
    if(handles.CESTR_ppm(i) ~= 0)
        if((handles.Mz_NoW(i,ppm==handles.CESTR_ppm(i)))<0)
            %leg_msg = [leg_msg;sprintf('Plot %i - CESTR = %.4f',i,handles.Mz(i,ppm==-handles.CESTR_ppm(i))-handles.Mz(i,ppm==handles.CESTR_ppm(i)))];
            leg_msg = [leg_msg;sprintf('Plot %i - CESTR = %.4f',i,handles.Mz_NoW(i,ppm==handles.CESTR_ppm(i)))];
        else
            %leg_msg = [leg_msg;sprintf('Plot %i - CESTR = %.5f',i,handles.Mz(i,ppm==-handles.CESTR_ppm(i))-handles.Mz(i,ppm==handles.CESTR_ppm(i)))];
            leg_msg = [leg_msg;sprintf('Plot %i - CESTR = %.5f',i,handles.Mz_NoW(i,ppm==handles.CESTR_ppm(i)))];
        end
    else
        leg_msg = [leg_msg;sprintf('Plot %i - Water pool only',i)];
    end
end
ylabel(handles.axesZSpectraPlot,'M_z/M_{z0}')
xlabel(handles.axesZSpectraPlot,'Frequency offsets, (ppm)')
legend(handles.axesZSpectraPlot,leg_msg,'Location','Best')
set(handles.axesZSpectraPlot,'XDir','reverse','ylim',[0 1]);
for i = 1:handles.count
    plot(handles.axesZSpectraPlot,ppm,handles.Mz_NoW(i,:),[color(i,1) '--']);
    plot(handles.axesZSpectraPlot,handles.CESTR_ppm(i),handles.Mz_NoW(i,ppm==handles.CESTR_ppm(i)),[color(i,1) 's']);
end
EnableButton([handles.pushbuttonPlot handles.pushbuttonClear])


if(handles.count == 6)
    questdlg({'Only 6 z-spectra will be plotted at one time!';' ';...
        'The next plot will clear the existing z-spectra, please save before proceeding !'},...
        '!! Warning !!','Ok','Ok')
    handles.count = 0;
end
guidata(handles.figure1, handles);

% --- Executes during object creation, after setting all properties.
function axesZSpectraPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesZSpectraPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesZSpectraPlot


% --- Executes on key press with focus on editSaturationTimeValue and none of its controls.
function editSaturationTimeValue_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editSaturationTimeValue (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% if(strcmp(eventdata.Key,'enter'))
%     editSaturationTimeValue_Callback
% end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editChemicalShiftsValues_Callback(hObject, eventdata, handles)
% hObject    handle to editChemicalShiftsValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editChemicalShiftsValues as text
%        str2double(get(hObject,'String')) returns contents of editChemicalShiftsValues as a double


% --- Executes during object creation, after setting all properties.
function editChemicalShiftsValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChemicalShiftsValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Menu_About_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbuttonClear.
function pushbuttonClear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hold(handles.axesZSpectraPlot,'off')
plot(handles.axesZSpectraPlot,0,0)

ylabel(handles.axesZSpectraPlot,'M_z/M_{z0}')
xlabel(handles.axesZSpectraPlot,'Frequency offsets, (ppm)')

handles.count = 0;
guidata(handles.figure1,handles)



function editB1Value_Callback(hObject, eventdata, handles)
% hObject    handle to editB1Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editB1Value as text
%        str2double(get(hObject,'String')) returns contents of editB1Value as a double
UpdatePulsePlot(handles);

% --- Executes during object creation, after setting all properties.
function editB1Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editB1Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanelDimension.
function uipanelDimension_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelDimension 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton3D'
        handles.dimension = '3D';
    case 'radiobutton2D'
        handles.dimension = '2D';
end
guidata(handles.figure1,handles)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu_About_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_About_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf(['Chemical exchange saturation transfer (CEST) simulator.:\n\n'...
        'The default setting is for a 3-pool exchange model consists of water (a), amide (b) and magnetization transfer (c).\n\n'...
        'The simulator is designed to accept any number of pools. The processing time will be longer when more pools are simulated, especially for the pulsed case. \n\n'...
        'Pool a is always reserved for water protons and pool b is for the CEST agent of interest; the remaining pools can be added after pool a and b as necessary.\n\n'...
        'Only 6 z-spectra will be plotted. The dotted plot(s) refers to the difference between the simulated water and n-pool z-spectra; CESTR is the difference at chemical shift of the CEST agent pool (Wb).\n\n'...
        'Please refer to the Readme.txt in the folder for more information.\n\n'...
        'Please report any bugs or errors to teeyeekai@gmail.com together with a detailed description on how it can be reproduced and the error message.\n']),'Help','Help','Modal');
open('Readme.txt');
