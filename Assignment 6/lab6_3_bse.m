disp('Choose simulation by 1. daily data 2. monthly data 3. yearly data');
h=input('');

if(h==1)

a=xlsread('bse12.xlsx');
a(isnan(a))=0;
ind=1;
q=size(a);
[m,v]=logreturn_d(a);
b=xlsread('bsedaily.xlsx');
for i=1:q(2)
    x=randn(262,1);
    x=x*sqrt(1/262);
    s=a(1,i);
    for j=1:262
        if(j==1)
        y(j)=s*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        else
        y(j)=y(j-1)*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        end
    end
    figure (i)
    hold on;
    plot(y);
    plot(flipud(b(1:262,i)),'r');
    hold off;
end
end

if(h==2)
a=xlsread('bsedata.xls');
a=a(13:end,:)
a(isnan(a))=0;
ind=1;
q=size(a);
[m,v]=logreturn_m(a);
b=xlsread('bsedaily.xlsx');
for i=1:q(2)
    x=randn(262,1);
    x=x*sqrt(1/262);
    s=a(1,i);
    for j=1:262
        if(j==1)
        y(j)=s*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        else
        y(j)=y(j-1)*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        end
    end
    figure (i)
    hold on;
    plot(y);
    plot(flipud(b(1:262,i)),'r');
    hold off;
end
end

if(h==3)
a=xlsread('bseyearly.xlsx');
a=a(2:end,:)
a(isnan(a))=0;
ind=1;
q=size(a);
[m,v]=logreturn_y(a);
b=xlsread('bsedaily.xlsx');
for i=1:q(2)
    x=randn(262,1);
    x=x*sqrt(1/262);
    s=a(1,i);
    for j=1:262
        if(j==1)
        y(j)=s*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        else
        y(j)=y(j-1)*exp(v(i)*x(j)+ (m(i)-0.5*v(i)*v(i))*(1/262));
        end
    end
    figure (i)
    hold on;
    plot(y);
    plot(flipud(b(1:262,i)),'r');
    hold off;
end
end