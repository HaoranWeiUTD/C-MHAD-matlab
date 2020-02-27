clear all; close all;clc

%%1)Replace the path at here
Path = 'C:\Users\hxw170830\Desktop\UTD Cotinuos Multimodal Human Action Dataset\TV gesture application\Subject11_Haoran\Action Video\';
fileFolder1=fullfile(Path);

dirOutput1=dir(fullfile(fileFolder1,'*.avi'));
fileNames1={dirOutput1.name}';

% File Number in the fileNames1
File= 10;  
obj = VideoReader([Path,fileNames1{File}]);

%Frame Number in that video
Frame=1;

%Show that frame at figure 1
figure(1)
imshow(read(obj,Frame));


