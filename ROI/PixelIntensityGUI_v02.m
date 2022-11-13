function varargout = PixelIntensityGUI_v02(varargin)
% PIXELINTENSITYGUI_V02 MATLAB code for PixelIntensityGUI_v02.fig
%      PIXELINTENSITYGUI_V02, by itself, creates a new PIXELINTENSITYGUI_V02 or raises the existing
%      singleton*.
%
%      H = PIXELINTENSITYGUI_V02 returns the handle to a new PIXELINTENSITYGUI_V02 or the handle to
%      the existing singleton*.
%
%      PIXELINTENSITYGUI_V02('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIXELINTENSITYGUI_V02.M with the given input arguments.
%
%      PIXELINTENSITYGUI_V02('Property','Value',...) creates a new PIXELINTENSITYGUI_V02 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PixelIntensityGUI_v02_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PixelIntensityGUI_v02_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PixelIntensityGUI_v02

% Last Modified by GUIDE v2.5 30-Mar-2014 14:31:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PixelIntensityGUI_v02_OpeningFcn, ...
    'gui_OutputFcn',  @PixelIntensityGUI_v02_OutputFcn, ...
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


% --- Executes just before PixelIntensityGUI_v02 is made visible.
function PixelIntensityGUI_v02_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PixelIntensityGUI_v02 (see VARARGIN)

% Choose default command line output for PixelIntensityGUI_v02
handles.output = hObject;

set(handles.imagePlace,'Visible','off')
set(handles.rgbOpts,'Enable','off')
% set(handles.roiButton,'Enable','off');

set(handles.selFile,'Visible','off');
set(handles.fileList','Visible','off');

set(handles.pmPanel,'Visible','off');

set(handles.statusThresh,'Visible','off')
axes(handles.statusThresh)

% set(handles.pDatapanel,'Visible','off')
% set(handles.kdens,'XTickLabel',[],'YTickLabel',[]);
% set(handles.pHist,'XTickLabel',[],'YTickLabel',[]);

set(handles.HMList,'Visible','off');
set(handles.hmFiletext,'Visible','off');

set(handles.hmPanel,'Visible','off')

set(handles.rHeatMap,'Visible','off')
set(handles.gHeatMap,'Visible','off')
set(handles.polyOUT,'Visible','off')
set(handles.origIm,'Visible','off')

set(handles.batExp,'Enable','off')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PixelIntensityGUI_v02 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PixelIntensityGUI_v02_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function fOpts_Callback(hObject, eventdata, handles)
% hObject    handle to fOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function expIm_Callback(hObject, eventdata, handles)
% hObject    handle to expIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.selFile,'Visible','on');
set(handles.fileList','Visible','on');

cla(handles.imagePlace);
set(handles.fileList,'String',[]);
set(handles.fileNtext,'String',[]);

handles.PathName = uigetdir('C:\');
% fullFileLocation = fullfile(handles.PathName,handles.FileName);
% [~, fileName, fileExtension] = fileparts(fullFileLocation);

if handles.PathName == 0
    return
else
    
    working_directory = handles.PathName;
    
    cd(working_directory);
    
    dirout = dir;
    dirFile = dirout(3).name;
    [~,~,extension] = fileparts(dirFile);
    
    if ~ismember(extension,{'.tiff','.tif'});
        warndlg('Folder does NOT contain .tif files!!');
        return
    else
        
        if strcmp(extension,'.tif')
            tifNames = dir('*.tif');
        elseif strcmp(extension,'.tiff')
            tifNames = dir('*.tiff');
        end
        
        fNameS = {tifNames.name};
        
        set(handles.fileList,'String',fNameS);
        
        contents = cellstr(get(handles.fileList,'String'));
        
        handles.FileName = contents{get(handles.fileList,'Value')};
        
        cla(handles.imagePlace);
        
        handles.lImagefile = imread(handles.FileName);
        set(handles.imagePlace,'Visible','on')
        axes(handles.imagePlace)
        imshow(handles.lImagefile)
        
        set(handles.imagePlace,'XTick',[],'XTickLabel',[]);
        set(handles.imagePlace,'YTick',[],'YTickLabel',[]);
        set(handles.rgbOpts,'Enable','on')
        
        set(handles.redD,'Checked','off')
        set(handles.greenD,'Checked','off')
        set(handles.blueD,'Checked','off')
        set(handles.rgbD,'Checked','on')
        
        set(handles.fileNtext,'String',handles.FileName);
    end
end



guidata(hObject, handles);


% --------------------------------------------------------------------
function rgbOpts_Callback(hObject, eventdata, handles)
% hObject    handle to rgbOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function redD_Callback(hObject, eventdata, handles)
% hObject    handle to redD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.imagePlace,'Visible','on')
axes(handles.imagePlace)
imshow(handles.Red)

set(handles.redD,'Checked','on')
set(handles.greenD,'Checked','off')
set(handles.blueD,'Checked','off')
set(handles.rgbD,'Checked','off')

handles.IMAGEvisible = handles.Red;

guidata(hObject, handles);

% --------------------------------------------------------------------
function greenD_Callback(hObject, eventdata, handles)
% hObject    handle to greenD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.imagePlace,'Visible','on')
axes(handles.imagePlace)
imshow(handles.Green)

set(handles.redD,'Checked','off')
set(handles.greenD,'Checked','on')
set(handles.blueD,'Checked','off')
set(handles.rgbD,'Checked','off')

handles.IMAGEvisible = handles.Green;

guidata(hObject, handles);


% --------------------------------------------------------------------
function blueD_Callback(hObject, eventdata, handles)
% hObject    handle to blueD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.imagePlace,'Visible','on')
axes(handles.imagePlace)
imshow(handles.Blue)

set(handles.redD,'Checked','off')
set(handles.greenD,'Checked','off')
set(handles.blueD,'Checked','on')
set(handles.rgbD,'Checked','off')

handles.IMAGEvisible = handles.Blue;

guidata(hObject, handles);


% --------------------------------------------------------------------
function rgbD_Callback(hObject, eventdata, handles)
% hObject    handle to rgbD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.imagePlace,'Visible','on')
axes(handles.imagePlace)
imshow(handles.lImagefile)

set(handles.redD,'Checked','off')
set(handles.greenD,'Checked','off')
set(handles.blueD,'Checked','off')
set(handles.rgbD,'Checked','on')

handles.IMAGEvisible = handles.lImagefile;

guidata(hObject, handles);

% % --- Executes on button press in roiButton.
% function roiButton_Callback(hObject, eventdata, handles)
% % hObject    handle to roiButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Construct a questdlg with three options
% roiChoice = questdlg('Is this the channel you want to draw ROI, channel will be locked', ...
% 	'ROI DRAW', ...
% 	'Yes, I want to use this channel','No, I want to select a different channel','Yes');
% % Handle response
% switch roiChoice
%     case 'Yes, I want to use this channel'
%         set(handles.rgbOpts,'Enable','off');
%         set(handles.roiButton,'Enable','off');
%
%         [~, handles.xi, handles.yi] = roipoly(handles.IMAGEvisible);
%
%     case 'No, I want to select a different channel'
%
% end
%
%
%
% guidata(hObject, handles);


% --- Executes on selection change in fileList.
function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileList

contents = cellstr(get(hObject,'String'));

if isempty(contents{get(hObject,'Value')})
    return
else
    
    handles.FileName = contents{get(hObject,'Value')};
    
    cla(handles.imagePlace);
    
    handles.lImagefile = imread(handles.FileName);
    handles.Red = handles.lImagefile;
    handles.Green = handles.lImagefile;
    handles.Blue = handles.lImagefile;
    
    blank_color = zeros(size(handles.lImagefile,1),size(handles.lImagefile,2));
    
    colorS = {'Red','Green','Blue'};
    for i = 1:3
        colorI = colorS{i};
        switch colorI
            case 'Red'
                new.Red = handles.lImagefile(:,:,1);
                new.Green = uint8(blank_color);
                new.Blue = uint8(blank_color);
                
                for i2 = 1:3
                    handles.Red(:,:,i2) = new.(colorS{i2});
                end
            case 'Green'
                new.Red = uint8(blank_color);
                new.Green = handles.lImagefile(:,:,2);
                new.Blue = uint8(blank_color);
                
                for i2 = 1:3
                    handles.Green(:,:,i2) = new.(colorS{i2});
                end
            case 'Blue'
                new.Red = uint8(blank_color);
                new.Green = uint8(blank_color);
                new.Blue = handles.lImagefile(:,:,3);
                
                for i2 = 1:3
                    handles.Blue(:,:,i2) = new.(colorS{i2});
                end
        end
    end
    
    set(handles.imagePlace,'XTick',[],'XTickLabel',[]);
    set(handles.imagePlace,'YTick',[],'YTickLabel',[]);
    set(handles.rgbOpts,'Enable','on')
    
    set(handles.imagePlace,'Visible','on')
    axes(handles.imagePlace)
    imshow(handles.lImagefile)
    
    set(handles.redD,'Checked','off')
    set(handles.greenD,'Checked','off')
    set(handles.blueD,'Checked','off')
    set(handles.rgbD,'Checked','on')
    
    set(handles.fileNtext,'String',handles.FileName);
    %     set(handles.roiButton,'Enable','on');
    
    handles.IMAGEvisible = handles.lImagefile;
    
end
% end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mPixelT.
function mPixelT_Callback(hObject, eventdata, handles)
% hObject    handle to mPixelT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

red_threshold = zeros();
green_threshold = zeros();

set(handles.mPixelT,'Enable','off')

for i = 1:length(handles.fNameS)
    
    % load image file
    fn = handles.fNameS{i};
    
    if strcmp(fn,'newraw.tif')
        continue
    end
    
    set(handles.fileNtext,'String',fn)
    
    tempFile = imread(fn);
    redpixels = tempFile(:,:,1);
    greenpixels = tempFile(:,:,2);
    
    [dim1,dim2] = size(redpixels);
    
    totPixels = dim1*dim2;
    onePercent = totPixels*0.01;
    boxDim = round(sqrt(onePercent));
    halfBD = round(boxDim/2);
    
    cla(handles.imagePlace) % REPEAT THIS LINE OUTSIDE TOGGLE
    axes(handles.imagePlace)
    imshow(tempFile); % REPEAT THIS LINE OUTSIDE TOGGLE
    
    set(handles.FILEname,'String','Click image to place threshold square');
    [x_coord, y_coord] = ginput(1);
    set(handles.FILEname,'String',[]);
    x_coord = round(x_coord);
    y_coord = round(y_coord);
    
    sXcoords = round([x_coord - halfBD , x_coord + halfBD, x_coord + halfBD, x_coord - halfBD]);
    sYcoords = round([y_coord - halfBD , y_coord - halfBD, y_coord + halfBD, y_coord + halfBD]);
    
    hold on
    
    samplebox = roipoly(dim2,dim1,sYcoords,sXcoords);
    nts_mask = poly2mask(sXcoords,sYcoords,dim1,dim2);
    [Bi, ~] = bwboundaries(samplebox,'noholes');
    boxIndices = cell2mat(Bi);
    boxPlotsS = boxIndices;
    
    hold on
    axes(handles.imagePlace)
    plot(boxPlotsS(:,1),boxPlotsS(:,2),'y')
    
    num_Gpxls = greenpixels(nts_mask);
    sngGpixels = single(num_Gpxls);
    
    num_Rpxls = redpixels(nts_mask);
    sngRpixels = single(num_Rpxls);
    
    red_threshold(i) = mean(sngRpixels);
    green_threshold(i) = mean(sngGpixels);
    
    set(handles.FILEname,'String','Press Enter to move to next image');
    
    pause
    
end

handles.red_threshold = red_threshold;
handles.green_threshold = green_threshold;

axes(handles.statusThresh)
set(handles.mPixelT,'Enable','off')

set(handles.hmPanel,'Visible','on')

set(handles.fileNtext,'String',[])
set(handles.FILEname,'String',[])

set(handles.batExp,'Enable','on')

guidata(hObject, handles);

% --------------------------------------------------------------------
function createHM_Callback(hObject, eventdata, handles)
% hObject    handle to createHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.imagePlace);
set(handles.fileNtext,'String',[]);
set(handles.imagePlace,'Visible','off')
set(handles.rgbOpts,'Enable','off')
% set(handles.roiButton,'Enable','off');

set(handles.selFile,'Visible','off');
set(handles.fileList,'Visible','off');

handles.PathName = uigetdir('C:\');

if handles.PathName == 0
    return
else
    
    working_directory = handles.PathName;
    
    cd(working_directory);
    
    dirout = dir;
    dirFile = dirout(3).name;
    [~,~,extension] = fileparts(dirFile);
    
    if ~ismember(extension,{'.tiff','.tif'});
        warndlg('Folder does NOT contain .tif files!!');
        return
    else
        
        if strcmp(extension,'.tif')
            tifNames = dir('*.tif');
        elseif strcmp(extension,'.tiff')
            tifNames = dir('*.tiff');
        end
        
        handles.fNameS = {tifNames.name};
        
        set(handles.pmPanel,'Visible','on');
        set(handles.fileNtext,'String',handles.PathName,'FontSize',12);
        
    end
    
end

set(handles.mPixelT,'Value',0)
set(handles.mPixelT,'Enable','on')

guidata(hObject, handles);

% --- Executes on button press in heatPlot.
function heatPlot_Callback(hObject, eventdata, handles)
% hObject    handle to heatPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.HMList,'Visible','on');

cla(handles.imagePlace);
set(handles.HMList,'String', handles.fNameS);
set(handles.hmFiletext,'Visible','on');
set(handles.fileNtext,'String',[]);

guidata(hObject, handles);


% --- Executes on selection change in HMList.
function HMList_Callback(hObject, eventdata, handles)
% hObject    handle to HMList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns HMList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from HMList

set(handles.HMList,'Enable','off')

contents = cellstr(get(hObject,'String'));

% Turn off buttons

set(handles.rHeatMap,'Enable','off')
set(handles.gHeatMap,'Enable','off')
set(handles.polyOUT,'Enable','off')
set(handles.origIm,'Enable','off')

set(handles.rHeatMap,'Visible','off')
set(handles.gHeatMap,'Visible','off')
set(handles.polyOUT,'Visible','off')
set(handles.origIm,'Visible','off')

% cla(handles.kdens)
% cla(handles.pHist)
cla(handles.imagePlace)

if isempty(contents{get(hObject,'Value')})
    return
else
    
    handles.FileName = contents{get(hObject,'Value')};
    
    cla(handles.imagePlace);
    
    handles.lImagefile = imread(handles.FileName);
    handles.Red = handles.lImagefile;
    handles.Green = handles.lImagefile;
    handles.Blue = handles.lImagefile;
    
    blank_color = zeros(size(handles.lImagefile,1),size(handles.lImagefile,2));
    
    colorS = {'Red','Green','Blue'};
    for i = 1:3
        colorI = colorS{i};
        switch colorI
            case 'Red'
                new.Red = handles.lImagefile(:,:,1);
                new.Green = uint8(blank_color);
                new.Blue = uint8(blank_color);
                
                for i2 = 1:3
                    handles.Red(:,:,i2) = new.(colorS{i2});
                end
            case 'Green'
                new.Red = uint8(blank_color);
                new.Green = handles.lImagefile(:,:,2);
                new.Blue = uint8(blank_color);
                
                for i2 = 1:3
                    handles.Green(:,:,i2) = new.(colorS{i2});
                end
            case 'Blue'
                new.Red = uint8(blank_color);
                new.Green = uint8(blank_color);
                new.Blue = handles.lImagefile(:,:,3);
                
                for i2 = 1:3
                    handles.Blue(:,:,i2) = new.(colorS{i2});
                end
        end
    end
    
    set(handles.imagePlace,'XTick',[],'XTickLabel',[]);
    set(handles.imagePlace,'YTick',[],'YTickLabel',[]);
    set(handles.rgbOpts,'Enable','on')
    
    set(handles.imagePlace,'Visible','on')
    axes(handles.imagePlace)
    imshow(handles.lImagefile)
    
    set(handles.redD,'Checked','off')
    set(handles.greenD,'Checked','off')
    set(handles.blueD,'Checked','off')
    set(handles.rgbD,'Checked','on')
    
    set(handles.FILEname,'String','DRAW POLYGON')
    set(handles.fileNtext,'String',handles.FileName)
    
    
    handles.IMAGEvisible = handles.lImagefile;
    
    % Heat map analysis
    
    tempImage = imread(handles.FileName);
    
    % Create matrix variable for red pixels
    redpixels = tempImage(:,:,1);
    % Create matrix variable for green pixels
    greenpixels = tempImage(:,:,2);
    % Create matrix variable for blue pixels
    % bluepixels = a(:,:,3);
    
    % Initalize interface to trace Region Of Interest (roi)
    [~, xi, yi] = roipoly(handles.FileName);
    cla(handles.imagePlace)
    nts_boundary = roipoly(tempImage,xi,yi);
    
    % Get single image dimensions
    polydim = size(tempImage); % Dimensions of image file
    polyx = polydim(1,1); % X dimension of image
    polyy = polydim(1,2); % Y dimension of image
    
    % Create NTS mask
    nts_mask = poly2mask(xi,yi,polyx,polyy);
    
    % Extract location/position information from nts mask
    [boundary_coordinates,logic_boundary_matrix] = bwboundaries(nts_boundary,'noholes');
    handles.maskIndices = cell2mat(boundary_coordinates);
    
    num_Gpxls = greenpixels(nts_mask);
    sngGpixels = single(num_Gpxls);
    
    thresholdG = mean(handles.green_threshold) + 2*std(handles.green_threshold);
    maxGpixel = max(sngGpixels);
    Gpixelindex = find(num_Gpxls > thresholdG);
    Gpixel_hist = num_Gpxls(Gpixelindex);
    
    % Green plot
    
    Gbgpixels2double = double(Gpixel_hist);
    Gnumpixels2double = double(num_Gpxls);
    
    % Get red pixels
    
    % Extracts a vector of red pixels from within nts mask
    num_Rpxls = redpixels(nts_mask);
    num_Rpxls2 = numel(num_Rpxls);
    sngRpixels = single(num_Rpxls);
    thresholdR = mean(handles.red_threshold) + 2*std(handles.red_threshold);
    maxRpixel = max(sngRpixels);
    Rpixelindex = find(num_Rpxls > thresholdR);
    Rpixden = numel(Rpixelindex)/num_Rpxls2;
    Rpixel_hist = num_Rpxls(Rpixelindex);
    
    Rbgpixels2double = double(Rpixel_hist);
    Rnumpixels2double = double(num_Rpxls);
    
    % Calculate red intensity mask & density
    red_pixel_intensity = roicolor(redpixels,thresholdR,maxRpixel);
    [Rintsity_threshold_coordinates,handles.Rintensity_mask_matrix] = bwboundaries(red_pixel_intensity,'noholes');
    find_red_pixels_above = find(handles.Rintensity_mask_matrix > 0);
    numSupra_thresh_red = numel(find_red_pixels_above);
    
    green_pixel_intensity = roicolor(greenpixels,thresholdG,maxGpixel);
    [Gintsity_threshold_coordinates,handles.Gintensity_mask_matrix] = bwboundaries(green_pixel_intensity,'noholes');
    find_green_pixels_above = find(handles.Gintensity_mask_matrix > 0);
    numSupra_thresh_green = numel(find_green_pixels_above);
    
    GIndicies = cell2mat(Gintsity_threshold_coordinates);
    RIndicies = cell2mat(Rintsity_threshold_coordinates);
    
    handles.Gintensity_mask_matrix(find(handles.Gintensity_mask_matrix > 0)) = 1;
    
    STATSgp = regionprops(handles.Gintensity_mask_matrix, greenpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');
    
    gpixelplot = STATSgp.PixelList;
    gpixelplotVal = STATSgp.PixelValues;
    
    handles.Rintensity_mask_matrix(find(handles.Rintensity_mask_matrix > 0)) = 1;
    
    STATSrp = regionprops(handles.Rintensity_mask_matrix, redpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');
    
    rpixelplot = STATSrp.PixelList;
    rpixelplotVal = STATSrp.PixelValues;
    
    
    handles.Rheat = zeros(size(handles.Rintensity_mask_matrix));
    for i = 1:length(rpixelplotVal);
        handles.Rheat(rpixelplot(i,2),rpixelplot(i,1)) = rpixelplotVal(i);
        %for x = 1:length(rpixelplotVal);
    end
    
    
    handles.Gheat = zeros(size(handles.Gintensity_mask_matrix));
    for j = 1:length(gpixelplotVal);
        handles.Gheat(gpixelplot(j,2),gpixelplot(j,1)) = gpixelplotVal(j);
        %for x = 1:length(rpixelplotVal);
    end
    
    set(handles.rHeatMap,'Visible','on')
    set(handles.gHeatMap,'Visible','on')
    set(handles.polyOUT,'Visible','on')
    set(handles.origIm,'Visible','on')
    
    set(handles.rHeatMap,'Enable','on')
    set(handles.gHeatMap,'Enable','on')
    set(handles.polyOUT,'Enable','on')
    set(handles.origIm,'Enable','on')
    
    set(handles.FILEname,'String',[])
end

set(handles.HMList,'Enable','on')

% end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function HMList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HMList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rHeatMap.
function rHeatMap_Callback(hObject, eventdata, handles)
% hObject    handle to rHeatMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rHeatMap

check = get(hObject,'Value');

checkPoly = get(handles.polyOUT,'Value');

if check
    cla(handles.imagePlace)
    axes(handles.imagePlace)
    
    h1 = image(handles.Rheat,'CDataMapping','scaled');
    colormap(jet(256));
    set(h1, 'AlphaData', handles.Rintensity_mask_matrix);
    colorbar
    
    if checkPoly
        hold on
        plot(handles.maskIndices(:,2),handles.maskIndices(:,1),'k');
    end
    
    set(handles.gHeatMap,'Value',0)
    set(handles.origIm,'Value',0)
    
end

guidata(hObject, handles);

% --- Executes on button press in gHeatMap.
function gHeatMap_Callback(hObject, eventdata, handles)
% hObject    handle to gHeatMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gHeatMap

check = get(hObject,'Value');

checkPoly = get(handles.polyOUT,'Value');

if check
    cla(handles.imagePlace)
    axes(handles.imagePlace)
    
    h1 = image(handles.Gheat,'CDataMapping','scaled');
    colormap(jet(256));
    set(h1, 'AlphaData', handles.Gintensity_mask_matrix);
    colorbar
    
    if checkPoly
        hold on
        plot(handles.maskIndices(:,2),handles.maskIndices(:,1),'k');
    end
    
    set(handles.rHeatMap,'Value',0)
    set(handles.origIm,'Value',0)
    
end

guidata(hObject, handles);

% --- Executes on button press in polyOUT.
function polyOUT_Callback(hObject, eventdata, handles)
% hObject    handle to polyOUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of polyOUT

check = get(hObject,'Value');
RchanCheck = get(handles.rHeatMap,'Value');
GchanCheck = get(handles.gHeatMap,'Value');
ImageCheck = get(handles.origIm,'Value');

if check
    
    axes(handles.imagePlace)
    hold on
    
    if ImageCheck
        plot(handles.maskIndices(:,2),handles.maskIndices(:,1),'y','LineWidth',2);
    else
        plot(handles.maskIndices(:,2),handles.maskIndices(:,1),'k');
    end
    
else
    cla(handles.imagePlace)
    if RchanCheck
        axes(handles.imagePlace)
        
        h1 = image(handles.Rheat,'CDataMapping','scaled');
        colormap(jet(256));
        set(h1, 'AlphaData', handles.Rintensity_mask_matrix);
        colorbar
        
    elseif GchanCheck
        axes(handles.imagePlace)
        
        h1 = image(handles.Gheat,'CDataMapping','scaled');
        colormap(jet(256));
        set(h1, 'AlphaData', handles.Gintensity_mask_matrix);
        colorbar
        
    elseif ImageCheck
        axes(handles.imagePlace)
        imshow(handles.FileName)
    end
    
    
end

guidata(hObject, handles);


% --- Executes on button press in origIm.
function origIm_Callback(hObject, eventdata, handles)
% hObject    handle to origIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of origIm

check = get(hObject,'Value');

checkPoly = get(handles.polyOUT,'Value');

if check
    cla(handles.imagePlace)
    axes(handles.imagePlace)
    
    imshow(handles.FileName)
    
    if checkPoly
        hold on
        plot(handles.maskIndices(:,2),handles.maskIndices(:,1),'y','LineWidth',2);
    end
    
    set(handles.rHeatMap,'Value',0)
    set(handles.gHeatMap,'Value',0)
    
end

guidata(hObject, handles);


% --------------------------------------------------------------------
function saveOpts_Callback(hObject, eventdata, handles)
% hObject    handle to saveOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saExp_Callback(hObject, eventdata, handles)
% hObject    handle to saExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.savePath = uigetdir('C:\');

if handles.savePath == 0
    return
else
    
    [~,imName,~] = fileparts(handles.FileName);
    default = {imName};
    
    saveName = inputdlg({'Save name'}, 'Save Name', [1 30], default);
    
    % Construct a questdlg with three options
    imgType = questdlg('Choose image export file type', ...
        'Image File Type', ...
        'TIF','JPEG','TIF');
    % Handle response
    switch imgType
        case 'TIF'
            imageExt = '.tif';
        case 'JPEG'
            imageExt = '.jpg';
    end
    
    polyQuest = questdlg('With or without polygon overlay', ...
        'Polygon Overlay', ...
        'With Overlay','Without Overlay','With Overlay');
    % Handle response
    switch polyQuest
        case 'With Overlay'
            overlayOpt = 1;
        case 'Without Overlay'
            overlayOpt = 0;
    end
    
    
    
    
end


guidata(hObject, handles);


% --------------------------------------------------------------------
function batExp_Callback(hObject, eventdata, handles)
% hObject    handle to batExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

expquest = questdlg('Are you sure you want to BATCH EXPORT?','BATCH?',...
    'Yes','No','Yes');

switch expquest
    case 'Yes'
        
        handles.savePath = uigetdir('C:\');

        set(handles.HMList,'Enable','off')
        set(handles.heatPlot,'Enable','off')
        set(handles.rgbOpts,'Enable','off')
        set(handles.saveOpts,'Enable','off')
        set(handles.batExp,'Enable','off')

        fileNames = handles.fNameS;

        cla(handles.imagePlace)
        
            set(handles.rHeatMap,'Visible','off')
            set(handles.gHeatMap,'Visible','off')
            set(handles.polyOUT,'Visible','off')
            set(handles.origIm,'Visible','off')
            
            set(handles.rHeatMap,'Enable','off')
            set(handles.gHeatMap,'Enable','off')
            set(handles.polyOUT,'Enable','off')
            set(handles.origIm,'Enable','off')
        
        for fi = 1:length(fileNames)
            
            set(handles.HMList,'Value',fi)

            handles.FileName = fileNames{fi};
            
            cla(handles.imagePlace);
            
            cd(handles.PathName)
            
            handles.lImagefile = imread(handles.FileName);
            handles.Red = handles.lImagefile;
            handles.Green = handles.lImagefile;
            handles.Blue = handles.lImagefile;
            
            blank_color = zeros(size(handles.lImagefile,1),size(handles.lImagefile,2));
            
            colorS = {'Red','Green','Blue'};
            for i = 1:3
                colorI = colorS{i};
                switch colorI
                    case 'Red'
                        new.Red = handles.lImagefile(:,:,1);
                        new.Green = uint8(blank_color);
                        new.Blue = uint8(blank_color);
                        
                        for i2 = 1:3
                            handles.Red(:,:,i2) = new.(colorS{i2});
                        end
                    case 'Green'
                        new.Red = uint8(blank_color);
                        new.Green = handles.lImagefile(:,:,2);
                        new.Blue = uint8(blank_color);
                        
                        for i2 = 1:3
                            handles.Green(:,:,i2) = new.(colorS{i2});
                        end
                    case 'Blue'
                        new.Red = uint8(blank_color);
                        new.Green = uint8(blank_color);
                        new.Blue = handles.lImagefile(:,:,3);
                        
                        for i2 = 1:3
                            handles.Blue(:,:,i2) = new.(colorS{i2});
                        end
                end
            end
            
            set(handles.imagePlace,'XTick',[],'XTickLabel',[]);
            set(handles.imagePlace,'YTick',[],'YTickLabel',[]);
            set(handles.rgbOpts,'Enable','on')
            
            set(handles.imagePlace,'Visible','on')
            axes(handles.imagePlace)
            imshow(handles.lImagefile)
            
            set(handles.redD,'Checked','off')
            set(handles.greenD,'Checked','off')
            set(handles.blueD,'Checked','off')
            set(handles.rgbD,'Checked','on')
            
            set(handles.FILEname,'String','DRAW POLYGON')
            set(handles.fileNtext,'String',handles.FileName)
            
            handles.IMAGEvisible = handles.lImagefile;
            
            % Heat map analysis
            
            tempImage = imread(handles.FileName);
            
            % Create matrix variable for red pixels
            redpixels = tempImage(:,:,1);
            % Create matrix variable for green pixels
            greenpixels = tempImage(:,:,2);
            % Create matrix variable for blue pixels
            % bluepixels = a(:,:,3);
            
            % Initalize interface to trace Region Of Interest (roi)
            [~, xi, yi] = roipoly(handles.FileName);
            cla(handles.imagePlace)
            nts_boundary = roipoly(tempImage,xi,yi);
            
            % Get single image dimensions
            polydim = size(tempImage); % Dimensions of image file
            polyx = polydim(1,1); % X dimension of image
            polyy = polydim(1,2); % Y dimension of image
            
            % Create NTS mask
            nts_mask = poly2mask(xi,yi,polyx,polyy);
            
            % Extract location/position information from nts mask
            [boundary_coordinates,logic_boundary_matrix] = bwboundaries(nts_boundary,'noholes');
            handles.maskIndices = cell2mat(boundary_coordinates);
            
            num_Gpxls = greenpixels(nts_mask);
            sngGpixels = single(num_Gpxls);
            
            thresholdG = mean(handles.green_threshold) + 2*std(handles.green_threshold);
            maxGpixel = max(sngGpixels);
            Gpixelindex = find(num_Gpxls > thresholdG);
            Gpixel_hist = num_Gpxls(Gpixelindex);
            
            % Green plot
            
            Gbgpixels2double = double(Gpixel_hist);
            Gnumpixels2double = double(num_Gpxls);
            
            % Get red pixels
            
            % Extracts a vector of red pixels from within nts mask
            num_Rpxls = redpixels(nts_mask);
            num_Rpxls2 = numel(num_Rpxls);
            sngRpixels = single(num_Rpxls);
            thresholdR = mean(handles.red_threshold) + 2*std(handles.red_threshold);
            maxRpixel = max(sngRpixels);
            Rpixelindex = find(num_Rpxls > thresholdR);
            Rpixden = numel(Rpixelindex)/num_Rpxls2;
            Rpixel_hist = num_Rpxls(Rpixelindex);
            
            Rbgpixels2double = double(Rpixel_hist);
            Rnumpixels2double = double(num_Rpxls);
            
            % Calculate red intensity mask & density
            red_pixel_intensity = roicolor(redpixels,thresholdR,maxRpixel);
            [Rintsity_threshold_coordinates,handles.Rintensity_mask_matrix] = bwboundaries(red_pixel_intensity,'noholes');
            find_red_pixels_above = find(handles.Rintensity_mask_matrix > 0);
            numSupra_thresh_red = numel(find_red_pixels_above);
            
            green_pixel_intensity = roicolor(greenpixels,thresholdG,maxGpixel);
            [Gintsity_threshold_coordinates,handles.Gintensity_mask_matrix] = bwboundaries(green_pixel_intensity,'noholes');
            find_green_pixels_above = find(handles.Gintensity_mask_matrix > 0);
            numSupra_thresh_green = numel(find_green_pixels_above);
            
            GIndicies = cell2mat(Gintsity_threshold_coordinates);
            RIndicies = cell2mat(Rintsity_threshold_coordinates);
            
            handles.Gintensity_mask_matrix(find(handles.Gintensity_mask_matrix > 0)) = 1;
            
            STATSgp = regionprops(handles.Gintensity_mask_matrix, greenpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');
            
            gpixelplot = STATSgp.PixelList;
            gpixelplotVal = STATSgp.PixelValues;
            
            handles.Rintensity_mask_matrix(find(handles.Rintensity_mask_matrix > 0)) = 1;
            
            STATSrp = regionprops(handles.Rintensity_mask_matrix, redpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');
            
            rpixelplot = STATSrp.PixelList;
            rpixelplotVal = STATSrp.PixelValues;
            
            
            handles.Rheat = zeros(size(handles.Rintensity_mask_matrix));
            for i = 1:length(rpixelplotVal);
                handles.Rheat(rpixelplot(i,2),rpixelplot(i,1)) = rpixelplotVal(i);
                %for x = 1:length(rpixelplotVal);
            end
            
            
            handles.Gheat = zeros(size(handles.Gintensity_mask_matrix));
            for j = 1:length(gpixelplotVal);
                handles.Gheat(gpixelplot(j,2),gpixelplot(j,1)) = gpixelplotVal(j);
                %for x = 1:length(rpixelplotVal);
            end
            
            imName = strtok(handles.FileName,'.');
            
            for grplS = 1:2
                
                switch grplS
                    case 1
                        gf = figure;
                        
                        h1 = image(handles.Gheat,'CDataMapping','scaled');
                        colormap(jet(256));
                        set(h1, 'AlphaData', handles.Gintensity_mask_matrix);
                        colorbar

                        saveName = strcat('GreenHeatPlot',imName,'.fig');
                        
                        cd(handles.savePath)
                        saveas(gf,saveName)
                        close(gf)
                        
                    case 2
                        rf = figure;
                        
                        h1 = image(handles.Rheat,'CDataMapping','scaled');
                        colormap(jet(256));
                        set(h1, 'AlphaData', handles.Rintensity_mask_matrix);
                        colorbar
                        
                        saveName = strcat('RedHeatPlot',imName,'.fig');
                        
                        cd(handles.savePath)
                        saveas(rf,saveName)
                        close(rf)
                        
                end
            end
            
            

            
            set(handles.FILEname,'String',[])
        end
        
        
        
        
        
    case 'No'
        return
end


guidata(hObject, handles);


% --------------------------------------------------------------------
function exitProg_Callback(hObject, eventdata, handles)
% hObject    handle to exitProg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


exitquest = questdlg('Are you sure you want to EXIT the program?','Exit?',...
    'Yes','No','Yes');

switch exitquest
    case 'Yes'
        delete(handles.figure1);
    case 'No'
        return
end
