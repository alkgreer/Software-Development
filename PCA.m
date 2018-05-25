function varargout = PCA(varargin)
% PCA MATLAB code for PCA.fig
%      PCA, by itself, creates a new PCA or raises the existing
%      singleton*.
%
%      H = PCA returns the handle to a new PCA or the handle to
%      the existing singleton*.
%
%      PCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCA.M with the given input arguments.
%
%      PCA('Property','Value',...) creates a new PCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCA

% Last Modified by GUIDE v2.5 31-Jul-2017 18:17:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA_OutputFcn, ...
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


% --- Executes just before PCA is made visible.
function PCA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCA (see VARARGIN)

plot_4_handle = handles.plot4; %handle for 3D Plot
rotate3d(plot_4_handle);%rotating only the 3D plot
scatter3(handles.plot4,1:10, 1:10, 1:10,'.w'); %plots a 3D blank default graph on plot 4

% Choose default command line output for PCA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = PCA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Get default command line output from handles structure
varargout{1} = handles.output;
 
function setGlobalPath(val)
global fullPath
fullPath = val;
 
function fullPth = getGlobalPath
global fullPath
fullPth = fullPath;

function setGlobalExtension(val)
global extension
extension = val;
 
function textEx = getGlobalExtension
global extension
textEx = extension;

function setGlobalMessagebox(val)
global handle
handle = val;
 
function messagebox = getGlobalMessagebox
global handle
messagebox = handle;


% --- Executes on button press in helpBtn.
function helpBtn_Callback(hObject, eventdata, handles)
% hObject    handle to helpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Call modaldlg with the argument 'Position'.
Help_Menu();






% --- Executes on button press in txtBtn.
function txtBtn_Callback(hObject, eventdata, handles)
% hObject    handle to txtBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Force messagebox to close if user has not closed it
current_messagebox = getGlobalMessagebox();
delete(current_messagebox);

%Let user choose file
[filename1, pathname1] = uigetfile({'*.txt','All Files'});

if filename1 ~= 0
    %Create the full pathname for file so it can be accessed globally
    fullPthName = strcat(pathname1,filename1); %concat the path and file name
    %try to load file
    try
        current_data = load(fullPthName);
    catch %user entered wrong datatype in file
        not_correct_file_character_type = msgbox('WARNING:You have chosen a file with an incorrect datatype and PCA cannot be performed', 'Error', 'help' );
        setGlobalMessagebox(not_correct_file_character_type);
        return
    end
    [rows , columns] = size(current_data);
    % warn user if choose over 20 proteins
    if rows > 20
        %Display a Message if the user has not chosen a file
        too_many_proteins_message = msgbox('WARNING:You have chosen a file with more than 20 Proteins and PCA cannot be performed.', 'Error', 'help' );
        setGlobalMessagebox(too_many_proteins_message);
    %User chosen correct file with many proteins
    elseif rows >= 10 && rows <= 20
        %Display a Message if the user has not chosen a file
        too_many_proteins_message = msgbox('WARNING:You have chosen a file with more than 10 Proteins and this could affect readability.', 'Error', 'help' );
        setGlobalMessagebox(too_many_proteins_message);
        %Let program know what file you are looking at 
        setGlobalExtension('.txt');
        %Set global path
        setGlobalPath(fullPthName);
    % warn user if choose over 0 proteins
    elseif rows == 0
        %Display a Message if the user has not chosen a file
        no_proteins_message = msgbox('WARNING:You have chosen a file with 0 Proteins and PCA cannot be performed.', 'Error', 'help' );
        setGlobalMessagebox(no_proteins_message);
    % warn user if choose not enough info per protein
    elseif columns < 12
        %Display a Message if the user has not chosen a file
        not_enough_info_message = msgbox('WARNING:You have chosen a file with less than data 12 values per protein and PCA cannot be performed.', 'Error', 'help' );
        setGlobalMessagebox(not_enough_info_message);
    else % user chose ideal file
        %Let program know what file you are looking at 
        setGlobalExtension('.txt');
        %Set global path
        setGlobalPath(fullPthName);
    end
end


% --- Executes on button press in imgBtn.
function imgBtn_Callback(hObject, eventdata, handles)
% hObject    handle to imgBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Force messagebox to close if user has not closed it
current_messagebox = getGlobalMessagebox();
delete(current_messagebox);

%Let user choose file
[filename2, pathname2] = uigetfile('*.jpg*','D:\Users\Public\Pictures\Sample Pictures');

if filename2 ~= 0
    %Create the full pathname for file so it can be accessed globally
    fullPthName = strcat(pathname2,filename2); %concat the path and file name
    Img = imread(fullPthName);
    [width, height, ~] = size(Img);
    %Warn user if they chose wrong image dimension
    if width ~= 156 && height ~= 120
        not_correct_img_message = msgbox('WARNING:You have entered an image that is not 120x156 in size.PCA cannot be performed.', 'Error', 'help' );
        setGlobalMessagebox(not_correct_img_message);
    else%correct file chosen
        %Let program know what file you are looking at 
        setGlobalExtension('.jpeg');
        %set global path to correct path
        setGlobalPath(fullPthName);
    end
end

% --- Executes on button press in pcaBtn.
function pcaBtn_Callback(hObject, eventdata, handles)
% hObject    handle to pcaBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Force messagebox to close if user has not closed it
current_messagebox = getGlobalMessagebox();
delete(current_messagebox);

%Confirm path
current_path = getGlobalPath();

%Confirm extension
extension = getGlobalExtension();

%Only perform PCA if user chose a file
if ~isempty(current_path) 
    number_of_proteins = [];
    %Only call ImgToGray function if user chose .jpeg
    if strcmp(extension,'.jpeg')
        %Don't show the componet percentages of any previous datasets
        set(handles.textPC1, 'Visible', 'off');
        set(handles.textPC2, 'Visible', 'off');
        set(handles.textPC3, 'Visible', 'off');
        Img = imread(current_path);
        [width, height, ~] = size(Img);
        %Warn user if they chose wrong image dimension
        if width ~= 156 && height ~= 120
            not_correct_img_message = msgbox('WARNING:You have entered an image that is not 120x156 in size.PCA cannot be performed.', 'Error', 'help' );
            setGlobalMessagebox(not_correct_img_message);
        else
            current_data = ImgToGray(current_path);
        end
        
    else%User chose .txt
        current_data = load(current_path);
        [rows , columns] = size(current_data);
        current_data = load(current_path);
        [~,~,~,~,explained]= pca(current_data);

        %Display PC components variance percentage in static text fields
        percentages = round(explained, 1);
        set(handles.textPC1, 'String', ['PC1% ' num2str(percentages(1))]);
        set(handles.textPC1, 'Visible', 'on');
        set(handles.textPC2, 'String', ['PC2% ' num2str(percentages(2))]);
        set(handles.textPC2, 'Visible', 'on');
        set(handles.textPC3, 'String', ['PC3% ' num2str(percentages(3))]);
        set(handles.textPC3, 'Visible', 'on');
        
    end
    
    %Confirm number of proteins by dataset rows
    [num_of_rows , ~] = size(current_data);
    number_of_proteins = [number_of_proteins 1:num_of_rows];
    %Initialize array with at least 12 values in each number of rows
    PCA_data = zeros(num_of_rows,12);
    
    %Peform PCA row by row
    for i = 1:num_of_rows
        [U, l] = pca_calc(current_data(i,:),12);
        PCA_data(i,:) = current_data(i,:)*U;
        write_files('Eigenvectors.txt',U);
        write_files('Eigenvalues.txt',l);
        write_files('PCA_data.txt',PCA_data);
    end
    %current_data = current_data - mean(mean(d));%normalize per experiment
    %current_data = current_data - mean(d(1,:));%normalize with blank
    
    %Plot graph 1 with pc1 pc2
    axes(handles.plot1);
    plot_with_cluster(handles.plot1,PCA_data,number_of_proteins',1,2);
    grid('on')
    xlabel('PC1');
    ylabel('PC2');
    
    %Plot graph 2 with pc1 pc3
    axes(handles.plot2);
    plot_with_cluster(handles.plot2,PCA_data,number_of_proteins',1,3);
    grid('on')
    xlabel('PC1');
    ylabel('PC3');
    
    %Plot graph 3 with pc2 pc3
    axes(handles.plot3);
    plot_with_cluster(handles.plot3,PCA_data,number_of_proteins',2,3);
    grid('on')
    xlabel('PC2');
    ylabel('PC3');
    
    %Plot graph 4 with pc1 pc2 pc3
    axes(handles.plot4);
    plot_with_cluster_3D(handles.plot4,PCA_data,number_of_proteins',1,2,3);
    grid('on')
    xlabel('PC1');
    ylabel('PC2');
    zlabel('PC3');
    
    %Create a legend array the size of the number of proteins
    legendmatrix = cell(num_of_rows,1);
    for k = 1:num_of_rows
        if k == 1 %The first row in dataset is blank by default
            legendmatrix{k}=strcat('Blank');
        else
            legendmatrix{k}=strcat('Protein',num2str(k-1));
        end
        
    end
    %Assign legend the legend array names
    legend(legendmatrix);
    
else
    %Display a Message if the user has not chosen a file
    no_file_chosen_message = msgbox('IMPORT A FILE FIRST', 'Error', 'help' );
    setGlobalMessagebox(no_file_chosen_message);

end

    
    
    


% --- Executes during object creation, after setting all properties.
function plot1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot1

% --- Executes during object creation, after setting all properties.
function plot2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot1

% --- Executes during object creation, after setting all properties.
function plot3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot1

% --- Executes during object creation, after setting all properties.
function plot4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot1


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%cla(handles.plot4,'reset');

%Force messagebox to close if user has not closed it
current_messagebox = getGlobalMessagebox();
delete(current_messagebox);

scatter3(handles.plot4,1:10, 1:10, 1:10,'.w'); %plots a 3D blank default graph on plot 4
pcaBtn_Callback(hObject, eventdata, handles);%redraw all plots


    



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(Help_Menu);
delete(hObject);