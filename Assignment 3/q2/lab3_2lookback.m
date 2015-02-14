function[root]=lab3_2lookback()
    T=1;r=0.08;sig=0.2;
    m=[5,10,15];
    a=[];b=[];
    for i =1:length(m)
        t=T/m(i);
        u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
        b=solve1(u,d,T,r,sig,m(i),t,a,b);
        fprintf('The value of lookback option at m = %d is %.8f\n',m(i),b(1));
        fprintf('\n\n');
    end
    xx={'S(0)', 'K', 'r' , 'sigma', 'm'};
    a=[];b=[];
    m=[1:1:15];
    for i =1:length(m)
        t=T/m(i);
        u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
        b=solve1(u,d,T,r,sig,m(i),t,a,b);
        value(i)=b(1);
    end
    graphical(m,value);
    a=[];b=[];
    m=5;t=T/m;
    u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
    b=solve1(u,d,T,r,sig,m,t,a,b);
    fprintf('The value of lookback option at all intermediate points for m=5 is: \n');
    for t=1:6
        fprintf('At t= %d: \n',t-1 )
        for i=2^(t-1):(2^t-1)
            disp(b(i));
        end
    end 
end

function[]=graphical(m,value)
    figure();
    p=plot(m,value,'b');
    grid on
    title1=['Plot of lookback option by varying m'];
    title(sprintf('%s',title1));
    xlabel('m');ylabel('Price of Lookback option at t=0');
    saveas(p,title1, 'png');
end


function[root1]=solve1(u,d,T,r,sig,m,t,a,b)
    p=(exp(r*t)-d)/(u-d);q=(u-exp(r*t))/(u-d);
    a(1)=100;b(1)=100;
    xx=2^m;yy=2^(m+1);
    for i=1:xx-1
        a(2*i)=a(i)*u;b(2*i)=max(b(i),a(2*i));
        a(2*i+1)=a(i)*d;b(2*i+1)=max(b(i),a(2*i+1));
    end
    for i=xx:yy-1
        b(i)=b(i)-a(i);
    end
    for i=(xx-1):-1:1
        b(i)=exp(-1*r*t)*(p*b(2*i)+q*b(2*i+1));
    end
    root1=b;
end
