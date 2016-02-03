function varargout = Quantization(varargin)
% QUANTIZATION MATLAB code for Quantization.fig
%      QUANTIZATION, by itself, creates a new QUANTIZATION or raises the existing
%      singleton*.
%
%      H = QUANTIZATION returns the handle to a new QUANTIZATION or the handle to
%      the existing singleton*.
%
%      QUANTIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUANTIZATION.M with the given input arguments.
%
%      QUANTIZATION('Property','Value',...) creates a new QUANTIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Quantization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Quantization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Quantization

% Last Modified by GUIDE v2.5 09-Jan-2015 20:02:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Quantization_OpeningFcn, ...
                   'gui_OutputFcn',  @Quantization_OutputFcn, ...
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


% --- Executes just before Quantization is made visible.
function Quantization_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
setappdata(handles.colors,'int',5);
guidata(hObject, handles);

% UIWAIT makes Quantization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Quantization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function colors_Callback(hObject, eventdata, handles)

colors = str2double(get(hObject,'String'));
if (isempty(colors))
     set(hObject,'String','5')
end

if colors > 255
  warndlg(['Number of colors should not exceed ' num2str(255)])
  set(hObject,'String',handles.xval) %set string to previous value
elseif colors < 2
  warndlg(['Number of colors should not be less than ' num2str(2)])
  set(hObject,'String',handles.xval) %set strcing to previous value
else
  handles.xval = colors; %update saved value
end

setappdata(handles.colors,'int',handles.xval);

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runbutton.
function runbutton_Callback(hObject, eventdata, handles)

if size(handles.Im, 3) == 3
    handles.Im = rgb2gray(handles.Im);
end
Im = double(handles.Im);

N = getappdata(handles.colors,'int');

[Im2, partition, codebook] = grayscale_red_Lloyd(Im,N);
Im2 = uint8(Im2); 
axes(handles.axes2)
imshow(Im2);
axis equal;
axis tight;
axis off;
title(strcat('lmage with only ',num2str(N),' gray values'))


% --- Executes on button press in browsebutton.
function browsebutton_Callback(hObject, eventdata, handles)

imagefile = uigetfile({'*.jpg;*.tif;*.png;*.bmp;*.gif','All Image Files';...
          '*.*','All Files' });
if ~isempty(imagefile)
    Im = imread(imagefile);
    axes(handles.axes1)
    imshow(Im);
    axis equal;
    axis tight;
    axis off;
    title('Original Image')
    handles.Im = Im;
end;
guidata(hObject, handles);
