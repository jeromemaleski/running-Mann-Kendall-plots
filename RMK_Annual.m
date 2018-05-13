%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this script calculates the man-kendall hyptothesis test for a trend and calculates
%the senns slope for an array of climate data in a running trends manner so that
%test and slope are calulated for each timeperiod in the data.
%
%input is a table of climate data with the first column being year and subsequent 
%columns being time series observations at each location
%
%this scrip calls as a function a modifided version of the MK trend test written by Jeff Burkey
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load Data

[data1,txt]=xlsread('ACTT_maxUpd.xlsx',5);

%%
timeRes='year';
stat='Flow';
minDataPoints=9; 

%set up storage

RMKH=nan(120,120); 
RMKp=nan(120,120); 
RMKsen=nan(120,120); 

annualMaxTMK_H_95{25}=nan(120,120);
annualMaxTMK_p_95{25}=nan(120,120);
annualMaxTMK_sen{25}=nan(120,120);


%for s=1:12 %months
%extract month

%    iMonth = find(data1(:,2)==(s)); %find month
%    iMonthD=data1(iMonth,:); %select month data

for i=3:23 %station loop
    %extract station    
    
    iStationD=data1(:,i); %select station data    
    
    startData=1;
    lengthData=length(iStationD);
    
   
%loop calculates running pval H and sens slope for each station
for u=startData:lengthData-minDataPoints % start date
    for v=u+minDataPoints:lengthData % end date
       
        kdata=[(u:v)' iStationD(u:v)];
        [RMKH(v,u), RMKp(v,u),RMKsen(v,u)]= ktaubSen_JM(kdata, 0.05);
     
    end
end

annualMaxTMK_H_95{i}=RMKH;
annualMaxTMK_p_95{i}=RMKp;
annualMaxTMK_sen{i}=RMKsen;

end


%end

save('annualMaxT Running MK','annualMaxTMK_H_95','annualMaxTMK_p_95','annualMaxTMK_sen');

close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
