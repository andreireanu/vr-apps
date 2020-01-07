function varargout = HeatMap12(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HeatMap12_OpeningFcn, ...
                   'gui_OutputFcn',  @HeatMap12_OutputFcn, ...
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
function HeatMap12_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = HeatMap12_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

function LoadImage_Callback(hObject, eventdata, handles)
cla(handles.axes);
[Image, ImagePath] = uigetfile('*.jpg','Alegeti o imagine in format jpg');
image = imread(fullfile([ImagePath Image]));
[sizeX,sizeY,~]=size(image);
setappdata(handles.axes, 'Image', Image);
setappdata(handles.axes, 'ImagePath', ImagePath);
setappdata(handles.axes, 'sizeX', sizeX);
setappdata(handles.axes, 'sizeY', sizeY);
axes(handles.axes);
imshow(image, 'Parent',handles.axes);
hold on;
clc;
drawnow;

set(handles.valMin,'String',"");
set(handles.valMax,'String',"");
set(handles.min,'String',"");
set(handles.max,'String',"");
set(handles.Show,'String',"");
 

function LoadFile_Callback(hObject, eventdata, handles)
cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 


[File, FilePath] = uigetfile('*.vtr','Alegeti fisierul cu datele in format VTR');
sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY');
set(handles.Show,'String',File);

hmAddAll = zeros(sizeX,sizeY);
text = fileread(fullfile([FilePath File])); 
temp2 = parse_json(text);
temp3 = cell2mat(temp2);
temp3 = temp3';
M = struct2cell(temp3);
M = cell2mat( M );

hmAdd = add(M,sizeX,sizeY); 
hmAddAll = hmAddAll + hmAdd;

h1 = fspecial('disk',floor(20));
hmAddAll = imfilter(hmAddAll,h1);
 
c = jet(64);
colormap(c);
h =  image(hmAddAll,'CDataMapping','scaled');
hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'), get(handles.CutOff, 'Value')  );
set(h,'AlphaData',hmAddAlpha);
set(handles.valMin,'String',0);
set(handles.valMax,'String',M(1,length(M)) - M(1,1));
set(handles.min,'String',"");
set(handles.max,'String',"");
setappdata(handles.LoadFolder,'hmAddAll',hmAddAll);
setappdata(handles.LoadFolder,'M',M);

x1 = getappdata(handles.aoi1,'x' );    
y1 = getappdata(handles.aoi1,'y' );   
x2 = getappdata(handles.aoi2,'x' );    
y2 = getappdata(handles.aoi2,'y' ); 
x3 = getappdata(handles.aoi3,'x' );    
y3 = getappdata(handles.aoi3,'y' ); 
x4 = getappdata(handles.aoi4,'x' );    
y4 = getappdata(handles.aoi4,'y' ); 
x5 = getappdata(handles.aoi5,'x' );    
y5 = getappdata(handles.aoi5,'y' ); 
x6 = getappdata(handles.aoi6,'x' );    
y6 = getappdata(handles.aoi6,'y' ); 
x7 = getappdata(handles.aoi7,'x' );    
y7 = getappdata(handles.aoi7,'y' ); 
x8 = getappdata(handles.aoi8,'x' );    
y8 = getappdata(handles.aoi8,'y' ); 
x9 = getappdata(handles.aoi9,'x' );    
y9 = getappdata(handles.aoi9,'y' ); 
x10 = getappdata(handles.aoi10,'x' );    
y10 = getappdata(handles.aoi10,'y' ); 
x11 = getappdata(handles.aoi11,'x' );    
y11 = getappdata(handles.aoi11,'y' ); 
x12 = getappdata(handles.aoi12,'x' );    
y12 = getappdata(handles.aoi12,'y' ); 
plotSave1 = plot(x1, y1, 'r.-', 'MarkerSize', 15);
plotSave2 = plot(x2, y2, '.-', 'MarkerSize', 15, 'color',[0  0.45  0.74] );
plotSave3 = plot(x3, y3, '.-', 'MarkerSize', 15, 'color',[0.93 0.69 0.13] );
plotSave4 = plot(x4, y4, '.-', 'MarkerSize', 15, 'color',[0.49 0.18 0.56] );
plotSave5 = plot(x5, y5, '.-', 'MarkerSize', 15, 'color',[0.47 0.67 0.19] );
plotSave6 = plot(x6, y6, '.-', 'MarkerSize', 15, 'color',[0.3 0.75 0.93] );
plotSave7 = plot(x7, y7, '.-', 'MarkerSize', 15, 'color',[0.64 0.08 0.18] );
plotSave8 = plot(x8, y8, '.-', 'MarkerSize', 15, 'color',[1 1 1] );
plotSave9 = plot(x9, y9, '.-', 'MarkerSize', 15, 'color',[0.15 0.15 0.15]);
plotSave10 = plot(x10, y10, '.-', 'MarkerSize', 15, 'color',[1 0 1] );
plotSave11 = plot(x11, y11, '.-', 'MarkerSize', 15, 'color',[0 0 1] );
plotSave12 = plot(x12, y12, '.-', 'MarkerSize', 15, 'color',[0 1 0] );
setappdata(handles.aoi1,'plotSave',plotSave1);
setappdata(handles.aoi2,'plotSave',plotSave2);
setappdata(handles.aoi3,'plotSave',plotSave3);
setappdata(handles.aoi4,'plotSave',plotSave4);
setappdata(handles.aoi5,'plotSave',plotSave5);
setappdata(handles.aoi6,'plotSave',plotSave6);
setappdata(handles.aoi7,'plotSave',plotSave7);
setappdata(handles.aoi8,'plotSave',plotSave8);
setappdata(handles.aoi9,'plotSave',plotSave9);
setappdata(handles.aoi10,'plotSave',plotSave10);
setappdata(handles.aoi11,'plotSave',plotSave11);
setappdata(handles.aoi12,'plotSave',plotSave12);
 
 
function LoadFolder_Callback(hObject, eventdata, handles);
cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 
folder = uigetdir('C:\SSD\Andrei\Matlab\GUIDE','Alegeti folderul cu datele in format VTR');
files = dir(fullfile(folder, '*.vtr'));
sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY');
set(handles.Show,'String',folder);

hmAddAll = zeros(sizeX,sizeY);
for k = 1 : length(files)
%   file = strcat(folder,"\",files(k).name);
  text = fileread(files(k).name); 
  temp = jsondecode(text);
  M = struct2cell(temp);
  M = cell2mat( M );
  hmAdd = add(M,sizeX,sizeY); 
  hmAddAll = hmAddAll + hmAdd;
end

hmAddAll = hmAddAll/length(folder);
 
h1 = fspecial('disk',floor(20));
hmAddAll = imfilter(hmAddAll,h1);

c = jet(64);
colormap(c);
h =  image(hmAddAll,'CDataMapping','scaled');
hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'), get(handles.CutOff, 'Value')  );
set(h,'AlphaData',hmAddAlpha);
setappdata(handles.LoadFolder,'hmAddAll',hmAddAll);

function SaveImage_Callback(~, ~, handles)
[File, FilePath] = uiputfile('*.jpg','Salveaza Imaginea');
export_fig(fullfile([FilePath File]),handles.axes);

function Transp_Callback(hObject, ~, handles)
guidata(hObject,handles);
cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 

hmAddAll = getappdata(handles.LoadFolder,'hmAddAll');
sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY'); 
hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'),get(handles.CutOff, 'Value') );
h =  image(hmAddAll,'CDataMapping','scaled');
set(h,'AlphaData',hmAddAlpha);
setappdata(handles.LoadFolder,'hmAddAlpha',hmAddAlpha);
setappdata(handles.LoadFolder,'hmAddAll',hmAddAll);

function Transp_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function CutOff_Callback(~, ~, handles)
 cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
 hold on; 

 sizeX = getappdata(handles.axes,'sizeX');
 sizeY = getappdata(handles.axes,'sizeY'); 
 hmAddAll = getappdata(handles.LoadFolder,'hmAddAll');
 h =  image(hmAddAll,'CDataMapping','scaled');
 hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'),get(handles.CutOff, 'Value') );
 set(h,'AlphaData',hmAddAlpha);
 setappdata(handles.LoadFolder,'hmAddAlpha',hmAddAlpha);
 
function CutOff_CreateFcn(hObject, ~, ~)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Show_Callback(hObjectx, eventdata, handles)

function Show_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 


function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double


% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valMax_Callback(hObject, eventdata, handles)
% hObject    handle to valMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valMax as text
%        str2double(get(hObject,'String')) returns contents of valMax as a double




% --- Executes during object creation, after setting all properties.
function valMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 



function valMin_Callback(hObject, eventdata, handles)
% hObject    handle to valMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valMin as text
%        str2double(get(hObject,'String')) returns contents of valMin as a double


% --- Executes during object creation, after setting all properties.
function valMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double


% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CalcInt_Callback(hObject, eventdata, handles)

min = str2num(get(handles.min,'String'));
max = str2num(get(handles.max,'String'));
valMin = str2num(get(handles.valMin,'String'));
valMax = str2num(get(handles.valMax,'String'));
minMat = round(min*90) + 1;
maxMat = round(max*90) + 1;
hmAddAll = getappdata(handles.LoadFolder,'hmAddAll');
M = getappdata(handles.LoadFolder,'M');
M = M(:,minMat:maxMat);
N = M(2:3,:);
s = sum(N);
ss = sum(s);

if( ss ~= 0 )
guidata(hObject,handles);
cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 

sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY');
hmAddAll = zeros(sizeX,sizeY);
hmAdd = add(M,sizeX,sizeY); 
hmAddAll = hmAddAll + hmAdd;
h1 = fspecial('disk',floor(20));
hmAddAll = imfilter(hmAddAll,h1);
c = jet(64);
colormap(c);
h =  image(hmAddAll,'CDataMapping','scaled');
hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'), get(handles.CutOff, 'Value')  );
set(h,'AlphaData',hmAddAlpha);
setappdata(handles.LoadFolder,'hmAddAll',hmAddAll);
else
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 
end

 
function aoi1_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi1,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
plotSave = plot(x, y, 'r.-', 'MarkerSize', 15);
setappdata(handles.aoi1,'BW',BW);
setappdata(handles.aoi1,'plotSave',plotSave);
setappdata(handles.aoi1,'x',x);
setappdata(handles.aoi1,'y',y);
 
function aoi2_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi2,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0  0.45  0.74];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi2,'BW',BW);
setappdata(handles.aoi2,'plotSave',plotSave);
setappdata(handles.aoi2,'x',x);
setappdata(handles.aoi2,'y',y);
 
function aoi3_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi3,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.93 0.69 0.13];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi3,'BW',BW);
setappdata(handles.aoi3,'plotSave',plotSave);
setappdata(handles.aoi3,'x',x);
setappdata(handles.aoi3,'y',y);

function aoi4_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi4,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.49 0.18 0.56];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi4,'BW',BW);
setappdata(handles.aoi4,'plotSave',plotSave);
setappdata(handles.aoi4,'x',x);
setappdata(handles.aoi4,'y',y);

function aoi5_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi5,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.47 0.67 0.19];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi5,'BW',BW);
setappdata(handles.aoi5,'plotSave',plotSave);
setappdata(handles.aoi5,'x',x);
setappdata(handles.aoi5,'y',y);

function aoi6_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi6,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.3 0.75 0.93];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi6,'BW',BW);
setappdata(handles.aoi6,'plotSave',plotSave);
setappdata(handles.aoi6,'x',x);
setappdata(handles.aoi6,'y',y);

 
function aoi7_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi7,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.64 0.08 0.18];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi7,'BW',BW);
setappdata(handles.aoi7,'plotSave',plotSave);
setappdata(handles.aoi7,'x',x);
setappdata(handles.aoi7,'y',y); 


function aoi8_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi8,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [1 1 1];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi8,'BW',BW);
setappdata(handles.aoi8,'plotSave',plotSave);
setappdata(handles.aoi8,'x',x);
setappdata(handles.aoi8,'y',y); 

function aoi9_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi9,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0.15 0.15 0.15];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi9,'BW',BW);
setappdata(handles.aoi9,'plotSave',plotSave);
setappdata(handles.aoi9,'x',x);
setappdata(handles.aoi9,'y',y); 

function aoi10_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi10,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [1 0 1];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi10,'BW',BW);
setappdata(handles.aoi10,'plotSave',plotSave);
setappdata(handles.aoi10,'x',x);
setappdata(handles.aoi10,'y',y); 

function aoi11_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi11,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0 0 1];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi11,'BW',BW);
setappdata(handles.aoi11,'plotSave',plotSave);
setappdata(handles.aoi11,'x',x);
setappdata(handles.aoi11,'y',y); 

function aoi12_Callback(hObject, eventdata, handles)
plotSave = getappdata(handles.aoi12,'plotSave');
delete(plotSave);
[BW,x,y] = roipoly();
color = [0 1 0];
plotSave = plot(x, y, '.-', 'MarkerSize', 15, 'color',color);
setappdata(handles.aoi12,'BW',BW);
setappdata(handles.aoi12,'plotSave',plotSave);
setappdata(handles.aoi12,'x',x);
setappdata(handles.aoi12,'y',y); 
 


% --- Executes on button press in writeFile.
function writeFile_Callback(hObject, eventdata, handles)
% hObject    handle to writeFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = getappdata(handles.LoadFolder,'M');
sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY'); 
BW1 = getappdata(handles.aoi1,'BW');
BW2 = getappdata(handles.aoi2,'BW');
BW3 = getappdata(handles.aoi3,'BW');
BW4 = getappdata(handles.aoi4,'BW');
BW5 = getappdata(handles.aoi5,'BW');
BW6 = getappdata(handles.aoi6,'BW');
BW7 = getappdata(handles.aoi7,'BW');
BW8 = getappdata(handles.aoi8,'BW');
BW9 = getappdata(handles.aoi9,'BW');
BW10 = getappdata(handles.aoi10,'BW');
BW11 = getappdata(handles.aoi11,'BW');
BW12 = getappdata(handles.aoi12,'BW');
sec1 = 0 ;  secInt1 = 0 ;countSecRec1 = 0;
sec2 = 0 ;  secInt2 = 0 ;countSecRec2 = 0;
sec3 = 0 ;  secInt3 = 0 ;countSecRec3 = 0;
sec4 = 0 ;  secInt4 = 0 ;countSecRec4 = 0;
sec5 = 0 ;  secInt5 = 0 ;countSecRec5 = 0;
sec6 = 0 ;  secInt6 = 0 ;countSecRec6 = 0;
sec7 = 0 ;  secInt7 = 0 ;countSecRec7 = 0;
sec8 = 0 ;  secInt8 = 0 ;countSecRec8 = 0;
sec9 = 0 ;  secInt9 = 0 ;countSecRec9 = 0;
sec10 = 0 ;  secInt10 = 0 ;countSecRec10 = 0;
sec11 = 0 ;  secInt11 = 0 ;countSecRec11 = 0;
sec12 = 0 ;  secInt12 = 0 ;countSecRec12 = 0;
if ( ~isempty(BW1))
    [sec1, secInt1,countSecRec1] = calcSec(BW1,M,sizeX,sizeY);
end
if ( ~isempty(BW2))
    [sec2, secInt2,countSecRec2] = calcSec(BW2,M,sizeX,sizeY);
end
if ( ~isempty(BW3))
    [sec3, secInt3,countSecRec3] = calcSec(BW3,M,sizeX,sizeY);
end
if ( ~isempty(BW4))
    [sec4, secInt4,countSecRec4] = calcSec(BW4,M,sizeX,sizeY);
end
if ( ~isempty(BW5))
    [sec5, secInt5,countSecRec5] = calcSec(BW5,M,sizeX,sizeY);
end
if ( ~isempty(BW6))
    [sec6, secInt6,countSecRec6] = calcSec(BW6,M,sizeX,sizeY);
end
if ( ~isempty(BW7))
    [sec7, secInt7,countSecRec7] = calcSec(BW7,M,sizeX,sizeY);
end
if ( ~isempty(BW8))
    [sec8, secInt8,countSecRec8] = calcSec(BW8,M,sizeX,sizeY);
end
if ( ~isempty(BW9))
    [sec9, secInt9,countSecRec9] = calcSec(BW9,M,sizeX,sizeY);
end
if ( ~isempty(BW10))
    [sec10, secInt10,countSecRec10] = calcSec(BW10,M,sizeX,sizeY);
end
if ( ~isempty(BW11))
    [sec11, secInt11,countSecRec11] = calcSec(BW11,M,sizeX,sizeY);
end
if ( ~isempty(BW12))
    [sec12, secInt12,countSecRec12] = calcSec(BW12,M,sizeX,sizeY);
end
str = get(handles.Show,'String');
k = strfind(str,"_");
ID = str(k(1,1)+1:k(1,2)-1);
raft = str(k(1,2)+1:length(str)-4);
ImagePath = getappdata(handles.axes,'ImagePath');  
s = fullfile([ImagePath 'DataAOI.json'])
fileID = fopen(s,'a');
fprintf(fileID,'{"ID":%s,"raft":%s,"AOI1_1":%5.3f,"AOI1_2":%5.3f,"AOI1_3":%2i,"AOI2_1":%5.3f,"AOI2_2":%5.3f,"AOI2_3":%2i,"AOI3_1":%5.3f,"AOI3_2":%5.3f,"AOI3_3":%2i,"AOI4_1":%5.3f,"AOI4_2":%5.3f,"AOI4_3":%2i,"AOI5_1":%5.3f,"AOI5_2":%5.3f,"AOI5_3":%2i,"AOI6_1":%5.3f,"AOI6_2":%5.3f,"AOI6_3":%2i,"AOI7_1":%5.3f,"AOI7_2":%5.3f,"AOI7_3":%2i,"AOI8_1":%5.3f,"AOI8_2":%5.3f,"AOI8_3":%2i,"AOI9_1":%5.3f,"AOI9_2":%5.3f,"AOI9_3":%2i,"AOI10_1":%5.3f,"AOI10_2":%5.3f,"AOI10_3":%2i,"AOI11_1":%5.3f,"AOI11_2":%5.3f,"AOI11_3":%2i,"AOI12_1":%5.3f,"AOI12_2":%5.3f,"AOI12_3":%2i},',ID,raft,sec1,secInt1,countSecRec1,sec2,secInt2,countSecRec2,sec3,secInt3,countSecRec3,sec4,secInt4,countSecRec4,sec5,secInt5,countSecRec5,sec6,secInt6,countSecRec6,sec7,secInt7,countSecRec7,sec8,secInt8,countSecRec8,sec9,secInt9,countSecRec9,sec10,secInt10,countSecRec10,sec11,secInt11,countSecRec11,sec12,secInt12,countSecRec12);
fclose(fileID);
   
  
function saveAOI_Callback(hObject, eventdata, handles)
BW1 = getappdata(handles.aoi1,'BW');
BW2 = getappdata(handles.aoi2,'BW');
BW3 = getappdata(handles.aoi3,'BW');
BW4 = getappdata(handles.aoi4,'BW');
BW5 = getappdata(handles.aoi5,'BW');
BW6 = getappdata(handles.aoi6,'BW');
BW7 = getappdata(handles.aoi7,'BW');
BW8 = getappdata(handles.aoi8,'BW');
BW9 = getappdata(handles.aoi9,'BW');
BW10 = getappdata(handles.aoi10,'BW');
BW11 = getappdata(handles.aoi11,'BW');
BW12 = getappdata(handles.aoi12,'BW');
x1 = getappdata(handles.aoi1,'x' );    
y1 = getappdata(handles.aoi1,'y' );   
x2 = getappdata(handles.aoi2,'x' );    
y2 = getappdata(handles.aoi2,'y' ); 
x3 = getappdata(handles.aoi3,'x' );    
y3 = getappdata(handles.aoi3,'y' ); 
x4 = getappdata(handles.aoi4,'x' );    
y4 = getappdata(handles.aoi4,'y' ); 
x5 = getappdata(handles.aoi5,'x' );    
y5 = getappdata(handles.aoi5,'y' ); 
x6 = getappdata(handles.aoi6,'x' );    
y6 = getappdata(handles.aoi6,'y' ); 
x7 = getappdata(handles.aoi7,'x' );    
y7 = getappdata(handles.aoi7,'y' ); 
x8 = getappdata(handles.aoi8,'x' );    
y8 = getappdata(handles.aoi8,'y' ); 
x9 = getappdata(handles.aoi9,'x' );    
y9 = getappdata(handles.aoi9,'y' ); 
x10 = getappdata(handles.aoi10,'x' );    
y10 = getappdata(handles.aoi10,'y' ); 
x11 = getappdata(handles.aoi11,'x' );    
y11 = getappdata(handles.aoi11,'y' ); 
x12 = getappdata(handles.aoi12,'x' );    
y12 = getappdata(handles.aoi12,'y' ); 
S = struct('BW1',BW1,'x1',x1,'y1',y1,'BW2',BW2,'x2',x2,'y2',y2,'BW3',BW3,'x3',x3,'y3',y3,'BW4',BW4,'x4',x4,'y4',y4,'BW5',BW5,'x5',x5,'y5',y5,'BW6',BW6,'x6',x6,'y6',y6,'BW7',BW7,'x7',x7,'y7',y7,'BW8',BW8,'x8',x8,'y8',y8,'BW9',BW9,'x9',x9,'y9',y9,'BW10',BW10,'x10',x10,'y10',y10,'BW11',BW11,'x11',x11,'y11',y11,'BW12',BW12,'x12',x12,'y12',y12);
[File, FilePath] = uiputfile('Raft');
save(fullfile([FilePath File]), 'S');


function loadAOI_Callback(hObject, eventdata, handles)
[File, FilePath] = uigetfile('*.rpt','Alegeti fisierul cu datele AOI'); 
S = importdata(fullfile([FilePath File]));

plotSave = getappdata(handles.aoi1,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi2,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi3,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi4,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi5,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi6,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi7,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi8,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi9,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi10,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi11,'plotSave');
delete(plotSave);
plotSave = getappdata(handles.aoi12,'plotSave');
delete(plotSave);

plotSave1 = plot(S.x1, S.y1, 'r.-', 'MarkerSize', 15);
plotSave2 = plot(S.x2, S.y2, '.-', 'MarkerSize', 15, 'color',[0  0.45  0.74] );
plotSave3 = plot(S.x3, S.y3, '.-', 'MarkerSize', 15, 'color',[0.93 0.69 0.13] );
plotSave4 = plot(S.x4, S.y4, '.-', 'MarkerSize', 15, 'color',[0.49 0.18 0.56] );
plotSave5 = plot(S.x5, S.y5, '.-', 'MarkerSize', 15, 'color',[0.47 0.67 0.19] );
plotSave6 = plot(S.x6, S.y6, '.-', 'MarkerSize', 15, 'color',[0.3 0.75 0.93] );
plotSave7 = plot(S.x7, S.y7, '.-', 'MarkerSize', 15, 'color',[0.64 0.08 0.18] );
plotSave8 = plot(S.x8, S.y8, '.-', 'MarkerSize', 15, 'color',[1 1 1] );
plotSave9 = plot(S.x9, S.y9, '.-', 'MarkerSize', 15, 'color',[0.15 0.15 0.15]);
plotSave10 = plot(S.x10, S.y10, '.-', 'MarkerSize', 15, 'color',[1 0 1] );
plotSave11 = plot(S.x11, S.y11, '.-', 'MarkerSize', 15, 'color',[0 0 1] );
plotSave12 = plot(S.x12, S.y12, '.-', 'MarkerSize', 15, 'color',[0 1 0] );

setappdata(handles.aoi1,'BW',S.BW1);
setappdata(handles.aoi2,'BW',S.BW2);
setappdata(handles.aoi3,'BW',S.BW3);
setappdata(handles.aoi4,'BW',S.BW4);
setappdata(handles.aoi5,'BW',S.BW5);
setappdata(handles.aoi6,'BW',S.BW6);
setappdata(handles.aoi7,'BW',S.BW7);
setappdata(handles.aoi8,'BW',S.BW8);
setappdata(handles.aoi9,'BW',S.BW9);
setappdata(handles.aoi10,'BW',S.BW10);
setappdata(handles.aoi11,'BW',S.BW11);
setappdata(handles.aoi12,'BW',S.BW12);
setappdata(handles.aoi1,'plotSave',plotSave1);
setappdata(handles.aoi2,'plotSave',plotSave2);
setappdata(handles.aoi3,'plotSave',plotSave3);
setappdata(handles.aoi4,'plotSave',plotSave4);
setappdata(handles.aoi5,'plotSave',plotSave5);
setappdata(handles.aoi6,'plotSave',plotSave6);
setappdata(handles.aoi7,'plotSave',plotSave7);
setappdata(handles.aoi8,'plotSave',plotSave8);
setappdata(handles.aoi9,'plotSave',plotSave9);
setappdata(handles.aoi10,'plotSave',plotSave10);
setappdata(handles.aoi11,'plotSave',plotSave11);
setappdata(handles.aoi12,'plotSave',plotSave12);
setappdata(handles.aoi1,'x',S.x1);
setappdata(handles.aoi1,'y',S.y1);
setappdata(handles.aoi2,'x',S.x2);
setappdata(handles.aoi2,'y',S.y2);
setappdata(handles.aoi3,'x',S.x3);
setappdata(handles.aoi3,'y',S.y3);
setappdata(handles.aoi4,'x',S.x4);
setappdata(handles.aoi4,'y',S.y4);
setappdata(handles.aoi5,'x',S.x5);
setappdata(handles.aoi5,'y',S.y5);
setappdata(handles.aoi6,'x',S.x6);
setappdata(handles.aoi6,'y',S.y6);
setappdata(handles.aoi7,'x',S.x7);
setappdata(handles.aoi7,'y',S.y7);
setappdata(handles.aoi8,'x',S.x8);
setappdata(handles.aoi8,'y',S.y8);
setappdata(handles.aoi9,'x',S.x9);
setappdata(handles.aoi9,'y',S.y9);
setappdata(handles.aoi10,'x',S.x10);
setappdata(handles.aoi10,'y',S.y10);
setappdata(handles.aoi11,'x',S.x11);
setappdata(handles.aoi11,'y',S.y11);
setappdata(handles.aoi12,'x',S.x12);
setappdata(handles.aoi12,'y',S.y12);


 
function reset_Callback(hObject, eventdata, handles)
M = getappdata(handles.LoadFolder,'M');
guidata(hObject,handles);
cla(handles.axes);
Image = getappdata(handles.axes,'Image');  
ImagePath = getappdata(handles.axes,'ImagePath');  
img = imread(fullfile([ImagePath Image]));
imshow(img, 'Parent',handles.axes);
hold on; 

sizeX = getappdata(handles.axes,'sizeX');
sizeY = getappdata(handles.axes,'sizeY');
hmAddAll = zeros(sizeX,sizeY);
hmAdd = add(M,sizeX,sizeY); 
hmAddAll = hmAddAll + hmAdd;
h1 = fspecial('disk',floor(20));
hmAddAll = imfilter(hmAddAll,h1);
c = jet(64);
colormap(c);
h =  image(hmAddAll,'CDataMapping','scaled');
hmAddAlpha = addAlpha( hmAddAll, sizeX, sizeY, get(handles.Transp, 'Value'), get(handles.CutOff, 'Value')  );
set(h,'AlphaData',hmAddAlpha);
setappdata(handles.LoadFolder,'hmAddAll',hmAddAll);
set(handles.min,'String',"");
set(handles.max,'String',"");
 
