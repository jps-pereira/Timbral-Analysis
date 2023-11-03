classdef timbral_analisys_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TimbralanalysisUIFigure       matlab.ui.Figure
        Signal_Time                   matlab.ui.control.UIAxes
        Signal_Frequency              matlab.ui.control.UIAxes
        WindowlengthEditField_2Label  matlab.ui.control.Label
        Windowlength                  matlab.ui.control.NumericEditField
        HopsizeEditFieldLabel         matlab.ui.control.Label
        Hopsize                       matlab.ui.control.NumericEditField
        FFTpointsLabel                matlab.ui.control.Label
        FFTpoints                     matlab.ui.control.NumericEditField
        ComputeSTFT                   matlab.ui.control.Button
        ComputeMFCCs                  matlab.ui.control.Button
        Play                          matlab.ui.control.Button
        Pause                         matlab.ui.control.Button
        Name_audio                    matlab.ui.control.EditField
        axisfrequency                 matlab.ui.control.Slider
        axistime                      matlab.ui.control.Slider
        sLabel                        matlab.ui.control.Label
        HzLabel                       matlab.ui.control.Label
        StartEditFieldLabel           matlab.ui.control.Label
        StartEditField                matlab.ui.control.NumericEditField
        EndLabel                      matlab.ui.control.Label
        EndEditField                  matlab.ui.control.NumericEditField
        sLabel_3                      matlab.ui.control.Label
        WindowButtonGroup             matlab.ui.container.ButtonGroup
        HammingButton                 matlab.ui.control.RadioButton
        ChoosewindowButton            matlab.ui.control.RadioButton
        KaiserButton                  matlab.ui.control.RadioButton
        BlackmanButton                matlab.ui.control.RadioButton
        HanningButton                 matlab.ui.control.RadioButton
        FilterbankLabel               matlab.ui.control.Label
        FilterBank                    matlab.ui.control.NumericEditField
        spectraldescriptors           matlab.ui.control.Button
        RunButton                     matlab.ui.control.Button
        FileButton                    matlab.ui.control.Button
        sLabel_4                      matlab.ui.control.Label
    end

properties (Access = private)
    Signal                 % Signal for temporal and frequencial representation
    Signal_spectrogram     % Signal for spectrogram
    Signal_mel             % Signal for mel spectrogram
    Signal_features        % Signal for Spectral features
    Sample_rate            % Fs
    Win                    % Window lenth
    duration               % Duration of audio signal
end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: FileButton
        function FileButtonPushed(app, event)
            
[filename, path] = uigetfile;
[Signal, Fs] = audioread(filename);
x = Signal(:,1);
app.Name_audio.Value = filename;
audio_info = audioinfo(filename)
N = length(x);        % sample lenth
slength = N/Fs;       % total time span of audio signal
app.Signal = x;
app.Sample_rate = Fs;
app.duration = slength;
        end

        % Value changed function: Name_audio
        function Name_audioValueChanged(app, event)
            value = app.Name_audio.Value;
        end

        % Value changed function: StartEditField
        function StartEditFieldValueChanged(app, event)
            value = app.StartEditField.Value;         
        end

        % Value changed function: EndEditField
        function EndEditFieldValueChanged(app, event)
            value = app.EndEditField.Value;          
        end

        % Button pushed function: RunButton
        function RunButtonPushed(app, event)
F_sample = app.Sample_rate; 
y = app.Signal;
endaudio = app.duration;

if app.axistime.Value == 0 || app.axisfrequency.Value == 0
    f = msgbox("Choose better your axes limits","Atention","warn");
end

if app.axistime.Value == 0
   app.axistime.Value = 100;
end

if app.axisfrequency.Value == 0
   app.axisfrequency.Value = 20000;
end

if app.EndEditField.Value >= endaudio
   app.EndEditField.Value = endaudio;
end

if app.StartEditField.Value >= endaudio
   app.StartEditField.Value = endaudio;
end    

if app.StartEditField.Value == 0 && app.EndEditField.Value == 0 
    Sig = y;
    
    % VETOR TEMPO
    n = length(Sig);
    t = (0:n-1)/ F_sample;

    % VETOR FREQUENCIA
    fq = linspace(0, F_sample/2,floor(n/2)+1);

    % FFT
    signalFFT = abs(fft(Sig));

    %Tempo
    plot(app.Signal_Time,t,Sig,'Color',[0.64,0.08,0.18]);
    title(app.Signal_Time,'Sinal do dominio do tempo');
    xlabel(app.Signal_Time,'tempo');
    ylabel(app.Signal_Time,'Amplitude');
    set(app.Signal_Time,'xlim',[0, app.axistime.Value]);

    %Frequencia
    plot(app.Signal_Frequency,fq,signalFFT(1:length(fq)),'linew',2,'Color',[0.07,0.18,0.25]);
    xlabel(app.Signal_Frequency,'Frequencia');
    ylabel(app.Signal_Frequency,'Amplitude');
    title(app.Signal_Frequency,'Sinal no Dominio da Frequencia');
    set(app.Signal_Frequency,'xlim',[0, app.axisfrequency.Value]);    
    app.Signal_spectrogram = Sig;
    app.Signal_mel = Sig;
    app.Signal_features = Sig;
elseif app.StartEditField.Value == 0 && app.EndEditField.Value ~= 0
    Sig = y(1*F_sample:app.EndEditField.Value*F_sample,1);

    % VETOR TEMPO
    n = length(Sig);
    t = (0:n-1)/ F_sample;

    % VETOR FREQUENCIA
    fq = linspace(0, F_sample/2,floor(n/2)+1);

    % FFT
    signalFFT = abs(fft(Sig));

    %Tempo
    plot(app.Signal_Time,t,Sig,'Color',[0.07,0.18,0.25]);
    title(app.Signal_Time,'Sinal do dominio do tempo');
    xlabel(app.Signal_Time,'tempo');
    ylabel(app.Signal_Time,'Amplitude');
    set(app.Signal_Time,'xlim',[0, app.axistime.Value]);

    %Frequencia
    plot(app.Signal_Frequency,fq,signalFFT(1:length(fq)),'linew',2,'Color',[0.07,0.18,0.25]);
    xlabel(app.Signal_Frequency,'Frequencia');
    ylabel(app.Signal_Frequency,'Amplitude');
    title(app.Signal_Frequency,'Sinal no Dominio da Frequencia');
    set(app.Signal_Frequency,'xlim',[0, app.axisfrequency.Value]);
    app.Signal_spectrogram = Sig;
    app.Signal_mel = Sig;
    app.Signal_features = Sig;
elseif app.StartEditField.Value ~= 0 && app.EndEditField.Value == 0 
    Sig = y(app.StartEditField.Value*F_sample:endaudio*F_sample,1);
    
    % VETOR TEMPO
    n = length(Sig);
    t = (0:n-1)/ F_sample;

    % VETOR FREQUENCIA
    fq = linspace(0, F_sample/2,floor(n/2)+1);

    % FFT
    signalFFT = abs(fft(Sig));

    %Tempo
    plot(app.Signal_Time,t,Sig,'Color',[0.64,0.08,0.18]);
    title(app.Signal_Time,'Sinal do dominio do tempo');
    xlabel(app.Signal_Time,'tempo');
    ylabel(app.Signal_Time,'Amplitude');
    set(app.Signal_Time,'xlim',[0, app.axistime.Value]);
    %Frequencia
    plot(app.Signal_Frequency,fq,signalFFT(1:length(fq)),'linew',2,'Color',[0.07,0.18,0.25]);
    xlabel(app.Signal_Frequency,'Frequencia');
    ylabel(app.Signal_Frequency,'Amplitude');
    title(app.Signal_Frequency,'Sinal no Dominio da Frequencia');
    set(app.Signal_Frequency,'xlim',[0, app.axisfrequency.Value]);
    app.Signal_spectrogram = Sig;
    app.Signal_mel = Sig;
    app.Signal_features = Sig;
elseif app.StartEditField.Value ~= 0 && app.EndEditField.Value ~= 0 

    Sig = y(app.StartEditField.Value*F_sample:app.EndEditField.Value*F_sample,1);

    % VETOR TEMPO
    n = length(Sig);
    t = (0:n-1)/ F_sample;

    % VETOR FREQUENCIA
    fq = linspace(0, F_sample/2,floor(n/2)+1);

    % FFT
    signalFFT = abs(fft(Sig));

    %Tempo
    plot(app.Signal_Time,t,Sig,'Color',[0.64,0.08,0.18]);
    title(app.Signal_Time,'Sinal do dominio do tempo');
    xlabel(app.Signal_Time,'tempo');
    ylabel(app.Signal_Time,'Amplitude');
    set(app.Signal_Time,'xlim',[0, app.axistime.Value]);

    %Frequencia
    plot(app.Signal_Frequency,fq,signalFFT(1:length(fq)),'linew',2,'Color',[0.07,0.18,0.25]);
    xlabel(app.Signal_Frequency,'Frequencia');
    ylabel(app.Signal_Frequency,'Amplitude');
    title(app.Signal_Frequency,'Sinal no Dominio da Frequencia');
    set(app.Signal_Frequency,'xlim',[0, app.axisfrequency.Value]);
    app.Signal_spectrogram = Sig;
    app.Signal_mel = Sig;
    app.Signal_features = Sig;
end

app.Signal = Sig;
        end

        % Value changed function: axistime
        function axistimeValueChanged(app, event)
            value = app.axistime.Value;
        end

        % Value changed function: axisfrequency
        function axisfrequencyValueChanged(app, event)
            value = app.axisfrequency.Value;
        end

        % Button pushed function: Play
        function PlayButtonPushed(app, event)
Sound = app.Signal;
Fs = app.Sample_rate;
endaudio = app.duration;

if app.EndEditField.Value ~= 0 && app.StartEditField.Value ~= 0
   sound(Sound(app.StartEditField.Value*Fs:app.EndEditField.Value*Fs), Fs);
   
elseif app.StartEditField.Value ~= 0 && app.EndEditField.Value == 0 
    sound(Sound(app.StartEditField.Value*Fs:endaudio*Fs), Fs);
    
elseif app.StartEditField.Value == 0 && app.EndEditField.Value ~= 0 
   sound(Sound(1:app.EndEditField.Value*Fs), Fs);
   
elseif app.StartEditField.Value == 0 && app.EndEditField.Value == 0 
    sound(Sound, Fs);
end
Sound = app.Signal;
        end

        % Button pushed function: Pause
        function PauseButtonPushed(app, event)
            clear sound;
        end

        % Value changed function: Windowlength
        function WindowlengthValueChanged(app, event)
            value = app.Windowlength.Value;     
        end

        % Value changed function: FFTpoints
        function FFTpointsValueChanged(app, event)
            value = app.FFTpoints.Value;
        end

        % Value changed function: Hopsize
        function HopsizeValueChanged(app, event)
            value = app.Hopsize.Value;
        end

        % Selection changed function: WindowButtonGroup
        function WindowButtonGroupSelectionChanged(app, event)
if app.HammingButton.Value
    win = hamming(app.Windowlength.Value);
elseif app.KaiserButton.Value
    win = kaiser(app.Windowlength.Value,2.5);
elseif app.BlackmanButton.Value
    win = blackman(app.Windowlength.Value);
elseif app.ChoosewindowButton.Value
    win = hanning(app.Windowlength.Value);
elseif app.HanningButton.Value
    win = hanning(app.Windowlength.Value);
else
    win = hanning(app.Windowlength.Value);
end
app.Win = win;
        end

        % Button pushed function: ComputeSTFT
        function ComputeSTFTButtonPushed(app, event)
F_sample = app.Sample_rate;
y = app.Signal_spectrogram;
wlen = app.Win;                             % window function

Compute = false;
Compute1 = false;
Compute2 = false;

if app.Hopsize.Value == 0
      f = msgbox("You didn't choose the Hop size, choose it","Atention","error");
elseif app.Hopsize.Value ~= 0
    Compute1 = true;
end
if app.FFTpoints.Value == 0
      f = msgbox("You didn't choose the FFT length, choose it","Atention","error"); 
elseif app.FFTpoints.Value ~= 0
    Compute2 = true;
end
if app.Windowlength.Value == 0
      f = msgbox("You didn't choose the Window or the Window length, choose it","Atention","error");     
elseif app.Windowlength.Value ~= 0
    Compute = true;
end
if  Compute==true && Compute1==true && Compute2==true
    % PARAMETROS DA STFT
             
    hop = app.Hopsize.Value;                    % hop size          
    nfft = app.FFTpoints.Value;                 % number of fft points
                                
    if wlen == hamming(app.Windowlength.Value)
        figure('Name','Spectrogram - Hamming','NumberTitle','off');
        spectrogram(y,wlen,hop,nfft,F_sample,'yaxis');
        colormap('jet');
    elseif wlen == hanning(app.Windowlength.Value)
        figure('Name','Spectrogram - Hanning','NumberTitle','off');
        spectrogram(y,wlen,hop,nfft,F_sample,'yaxis');
        colormap('jet'); 
    elseif wlen == kaiser(app.Windowlength.Value,2.5)
        figure('Name','Spectrogram - Kaiser','NumberTitle','off');
        spectrogram(y,wlen,hop,nfft,F_sample,'yaxis');
        colormap('jet');
    elseif wlen == blackman(app.Windowlength.Value)
        figure('Name','Spectrogram - Blackman','NumberTitle','off');
        spectrogram(y,wlen,hop,nfft,F_sample,'yaxis');
        colormap('jet');
    end
end
        end

        % Button pushed function: ComputeMFCCs
        function ComputeMFCCsButtonPushed(app, event)
F_sample = app.Sample_rate;
y = app.Signal_mel;
wlen = app.Win;                             % window choose

Compute = false;
Compute1 = false;
Compute2 = false;
Compute3 = false;

if app.Windowlength.Value == 0
      f = msgbox("You didn't choose the Window length, choose it","Atention","error");   
elseif app.Windowlength.Value ~= 0
    Compute = true;
end
if app.Hopsize.Value == 0
      f = msgbox("You didn't choose the Hop size, choose it","Atention","error");
elseif app.Hopsize.Value ~= 0
    Compute1 = true;
end
if app.FFTpoints.Value == 0
      f = msgbox("You didn't choose the FFT length, choose it","Atention","error");
elseif app.FFTpoints.Value ~= 0
    Compute2 = true;
end
if app.FilterBank.Value == 0
      f = msgbox("You didn't choose the Number of bands, choose it","Atention","error");
elseif app.FilterBank.Value ~= 0
    Compute3 = true;
end    
if  Compute==true && Compute1==true && Compute2==true && Compute3==true
        % PARAMETROS DA STFT
                 
        hop = app.Hopsize.Value;                    % hop size          
        nfft = app.FFTpoints.Value;                 % number of fft points
        Numbands = app.FilterBank.Value;            % Numero de bandas do banco de filtros
        
        % Mel-Spectrogram
        if wlen == hamming(app.Windowlength.Value)
            figure('Name','Melspectrogram - Hamming','NumberTitle','off');
            melSpectrogram(y,F_sample, ...
                           'Window',wlen, ...
                           'OverlapLength',hop, ...
                           'FFTLength',nfft, ...
                           'NumBands',Numbands);
            colormap('jet');
        elseif wlen == hanning(app.Windowlength.Value)
            figure('Name','Melspectrogram - Hanning','NumberTitle','off');
            melSpectrogram(y,F_sample, ...
                           'Window',wlen, ...
                           'OverlapLength',hop, ...
                           'FFTLength',nfft, ...
                           'NumBands',Numbands);
            colormap('jet');
        elseif wlen == kaiser(app.Windowlength.Value,2.5)
            figure('Name','Melspectrogram - Kaiser','NumberTitle','off');
            melSpectrogram(y,F_sample, ...
                           'Window',wlen, ...
                           'OverlapLength',hop, ...
                           'FFTLength',nfft, ...
                           'NumBands',Numbands);
             colormap('jet');
        elseif wlen == blackman(app.Windowlength.Value)
            figure('Name','Melspectrogram - Blackman','NumberTitle','off');
            melSpectrogram(y,F_sample, ...
                           'Window',wlen, ...
                           'OverlapLength',hop, ...
                           'FFTLength',nfft, ...
                           'NumBands',Numbands);
            colormap('jet');  
        end      
 end         
        end

        % Value changed function: FilterBank
        function FilterBankValueChanged(app, event)
            value = app.FilterBank.Value;  
        end

        % Button pushed function: spectraldescriptors
        function spectraldescriptorsButtonPushed(app, event)
F_sample = app.Sample_rate; 
y = app.Signal_features;

rolloff = spectralRolloffPoint(y,F_sample);
t1 = linspace(0,size(y,1)/F_sample,size(rolloff,1));

Slope = spectralSlope(y,F_sample);
t2 = linspace(0,size(y,1)/F_sample,size(Slope,1));

Decrease = spectralDecrease(y,F_sample);
t3 = linspace(0,size(y,1)/F_sample,size(Decrease,1));

Centroid = spectralCentroid(y,F_sample);
t4 = linspace(0,size(y,1)/F_sample,size(Centroid,1));

flux = spectralFlux(y,F_sample);
t5 = linspace(0,size(y,1)/F_sample,size(flux,1));

flatness = spectralFlatness(y,F_sample);
t6 = linspace(0,size(y,1)/F_sample,size(flatness,1));

spread = spectralSpread(y,F_sample);
t7 = linspace(0,size(y,1)/F_sample,size(spread,1));            

entropy = spectralEntropy(y,F_sample);
t8 = linspace(0,size(y,1)/F_sample,size(entropy,1));

%========================================================%
       
figure('Name','Spectral Features','NumberTitle','off');
subplot(2,2,2)
plot(t1,rolloff,'Color',[0.07,0.18,0.25])
ylabel('Rolloff Point')
xlabel('Time (s)')

subplot(2,2,4)
plot(t2,Slope,'Color',[0.07,0.18,0.25])
ylabel('Slope')
xlabel('Time (s)')

subplot(2,2,3)
plot(t3,Decrease,'Color',[0.07,0.18,0.25])
ylabel('Decrease')
xlabel('Time (s)')

subplot(2,2,1)
plot(t4,Centroid,'Color',[0.07,0.18,0.25])
ylabel('Centroid')

%========================================================%

figure('Name','Spectral Features','NumberTitle','off');
subplot(2,2,4)
plot(t5,flux,'Color',[0,0,0])
ylabel('Flux')
xlabel('Time (s)')

subplot(2,2,1)
plot(t7,spread,'Color',[0,0,0])
ylabel('Spread')
xlabel('Time (s)')

subplot(2,2,2)
plot(t7,flatness,'Color',[0,0,0])
ylabel('Flatness')
xlabel('Time (s)')

subplot(2,2,3)
plot(t7,entropy,'Color',[0,0,0])
ylabel('Entropy')
xlabel('Time (s)')
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TimbralanalysisUIFigure and hide until all components are created
            app.TimbralanalysisUIFigure = uifigure('Visible', 'off');
            app.TimbralanalysisUIFigure.IntegerHandle = 'on';
            app.TimbralanalysisUIFigure.AutoResizeChildren = 'off';
            app.TimbralanalysisUIFigure.Color = [0.9412 0.9412 0.9412];
            app.TimbralanalysisUIFigure.Colormap = [0.2431 0.149 0.6588;0.2431 0.1529 0.6745;0.2471 0.1569 0.6863;0.2471 0.1608 0.698;0.251 0.1647 0.7059;0.251 0.1686 0.7176;0.2549 0.1725 0.7294;0.2549 0.1765 0.7412;0.2588 0.1804 0.749;0.2588 0.1843 0.7608;0.2627 0.1882 0.7725;0.2588 0.1882 0.7804;0.2627 0.1961 0.7922;0.2667 0.2 0.8039;0.2667 0.2039 0.8157;0.2706 0.2078 0.8235;0.2706 0.2157 0.8353;0.2706 0.2196 0.8431;0.2745 0.2235 0.851;0.2745 0.2275 0.8627;0.2745 0.2314 0.8706;0.2745 0.2392 0.8784;0.2784 0.2431 0.8824;0.2784 0.2471 0.8902;0.2784 0.2549 0.898;0.2784 0.2588 0.902;0.2784 0.2667 0.9098;0.2784 0.2706 0.9137;0.2784 0.2745 0.9216;0.2824 0.2824 0.9255;0.2824 0.2863 0.9294;0.2824 0.2941 0.9333;0.2824 0.298 0.9412;0.2824 0.3059 0.9451;0.2824 0.3098 0.949;0.2824 0.3137 0.9529;0.2824 0.3216 0.9569;0.2824 0.3255 0.9608;0.2824 0.3294 0.9647;0.2784 0.3373 0.9686;0.2784 0.3412 0.9686;0.2784 0.349 0.9725;0.2784 0.3529 0.9765;0.2784 0.3569 0.9804;0.2784 0.3647 0.9804;0.2745 0.3686 0.9843;0.2745 0.3765 0.9843;0.2745 0.3804 0.9882;0.2706 0.3843 0.9882;0.2706 0.3922 0.9922;0.2667 0.3961 0.9922;0.2627 0.4039 0.9922;0.2627 0.4078 0.9961;0.2588 0.4157 0.9961;0.2549 0.4196 0.9961;0.251 0.4275 0.9961;0.2471 0.4314 1;0.2431 0.4392 1;0.2353 0.4431 1;0.2314 0.451 1;0.2235 0.4549 1;0.2196 0.4627 0.9961;0.2118 0.4667 0.9961;0.2078 0.4745 0.9922;0.2 0.4784 0.9922;0.1961 0.4863 0.9882;0.1922 0.4902 0.9882;0.1882 0.498 0.9843;0.1843 0.502 0.9804;0.1843 0.5098 0.9804;0.1804 0.5137 0.9765;0.1804 0.5176 0.9725;0.1804 0.5255 0.9725;0.1804 0.5294 0.9686;0.1765 0.5333 0.9647;0.1765 0.5412 0.9608;0.1765 0.5451 0.9569;0.1765 0.549 0.9529;0.1765 0.5569 0.949;0.1725 0.5608 0.9451;0.1725 0.5647 0.9412;0.1686 0.5686 0.9373;0.1647 0.5765 0.9333;0.1608 0.5804 0.9294;0.1569 0.5843 0.9255;0.1529 0.5922 0.9216;0.1529 0.5961 0.9176;0.149 0.6 0.9137;0.149 0.6039 0.9098;0.1451 0.6078 0.9098;0.1451 0.6118 0.9059;0.1412 0.6196 0.902;0.1412 0.6235 0.898;0.1373 0.6275 0.898;0.1373 0.6314 0.8941;0.1333 0.6353 0.8941;0.1294 0.6392 0.8902;0.1255 0.6471 0.8902;0.1216 0.651 0.8863;0.1176 0.6549 0.8824;0.1137 0.6588 0.8824;0.1137 0.6627 0.8784;0.1098 0.6667 0.8745;0.1059 0.6706 0.8706;0.102 0.6745 0.8667;0.098 0.6784 0.8627;0.0902 0.6824 0.8549;0.0863 0.6863 0.851;0.0784 0.6902 0.8471;0.0706 0.6941 0.8392;0.0627 0.698 0.8353;0.0549 0.702 0.8314;0.0431 0.702 0.8235;0.0314 0.7059 0.8196;0.0235 0.7098 0.8118;0.0157 0.7137 0.8078;0.0078 0.7176 0.8;0.0039 0.7176 0.7922;0 0.7216 0.7882;0 0.7255 0.7804;0 0.7294 0.7765;0.0039 0.7294 0.7686;0.0078 0.7333 0.7608;0.0157 0.7333 0.7569;0.0235 0.7373 0.749;0.0353 0.7412 0.7412;0.051 0.7412 0.7373;0.0627 0.7451 0.7294;0.0784 0.7451 0.7216;0.0902 0.749 0.7137;0.102 0.7529 0.7098;0.1137 0.7529 0.702;0.1255 0.7569 0.6941;0.1373 0.7569 0.6863;0.1451 0.7608 0.6824;0.1529 0.7608 0.6745;0.1608 0.7647 0.6667;0.1686 0.7647 0.6588;0.1725 0.7686 0.651;0.1804 0.7686 0.6471;0.1843 0.7725 0.6392;0.1922 0.7725 0.6314;0.1961 0.7765 0.6235;0.2 0.7804 0.6157;0.2078 0.7804 0.6078;0.2118 0.7843 0.6;0.2196 0.7843 0.5882;0.2235 0.7882 0.5804;0.2314 0.7882 0.5725;0.2392 0.7922 0.5647;0.251 0.7922 0.5529;0.2588 0.7922 0.5451;0.2706 0.7961 0.5373;0.2824 0.7961 0.5255;0.2941 0.7961 0.5176;0.3059 0.8 0.5059;0.3176 0.8 0.498;0.3294 0.8 0.4863;0.3412 0.8 0.4784;0.3529 0.8 0.4667;0.3686 0.8039 0.4549;0.3804 0.8039 0.4471;0.3922 0.8039 0.4353;0.4039 0.8039 0.4235;0.4196 0.8039 0.4118;0.4314 0.8039 0.4;0.4471 0.8039 0.3922;0.4627 0.8 0.3804;0.4745 0.8 0.3686;0.4902 0.8 0.3569;0.5059 0.8 0.349;0.5176 0.8 0.3373;0.5333 0.7961 0.3255;0.5451 0.7961 0.3176;0.5608 0.7961 0.3059;0.5765 0.7922 0.2941;0.5882 0.7922 0.2824;0.6039 0.7882 0.2745;0.6157 0.7882 0.2627;0.6314 0.7843 0.251;0.6431 0.7843 0.2431;0.6549 0.7804 0.2314;0.6706 0.7804 0.2235;0.6824 0.7765 0.2157;0.698 0.7765 0.2078;0.7098 0.7725 0.2;0.7216 0.7686 0.1922;0.7333 0.7686 0.1843;0.7451 0.7647 0.1765;0.7608 0.7647 0.1725;0.7725 0.7608 0.1647;0.7843 0.7569 0.1608;0.7961 0.7569 0.1569;0.8078 0.7529 0.1529;0.8157 0.749 0.1529;0.8275 0.749 0.1529;0.8392 0.7451 0.1529;0.851 0.7451 0.1569;0.8588 0.7412 0.1569;0.8706 0.7373 0.1608;0.8824 0.7373 0.1647;0.8902 0.7373 0.1686;0.902 0.7333 0.1765;0.9098 0.7333 0.1804;0.9176 0.7294 0.1882;0.9255 0.7294 0.1961;0.9373 0.7294 0.2078;0.9451 0.7294 0.2157;0.9529 0.7294 0.2235;0.9608 0.7294 0.2314;0.9686 0.7294 0.2392;0.9765 0.7294 0.2431;0.9843 0.7333 0.2431;0.9882 0.7373 0.2431;0.9961 0.7412 0.2392;0.9961 0.7451 0.2353;0.9961 0.7529 0.2314;0.9961 0.7569 0.2275;0.9961 0.7608 0.2235;0.9961 0.7686 0.2196;0.9961 0.7725 0.2157;0.9961 0.7804 0.2078;0.9961 0.7843 0.2039;0.9961 0.7922 0.2;0.9922 0.7961 0.1961;0.9922 0.8039 0.1922;0.9922 0.8078 0.1922;0.9882 0.8157 0.1882;0.9843 0.8235 0.1843;0.9843 0.8275 0.1804;0.9804 0.8353 0.1804;0.9765 0.8392 0.1765;0.9765 0.8471 0.1725;0.9725 0.851 0.1686;0.9686 0.8588 0.1647;0.9686 0.8667 0.1647;0.9647 0.8706 0.1608;0.9647 0.8784 0.1569;0.9608 0.8824 0.1569;0.9608 0.8902 0.1529;0.9608 0.898 0.149;0.9608 0.902 0.149;0.9608 0.9098 0.1451;0.9608 0.9137 0.1412;0.9608 0.9216 0.1373;0.9608 0.9255 0.1333;0.9608 0.9333 0.1294;0.9647 0.9373 0.1255;0.9647 0.9451 0.1216;0.9647 0.949 0.1176;0.9686 0.9569 0.1098;0.9686 0.9608 0.1059;0.9725 0.9686 0.102;0.9725 0.9725 0.0941;0.9765 0.9765 0.0863;0.9765 0.9843 0.0824;1 1 0.0667;1 1 0;1 0 0;1 0 0];
            app.TimbralanalysisUIFigure.Position = [100 100 793 622];
            app.TimbralanalysisUIFigure.Name = 'Timbral analysis';
            app.TimbralanalysisUIFigure.Resize = 'off';
            app.TimbralanalysisUIFigure.Pointer = 'hand';

            % Create Signal_Time
            app.Signal_Time = uiaxes(app.TimbralanalysisUIFigure);
            title(app.Signal_Time, '')
            xlabel(app.Signal_Time, 'X')
            ylabel(app.Signal_Time, 'Y')
            app.Signal_Time.PlotBoxAspectRatio = [4.17261904761905 1 1];
            app.Signal_Time.FontName = 'Arial';
            app.Signal_Time.ColorOrder = [0.6392 0.0784 0.1804;0 0.451 0.7412;0 0.451 0.7412;0.4941 0.1843 0.5569;0.4667 0.6745 0.1882;0.302 0.7451 0.9333;0.6392 0.0784 0.1804];
            app.Signal_Time.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Signal_Time.Position = [17 386 766 233];

            % Create Signal_Frequency
            app.Signal_Frequency = uiaxes(app.TimbralanalysisUIFigure);
            title(app.Signal_Frequency, '')
            xlabel(app.Signal_Frequency, 'X')
            ylabel(app.Signal_Frequency, 'Y')
            app.Signal_Frequency.PlotBoxAspectRatio = [4.17261904761905 1 1];
            app.Signal_Frequency.FontName = 'Arial';
            app.Signal_Frequency.ColorOrder = [0.6392 0.0784 0.1804;0 0.451 0.7412;0 0.451 0.7412;0.2 0.0196 0.2588;0.4706 0.6706 0.1882;0.302 0.7451 0.9333;0.6392 0.0784 0.1804];
            app.Signal_Frequency.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Signal_Frequency.Position = [15 151 766 233];

            % Create WindowlengthEditField_2Label
            app.WindowlengthEditField_2Label = uilabel(app.TimbralanalysisUIFigure);
            app.WindowlengthEditField_2Label.BackgroundColor = [0.0706 0.1804 0.251];
            app.WindowlengthEditField_2Label.HorizontalAlignment = 'center';
            app.WindowlengthEditField_2Label.FontName = 'Arial';
            app.WindowlengthEditField_2Label.FontSize = 10;
            app.WindowlengthEditField_2Label.FontColor = [1 1 1];
            app.WindowlengthEditField_2Label.Position = [291 114 120 13];
            app.WindowlengthEditField_2Label.Text = 'Window length';

            % Create Windowlength
            app.Windowlength = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.Windowlength.ValueChangedFcn = createCallbackFcn(app, @WindowlengthValueChanged, true);
            app.Windowlength.HorizontalAlignment = 'center';
            app.Windowlength.FontName = 'Arial';
            app.Windowlength.FontSize = 10;
            app.Windowlength.FontWeight = 'bold';
            app.Windowlength.Position = [291 90 120 22];

            % Create HopsizeEditFieldLabel
            app.HopsizeEditFieldLabel = uilabel(app.TimbralanalysisUIFigure);
            app.HopsizeEditFieldLabel.BackgroundColor = [0.0706 0.1804 0.251];
            app.HopsizeEditFieldLabel.HorizontalAlignment = 'center';
            app.HopsizeEditFieldLabel.VerticalAlignment = 'bottom';
            app.HopsizeEditFieldLabel.FontName = 'Arial';
            app.HopsizeEditFieldLabel.FontSize = 10;
            app.HopsizeEditFieldLabel.FontColor = [1 1 1];
            app.HopsizeEditFieldLabel.Position = [291 71 55 13];
            app.HopsizeEditFieldLabel.Text = 'Hop size';

            % Create Hopsize
            app.Hopsize = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.Hopsize.ValueChangedFcn = createCallbackFcn(app, @HopsizeValueChanged, true);
            app.Hopsize.HorizontalAlignment = 'center';
            app.Hopsize.FontName = 'Arial';
            app.Hopsize.FontSize = 10;
            app.Hopsize.FontWeight = 'bold';
            app.Hopsize.Position = [291 48 55 22];

            % Create FFTpointsLabel
            app.FFTpointsLabel = uilabel(app.TimbralanalysisUIFigure);
            app.FFTpointsLabel.BackgroundColor = [0.0706 0.1804 0.251];
            app.FFTpointsLabel.HorizontalAlignment = 'center';
            app.FFTpointsLabel.VerticalAlignment = 'bottom';
            app.FFTpointsLabel.FontName = 'Arial';
            app.FFTpointsLabel.FontSize = 10;
            app.FFTpointsLabel.FontColor = [1 1 1];
            app.FFTpointsLabel.Position = [356 71 55 13];
            app.FFTpointsLabel.Text = 'FFT points';

            % Create FFTpoints
            app.FFTpoints = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.FFTpoints.ValueChangedFcn = createCallbackFcn(app, @FFTpointsValueChanged, true);
            app.FFTpoints.HorizontalAlignment = 'center';
            app.FFTpoints.FontName = 'Arial';
            app.FFTpoints.FontSize = 10;
            app.FFTpoints.FontWeight = 'bold';
            app.FFTpoints.Position = [356 48 55 22];

            % Create ComputeSTFT
            app.ComputeSTFT = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.ComputeSTFT.ButtonPushedFcn = createCallbackFcn(app, @ComputeSTFTButtonPushed, true);
            app.ComputeSTFT.BackgroundColor = [0.0706 0.1804 0.251];
            app.ComputeSTFT.FontName = 'Arial';
            app.ComputeSTFT.FontSize = 11;
            app.ComputeSTFT.FontWeight = 'bold';
            app.ComputeSTFT.FontColor = [0.9412 0.9412 0.9412];
            app.ComputeSTFT.Position = [583 13 60 30];
            app.ComputeSTFT.Text = 'Spec';

            % Create ComputeMFCCs
            app.ComputeMFCCs = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.ComputeMFCCs.ButtonPushedFcn = createCallbackFcn(app, @ComputeMFCCsButtonPushed, true);
            app.ComputeMFCCs.BackgroundColor = [0.0706 0.1804 0.251];
            app.ComputeMFCCs.FontName = 'Arial';
            app.ComputeMFCCs.FontSize = 11;
            app.ComputeMFCCs.FontWeight = 'bold';
            app.ComputeMFCCs.FontColor = [0.9412 0.9412 0.9412];
            app.ComputeMFCCs.Position = [648 13 60 30];
            app.ComputeMFCCs.Text = 'Mel- Spec';

            % Create Play
            app.Play = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.Play.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.Play.Icon = 'botao-play.png';
            app.Play.IconAlignment = 'center';
            app.Play.Position = [583 56 90 30];
            app.Play.Text = '';

            % Create Pause
            app.Pause = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.Pause.ButtonPushedFcn = createCallbackFcn(app, @PauseButtonPushed, true);
            app.Pause.Icon = 'pausa.png';
            app.Pause.IconAlignment = 'center';
            app.Pause.Position = [683 56 90 30];
            app.Pause.Text = '';

            % Create Name_audio
            app.Name_audio = uieditfield(app.TimbralanalysisUIFigure, 'text');
            app.Name_audio.ValueChangedFcn = createCallbackFcn(app, @Name_audioValueChanged, true);
            app.Name_audio.HorizontalAlignment = 'center';
            app.Name_audio.FontName = 'Arial';
            app.Name_audio.Position = [583 98 190 30];

            % Create axisfrequency
            app.axisfrequency = uislider(app.TimbralanalysisUIFigure);
            app.axisfrequency.Limits = [0 20000];
            app.axisfrequency.MajorTicks = [0 5000 10000 15000 20000];
            app.axisfrequency.MajorTickLabels = {'0 ', '5000', '10000', '15000', '20000'};
            app.axisfrequency.Orientation = 'vertical';
            app.axisfrequency.ValueChangedFcn = createCallbackFcn(app, @axisfrequencyValueChanged, true);
            app.axisfrequency.FontName = 'Arial';
            app.axisfrequency.FontSize = 10;
            app.axisfrequency.FontWeight = 'bold';
            app.axisfrequency.Position = [219 18 3 103];

            % Create axistime
            app.axistime = uislider(app.TimbralanalysisUIFigure);
            app.axistime.MajorTicks = [0 20 40 60 80 100];
            app.axistime.MajorTickLabels = {'0', '20', '40', '60', '80', '100'};
            app.axistime.Orientation = 'vertical';
            app.axistime.ValueChangedFcn = createCallbackFcn(app, @axistimeValueChanged, true);
            app.axistime.FontName = 'Arial';
            app.axistime.FontSize = 10;
            app.axistime.FontWeight = 'bold';
            app.axistime.Position = [157 18 3 103];

            % Create sLabel
            app.sLabel = uilabel(app.TimbralanalysisUIFigure);
            app.sLabel.FontName = 'Arial';
            app.sLabel.FontSize = 11;
            app.sLabel.FontWeight = 'bold';
            app.sLabel.Position = [189 9 20 22];
            app.sLabel.Text = '[s]';

            % Create HzLabel
            app.HzLabel = uilabel(app.TimbralanalysisUIFigure);
            app.HzLabel.FontName = 'Arial';
            app.HzLabel.FontSize = 11;
            app.HzLabel.FontWeight = 'bold';
            app.HzLabel.Position = [251 9 30 22];
            app.HzLabel.Text = '[Hz]';

            % Create StartEditFieldLabel
            app.StartEditFieldLabel = uilabel(app.TimbralanalysisUIFigure);
            app.StartEditFieldLabel.BackgroundColor = [0.0706 0.1804 0.251];
            app.StartEditFieldLabel.HorizontalAlignment = 'center';
            app.StartEditFieldLabel.FontName = 'Arial';
            app.StartEditFieldLabel.FontSize = 11;
            app.StartEditFieldLabel.FontWeight = 'bold';
            app.StartEditFieldLabel.FontColor = [1 1 1];
            app.StartEditFieldLabel.Position = [24 102 31 25];
            app.StartEditFieldLabel.Text = 'Start';

            % Create StartEditField
            app.StartEditField = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.StartEditField.Limits = [0 Inf];
            app.StartEditField.ValueChangedFcn = createCallbackFcn(app, @StartEditFieldValueChanged, true);
            app.StartEditField.HorizontalAlignment = 'center';
            app.StartEditField.Position = [63 102 70 25];

            % Create EndLabel
            app.EndLabel = uilabel(app.TimbralanalysisUIFigure);
            app.EndLabel.BackgroundColor = [0.0706 0.1804 0.251];
            app.EndLabel.HorizontalAlignment = 'center';
            app.EndLabel.FontName = 'Arial';
            app.EndLabel.FontSize = 11;
            app.EndLabel.FontWeight = 'bold';
            app.EndLabel.FontColor = [1 1 1];
            app.EndLabel.Position = [24 61 32 25];
            app.EndLabel.Text = ' End ';

            % Create EndEditField
            app.EndEditField = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.EndEditField.Limits = [0 Inf];
            app.EndEditField.ValueChangedFcn = createCallbackFcn(app, @EndEditFieldValueChanged, true);
            app.EndEditField.HorizontalAlignment = 'center';
            app.EndEditField.Position = [63 61 70 25];

            % Create sLabel_3
            app.sLabel_3 = uilabel(app.TimbralanalysisUIFigure);
            app.sLabel_3.Interruptible = 'off';
            app.sLabel_3.FontName = 'Arial';
            app.sLabel_3.FontSize = 11;
            app.sLabel_3.FontWeight = 'bold';
            app.sLabel_3.Position = [113 62 25 22];
            app.sLabel_3.Text = 's';

            % Create WindowButtonGroup
            app.WindowButtonGroup = uibuttongroup(app.TimbralanalysisUIFigure);
            app.WindowButtonGroup.AutoResizeChildren = 'off';
            app.WindowButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @WindowButtonGroupSelectionChanged, true);
            app.WindowButtonGroup.ForegroundColor = [1 1 1];
            app.WindowButtonGroup.TitlePosition = 'centertop';
            app.WindowButtonGroup.Title = 'Window';
            app.WindowButtonGroup.BackgroundColor = [0.0706 0.1804 0.251];
            app.WindowButtonGroup.FontWeight = 'bold';
            app.WindowButtonGroup.FontSize = 10;
            app.WindowButtonGroup.Position = [432 9 134 119];

            % Create HammingButton
            app.HammingButton = uiradiobutton(app.WindowButtonGroup);
            app.HammingButton.Text = ' Hamming';
            app.HammingButton.FontColor = [1 1 1];
            app.HammingButton.Position = [11 40 115 22];

            % Create ChoosewindowButton
            app.ChoosewindowButton = uiradiobutton(app.WindowButtonGroup);
            app.ChoosewindowButton.Text = ' Choose window';
            app.ChoosewindowButton.FontColor = [1 1 1];
            app.ChoosewindowButton.Position = [11 81 115 22];
            app.ChoosewindowButton.Value = true;

            % Create KaiserButton
            app.KaiserButton = uiradiobutton(app.WindowButtonGroup);
            app.KaiserButton.Text = ' Kaiser';
            app.KaiserButton.FontColor = [1 1 1];
            app.KaiserButton.Position = [11 20 115 22];

            % Create BlackmanButton
            app.BlackmanButton = uiradiobutton(app.WindowButtonGroup);
            app.BlackmanButton.Text = ' Blackman ';
            app.BlackmanButton.FontColor = [1 1 1];
            app.BlackmanButton.Position = [11 1 115 22];

            % Create HanningButton
            app.HanningButton = uiradiobutton(app.WindowButtonGroup);
            app.HanningButton.Text = ' Hanning';
            app.HanningButton.FontColor = [1 1 1];
            app.HanningButton.Position = [11 61 70 22];

            % Create FilterbankLabel
            app.FilterbankLabel = uilabel(app.TimbralanalysisUIFigure);
            app.FilterbankLabel.BackgroundColor = [0.0706 0.1804 0.251];
            app.FilterbankLabel.HorizontalAlignment = 'center';
            app.FilterbankLabel.VerticalAlignment = 'bottom';
            app.FilterbankLabel.FontName = 'Arial';
            app.FilterbankLabel.FontSize = 10;
            app.FilterbankLabel.FontColor = [1 1 1];
            app.FilterbankLabel.Position = [291 32 120 13];
            app.FilterbankLabel.Text = 'Filter bank';

            % Create FilterBank
            app.FilterBank = uieditfield(app.TimbralanalysisUIFigure, 'numeric');
            app.FilterBank.ValueChangedFcn = createCallbackFcn(app, @FilterBankValueChanged, true);
            app.FilterBank.HorizontalAlignment = 'center';
            app.FilterBank.FontName = 'Arial';
            app.FilterBank.FontSize = 10;
            app.FilterBank.FontWeight = 'bold';
            app.FilterBank.Position = [291 9 120 22];

            % Create spectraldescriptors
            app.spectraldescriptors = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.spectraldescriptors.ButtonPushedFcn = createCallbackFcn(app, @spectraldescriptorsButtonPushed, true);
            app.spectraldescriptors.BackgroundColor = [0.0706 0.1804 0.251];
            app.spectraldescriptors.FontName = 'Arial';
            app.spectraldescriptors.FontSize = 11;
            app.spectraldescriptors.FontWeight = 'bold';
            app.spectraldescriptors.FontColor = [0.9412 0.9412 0.9412];
            app.spectraldescriptors.Position = [713 13 61 30];
            app.spectraldescriptors.Text = 'Features';

            % Create RunButton
            app.RunButton = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.RunButton.ButtonPushedFcn = createCallbackFcn(app, @RunButtonPushed, true);
            app.RunButton.BackgroundColor = [0.0706 0.1804 0.251];
            app.RunButton.FontName = 'Arial';
            app.RunButton.FontSize = 11;
            app.RunButton.FontWeight = 'bold';
            app.RunButton.FontColor = [0.9412 0.9412 0.9412];
            app.RunButton.Position = [81 13 52 30];
            app.RunButton.Text = 'Run ';

            % Create FileButton
            app.FileButton = uibutton(app.TimbralanalysisUIFigure, 'push');
            app.FileButton.ButtonPushedFcn = createCallbackFcn(app, @FileButtonPushed, true);
            app.FileButton.BackgroundColor = [0.0706 0.1804 0.251];
            app.FileButton.FontName = 'Arial';
            app.FileButton.FontSize = 11;
            app.FileButton.FontWeight = 'bold';
            app.FileButton.FontColor = [0.9412 0.9412 0.9412];
            app.FileButton.Position = [23 13 50 30];
            app.FileButton.Text = ' File';

            % Create sLabel_4
            app.sLabel_4 = uilabel(app.TimbralanalysisUIFigure);
            app.sLabel_4.FontName = 'Arial';
            app.sLabel_4.FontSize = 11;
            app.sLabel_4.FontWeight = 'bold';
            app.sLabel_4.Position = [113 103 25 22];
            app.sLabel_4.Text = 's';

            % Show the figure after all components are created
            app.TimbralanalysisUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = timbral_analisys_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TimbralanalysisUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TimbralanalysisUIFigure)
        end
    end
end