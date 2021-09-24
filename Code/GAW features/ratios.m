function [Ratio_matrix,Ratio_matrix1,y]=ratios(matrix,S_P)
%the objective of this function is to return a Ratio_matrix contains 7
%symmetry indicators the inputs of this function are a matrix contains the
%movement of each two opposing points and the period sampling 
%the outputs is Ratio_matrix contains the symmetry indicators
l=size(matrix);
c=1;
for i=1:2:l(2)
    % Ar is the amplitude |Pr is the periode| Or is the open phase| Cr
    % is the closed phase |tr is the time from max_opening to closing
    [Ar,Pr,Or,Cr,tr,yr]=Symmetry_indicators(matrix(:,i),S_P);  
    [Al,Pl,Ol,Cl,tl,yl]=Symmetry_indicators(-matrix(:,i+1),S_P);
    [Ramp]=ratio_Amp(mean(Ar),mean(Al)); %Amplitude ratio
    [Rper]=ratio_per(mean(Pr),mean(Pl)); %Period ratio
    if(isempty(Or))
        Or=0;
    end
    if(isempty(Cr))
        Cr=0;
    end
    if(isempty(Ol))
        Ol=0;
    end
    if(isempty(Cl))
        Cl=0;
    end
    [Roq_r,OQ_r]=ratio_open_close(Or(1),Cr(1)); %the open close ratio for the right points
    [Roq_l,OQ_l]=ratio_open_close(Ol(1),Cl(1)); %the open close ratio for the left points
    [PSI]=phase_symmetry(tr,tl,Pr(1));%the phase symmetry index 
    if (c==1)
        d=[Ramp Rper Roq_r OQ_r Roq_l OQ_l PSI];
        Ratio_matrix=d;
        c=c+1;
    else
        d=[Ramp Rper Roq_r OQ_r Roq_l OQ_l PSI];
        Ratio_matrix=[Ratio_matrix;d];
    end
    y= yr + yl ; 
    GGI_r = min(yr)/max(yr);
    GGI_l = min(yl)/max(yl);
    ALR_r=(max(yr)-min(yr))/length(yr);
    ALR_l=(max(yl)-min(yl))/length(yl);
    C_l= Cl(1)/S_P;
    C_r= Cr(1)/S_P;
    ST_r=maxi(yr)/ALR_r;
    ST_l=maxi(yl)/ALR_l;
    Ratio_matrix1=[GGI_r,GGI_l,ALR_r,ALR_l,C_r,C_l, ST_r,ST_l];
end
end