clear all; close all;clc

%%1)Replace the path at here
fileFolder2=fullfile('C:\Users\hxw170830\Desktop\UTD Cotinuos Multimodal Human Action Dataset\TV gesture application\Subject11_Haoran\Shimmer Data\');

dirOutput2=dir(fullfile(fileFolder2,'*.csv'));
fileNames2={dirOutput2.name}';
num = xlsread([fileFolder2,fileNames2{1}]);

%figure 1 plot the origianl inertial signal along 6 axis
figure(1)
subplot(6, 1, 1);
plot(num(:,2))
ylabel('Acceleration-X','FontSize',12)
subplot(6, 1, 2);
plot(num(:,3))
ylabel('Acceleration-Y','FontSize',12)
subplot(6, 1, 3);
plot(num(:,4))
ylabel('Acceleration-Z','FontSize',12)
subplot(6, 1, 4);
plot(num(:,5))
ylabel('Angular -X','FontSize',12)
subplot(6, 1, 5);
plot(num(:,6))
ylabel('Angular-Y','FontSize',12)
subplot(6, 1, 6);
plot(num(:,7))
ylabel('Angular-Z','FontSize',12)
xlabel('Frames of inertial signal','FontSize',12)


%===== Moving average filter on inertial ===%
winsize = 3; %Window Size
mov_avg_filter = ones(winsize, 1)./winsize;
tmp_data = imfilter([num(1:floor(winsize/2),:); num; num(end-floor(winsize/2)+1:end,:)], mov_avg_filter, 'same');  %add element to make same lenght
num = tmp_data(floor(winsize/2)+1:end-floor(winsize/2),:);
clear tmp_data;

%=====Mean to Zero=====%
for i=2:7
    num(:,i) = (num(:,i) - mean(num(:,i)));
end

%figure 2 plot the inertial signal with mean value of 0 along each axis 
figure(2)
subplot(6, 1, 1);
plot(num(:,2))
ylabel('Acceleration-X','FontSize',12)
subplot(6, 1, 2);
plot(num(:,3))
ylabel('Acceleration-Y','FontSize',12)
subplot(6, 1, 3);
plot(num(:,4))
ylabel('Acceleration-Z','FontSize',12)
subplot(6, 1, 4);
plot(num(:,5))
ylabel('Angular -X','FontSize',12)
subplot(6, 1, 5);
plot(num(:,6))
ylabel('Angular-Y','FontSize',12)
subplot(6, 1, 6);
plot(num(:,7))
ylabel('Angular-Z','FontSize',12)
xlabel('Frames of inertial signal','FontSize',12)

%===== Calculate Overall Acc and Ang =====%
acc_vector = num(:,2:4);
acc = sqrt(acc_vector(:,1).^2 + acc_vector(:,2).^2 + acc_vector(:,3).^2)';
angvel_vector = num(:,5:7);
ang_vel = sqrt(angvel_vector(:,1).^2 + angvel_vector(:,2).^2 + angvel_vector(:,3).^2)';
sig_img = [num(:,2:7), acc', ang_vel'];

%=====Nomalization=====%
for i=1:8
    sig_img(:,i) = (sig_img(:,i) - min(sig_img(:,i))) / (max(sig_img(:,i)) - min(sig_img(:,i)));
end

%figure 3 is the input image to the 2D CNN network 
figure(3)  
imshow(sig_img(600:3:750,:)')