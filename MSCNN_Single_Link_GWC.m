%% The script is used for data classification multi-sampling CNN single link version construction
% Author: Weicheng Gao, AKA JoeyBG.
% Time: 2022.11.12.
% Unless you are a member of the New Type System Radar Laboratory of the Beijing Institute of Technology, my senior or junior. No one else can use this code without permission
% Parameters input should be defined as follow:
% {
%     Radar parameters:
%     L_width: The observation area in the length direction(m).
%     W_width: The observation area in the width direction(m).
%     LL & WW:The resolution in the length and width direction, we use our
%     sample data to generate, which is 64 points per frame.
%     B_width: Band width of the radar ejection wave(Hz).
%     fc: Carrier frequency.
%     tRange: Carrier duration(s).
%     nT: Sampling numbers.
% 
%     Wall parameters:
%     d: The distance between radar and the wall(m).
%     e_content: Dielectric constant of wall.
% 
%     Antenna parameters:
%     N_line: Number of antenna partitions, single-shot single-receive
%     antenna.
% 
%     Target parameters:
%     x_tag: X direction of the targets(m).
%     y_tag: Y direction of the targets(m).
% 
%     Imaging parameters:
%     Radar_image_path: Datas.
% }

%% Matlab Code Initializing
% Clear windows and all other params.
clear all;
close all;
clc;

%% Load Initial Parameters
% Load parameters for network initialization. 
% For transfer learning, the network initialization parameters are the parameters of the initial pretrained network.
trainingSetup = load("D:\MatlabR2022a\bin\JoeyBG_Sundries\Multi-Sampling_Class\MSCNN_Single_Link_Parameters.mat");

%% Import Data
% Import training and validation data.
imdsTrain = imageDatastore("D:\JoeyBG_Research_Production\TWR_MCAE_IEEE_TGRS_2022_Series\Software\Datasets\TWR_wall_after_WSN\Train_datas_wall","IncludeSubfolders",true,"LabelSource","foldernames");
imdsValidation = imageDatastore("D:\JoeyBG_Research_Production\TWR_MCAE_IEEE_TGRS_2022_Series\Software\Datasets\TWR_wall_after_WSN\Test_datas_wall","IncludeSubfolders",true,"LabelSource","foldernames");

% Resize the images to match the network input layer.
augimdsTrain = augmentedImageDatastore([256 256 3],imdsTrain);
augimdsValidation = augmentedImageDatastore([256 256 3],imdsValidation);

%% Set Training Option
% Specify options to use when training.
opts = trainingOptions("adam",...
    "ExecutionEnvironment","auto",...
    "InitialLearnRate",0.005,...
    "MaxEpochs",80,...
    "MiniBatchSize",64,...
    "OutputNetwork","best-validation-loss",...
    "Shuffle","every-epoch",...
    "ValidationFrequency",10,...
    "Plots","training-progress",...
    "ValidationData",augimdsValidation);

%% Create Layer Graph
% Create the layer graph variable to contain the network layers.
lgraph = layerGraph();

%% Add Layer Branches
% Add the branches of the network to the layer graph. Each branch is a linear array of layers.
layers = [
    imageInputLayer([256 256 3],"Name","datainput")
    maxPooling2dLayer([5 5],"Name","maxpool_1","Padding","same")
    convolution2dLayer([7 7],8,"Name","conv_1")
    maxPooling2dLayer([5 5],"Name","maxpool_4","Stride",[2 2])
    convolution2dLayer([5 5],16,"Name","conv_4")
    maxPooling2dLayer([5 5],"Name","maxpool_7","Stride",[2 2])
    convolution2dLayer([3 3],32,"Name","conv_8")
    maxPooling2dLayer([5 5],"Name","maxpool_11","Stride",[2 2])
    convolution2dLayer([3 3],32,"Name","conv_9")
    maxPooling2dLayer([5 5],"Name","maxpool_12","Stride",[2 2])
    fullyConnectedLayer(1024,"Name","fc_1")
    fullyConnectedLayer(7,"Name","fc_2")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

%% Train Network
% Train the network using the specified options and training data.
plot(lgraph);
[net, traininfo] = trainNetwork(augimdsTrain,layers,opts);

%% Confusion Matrix Plotting
% Load and classify test data using the trained network.
close all;
XTest = augimdsValidation;
YTest = imdsValidation.Labels;
YPredicted = classify(trainedNetwork_1,XTest); 
Confusion_matrix = plotconfusion(YTest,YPredicted);
f = gcf;
exportgraphics(f,'Confusion Matrix MSCNN Single Link.png','Resolution',600);