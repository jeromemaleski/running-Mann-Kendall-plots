%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This scripts plots running mann kendal data for a number of months
%
%input are tables of sens slope, p-value and feild significance created by
%scripts RMK_Monthly and RMK_FS_monthly
%
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input monthly sens and pval and FS for 12 months
%loop to sum all stations and make a sum of stations solps for 12 months
%with FS
% one program for rainfall another for temperature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Data
load('C:\Users\jmaleski\Desktop\RMK ACT data\monthly RMK\monthlyPcp Running MK.mat')
load('C:\Users\jmaleski\Desktop\RMK ACT data\monthly RMK\monthlyRain FS.mat')


%% set up data 

%slope=monthlyMaxTMK_sen;
%pval=monthlyMaxTMK_p_95;
%FS95=monthlyMaxTMK_FS_95;

slope=monthlySPEI1MK_sen;
pval=monthlySPEI1MK_p_95;
FS95=monthlySPEI1MK_FS_95;


timeRes='monthly';
month={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
lable='Mean SPEI1';
savelable='SPEI1 all stations 95';
minDataPoints=9; 

setpval=.05;

%Set parameters for graph generation
fn='Helvetica Neue';
fstitle=14;
fsaxis=14;
linewidth=1.2;
%colormap
MR=[0,1;
    .2,.3;
    .7,.4;
    0.8,.5;
    1,0];
MG=[0,1;
    0.3,1;
    1,0];
MB=[0,1; 
    %0.1,1;
    1,1];

cool2 = colormapRGBmatrices(250,MR,MG,MB);


%% rainfall

for m=1:12
    
SumSlope=zeros;
station_cnt95=zeros;
iSum=zeros;
ipv=zeros;

%sum slopes
 
  
for i=3:23

iSum=slope{m,i};    
    
SumSlope=SumSlope+iSum;    
    
end

SumSlope=SumSlope/21; %mean
SumSlope=SumSlope*10; %per decade

%count stations

for i=3:23

ipv=pval{m,i};    
ipv=ipv <= setpval;
ipv=double(ipv);
station_cnt95=station_cnt95+ipv;  
    
end

%trim
station_cnt95(119:120,:) = [];
station_cnt95(:,119:120) = [];
SumSlope(119:120,:) = [];
SumSlope(:,119:120) = [];


%% create figure

%for i=2:22;

%set up figure

h=figure ;

imax=max(max(SumSlope));
%imax=max(imax);
imin=min(min(SumSlope));
%imin=min(imin);

%plot value
surface(SumSlope);
shading flat
hold on

%plot contour confidence p<.05
%[~,c]=contour(annualMeanTMK_p_95{1,i},[0,.1],'b','LineWidth',2);

iFS95=FS95{1,m};
iFS95(119:120,:) = [];
iFS95(:,119:120) = [];
fs=station_cnt95 >= iFS95;
fs = double(fs);
[~,c]=contour(fs,'LineColor',[.5,.5,.5],'LineWidth',2);


%# change the ZData property of the inner patches
cc = get(c,'Children');    %# get handles to patch objects
for p=1:numel(cc)
    zdata = ones(size( get(cc(p),'XData') ));
    set(cc(p), 'ZData',(imax+10)*zdata)
end

%lables

%set(gca,'xtick',1:10:120,'xticklabel',1895:10:2012)
%set(gca,'ytick',1:10:120,'yticklabel',1895:10:2012)
%title(strcat(month{1,m},'-',lable),'fontsize',fsaxis,'fontname',fn)
%xlabel('Beginning year','fontsize',fsaxis,'fontname',fn)
%ylabel('Ending year','fontsize',fsaxis,'fontname',fn)
sizeData=size(SumSlope);
axis([1 sizeData(1) 1 sizeData(1)])
set(gca, 'XTick', []);
set(gca, 'YTick', []);


%colormap (cool2)
%colormap (hot)
%colormap(flipud(hot))

colorbar
h = colorbar;
%ylabel(h, '\circ C / decade','fontsize',fsaxis,'fontname',fn);
%ylabel(h, 'mm / month','fontsize',fsaxis,'fontname',fn);


%caxis([imin,imax])
caxis([-.5,.5])



%save figure
filename=(strcat(month{1,m},'-',savelable));
print('-dpng',filename)
close

%save slope matrix
savename=(strcat(month{1,m},'-',savelable));
save(savename,'SumSlope');

end

%% temperature
for m=1:12
    
SumSlope=zeros;
station_cnt95=zeros;
iSum=zeros;
ipv=zeros;

%sum slopes
 
    
for i=3:23

iSum=slope{m,i};    
    
SumSlope=SumSlope+iSum;    
    
end

SumSlope=SumSlope/21; %mean
SumSlope=SumSlope*10; %per decade

%count stations

for i=3:23

ipv=pval{m,i};    
ipv=ipv <= setpval;
ipv=double(ipv);
station_cnt95=station_cnt95+ipv;  
    
end

%trim
station_cnt95(119:120,:) = [];
station_cnt95(:,119:120) = [];
SumSlope(119:120,:) = [];
SumSlope(:,119:120) = [];





%% create figure


%for i=2:22;

%set up figure

h=figure ;

imax=max(max(SumSlope));
%imax=max(imax);
imin=min(min(SumSlope));
%imin=min(imin);

%plot value
surface(SumSlope);
shading flat
hold on

%plot contour confidence p<.05
%[~,c]=contour(annualMeanTMK_p_95{1,i},[0,.1],'b','LineWidth',2);

iFS95=FS95{1,m};
iFS95(119:120,:) = [];
iFS95(:,119:120) = [];
fs=station_cnt95 >= iFS95;
fs = double(fs);
[~,c]=contour(fs,'LineColor',[.5,.5,.5],'LineWidth',2);


%# change the ZData property of the inner patches
cc = get(c,'Children');    %# get handles to patch objects
for p=1:numel(cc)
    zdata = ones(size( get(cc(p),'XData') ));
    set(cc(p), 'ZData',(imax+10)*zdata)
end

%lables

%set(gca,'xtick',1:10:120,'xticklabel',1895:10:2012)
%set(gca,'ytick',1:10:120,'yticklabel',1895:10:2012)
%title(strcat(month{1,m},'-',lable),'fontsize',fsaxis,'fontname',fn)
%xlabel('Beginning year','fontsize',fsaxis,'fontname',fn)
%ylabel('Ending year','fontsize',fsaxis,'fontname',fn)
sizeData=size(SumSlope);
axis([1 sizeData(1) 1 sizeData(1)])
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%colormap (cool2)
%colormap (hot)
%colormap(flipud(hot))

%colorbar
%h = colorbar;
%ylabel(h, '\circ C / decade','fontsize',fsaxis,'fontname',fn);
%ylabel(h, 'mm pcp / month','fontsize',fsaxis,'fontname',fn);


%caxis([imin,imax])
caxis([-1,1])



%save figure
filename=(strcat(month{1,m},'-',savelable));
print('-dpng',filename)
close

%save slope matrix
savename=(strcat(month{1,m},'-',savelable));
save(savename,'SumSlope');


end


[x,y] = meshgrid(-10:0.1:10,-10:0.1:10);  % just to get some x and y values
z = sqrt(x.^2 + y.^2);
surf(x,y,z)
shading interp
set(gca,'cameraposition',[0 0 180])  % this essentially turns a 3d surface plot into a 2d plot
colormap(flipud(jet))
contourf(x,y,z)
