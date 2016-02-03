function varargout = MyHuffmanGui(varargin)
% MYHUFFMANGUI MATLAB code for MyHuffmanGui.fig
%      MYHUFFMANGUI, by itself, creates a new MYHUFFMANGUI or raises the existing
%      singleton*.
%
%      H = MYHUFFMANGUI returns the handle to a new MYHUFFMANGUI or the handle to
%      the existing singleton*.
%
%      MYHUFFMANGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYHUFFMANGUI.M with the given input arguments.
%
%      MYHUFFMANGUI('Property','Value',...) creates a new MYHUFFMANGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyHuffmanGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyHuffmanGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyHuffmanGui

% Last Modified by GUIDE v2.5 28-Jan-2015 18:29:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyHuffmanGui_OpeningFcn, ...
                   'gui_OutputFcn',  @MyHuffmanGui_OutputFcn, ...
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


% --- Executes just before MyHuffmanGui is made visible.
function MyHuffmanGui_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes1);
title('Original Image');
axes(handles.axes2);
title('Decomposed Image');
axes(handles.axes3);
title('Histogram of Image');

% Choose default command line output for MyHuffmanGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyHuffmanGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyHuffmanGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in encodebutton.
function encodebutton_Callback(hObject, eventdata, handles)
I1 = rgb2gray(handles.Im);
A = I1(:);

[count, x] = imhist(I1);
axes(handles.axes3)
stem(x, count, 'Color', 'magenta', 'Marker', 'none');
axis tight;
title('Histogram of Image')
probabilities = count / sum(count);

[dict,avglen] = huffmandict( (0:255), probabilities); % build the Huffman dictionary
comp = huffmanenco(A,dict);         %encode your original image with the dictionary you just built
compression_ratio = num2str((512*512*8)/length(comp));   %computing the compression ratio

set(handles.compressiontext, 'String', compression_ratio);
handles.comp = comp;
handles.dict = dict;
handles.I1 = I1;

guidata(hObject, handles);


% --- Executes on button press in savetxt.
function savetxt_Callback(hObject, eventdata, handles)
comp = handles.comp;
dict = handles.dict;
[M, N] = size(handles.I1);
[filename, pathname] = uiputfile('*.txt','Save the encoded Image As');
fid = fopen([pathname '/', filename], 'wt');
fprintf(fid, [repmat('%g\t', 1, size(comp,2)-1) '%g\n'], [M, N, comp.']);
fclose(fid);
save([pathname '/' filename '.mat'],'dict');



% --- Executes on button press in decodebutton.
function decodebutton_Callback(hObject, eventdata, handles)
% [M, N] = size(handles.I1);
% I2 = huffmandeco(handles.comp, handles.dict); % Decode the code
% I3 = uint8(I2);
[filename, pathname] = uigetfile('*.txt','Open the encoded Image');
fid = fopen([pathname '/', filename]);
A = fscanf(fid,'%g');
M = A(1);
N = A(2);
comp = A(3:end);
load([pathname '/' filename '.mat']);
I2 = huffmandeco(comp,dict); % Decode the code
I3 = uint8(I2);

I4 = reshape(I3, M, N);
axes(handles.axes2)
imshow(I4);
axis tight;
axis off;
title('Decomposed Image')
