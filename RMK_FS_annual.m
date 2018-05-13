%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This scripts automates the testing of a large number of running tresnds for 
%field significance using the function testFieldSignificance

%input is a table of climate data with first column being year and subsequent 
%columns being time series observations at each location
%
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabpool open; %set up parallel workers

%% Load Data

[data1,txt]=xlsread('ACTT_MaxUpd.xlsx',2);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 


%dataName=strcat(timeRes,minDataPoints,stat,txt{i}); %name data
%dataName=strcat(timeRes,minDataPoints,stat,'ichetucknee'); %name data

d = size(data1);
%data=data1(:,2:d(1,2)); % get data assumes first col is dates rest data
startData=1;
endData=d(1,1);
lengthData=endData;


%storage
%lengthData=length(data);

AMaxT_MK_FS_90=nan(lengthData,lengthData);
AMaxT_MK_FS_95=nan(lengthData,lengthData);


%startData=find(isnan(data1(:,1))==0,1,'first'); % start time of data series relative with 1/1/1895
%endData=find(isnan(data1(:,1))==0,1,'last'); % end time of data series relative with 1/1/2012
% lengthData=length(data);

%loop calculates running pval H and sens slope for each station then runs
%feild significance simulation loop picks out each start and end date then
%tests the feild significance for that set of dates
tic
for u=startData:lengthData-minDataPoints % start date
    parfor v=u+minDataPoints:lengthData % end date
       
       %select length to field test
       kdata=data1(u:v,:);
       %now test field
       
       [AMaxT_MK_FS_95(v,u), AMaxT_MK_FS_90(v,u)]=testFieldSignificance(kdata(:,2:d(1,2)),kdata(:,1));
        
        
    
    end
end

toc

save('AMaxT','AMaxT_MK_FS_90','AMaxT_MK_FS_95');


close all; clear all; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Load Data

[data1,txt]=xlsread('ACTT_MeanUpd.xlsx',2);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 



%dataName=strcat(timeRes,minDataPoints,stat,txt{i}); %name data
%dataName=strcat(timeRes,minDataPoints,stat,'ichetucknee'); %name data

d = size(data1);
%data=data1(:,2:d(1,2)); % get data assumes first col is dates rest data
startData=1;
endData=d(1,1);
lengthData=endData;


%storage
%lengthData=length(data);


AMeanT_MK_FS_90=nan(lengthData,lengthData);
AMeanT_MK_FS_95=nan(lengthData,lengthData);


for u=startData:lengthData-minDataPoints % start date
    parfor v=u+minDataPoints:lengthData % end date
       
       %select length to field test
       kdata=data1(u:v,:);
       %now test field
       
       [AMeanT_MK_FS_95(v,u), AMeanT_MK_FS_90(v,u)]=testFieldSignificance(kdata(:,2:d(1,2)),kdata(:,1));
        
        
    
    end
end
save('AMeanT','AMeanT_MK_FS_90','AMeanT_MK_FS_90');
toc

%% Load Data

[data1,txt]=xlsread('ACTT_MinUpd.xlsx',2);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 

d = size(data1);
%data=data1(:,2:d(1,2)); % get data assumes first col is dates rest data
startData=1;
endData=d(1,1);
lengthData=endData;


%storage
%lengthData=length(data);


AMinT_MK_FS_90=nan(lengthData,lengthData);
AMinT_MK_FS_95=nan(lengthData,lengthData);



for u=startData:lengthData-minDataPoints % start date
    parfor v=u+minDataPoints:lengthData % end date
       
       %select length to field test
       kdata=data1(u:v,:);
       %now test field
       
       [AMinT_MK_FS_95(v,u), AMinT_MK_FS_90(v,u)]=testFieldSignificance(kdata(:,2:d(1,2)),kdata(:,1));
        
        
    
    end
end
save('AMinT','AMinT_MK_FS_90','AMinT_MK_FS_90');
toc

matlabpool('close');



