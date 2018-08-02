function varargout = guiDemo(varargin)
% GUIDEMO MATLAB code for guiDemo.fig
%      GUIDEMO, by itself, creates a new GUIDEMO or raises the existing
%      singleton*.
%
%      H = GUIDEMO returns the handle to a new GUIDEMO or the handle to
%      the existing singleton*.
%
%      GUIDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDEMO.M with the given input arguments.
%
%      GUIDEMO('Property','Value',...) creates a new GUIDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiDemo

% Last Modified by GUIDE v2.5 23-Jan-2017 17:14:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guiDemo_OutputFcn, ...
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


% --- Executes just before guiDemo is made visible.
function guiDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiDemo (see VARARGIN)

% Choose default command line output for guiDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiDemo wait for user response (see UIRESUME)
% uiwait(handles.MainWidget);
% 导入模型
axes(handles.Axes);
AM=amLoadModel('amModelScript.m');

AM.qm.rm.R=Rot(-pi/2,'z',3);
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

setappdata(handles.MainWidget,'AM',AM);
amDraw(AM);
SetShowState(0.6);

% 设置滑动条
set(handles.Slider_1, 'Value'  ,AM.arm.Link(1).Theta);
set(handles.Slider_2, 'Value'  ,AM.arm.Link(2).Theta);
set(handles.Slider_3, 'Value'  ,AM.arm.Link(3).Theta);
set(handles.Slider_4, 'Value'  ,AM.arm.Link(4).Theta);

% 设置定时器
handles.timer = timer('Period',0.02,'ExecutionMode','FixedRate',...
'TimerFcn',{@TimerCallFunc,handles});

guidata(hObject, handles); %这句必须加

% --- Outputs from this function are returned to the command line.
function varargout = guiDemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Slider_1_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%%
val=get(hObject, 'Value' );
set(handles.Text_1, 'String' ,num2str(val));

AM=getappdata(handles.MainWidget,'AM');
AM.arm.Theta(1)=val;
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

cla reset; %% 重要语句，清空当前画面
amDraw(AM);
SetShowState(0.6);
drawnow;
setappdata(handles.MainWidget,'AM',AM);

% --- Executes during object creation, after setting all properties.
function Slider_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_2_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject, 'Value' );
set(handles.Text_2, 'String' ,num2str(val));

AM=getappdata(handles.MainWidget,'AM');
AM.arm.Theta(2)=val;
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

cla reset; %% 重要语句，清空当前画面
amDraw(AM);
SetShowState(0.6);
drawnow;
setappdata(handles.MainWidget,'AM',AM);


% --- Executes during object creation, after setting all properties.
function Slider_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_3_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject, 'Value' );
set(handles.Text_3, 'String' ,num2str(val));

AM=getappdata(handles.MainWidget,'AM');
AM.arm.Theta(3)=val;
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

cla reset; %% 重要语句，清空当前画面
amDraw(AM);
SetShowState(0.6);
drawnow;
setappdata(handles.MainWidget,'AM',AM);


% --- Executes during object creation, after setting all properties.
function Slider_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_4_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject, 'Value' );
set(handles.Text_4, 'String' ,num2str(val));

AM=getappdata(handles.MainWidget,'AM');
AM.arm.Theta(4)=val;
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

cla reset; %% 重要语句，清空当前画面
amDraw(AM);
SetShowState(0.6);
drawnow;
setappdata(handles.MainWidget,'AM',AM);


% --- Executes during object creation, after setting all properties.
function Slider_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Function_Callback(hObject, eventdata, handles)
% hObject    handle to Function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in PushBtn_1.



function PushBtn_1_Callback(hObject, eventdata, handles)
% hObject    handle to PushBtn_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start(handles.timer);

% 定时器处理函数
function TimerCallFunc(obj,events,handles)

%{%}
AM=getappdata(handles.MainWidget,'AM');
AM.arm.Theta(2)=AM.arm.Theta(2)+pi/180*2;
AM.arm=armUpdatePose(AM.arm,AM.arm.Theta,MT(AM.qm.rm.R,AM.qm.rm.P));

cla reset; %% 重要语句，清空当前画面
amDraw(AM);
SetShowState(0.6);
drawnow;
setappdata(handles.MainWidget,'AM',AM);


% --- Executes during object deletion, before destroying properties.
function MainWidget_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to MainWidget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.timer);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
