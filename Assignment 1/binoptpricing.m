function[root]=binoptpricing()
    m=[1,5,10,20,50,100,200,400];
    
    for i=1:length(m)
        solve1(m(i));
    end
    fprintf('\n\n');
    graphical(1,200);
    graphical(5,400);
    solve3(20);
end

function[]=graphical(x,y)
    m=[100:x:y];
    for i=1:length(m)
        [call(i),put(i)]=solve2(m(i));
    end
    if x==1
        figure('Name','Plot of European call at t=0 by varying m by step 1')
        plot(m,call,'b');
        figure('Name','Plot of European put at t=0 by varying m by step 1')
        plot(m,put,'b');
    else
        figure('Name','Plot of European call at t=0 by varying m by step 5')
        plot(m,call,'b');
        figure('Name','Plot of European put at t=0 by varying m by step 5')
        plot(m,put,'b');
    end
end
function[root1,root2]=solve1(m)
k=10;T=3;r=0.06;sig=0.3;
    a=zeros(m+1);b=zeros(m+1);c=zeros(m+1);t=T/m;
    u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);
    d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
    p=(exp(r*t)-d)/(u-d);
    q=(u-exp(r*t))/(u-d);
    a(1,1)=9;
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
            b(i,j)=exp(-1*r*t)*(p*b(i+1,j)+q*b(i+1,j+1));
            c(i,j)=exp(-1*r*t)*(p*c(i+1,j)+q*c(i+1,j+1));
        end
    end
   % fprintf('\n\n for European call option\n');
   %printing(b,m);
    fprintf('The value of Europenan call for M=%d is %.8f\n',m,b(1,1));
    fprintf('The value of Europenan put  for M=%d is %.8f\n',m,c(1,1));
    root1=b(1,1);root2=c(1,1);
  % fprintf('\n\n for European put option\n');
   % printing(c,m);
    
end
function[root1,root2]=solve3(m)
    k=10;T=3;r=0.06;sig=0.3;
    a=zeros(m+1);b=zeros(m+1);c=zeros(m+1);t=T/m;
    u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);
    d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
    p=(exp(r*t)-d)/(u-d);
    q=(u-exp(r*t))/(u-d);
    a(1,1)=9;
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
            b(i,j)=exp(-1*r*t)*(p*b(i+1,j)+q*b(i+1,j+1));
            c(i,j)=exp(-1*r*t)*(p*c(i+1,j)+q*c(i+1,j+1));
        end
    end
    t1=[0,0.30,0.75,1.50,2.70];
    %t2=(t1./ 0.15)+1
    t2=[1,3,6,11,19];
    fprintf('\n\n for European call option\n');
    for i=1:length(t2)
        fprintf('The value of at state time = %f is ',t1(i))
        for j=1:t2(i)
            fprintf('%.8f ', b(t2(i),j));
        end
        fprintf('\n');
    end
    fprintf('\n\n for European put option\n');
    for i=1:length(t2)
        fprintf('The value of at state time = %f is ',t1(i))
        for j=1:t2(i)
            fprintf('%.8f ', c(t2(i),j));
        end
        fprintf('\n');
    end
                 
end

function[root1,root2]=solve2(m)
k=10;T=3;r=0.06;sig=0.3;
    a=zeros(m+1);b=zeros(m+1);c=zeros(m+1);t=T/m;
    u=exp(sig*sqrt(t)+(r-0.5*sig*sig)*t);
    d=exp(-1*sig*sqrt(t)+(r-0.5*sig*sig)*t);
    p=(exp(r*t)-d)/(u-d);
    q=(u-exp(r*t))/(u-d);
    a(1,1)=9;
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
            b(i,j)=exp(-1*r*t)*(p*b(i+1,j)+q*b(i+1,j+1));
            c(i,j)=exp(-1*r*t)*(p*c(i+1,j)+q*c(i+1,j+1));
        end
    end
    root1=b(1,1);root2=c(1,1);
end

function[]=printing(a,m)
    for i=1:m+1
        for j=1:i
            fprintf(1,'%f ',a(i,j));
        end
        fprintf('\n');
    end
end