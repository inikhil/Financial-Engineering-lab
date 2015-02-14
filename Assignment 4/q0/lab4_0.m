function[root]=lab4_0()
    T=1;r=0.08;sig=0.2;
    %m=[5,10,15,25,50];
    m=10;
    %for i =1:length(m)
        t=T/m;
        u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
        solve1(u,d,T,r,sig,m,t);
        %fprintf('The value of lookback option at m = %d is %.8f\n',m(i),b(1));
        %fprintf('\n\n');
    %end
    %{
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
 %}
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
    ini=100;a=zeros(m+1,m+1);
    for i=1:ceil(m/2)
        up=m+1-i;down=m-up;
        fin=ini*power(u,up)*power(d,down);
        for j=1:down+1
            a(i,j)=ini*power(u,up)-fin;
        end
    end
    if mod(m,2)==0
        up=m/2;down=m/2;
        fin=ini*power(u,up)*power(d,down);
        for j=1:m/2
             a(m/2+1,j) = ini*power(u,up)-fin;
        end
         a(m/2+1,m/2+1)=max(ini,fin)-fin;
    end
    for i=ceil(m/2+1):m+1
        up=m+1-i;down=m-up;
        fin=ini*power(u,up)*power(d,down);
        for j=1:down+1
            k=j-1;
            if up==k
                a(i,j)=max(ini,ini*power(u,up))-fin;
            else if up<k
                    a(i,j)=ini*power(u,up)-fin;
                else
                    a(i,j)=max(ini,fin)-fin;
                end
            end
        end
    end
    a
    ans=0;
    for i=1:m+1
        up=m+1-i;down=m-up;cal=0;
        mul=exp(-1*r*T)*power(p,up)*power(q,down);
        for j=1:i
            cal=cal + a(i,j);
        end
        ans = ans + cal*mul;
    end
    ans
end