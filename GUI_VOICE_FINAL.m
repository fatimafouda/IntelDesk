function varargout = GUI_VOICE_FINAL(varargin)
% GUI_VOICE_FINAL MATLAB code for GUI_VOICE_FINAL.fig
%      GUI_VOICE_FINAL, by itself, creates a new GUI_VOICE_FINAL or raises the existing
%      singleton*.
%
%      H = GUI_VOICE_FINAL returns the handle to a new GUI_VOICE_FINAL or the handle to
%      the existing singleton*.
%
%      GUI_VOICE_FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_VOICE_FINAL.M with the given input arguments.
%
%      GUI_VOICE_FINAL('Property','Value',...) creates a new GUI_VOICE_FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_VOICE_FINAL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_VOICE_FINAL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_VOICE_FINAL

% Last Modified by GUIDE v2.5 07-Jun-2016 19:51:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_VOICE_FINAL_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_VOICE_FINAL_OutputFcn, ...
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


% --- Executes just before GUI_VOICE_FINAL is made visible.
function GUI_VOICE_FINAL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_VOICE_FINAL (see VARARGIN)

% Choose default command line output for GUI_VOICE_FINAL
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_VOICE_FINAL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_VOICE_FINAL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in
% Male.------------------------------------------------------------------------------------------------------------MALE---------------------------------------------------------------------------------------------------------------------------
function Male_Callback(hObject, eventdata, handles)
% hObject    handle to Male (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Orginal_data_high_male_mfcc = evalin('base', 'Orginal_data_high_male_mfcc');
Orginal_data_low_male_mfcc = evalin('base', 'Orginal_data_low_male_mfcc');
Orginal_data_neutral_male_lfpc = evalin('base', 'Orginal_data_neutral_male_lfpc');
Orginal_data_sad_male_lfpc = evalin('base', 'Orginal_data_sad_male_lfpc');
Orginal_data_happy_male_lpc= evalin('base', 'Orginal_data_happy_male_lpc');
Orginal_data_anger_male_lpc= evalin('base', 'Orginal_data_anger_male_lpc');
Orginal_data_fear_male_lpc= evalin('base', 'Orginal_data_fear_male_lpc');
Orginal_data_happy_fear_male_lpc= evalin('base', 'Orginal_data_happy_fear_male_lpc');

A=0;
S=0;
F=0;
H=0;
N=0;

Ang_T=num2str(A);
set(handles.Ang_T,'string',Ang_T);

Hap_T=num2str(H);
set(handles.Hap_T,'string',Hap_T);

Sad_T=num2str(S);
set(handles.Sad_T,'string',Sad_T);

Fear_T=num2str(F);
set(handles.Fear_T,'string',Fear_T);

Neut_T=num2str(N);
set(handles.Neut_T,'string',Neut_T);




low_num=0;
high_num=0;
low_count=0;
high_count=0;
Em=0;
%Em=1 (Low categ),Em=2 (high categ) ,Em=3 (3rd Stage happy/fear) 

%# prepare audio recording
Fs = 32000;  
recObj = audiorecorder(Fs,8,1);
 rate=Fs;
disp('Start speaking...')
for index = 1 : 2
    
     recordblocking(recObj, 4); %recording 1sec interval
         sig = getaudiodata(recObj);  %get data of the recorded data
   
    
   
    x=sig;
    %1st stage
    %------------------------------------------------------------------------------------------------------LOW--------------OR--------------HIGH--------------------------------------------------------------------------------------
j=1;
k=1;
Em=0;
Array_low=[];
Array_high=[];
%x=x.*hamm_wavread(1:length(x));
low_num=0;
high_num=0;
for w=1:length(x)/rate
    y1=1+rate*(w-1);
    y2=rate*w;
if w==length(x)
    break;
end
period=x(y1:y2);



 Y = abs(fft(x,rate));
    Y=MFCC_fix(log10(Y(1:4000)));
    %Y=dct(Y);


k=1;

    for i=1:length(Orginal_data_low_male_mfcc)
        
        Array_low(1,i)=abs(Y(1,k)*100/Orginal_data_low_male_mfcc(1,i));
        
          if Array_low(1,i)>200
            Array_low(1,i)=0;
        
          else if Array_low(1,i)>100
            Array_low(1,i)=100-rem(Array_low(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_high_male_mfcc)
        
        Array_high(1,i)=abs(Y(1,k)*100/Orginal_data_high_male_mfcc(1,i));
        
        if Array_high(1,i)>200
            Array_high(1,i)=0;
            
        else if Array_high (1,i)>100
            Array_high(1,i)=100-rem(Array_high(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_low=zeros(1,200000);
    pers_high=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_low_male_mfcc)
        pers_low(1,k)=pers_low(1,k)+Array_low(1,i);
      
        if m==13
             pers_low(1,k)= pers_low(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_high_male_mfcc)
           pers_high(1,k)=pers_high(1,k)+Array_high(1,i);      
        if m==13
              pers_high(1,k)= pers_high(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_low=max(pers_low);
max_high=max(pers_high);

if max_low>max_high 
    low_num=low_num+1;
else if max_high>max_low   
        high_num=high_num+1;

    end
end

end

if low_num>high_num
 % disp('Low category')
  %low_count=low_count+1;
  Em=1;
else if high_num>low_num
        %disp('High category')
        %high_count=high_count+1;
        Em=2;
    end
end
  

    
%2nd stage
%----------------------------------------------------------------------------------------------------------LOW------------------------------------------------------------------------------------------------------------------------
if Em==1


  j=1;
k=1;
Array_sad=[];
Array_neut=[];

sad_num=0;
neut_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


fft_sig=abs(fft(period,rate)); %taking FFT of given input data wavefile
tes=fft_sig(1:4000);
 lfpc=LFPC_fix(tes); %LFPC process

k=1;
    for i=1:length(Orginal_data_sad_male_lfpc)
        
        Array_sad(1,i)=abs(lfpc(1,k)*100/Orginal_data_sad_male_lfpc(1,i));
        
          if Array_sad(1,i)>200
            Array_sad(1,i)=0;
        
          else if Array_sad(1,i)>100
            Array_sad(1,i)=100-rem(Array_sad(1,i),100);
              end
          end
   
        if k==12
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_neutral_male_lfpc)
        
        Array_neut(1,i)=abs(lfpc(1,k)*100/Orginal_data_neutral_male_lfpc(1,i));
        
        if Array_neut(1,i)>200
            Array_neut(1,i)=0;
            
        else if Array_neut (1,i)>100
            Array_neut(1,i)=100-rem(Array_neut(1,i),100);
            end
        end
        
        if k==12
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_sa=zeros(1,200000);
    pers_fe=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_sad_male_lfpc)
        pers_sa(1,k)=pers_sa(1,k)+Array_sad(1,i);
      
        if m==12
             pers_sa(1,k)= pers_sa(1,k)/12;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_neutral_male_lfpc)
           pers_fe(1,k)=pers_fe(1,k)+Array_neut(1,i);      
        if m==12
              pers_fe(1,k)= pers_fe(1,k)/12;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_sad=max(pers_sa);
max_neut=max(pers_fe);

if max_sad>max_neut 
    sad_num=sad_num+1;
else if max_neut>max_sad   
        neut_num=neut_num+1;
    end
end

end

if sad_num>neut_num
  disp('sad')
  S=S+1;
  %sad_count=sad_count+1;
  
else if neut_num>sad_num
        disp('neutral')
        N=N+1;
      %  neut_count=neut_count+1;
    end
end
end
%2nd Stage 
%--------------------------------------------------------------------------------------------------------------------------HIGH----------------------------------------------------------------------------------------------------------------
if Em==2
   j=1;
k=1;
Array_ang=[];
Array_happy_fear=[];
ang_num=0;
happy_fear_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


p =12;  %LPC order
a=lpc(period, p); % Get LPC of the input voice



k=1;
    for i=1:length(Orginal_data_anger_male_lpc)
        
        Array_ang(1,i)=abs(a(1,k)*100/Orginal_data_anger_male_lpc(1,i));
        
          if Array_ang(1,i)>200
            Array_ang(1,i)=0;
        
          else if Array_ang(1,i)>100
            Array_ang(1,i)=100-rem(Array_ang(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_happy_fear_male_lpc)
        
        Array_happy_fear(1,i)=abs(a(1,k)*100/Orginal_data_happy_fear_male_lpc(1,i));
        
        if Array_happy_fear(1,i)>200
            Array_happy_fear(1,i)=0;
            
        else if Array_happy_fear (1,i)>100
            Array_happy_fear(1,i)=100-rem(Array_happy_fear(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_ang=zeros(1,200000);
    pers_hap_fe=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_anger_male_lpc)
        pers_ang(1,k)=pers_ang(1,k)+Array_ang(1,i);
      
        if m==13
             pers_ang(1,k)= pers_ang(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_happy_fear_male_lpc)
           pers_hap_fe(1,k)=pers_hap_fe(1,k)+Array_happy_fear(1,i);      
        if m==13
              pers_hap_fe(1,k)= pers_hap_fe(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_ang=max(pers_ang);
max_hap_fe=max(pers_hap_fe);

if max_ang>max_hap_fe 
    ang_num=ang_num+1;
else if max_hap_fe>max_ang   
        happy_fear_num=happy_fear_num+1;

    end
end

end

if ang_num>happy_fear_num
  disp('Anger')
  A=A+1;
  %ang_count=ang_count+1;

else if happy_fear_num>ang_num
        %disp('Fear or happy')
        %happy_count=happy_count+1;
        Em=3;
    end
end 
    
end

%3rd Stage
%----------------------------------------------------------------------------------------------------------------Happy/Fear---------------------------------------------------------------------------------------------------
if Em==3
    j=1;
k=1;
Array_fear=[];
Array_happy=[];
%x=x.*hamm_wavread(1:length(x));
fear_num=0;
happy_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


p =12;  %LPC order
a=lpc(period, p); % Get LPC of the input voice



k=1;
    for i=1:length(Orginal_data_fear_male_lpc)
        
        Array_fear(1,i)=abs(a(1,k)*100/Orginal_data_fear_male_lpc(1,i));
        
          if Array_fear(1,i)>200
            Array_fear(1,i)=0;
        
          else if Array_fear(1,i)>100
            Array_fear(1,i)=100-rem(Array_fear(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_happy_male_lpc)
        
        Array_happy(1,i)=abs(a(1,k)*100/Orginal_data_happy_male_lpc(1,i));
        
        if Array_happy(1,i)>200
            Array_happy(1,i)=0;
            
        else if Array_happy (1,i)>100
            Array_happy(1,i)=100-rem(Array_happy(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_fear=zeros(1,200000);
    pers_hap=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_fear_male_lpc)
        pers_fear(1,k)=pers_fear(1,k)+Array_fear(1,i);
      
        if m==13
             pers_fear(1,k)= pers_fear(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_happy_male_lpc)
           pers_hap(1,k)=pers_hap(1,k)+Array_happy(1,i);      
        if m==13
              pers_hap(1,k)= pers_hap(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_fear=max(pers_fear);
max_hap=max(pers_hap);

if max_fear>max_hap 
    fear_num=fear_num+1;
else if max_hap>max_fear   
        happy_num=happy_num+1;

    end
end

end

if fear_num>happy_num
  disp('fear')
  F=F+1;
  %ang_count=ang_count+1;
  
else if happy_num>fear_num
        disp('happy')
        H=H+1;
      %  happy_count=happy_count+1;
    end
end
end

end
rec=A+S+F+N+H;
A=A*100/rec;
A=round(A/.001)*0.001;
S=S*100/rec;
S=round(S/.001)*0.001;
F=F*100/rec;
F=round(F/.001)*0.001;
H=H*100/rec;
H=round(H/.001)*0.001;
N=N*100/rec;
N=round(N/.001)*0.001;

Ang_T=num2str(A);
set(handles.Ang_T,'string',Ang_T);

Hap_T=num2str(H);
set(handles.Hap_T,'string',Hap_T);

Sad_T=num2str(S);
set(handles.Sad_T,'string',Sad_T);

Fear_T=num2str(F);
set(handles.Fear_T,'string',Fear_T);

Neut_T=num2str(N);
set(handles.Neut_T,'string',Neut_T);



% --- Executes on button press in
% Female.-------------------------------------------------------------------------------------------------------------------FEMALE---------------------------------------------------------------------------------------------------------------
function Female_Callback(hObject, eventdata, handles)
% hObject    handle to Female (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Orginal_data_high_female_mfcc = evalin('base', 'Orginal_data_high_female_mfcc');
Orginal_data_low_female_mfcc = evalin('base', 'Orginal_data_low_female_mfcc');
Orginal_data_neutral_female_lfpc = evalin('base', 'Orginal_data_neutral_female_lfpc');
Orginal_data_sad_female_lfpc = evalin('base', 'Orginal_data_sad_female_lfpc');
Orginal_data_happy_female_lpc= evalin('base', 'Orginal_data_happy_female_lpc');
Orginal_data_anger_female_lpc= evalin('base', 'Orginal_data_anger_female_lpc');
Orginal_data_fear_female_lpc= evalin('base', 'Orginal_data_fear_female_lpc');
Orginal_data_happy_fear_female_lpc= evalin('base', 'Orginal_data_happy_fear_female_lpc');

A=0;
S=0;
F=0;
H=0;
N=0;

Ang_T=num2str(A);
set(handles.Ang_T,'string',Ang_T);

Hap_T=num2str(H);
set(handles.Hap_T,'string',Hap_T);

Sad_T=num2str(S);
set(handles.Sad_T,'string',Sad_T);

Fear_T=num2str(F);
set(handles.Fear_T,'string',Fear_T);

Neut_T=num2str(N);
set(handles.Neut_T,'string',Neut_T);




low_num=0;
high_num=0;
low_count=0;
high_count=0;
Em=0;
%Em=1 (Low categ),Em=2 (high categ) ,Em=3 (3rd Stage happy/fear) 

%# prepare audio recording
Fs = 32000;  
recObj = audiorecorder(Fs,8,1);
 rate=Fs;
disp('Start speaking...')
for index = 1 : 2
    
     recordblocking(recObj, 4); %recording 1sec interval
         sig = getaudiodata(recObj);  %get data of the recorded data
   
    
   
    x=sig;
    %1st stage
    %------------------------------------------------------------------------------------------------------LOW--------------OR--------------HIGH--------------------------------------------------------------------------------------
j=1;
k=1;
Em=0;
Array_low=[];
Array_high=[];
%x=x.*hamm_wavread(1:length(x));
low_num=0;
high_num=0;
for w=1:length(x)/rate
    y1=1+rate*(w-1);
    y2=rate*w;
if w==length(x)
    break;
end
period=x(y1:y2);



 Y = abs(fft(x,rate));
    Y=MFCC_fix(log10(Y(1:4000)));
    Y=dct(Y);


k=1;

    for i=1:length(Orginal_data_low_female_mfcc)
        
        Array_low(1,i)=abs(Y(1,k)*100/Orginal_data_low_female_mfcc(1,i));
        
          if Array_low(1,i)>200
            Array_low(1,i)=0;
        
          else if Array_low(1,i)>100
            Array_low(1,i)=100-rem(Array_low(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_high_female_mfcc)
        
        Array_high(1,i)=abs(Y(1,k)*100/Orginal_data_high_female_mfcc(1,i));
        
        if Array_high(1,i)>200
            Array_high(1,i)=0;
            
        else if Array_high (1,i)>100
            Array_high(1,i)=100-rem(Array_high(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_low=zeros(1,200000);
    pers_high=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_low_female_mfcc)
        pers_low(1,k)=pers_low(1,k)+Array_low(1,i);
      
        if m==13
             pers_low(1,k)= pers_low(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_high_female_mfcc)
           pers_high(1,k)=pers_high(1,k)+Array_high(1,i);      
        if m==13
              pers_high(1,k)= pers_high(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_low=max(pers_low);
max_high=max(pers_high);

if max_low>max_high 
    low_num=low_num+1;
else if max_high>max_low   
        high_num=high_num+1;

    end
end

end

if low_num>high_num
 % disp('Low category')
  %low_count=low_count+1;
  Em=1;
else if high_num>low_num
        %disp('High category')
        %high_count=high_count+1;
        Em=2;
    end
end
  

    
%2nd stage
%----------------------------------------------------------------------------------------------------------LOW------------------------------------------------------------------------------------------------------------------------
if Em==1


  j=1;
k=1;
Array_sad=[];
Array_neut=[];

sad_num=0;
neut_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


fft_sig=abs(fft(period,rate)); %taking FFT of given input data wavefile
tes=fft_sig(1:4000);
 lfpc=LFPC_fix(tes); %LFPC process

k=1;
    for i=1:length(Orginal_data_sad_female_lfpc)
        
        Array_sad(1,i)=abs(lfpc(1,k)*100/Orginal_data_sad_female_lfpc(1,i));
        
          if Array_sad(1,i)>200
            Array_sad(1,i)=0;
        
          else if Array_sad(1,i)>100
            Array_sad(1,i)=100-rem(Array_sad(1,i),100);
              end
          end
   
        if k==12
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_neutral_female_lfpc)
        
        Array_neut(1,i)=abs(lfpc(1,k)*100/Orginal_data_neutral_female_lfpc(1,i));
        
        if Array_neut(1,i)>200
            Array_neut(1,i)=0;
            
        else if Array_neut (1,i)>100
            Array_neut(1,i)=100-rem(Array_neut(1,i),100);
            end
        end
        
        if k==12
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_sa=zeros(1,200000);
    pers_fe=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_sad_female_lfpc)
        pers_sa(1,k)=pers_sa(1,k)+Array_sad(1,i);
      
        if m==12
             pers_sa(1,k)= pers_sa(1,k)/12;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_neutral_female_lfpc)
           pers_fe(1,k)=pers_fe(1,k)+Array_neut(1,i);      
        if m==12
              pers_fe(1,k)= pers_fe(1,k)/12;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_sad=max(pers_sa);
max_neut=max(pers_fe);

if max_sad>max_neut 
    sad_num=sad_num+1;
else if max_neut>max_sad   
        neut_num=neut_num+1;
    end
end

end

if sad_num>neut_num
  disp('sad')
  S=S+1;
  %sad_count=sad_count+1;
  
else if neut_num>sad_num
        disp('neutral')
        N=N+1;
      %  neut_count=neut_count+1;
    end
end
end
%2nd Stage 
%--------------------------------------------------------------------------------------------------------------------------HIGH----------------------------------------------------------------------------------------------------------------
if Em==2
   j=1;
k=1;
Array_ang=[];
Array_happy_fear=[];
ang_num=0;
happy_fear_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


p =12;  %LPC order
a=lpc(period, p); % Get LPC of the input voice



k=1;
    for i=1:length(Orginal_data_anger_female_lpc)
        
        Array_ang(1,i)=abs(a(1,k)*100/Orginal_data_anger_female_lpc(1,i));
        
          if Array_ang(1,i)>200
            Array_ang(1,i)=0;
        
          else if Array_ang(1,i)>100
            Array_ang(1,i)=100-rem(Array_ang(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_happy_fear_female_lpc)
        
        Array_happy_fear(1,i)=abs(a(1,k)*100/Orginal_data_happy_fear_female_lpc(1,i));
        
        if Array_happy_fear(1,i)>200
            Array_happy_fear(1,i)=0;
            
        else if Array_happy_fear (1,i)>100
            Array_happy_fear(1,i)=100-rem(Array_happy_fear(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_ang=zeros(1,200000);
    pers_hap_fe=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_anger_female_lpc)
        pers_ang(1,k)=pers_ang(1,k)+Array_ang(1,i);
      
        if m==13
             pers_ang(1,k)= pers_ang(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_happy_fear_female_lpc)
           pers_hap_fe(1,k)=pers_hap_fe(1,k)+Array_happy_fear(1,i);      
        if m==13
              pers_hap_fe(1,k)= pers_hap_fe(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_ang=max(pers_ang);
max_hap_fe=max(pers_hap_fe);

if max_ang>max_hap_fe 
    ang_num=ang_num+1;
else if max_hap_fe>max_ang   
        happy_fear_num=happy_fear_num+1;

    end
end

end

if ang_num>happy_fear_num
  disp('Anger')
  A=A+1;
  %ang_count=ang_count+1;

else if happy_fear_num>ang_num
        %disp('Fear or happy')
        %happy_count=happy_count+1;
        Em=3;
    end
end 
    
end

%3rd Stage
%----------------------------------------------------------------------------------------------------------------Happy/Fear---------------------------------------------------------------------------------------------------
if Em==3
    j=1;
k=1;
Array_fear=[];
Array_happy=[];
%x=x.*hamm_wavread(1:length(x));
fear_num=0;
happy_num=0;
for w=1:length(x)/1323
    y1=1+1323*(w-1);
    y2=1323*w;
%period=x((1+(1323*(w-1))):(1323*w));
if w==length(x)
    break;
end
period=x(y1:y2);


p =12;  %LPC order
a=lpc(period, p); % Get LPC of the input voice



k=1;
    for i=1:length(Orginal_data_fear_female_lpc)
        
        Array_fear(1,i)=abs(a(1,k)*100/Orginal_data_fear_female_lpc(1,i));
        
          if Array_fear(1,i)>200
            Array_fear(1,i)=0;
        
          else if Array_fear(1,i)>100
            Array_fear(1,i)=100-rem(Array_fear(1,i),100);
              end
          end
   
        if k==13
            k=0;
        end
        k=k+1;
    end
    
 k=1;  
    for i=1:length(Orginal_data_happy_female_lpc)
        
        Array_happy(1,i)=abs(a(1,k)*100/Orginal_data_happy_female_lpc(1,i));
        
        if Array_happy(1,i)>200
            Array_happy(1,i)=0;
            
        else if Array_happy (1,i)>100
            Array_happy(1,i)=100-rem(Array_happy(1,i),100);
            end
        end
        
        if k==13
            k=0;
        end
        k=k+1;
    end
    
    
    
    
    
    pers_fear=zeros(1,200000);
    pers_hap=zeros(1,200000);
    k=1;
    m=1;
    for i=1:length(Orginal_data_fear_female_lpc)
        pers_fear(1,k)=pers_fear(1,k)+Array_fear(1,i);
      
        if m==13
             pers_fear(1,k)= pers_fear(1,k)/13;
      
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    for i=1:length(Orginal_data_happy_female_lpc)
           pers_hap(1,k)=pers_hap(1,k)+Array_happy(1,i);      
        if m==13
              pers_hap(1,k)= pers_hap(1,k)/13;
            k=k+1;
            m=0;
        end
          m=m+1;
    end
    
    
    
    
    
max_fear=max(pers_fear);
max_hap=max(pers_hap);

if max_fear>max_hap 
    fear_num=fear_num+1;
else if max_hap>max_fear   
        happy_num=happy_num+1;

    end
end

end

if fear_num>happy_num
  disp('fear')
  F=F+1;
  %ang_count=ang_count+1;
  
else if happy_num>fear_num
        disp('happy')
        H=H+1;
      %  happy_count=happy_count+1;
    end
end
end

end
rec=A+S+F+N+H;
A=A*100/rec;
A=round(A/.001)*0.001;
S=S*100/rec;
S=round(S/.001)*0.001;
F=F*100/rec;
F=round(F/.001)*0.001;
H=H*100/rec;
H=round(H/.001)*0.001;
N=N*100/rec;
N=round(N/.001)*0.001;

Ang_T=num2str(A);
set(handles.Ang_T,'string',Ang_T);

Hap_T=num2str(H);
set(handles.Hap_T,'string',Hap_T);

Sad_T=num2str(S);
set(handles.Sad_T,'string',Sad_T);

Fear_T=num2str(F);
set(handles.Fear_T,'string',Fear_T);

Neut_T=num2str(N);
set(handles.Neut_T,'string',Neut_T);
