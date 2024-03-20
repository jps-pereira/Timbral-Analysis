> Status: Done
> 
> ![GitHub License](https://img.shields.io/github/license/jps-pereira/Timbral-Analysis)

<p align="center">
  <img width="170" height="170" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/7de5ae40-eeb2-4143-888c-b19b42929616">
</p>

## Project

To achieve the results presented in this repository, the important phases of the project were as follows:

- Use of main tools for timbre analysis, such as spectrograms, mel spectrograms, and spectral features.
- Development of the graphical interface: To bring together the tools developed in the previous stage in an easy and interactive manner, a graphical user interface [GUI](https://pt.wikipedia.org/wiki/Interface_gr%C3%A1fica_do_utilizador) was developed using the [MATLAB](https://www.mathworks.com/products/matlab.html) software through the [AppDesigner](https://www.mathworks.com/products/matlab/app-designer.html) tool. This interface assists in the analysis process by grouping the obtained results.

App Designer is a MATLAB tool that enables the creation of graphical application interfaces. With AppDesigner, users can design user interfaces with a variety of graphical elements, such as buttons, text boxes, graphs, progress bars, and more. This allows for the creation of visually appealing and interactive applications that can be used for tasks such as data analysis, simulation, system control, and result visualization.

The process of publishing applications created in AppDesigner is also simplified, allowing users to share their applications with others. Applications can be published as standalone apps or integrated into an existing MATLAB environment. The installation file <code>.mlappinstall</code> is in this repository; the installation will integrate the developed application into the previously installed MATLAB software. Additionally, the source code is available in this repository as <code>timbral_analisys_exported.m</code> and the file used on Appbuilder as <code>timbral_analysis.mlapp</code>. The MATLAB code and installation file generate a tool for spectral analysis of music signals, serving as a useful means for instrument timbre recognition and facilitating other projects related to applications in [MIR](https://musicinformationretrieval.com/) (Musical Information Retrieval).

<p align="center">
  <img width="400" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/82fe78e2-5b8d-427d-819c-c7ce29cf71e1">
</p>


## How to use

- Step 1: Choose the audio file to be read using the file button. Upon selecting the file, its name will be displayed in the text box, and information about the audio will be shown in the MATLAB command line. Execute the file reading by clicking the <code>Run</code> button , so that the signal is represented on the already displayed graphs in the interface, in both the time and frequency domains using the FFT algorithm. If the user does not set limits on the time and frequency <code>sliders</code>, a message box will appear to guide them towards a better decision, and by default, the frequency axis will use the value of 20 kHz, and the time axis will use 100 s.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/8d0763b7-1af3-4877-8445-88fb15052ac0">
</p>

- Step 2: If necessary, you can edit the audio by specifying the start and end times in the <code>Start</code> and <code>End</code> text boxes. This step permanently alters the signal for all subsequent functions, unlike the <code>sliders</code> that only display the desired segments based on their values. Whether or not the audio is edited, you can listen to the played audio using the <code>play</code> and <code>pause</code> buttons.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/2366f94c-9e72-4716-a344-54dca5ee7736">
</p>

- Step 3: Define the windowing and filter bank parameters for extracting spectrogram and mel-spectrogram features. If any parameter is not specified, an error message will alert the user about which parameter needs to be filled in.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/b1f5803c-4123-4c36-beba-0427b57fc6ad">
</p>

- Step 4: Final stage of feature extraction using the <code>Spec</code>, <code>Mel-spec</code>, and <code>Features</code> buttons, allowing for the adjustment of parameters for a new feature extraction, enhancing the analysis with greater precision.

<p align="center">
  <img width="578" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/900ecd3d-2354-40e5-8358-b3ee85a65adf">
</p>

## Development ideas

- Instrument classification;
- Gender recognition;
- Analysis of audio on real time (not recorded);
- Separation of source (musical instruments);
- Analysis of noises.

## Author
> João Pedro Pereira <div> <a href="https://www.linkedin.com/in/joaopedro-pereira-/" target="_blank"><img src="https://img.shields.io/badge/-LinkedIn-%230077B5?style=for-the-badge&logo=linkedin&logoColor=white" target="_blank"></a> <a href = "mailto:jp_pereira@id.uff.br"><img src="https://img.shields.io/badge/-Gmail-%23333?style=for-the-badge&logo=gmail&logoColor=white" target="_blank"></a> </div>
