%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This scripts automates the testing of a large number of running tresnds for 
%field significance using the function testFieldSignificance

%input is a table of climate data with first column being year, second column being 
%month and subsequent columns being time series observations at each location
%
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabpool open; %set up parallel workers

%% Load Data
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Meta.mat')
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Stat.mat')

[data1,txt]=xlsread('ACTT_MinUpd.xlsx',1);

%%
timeRes='month';
stat='MaxT';
minDataPoints=9; 

%set up storage

RMK_FS_95=nan(120,120); 
RMK_FS_90=nan(120,120); 


monthlyMinTMK_FS_95{25}=nan(120);
monthlyMinTMK_FS_90{25}=nan(120);


for i=1:12 %months
%extract month

    iMonth = find(data1(:,2)==(i)); %find month
    iMonthD=data1(iMonth,:); %select month data
    startData=1;
    d=size(iMonthD);
    lengthData=d(1,1);
    widthData=d(1,2);

%loop calculates FS for each month
for u=startData:lengthData-minDataPoints % start date
    parfor v=u+minDataPoints:lengthData % end date

       %select length to field test
       kdata=iMonthD(u:v,:);
       
       %now test field
       
       [RMK_FS_95(v,u), RMK_FS_90(v,u)]=testFieldSignificance(kdata(:,3:widthData),kdata(:,1));
        
     
    end


monthlyMinTMK_FS_95{i}=RMK_FS_95;
monthlyMinTMK_FS_90{i}=RMK_FS_90;


end


end

save('monthlyMinT FS','monthlyMinTMK_FS_95','monthlyMinTMK_FS_90');

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

