%% The script is used for data classification using multi-sampling convolutional neural network (MSCNN)
% Author: Weicheng Gao, AKA JoeyBG.
% Time: 2022.11.12.
% Learning purposes only! 
% Unless you are a member of the New Type System Radar Laboratory of the Beijing Institute of Technology, my senior or junior. No one else can use this code for releasing without permission.
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