function[root]=lab3_1american()
    k=100;T=1;r=0.08;sig=0.2;m=100;t=T/m;
    a=zeros(m+1);a(1,1)=100;
    [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
    fprintf('For set 1 The value of American call  is %.8f\n',b(1,1))
    fprintf('For set 1 The value of American put   is %.8f\n',c(1,1));
    fprintf('\n\n');
    [b,c]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
    fprintf('For set 2 The value of American call  is %.8f\n',b(1,1))
    fprintf('For set 2 The value of American put   is %.8f\n',c(1,1));
    fprintf('\n\n');
    xx={'S(0)', 'K', 'r' , 'sigma', 'm'};
    x=[50:5:150];
    for i=1:length(x)
        a(1,1)=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1,1);put(i)=c(1,1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
         call1(i)=b1(1,1);put1(i)=c1(1,1);
    end
    graphical(x,call,put,call1,put1,xx,1);a(1,1)=100;
    for i=1:length(x)
        k=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1,1);put(i)=c(1,1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
         call1(i)=b1(1,1);put1(i)=c1(1,1);
    end
    graphical(x,call,put,call1,put1,xx,2);k=100;
    x=[];call=[];put=[];call1=[];put1=[];
    x=[.04:.01:.16];
    for i=1:length(x)
        r=x(i);
        if exp(r*t)>=set1_d(sig,t) && exp(r*t)<=set1_u(sig,t) % Arbitrage condition
            [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
            call(i)=b(1,1);put(i)=c(1,1); 
        end
        if exp(r*t)>=set2_d(sig,t,r) && exp(r*t)<=set2_u(sig,t,r) % Arbitrage condition
            [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
            call1(i)=b1(1,1);put1(i)=c1(1,1);
        end
    end
    graphical(x,call,put,call1,put1,xx,3);r=.08;
    x=[];call=[];put=[];call1=[];put1=[];
    x=[.1:.01:.3];
    for i=1:length(x)
        sig=x(i);
        [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
        call(i)=b(1,1);put(i)=c(1,1);
        [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
        call1(i)=b1(1,1);put1(i)=c1(1,1);
    end
     graphical(x,call,put,call1,put1,xx,4); x=[];call=[];put=[];sig=0.2;
     call1=[];put1=[];
    x=[50:1:150];
    for k=95:5:105
        for i=1:length(x)
             m=x(i);t=T/m;
             [b,c]=solve1(set1_u(sig,t),set1_d(sig,t),k,T,r,sig,m,t,a);
             call(i)=b(1,1);put(i)=c(1,1);
             [b1,c1]=solve1(set2_u(sig,t,r),set2_d(sig,t,r),k,T,r,sig,m,t,a);
             call1(i)=b1(1,1);put1(i)=c1(1,1);
        end
        graphical_m(x,call,put,call1,put1,k);m=100;t=T/m;
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
    title1=['Plot of American call option by varying ', xx{j} , ' using set 1'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of American call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put,'b');grid on
    title1=['Plot of American put option by varying ', xx{j} , ' using set 1'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of American put option option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,call1,'b');grid on
    title1=['Plot of American call option by varying ', xx{j} , ' using set 2'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of American call option at t=0');
    saveas(p,title1, 'png');
    figure();
    p=plot(x,put1,'b');grid on
    title1=['Plot of American put option by varying ', xx{j} , ' using set 2'];
    title(sprintf('%s',title1));
    xlabel(xx{j});ylabel('Price of American put option at t=0');
    saveas(p,title1, 'png');
end

function[]=graphical_m(x,call,put,call1,put1,k)
    figure();
    p=plot(x,call,'b');grid on
    title1=['Plot of American call by varying m using set 1 and k=  ',num2str(k)];
    title(sprintf('%s',title1));
    xlabel('m');ylabel('Price of American call option at t=0');
    saveas(p,title1,'png');
    figure();
    p=plot(x,put,'b');grid on
    title1=['Plot of American put by varying m using set 1 and k= ',num2str(k)];
    title(sprintf('%s',title1));
    xlabel('m');ylabel('Price of American put option at t=0');
    saveas(p,title1,'png');
    figure();
    p=plot(x,call1,'b');grid on
    title1=['Plot of American call by varying m using set 2 and k= ', num2str(k)];
    title(sprintf('%s',title1));
    xlabel('m');ylabel('Price of American call option at t=0');
    saveas(p,title1,'png');
    figure();
    p=plot(x,put1,'b');grid on
    title1=['Plot of American put by varying m using set 2 and k= ', num2str(k)];
    title(sprintf('%s',title1));
    xlabel('m');ylabel('Price of American put option at t=0');
    saveas(p,title1,'png');
end

function[root1,root2]=solve1(u,d,k,T,r,sig,m,t,a)
    b=zeros(m+1);c=zeros(m+1);
    p=(exp(r*t)-d)/(u-d);
    q=(u-exp(r*t))/(u-d);
    for i=1:m
        for j=1:i
            a(i+1,j)=a(i,j)*(u);
            a(i+1,j+1)=a(i,j)*(d);
        end
    end
   % printing(a,m);
    for j=1:m+1
        if a(m+1,j)>k
            b(m+1,j)=a(m+1,j)-k;c(m+1,j)=0;
        else
            b(m+1,j)=0;c(m+1,j)=k-a(m+1,j);
        end
    end
    for i=m:-1:1
        for j=1:i 
            b(i,j)=max((exp(-1*r*t)*(p*b(i+1,j)+q*b(i+1,j+1))),max((a(i,j)-k),0));
            c(i,j)=max((exp(-1*r*t)*(p*c(i+1,j)+q*c(i+1,j+1))),max((k-a(i,j)),0));
        end
    end
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