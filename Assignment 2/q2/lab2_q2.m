function[root]=lab2_q2opt()
    k=100;T=1;r=0.08;sig=0.2;m=10;t=T/m;
    %a=zeros(m+1);
    a(1)=100;
    [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
    fprintf('For set 1 The value of Asian call  is %.8f\n',b(1))
    fprintf('For set 1 The value of Asian put   is %.8f\n',c(1));
    fprintf('\n\n');
    [b,c]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
    fprintf('For set 2 The value of Asian call  is %.8f\n',b(1))
    fprintf('For set 2 The value of Asian put   is %.8f\n',c(1));
    fprintf('\n\n');
    x=[50:5:150];
    xx={'S(0)', 'K', 'r' , 'sigma', 'm'};
    for i=1:length(x)
        a(1)=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1);put(i)=c(1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
         call1(i)=b1(1);put1(i)=c1(1);
    end
    %graphical_S0(x,call,put,call1,put1);
    a(1)=100;
    graphical(x,call,put,call1,put1,xx,1);
    for i=1:length(x)
        k=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1);put(i)=c(1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
         call1(i)=b1(1);put1(i)=c1(1);
    end
    %graphical_k(x,call,put,call1,put1);
    k=100;
    graphical(x,call,put,call1,put1,xx,2);
    x=[];call=[];put=[];call1=[];put1=[];
    x=[.04:.01:.16];
    for i=1:length(x)
        r=x(i);
        if exp(r*t)>=set1_d(sig,t) && exp(r*t)<=set1_u(sig,t) % Arbitrage condition
            [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
            call(i)=b(1);put(i)=c(1);
        end
        if exp(r*t)>=set2_d(sig,t,r) && exp(r*t)<=set2_u(sig,t,r) % Arbitrage condition
            [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
            call1(i)=b1(1);put1(i)=c1(1);
        end
    end
    %graphical_r(x,call,put,call1,put1);
    r=.08;
    graphical(x,call,put,call1,put1,xx,3);
    x=[];call=[];put=[];call1=[];put1=[];
    x=[.1:.01:.3];
    for i=1:length(x)
        sig=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1);put(i)=c(1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
        call1(i)=b1(1);put1(i)=c1(1);
    end
    % graphical_sig(x,call,put,call1,put1);
    graphical(x,call,put,call1,put1,xx,4);
    x=[];call=[];put=[];sig=0.2;
     call1=[];put1=[];
    x=[1:1:10];
    for k=95:5:105
        for i=1:length(x)
             m=x(i);t=T/m;
             [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
             call(i)=b(1);put(i)=c(1);
             [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
             call1(i)=b1(1);put1(i)=c1(1);
        end
        graphical_m(x,call,put,call1,put1,k);
       % graphical(x,call,put,call1,put1,xx,5);
        m=100;t=T/m;
    end
end

function[root]=set1_u(sig,t)
     root=exp(sig*sqrt(t));
end
function[root]=set1_d(sig,t)
     root=exp(-1*sig*sqrt(t));
end
function[root]=set2_u(sig,t,r);
     root=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);
end
function[root]=set2_d(sig,t,r);
    root=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
end

function[]=graphical(x,call,put,call1,put1,xx,j)
    figure();
    p=plot(x,call,'b');
    grid on
    title1=['Plot of Asian call option by varying ', xx{j} , ' using set 1'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of Asian call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put,'b');grid on
    title1=['Plot of Asian put option by varying ', xx{j} , ' using set 1'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of Asian put option option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,call1,'b');grid on
    title1=['Plot of Asian call option by varying ', xx{j} , ' using set 2'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of Asian call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put1,'b');grid on
    title1=['Plot of Asian put option by varying ', xx{j} , ' using set 2'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of Asian put option at t=0');
    saveas(p,title1, 'png');
end
function[]=graphical_m(x,call,put,call1,put1,k)
    figure();
    p=plot(x,call,'b');grid on
    title1=['Plot of Asian call option by varying m using set 1 and k= ',num2str(k)];
    title(sprintf('Plot of Asian call option by varying m using set 1 and k= %d',k));
    xlabel('m');ylabel('Price of Asian call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put,'b');grid on
    title1=['Plot of Asian put option by varying m using set 1 and k= ',num2str(k)];
    title(sprintf('Plot of Asian put option by varying m using set 1 and k= %d',k));
    xlabel('m');ylabel('Price of Asian put option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,call1,'b');grid on
    title1=['Plot of Asian call option by varying m using set 2 and k= ',num2str(k)];
    title(sprintf('Plot of Asian call option by varying m using set 2 and k= %d',k));
    xlabel('m');ylabel('Price of Asian call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put1,'b');grid on
    title1=['Plot of Asian put option by varying m using set 2 and k= ', num2str(k)];
    title(sprintf('Plot of Asian put option by varying m using set 2 and k= %d', k));
    xlabel('m');ylabel('Price of Asian put option at t=0');
    saveas(p,title1, 'png');
end



function[root1,root2]=solve1(u,d,k,T,r,sig,m,t,a)
   % b=zeros(m+1);c=zeros(m+1);
    p=(exp(r*t)-d)/(u-d);
    q=(u-exp(r*t))/(u-d);
    for i=1:(2^m-1)
        a(2*i)=a(i)*u;
        a(2*i+1)=a(i)*d;
    end
    b=a;
    for i=2:2^(m+1)-1
        if mod(i,2)==0
            b(i)=b(i)+b(i/2);
        else
            b(i)=b(i)+b((i-1)/2);
        end
    end
    c=b;
    for i=2^(m):2^(m+1)-1
        b(i)=b(i)/(m+1);c(i)=c(i)/(m+1);
        b(i)=max(b(i)-k,0);c(i)=max(k-c(i),0);
    end
    for i=(2^m-1):-1:1
        b(i)=exp(-1*r*t)*(p*b(2*i)+q*b(2*i+1));
        c(i)=exp(-1*r*t)*(p*c(2*i)+q*c(2*i+1));
    end
        
   % printing(a,m);
    root1=b;root2=c;
end

function[]=printing(a,m)
    for i=1:m+1
        for j=1:i
            fprintf(1,'%f ',a(i,j));
        end
        fprintf('\n');
    end
end