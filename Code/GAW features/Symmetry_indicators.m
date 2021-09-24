function [Amp,Per,O_phase,C_phase,t,y]=Symmetry_indicators(y1,S_P)
%the objective is this function is to compute the the Amp,the period, the
%open phase, the closed phase and t which are the outputs 
%the inputs are the vector of movement of vocal fold and the sampling
%periods
m = min(y1);
if(m<0)
    m=0;
end
for i=1:length(y1)
    if (y1(i)<0)
        y(i)=0;
    else
        y(i)=y1(i);
    end
end
%figure ,plot(y);
%hold on

[vmax]=maximum_opening(y); %the indexes correspond to the Amplitudes in the vector 
for i=1:length(vmax)
    if vmax(i) == 0 
        Amp(i)=0; 
    else 
        Amp(i)= y(vmax(i));% the vector of Amplitudes 
    end
    
    if(i~=length(vmax))
        Per(i) = (vmax(i+1)-vmax(i))*S_P; %the vector of periods
    else
        Per(i)= vmax(i) * S_P;
    end
%     plot(vmax(i),y(vmax(i)),'r.');
end
c1=1;
c2=1;
for i=2:length(y)
    if ((y(i)==m)&&(y(i-1)>m))
        Vc(c1)=i;%the indexes of the closed points 
        c1=c1+1;
%         plot(i,y(i),'r.')
    end
    if ((y(i)>m)&&(y(i-1)==m))
        Vo(c2)=i;%the indexes of the open points 
        c2=c2+1;
%         plot(i-1,y(i-1),'g.')
    end
end
A = exist('Vc');
B = exist('Vo');
if((A==0)||(B==0))
    O_phase = 0;
    C_phase = 0;
    t=0;
else
    if (length(Vo)==length(Vc))
      if(Vo(1)<Vc(1))
        O_phase=(Vc-Vo)*S_P;%the period of the open phase.
        C_phase=(Vo(2:end)-Vc(1:end-1))*S_P;%the period of the closed  phase.
        t=vmax(1)*S_P;%the period from the maximum  to the first closing. 
      else
        C_phase=(Vo-Vc)*S_P;
        O_phase=(Vc(2:end)-Vo(1:end-1))*S_P;
        t=vmax(1)*S_P;
      end
    else
      if(Vo(1)<Vc(1))
        O_phase=(Vc-Vo(1:end-1))*S_P;
        C_phase=(Vo(2:end-1)-Vc(1:end-1))*S_P;
        t=vmax(1)*S_P;
      else
        C_phase=(Vo-Vc(1:end-1))*S_P;
        O_phase=(Vc(2:end-1)-Vo(1:end-1))*S_P;
        t=vmax(1)*S_P;
      end
    end
end
% hold off
end
