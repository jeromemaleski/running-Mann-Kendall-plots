%this function calculates a test for field sigificance for the case of 
%regional climate data were spatial correlations between data can occur by 
%permutating the data and creating a frequency distribution against which we 
%can set significance tests (see Burn and Hag Elnuir, 2002).
%
%input is a table with each column being an observation location and each row being an observation

%returned are the number of stations needed to reach signifcance at the 90th and 95th percentiles

%this function calls as a function a modifided version of the MK trend test written by Jeff Burkey
%Jerome Maleski 5/4/2015



function [MKFS95, MKFS90] = testFieldSignificance(data, years)



nMK90=[];
nMK95=[];

numPermutations = 1000;

for i=1:numPermutations % number of permutations

    order = randperm(size(data,1)); %re-order along length of data
    reorderedData = data(order,:);
    
    for j = 1:size(reorderedData,2) %select each data row
        
        thisData=reorderedData(:,j); %selected row
            
        ktbData = [years thisData];
            
        [sig(j)]=ktaub_JM(ktbData,.05); % Mann-Kendall and Sen's slope

    end
    
    % count number of gauges at 90% and 95% significance levels
    
    nMK90(i) = sum(sig<=0.1);
    nMK95(i) = sum(sig<=0.05);

end

% sort values and determine the actual 90 and 95% levels of significance
sortedMK90 = sort(nMK90);
sortedMK95 = sort(nMK95);

MKFS90 = sortedMK90(numPermutations * 0.9);
MKFS95 = sortedMK95(numPermutations * 0.95);