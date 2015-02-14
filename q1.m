%% Vasicek model
% vector
close all;
clear;
clc;

beta=[5.9 3.9 0.1];
mu=[0.2 0.1 0.4];
sigma=[0.3 0.3 0.11];
r0=[0.1 0.2 0.1];

for i=1:3
    for j=1:11
        t(j)=(j)*0.5;
        y(j)=vasicek(beta(i), mu(i),t(j),sigma(i), r0(i))
    end
    
    figure(i)
    plot(t,y)
end

r=0.1:0.1:1;
t=0.05:0.05:25;
%% for 500 time points 3rd loop is for accounting 500 time points
for i=1:3
   
    for j=1:length(r)
        
        for k=1:length(t)
           %t(k)=k*0.05;
           y(k)=vasicek(beta(i), mu(i),t(k),sigma(i), r(j));
        end
        figure(i+3)
        hold on;
        plot(t,y);
        hold off;
    end
    
    
end