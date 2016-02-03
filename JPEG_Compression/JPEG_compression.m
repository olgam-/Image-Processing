function varargout = JPEG_compression(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JPEG_compression_OpeningFcn, ...
                   'gui_OutputFcn',  @JPEG_compression_OutputFcn, ...
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


% --- Executes just before JPEG_compression is made visible.
function JPEG_compression_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes1);
title('Original Image');
axes(handles.axes2);
title('Restored Image');
axes(handles.axes4);
title('Y Channel');
axes(handles.axes5);
title('Cb Channel');
axes(handles.axes6);
title('Cr Channel');

% Choose default command line output for JPEG_compression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JPEG_compression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JPEG_compression_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
imagefile = uigetfile({'*.jpg;*.tif;*.png;*.bmp;*.gif','All Image Files';...
          '*.*','All Files' });
if ~isempty(imagefile)
    Im = imread(imagefile);
    axes(handles.axes1)
    imshow(Im);
    axis tight;
    axis off;
    title('Original Image')
    handles.Im = Im;
end;
guidata(hObject, handles);


% --- Executes on button press in compressbutton.
function compressbutton_Callback(hObject, eventdata, handles)

[ImY, ImCb, ImCr] = myjpegcompression(handles.Im);

axes(handles.axes4)
imshow(ImY);
axis tight;
axis off;
title('Y channel')

axes(handles.axes5)
imshow(ImCb);
axis tight;
axis off;
title('Cb channel')

axes(handles.axes6)
imshow(ImCr);
axis tight;
axis tight;
axis off;
title('Cr channel')

Idec(:,:,1) = ImY;
Idec(:,:,2) = ImCb;
Idec(:,:,3) = ImCr;

ImComp = ycbcr2rgb(Idec);

axes(handles.axes2)
imshow(ImComp);
axis tight;
axis off;
title('Restored Image')

handles.ImComp = ImComp;

guidata(hObject, handles);


% --- Executes on button press in saveimage.
function saveimage_Callback(hObject, eventdata, handles)

[filename, pathname] = uiputfile('*.bmp','Save the compressed Image As');
imwrite(handles.ImComp, filename, 'BMP');
