> Status: Done
> 
> ![GitHub License](https://img.shields.io/github/license/jps-pereira/Timbral-Analysis)

<p align="center">
  <img width="150" height="150" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/7de5ae40-eeb2-4143-888c-b19b42929616">
</p>

## Project

Para atingir o resultado apresentado nesse repositório as fases importantes do projeto foram as seguintes:

- Uso das ferramentas principais para análise do timbre, como os espectrogramas, mel-espectrogramas e as características espectrais.
- Desenvolvimento da interface gráfica: Para reunir as ferramentas desenvolvidas na etapa anterior, de forma fácil e interativa, foi desenvolvida uma interface gráfica de
usuário [GUI](https://pt.wikipedia.org/wiki/Interface_gr%C3%A1fica_do_utilizador) no software [MATLAB](https://www.mathworks.com/products/matlab.html) através da ferramenta [AppDesigner](https://www.mathworks.com/products/matlab/app-designer.html), capaz de auxiliar o processo de análise agrupando os resultados obtidos.

O App Designer é uma ferramenta MATLAB, que viabiliza a criação de interfaces de aplicativos gráficos. Com o AppDesignerdesigner, os usuários têm a capacidade de projetar interfaces de usuário com uma variedade de elementos gráficos, como botões, caixas de texto, gráficos, barras de progresso, e muito mais. Isso permite a criação de aplicativos visualmente atraentes e interativos que podem ser usados para tarefas como análise de dados, simulação, controle de sistemas e visualização de resultados.

O processo de publicação de aplicativos criados no AppDesigner também é simplificado, permitindo que os usuários compartilhem seus aplicativos com outras pessoas. Os aplicativos podem ser publicados como aplicativos autônomos ou integrados em um ambiente MATLAB existente. O arquivo de instalação <code>.mlappinstall</code> está neste repositório, a instalação integrará o aplicativo desenvolvido ao software MATLAB previamente instalado. Além disso, o código-fonte está disponível neste repositório como <code>timbral_analisys_exported.m</code>. O Código e arquivo de instalação MATLAB geram uma ferramenta para análise espectral de sinais de música, sendo um bom meio para o reconhecimento do timbre de instrumentos, assim como um facilitador para outros projetos, que envolvem aplicações em [MIR](https://musicinformationretrieval.com/) (Musical Information Retrieval).

<p align="center">
  <img width="400" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/ed1accc7-aeaa-45ec-b15a-5cd6a50f89d3">
</p>


## How to use

- Passo 1: Escolher o arquivo de áudio a ser lido no botão file. Ao escolher o arquivo, o nome do mesmo será exibido na caixa de texto, e informações sobre o áudio serão mostradas da command line do MATLAB.Executar a leitura do arquivo no botão Run, de forma que o sinal seja representado nos gráficos já expostos da interface, no domínio do tempo e no domínio da frequência usando o algoritmo de FFT. Caso o usuário não defina os limites os eixos nos sliders de tempo e frequência, uma caixa de mensagem aparecerá para orienta-lo a uma melhor decisão, além de, por padrão, usar o valor de 20 kHz para o eixo frequencial e 100 s para o eixo do tempo.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/f8392552-41be-4293-89cb-81c4b0c08b5f">
</p>

- Passo 2: Caso seja necessário, é possível editar o áudio determinando o instante de começo e fim nas caixas de texto <code>Start</code> e <code>End</code>, essa etapa altera o sinal em definitivo para todas as funções posteriores, diferente dos <code>sliders</code> que apenas mostram os trechos desejados de acordo com seus valores. Com a edição do áudio feita ou não, é possível ouvir o áudio lido através dos botões de <code>play</code> e <code>pause</code>.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/6659a1a4-5bee-4007-9f7e-4ce48f5b814a">
</p>

- Passo 3: Defina os parâmetros de janelamento e banco de filtros para a extração dos recursos de espectrograma e mel-espectrograma, caso algum parâmetro não seja definido, uma mensagem de erro alertará o usuário sobre qual parâmetro ele deve preencher.

<p align="center">
  <img width="365" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/3c961bd0-4768-4cb3-a7ad-4e0324ac9f24">
</p>

- Passo 4: Etapa final de extração dos recursos fazendo uso dos botões <code>Spec</code>, <code>Mel-spec</code> e <code>Features</code>, sendo possível a alteração dos parâmetros para uma nova extração de recursos, tornando a análise mais cuidadosa.

<p align="center">
  <img width="550" height="300" src="https://github.com/jps-pereira/Timbral-Analysis/assets/145292371/cdee35b1-e1bf-4238-832a-ed34e05bfd6e">
</p>

## Development ideas

- Instrument classification;
- Gender recognition;
- Analysis of audio on real time (not recorded);
- Separation of source (musical instruments);
- Analysis of noises.

## Author
> João Pedro Pereira <div> <a href="https://www.linkedin.com/in/joaopedro-pereira-/" target="_blank"><img src="https://img.shields.io/badge/-LinkedIn-%230077B5?style=for-the-badge&logo=linkedin&logoColor=white" target="_blank"></a> <a href = "mailto:jp_pereira@id.uff.br"><img src="https://img.shields.io/badge/-Gmail-%23333?style=for-the-badge&logo=gmail&logoColor=white" target="_blank"></a> </div>
