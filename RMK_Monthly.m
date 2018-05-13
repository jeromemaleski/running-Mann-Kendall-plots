%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this script calculates the man-kendall hyptothesis test for a trend and calculates
%the senns slope for an array of climate data in a running trends manner so that
%test and slope are calulated for each timeperiod in the data.
%
%input is a table of climate data with first column being year, second column being 
%month and subsequent columns being time series observations at each location
%
%this scrip calls as a function a modifided version of the MK trend test written by Jeff Burkey
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load Data

[data1,txt]=xlsread('ACTT_maxUpd.xlsx',1);

%%
timeRes='month';
stat='Temp';
minDataPoints=9; 

%set up storage

RMKH=nan(120,120); 
RMKp=nan(120,120); 
RMKsen=nan(120,120); 

monthlyMaxTMK_H_95{25,25}=nan(120,120);
monthlyMaxTMK_p_95{25,25}=nan(120,120);
monthlyMaxTMK_sen{25,25}=nan(120,120);


for s=1:12 %months
%extract month

    iMonth = find(data1(:,2)==(s)); %find month
    iMonthD=data1(iMonth,:); %select month data

for i=3:23 %station loop
    %extract station    
    
    iStationD=iMonthD(:,i); %select station data    
    
    startData=1;
    lengthData=length(iStationD);
    
   
%loop calculates running pval H and sens slope for each station
for u=startData:lengthData-minDataPoints % start date
    for v=u+minDataPoints:lengthData % end date
       
        kdata=[(u:v)' iStationD(u:v)];
        [RMKH(v,u), RMKp(v,u),RMKsen(v,u)]= ktaubSen_JM(kdata, 0.05);
     
    end
end

monthlyMaxTMK_H_95{s,i}=RMKH;
monthlyMaxTMK_p_95{s,i}=RMKp;
monthlyMaxTMK_sen{s,i}=RMKsen;

end


end

save('monthlyMaxT Running MK','monthlyMaxTMK_H_95','monthlyMaxTMK_p_95','monthlyMaxTMK_sen');

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Load Data
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Meta.mat')
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Stat.mat')

[data1,txt]=xlsread('ACTT_MinUpd.xlsx',1);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 

%set up storage

RMKH=nan(120,120); 
RMKp=nan(120,120); 
RMKsen=nan(120,120); 

monthlyMinTMK_H_95{25,25}=nan(120,120);
monthlyMinTMK_p_95{25,25}=nan(120,120);
monthlyMinTMK_sen{25,25}=nan(120,120);


for s=1:12 %months
%extract month

    iMonth = find(data1(:,2)==(s)); %find month
    iMonthD=data1(iMonth,:); %select month data

for i=3:23 %station loop
    %extract station    
    
    iStationD=iMonthD(:,i); %select station data    
    
    startData=1;
    lengthData=length(iStationD);
    
   
%loop calculates running pval H and sens slope for each station
for u=startData:lengthData-minDataPoints % start date
    for v=u+minDataPoints:lengthData % end date
       
        kdata=[(u:v)' iStationD(u:v)];
        [RMKH(v,u), RMKp(v,u),RMKsen(v,u)]= ktaubSen_JM(kdata, 0.05);
     
    end
end

monthlyMinTMK_H_95{s,i}=RMKH;
monthlyMinTMK_p_95{s,i}=RMKp;
monthlyMinTMK_sen{s,i}=RMKsen;

end


end

save('monthlyMinT Running MK','monthlyMinTMK_H_95','monthlyMinTMK_p_95','monthlyMinTMK_sen');

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Load Data
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Meta.mat')
%load('C:\Users\jmaleski\Box Sync\ACF ACT work\matlab code\running trends\Stat.mat')

[data1,txt]=xlsread('ACTT_MeanUpd.xlsx',1);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 

%set up storage

RMKH=nan(120,120); 
RMKp=nan(120,120); 
RMKsen=nan(120,120); 

monthlyMeanTMK_H_95{25,25}=nan(120,120);
monthlyMeanTMK_p_95{25,25}=nan(120,120);
monthlyMeanTMK_sen{25,25}=nan(120,120);


for s=1:12 %months
%extract month

    iMonth = find(data1(:,2)==(s)); %find month
    iMonthD=data1(iMonth,:); %select month data

for i=3:23 %station loop
    %extract station    
    
    iStationD=iMonthD(:,i); %select station data    
    
    startData=1;
    lengthData=length(iStationD);
    
   
%loop calculates running pval H and sens slope for each station
for u=startData:lengthData-minDataPoints % start date
    for v=u+minDataPoints:lengthData % end date
       
        kdata=[(u:v)' iStationD(u:v)];
        [RMKH(v,u), RMKp(v,u),RMKsen(v,u)]= ktaubSen_JM(kdata, 0.05);
     
    end
end

monthlyMeanTMK_H_95{s,i}=RMKH;
monthlyMeanTMK_p_95{s,i}=RMKp;
monthlyMeanTMK_sen{s,i}=RMKsen;

end


end

save('monthlyMeanT Running MK','monthlyMeanTMK_H_95','monthlyMeanTMK_p_95','monthlyMeanTMK_sen');

