%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This scripts plots running mann kendal data for a number of years
%
%input are tables of sens slope, p-value and feild significance created by
%scripts RMK_annual and RMK_FS_annual
%
%Jerome Maleski 5/4/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input annual sens slope, pval and FS for 21 stations
%loop to sum all stations and make a sum of stations slopes 
%with FS
%one seqence for rainfall another for temperature

%% Load Data
load('C:\Users\jmaleski\Desktop\RMK ACT data\Annual RMK\A pcp FS.mat')
load('C:\Users\jmaleski\Desktop\RMK ACT data\Annual RMK\A rain RMK.mat')

%% set up data 

slope=annualMinTMK_sen;
pval=annualMinTMK_p_95;


%%
% precipitation code

timeRes='annual';
%month={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
lable='Precipitation each station p<.05';
savelable='Prcp each station 95';
minDataPoints=9; 

setpval=.05;

%Set parameters for graph generation
fn='Helvetica Neue';
fstitle=14;
fsaxis=14;
linewidth=1.2;


%%
for i=2:22
    
    

%chose station
istation=slope{1,i};

%chose pval

ipv=pval{1,i};    
ipv=ipv <= setpval;
ipv=double(ipv);

    



%% create figure


%set up figure

h=figure ;

imax=max(max(istation));
%imax=max(imax);
imin=min(min(istation));
%imin=min(imin);

%plot value

surface(istation);
shading flat
hold on
%contourf(SumSlope,[-20,-2,2,20]);
%plot contour confidence p<.05
%

[~,c]=contour(ipv,'LineColor',[.5,.5,.5],'LineWidth',1);

%# change the ZData property of the inner patches
cc = get(c,'Children');    %# get handles to patch objects
for p=1:numel(cc)
    zdata = ones(size( get(cc(p),'XData') ));
    set(cc(p), 'ZData',(imax+10)*zdata)
end

%lables

set(gca,'xtick',1:10:120,'xticklabel',1895:10:2012)
set(gca,'ytick',1:10:120,'yticklabel',1895:10:2012)
%title(strcat(month{1,m},'-',lable),'fontsize',fsaxis,'fontname',fn)
title((strcat(Name(i-1,1),' Precipitation')),'fontsize',fsaxis,'fontname',fn);

xlabel('Beginning year','fontsize',fsaxis,'fontname',fn)
ylabel('Ending year','fontsize',fsaxis,'fontname',fn)
sizeData=size(istation);
axis([1 sizeData(1) 1 sizeData(1)])



%colormap (cool2)
%colormap (hot)
%colormap(flipud(hot))

colorbar
h = colorbar;
%ylabel(h, '\circ C / year','fontsize',fsaxis,'fontname',fn);
ylabel(h, 'mm pcp / year','fontsize',fsaxis,'fontname',fn);


%caxis([imin,imax])
caxis([-20,20])

%save figure
filename=(strcat(Name(i-1,1),'-Pcp'));

print('-dpng',filename{1,1})
close



end

%%
%temperature code

timeRes='annual';
%month={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
lable='Max Temp p<.05';
savelable='Max Temp 95';
minDataPoints=9; 

setpval=.05;

%Set parameters for graph generation
fn='Helvetica Neue';
fstitle=14;
fsaxis=14;
linewidth=1.2;




for i=2:22
    

%chose station
istation=slope{1,i}*10;

%chose pval

ipv=pval{1,i};    
ipv=ipv <= setpval;
ipv=double(ipv);

    



%% create figure


%set up figure

h=figure ;

imax=max(max(istation));
%imax=max(imax);
imin=min(min(istation));
%imin=min(imin);

%plot value

surface(istation);
shading flat
hold on
%contourf(SumSlope,[-20,-2,2,20]);
%plot contour confidence p<.05
%

[~,c]=contour(ipv,'LineColor',[.5,.5,.5],'LineWidth',1);

%# change the ZData property of the inner patches
cc = get(c,'Children');    %# get handles to patch objects
for p=1:numel(cc)
    zdata = ones(size( get(cc(p),'XData') ));
    set(cc(p), 'ZData',(imax+10)*zdata)
end

%lables

set(gca,'xtick',1:10:120,'xticklabel',1895:10:2012)
set(gca,'ytick',1:10:120,'yticklabel',1895:10:2012)
%title(strcat(month{1,m},'-',lable),'fontsize',fsaxis,'fontname',fn)
title((strcat(Name(i-1,1),' Min Temp')),'fontsize',fsaxis,'fontname',fn);

xlabel('Beginning year','fontsize',fsaxis,'fontname',fn)
ylabel('Ending year','fontsize',fsaxis,'fontname',fn)
sizeData=size(istation);
axis([1 sizeData(1) 1 sizeData(1)])



colorbar
h = colorbar;
ylabel(h, '\circ C / decade','fontsize',fsaxis,'fontname',fn);
%ylabel(h, 'mm pcp / year','fontsize',fsaxis,'fontname',fn);


%caxis([imin,imax])
caxis([-1,1])

%save figure
filename=(strcat(Name(i-1,1),'-Min Temp'));

print('-dpng',filename{1,1})
close



end


