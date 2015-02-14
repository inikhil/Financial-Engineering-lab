close all;
clear;
clc;

beta=[0.02 0.7 0.06];
mu=[0.7 0.1 0.09];
sig=[0.02 0.3 0.5];
r0=[0.1 0.2 0.02];

t=0;
for i=1:3
    for j=1:10
        y(j,1)=t+j*0.5;
        y(j,2)=Cir(beta(i)*mu(i),beta(i),y(j,1)-t,sig(i),r0(i));
        y(j,2)=log(y(j,2))/(t-y(j,1));
    end
    figure();
    plot([0;y(:,1)],[r0(i);y(:,2)]);
    hold on;
    scatter([0;y(:,1)],[r0(i);y(:,2)],'*');
    xlabel('Time to maturity');
    ylabel('Yield');
    str=sprintf('CIR model with beta=%f, mu=%f, sig=%f and r(0)=%f',beta(i),mu(i),sig(i),r0(i));
    title(str);
    hold off;
end

r0=0.1:0.1:1;
for i=1:3
    figure();
    hold on;
    for j=1:10
        for k=1:10
            y(k,1)=t+k*0.5;
            y(k,2)=Cir(beta(i)*mu(i),beta(i),y(k,1)-t,sig(i),r0(j));
            y(k,2)=log(y(k,2))/(t-y(k,1));
        end
        plot([0;y(:,1)],[r0(j);y(:,2)]);
        scatter([0;y(:,1)],[r0(j);y(:,2)],'*');
    end
    xlabel('Time to maturity');
    ylabel('Yield');
    str=sprintf('CIR model with beta=%f, mu=%f and sig=%f',beta(i),mu(i),sig(i));
    title(str);
    hold off;
end