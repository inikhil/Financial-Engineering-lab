function[]=markowitz_online()
    file='price.xlsx';
    a=xlsread(file);
    for j =1:10
        m(j)=0;
        for i=2:50
            m(j)=m(j)+a(i,j)-a(1,j);
            r(i-1,j)=(a(i,j)-a(1,j))/a(1,j);
            %r(i-1,j)=(a(i,j)-a(i-1,j))/a(i-1,j);
            %m(j)=m(j)+r(i-1,j);
        end
        m(j)=m(j)/(49*a(1,j));
        %m(j)=m(j)/49;
    end
    for i=1:10
        for j=1:10
            t=cov(r(:,i),r(:,j));
            C(i,j)=t(1,2);
        end
    end
    x=ones(1,10);
    a=x*inv(C)*x.';b=x*inv(C)*m.';c=m*inv(C)*m.';phu_rf=0.07;
    d=a*c-b*b;
    phu=[-0.3:0.03:0.5];
    for i =1:length(phu)
        sig_sq(i)=(a*phu(i)*phu(i)-2*b*phu(i)+c)/d;
    end
    figure();
    p=plot(sig_sq,phu,'b');
    grid on
    title1='Plot of Markowitz frontier varying mean return';
    title(sprintf('%s',title1));
    xlabel('Square of sigma of portfolio');ylabel('mean return of portfolio');
    %saveas(p,title1, 'jpg');
    portfolio(phu_rf,x,C,m,a,b,c,d);
    for i=1:length(m)
        security_market(phu_rf,m(i),i);
    end
        
end

function[]=portfolio(phu_rf,x,C,m,a,b,c,d)
    xx=(m-phu_rf*x)*inv(C);
    y=xx * x.';
    w=xx/y;
    for j=1:10
        fprintf('%f ',w(j));
    end
        fprintf('\n');
    riskfree(m,C,x,a,b,c,d,w,phu_rf);
end
function[]=riskfree(m,C,x,a,b,c,d,w,phu_rf)

    phu=m*w.';sig_sq=w*C*w.';
    sig=[0.1:0.03:0.5];
    for i =1:length(sig)
        pu(i)=phu_rf+((phu-phu_rf)*sig(i))/sqrt(sig_sq);
    end
    figure()
    p=plot(pu,sig,'b');
    grid on
    title1='Plot of Capital market line using risk free return';
    title(sprintf('%s',title1));
    xlabel('sigma of portfolio');ylabel('mean return of portfolio');
    %saveas(p,title1, 'png');  
end
function[]=security_market(phu_rf,m1,xx)
    beta=[0:0.5:2];
    for i=1:length(beta)
        y(i)=phu_rf+beta(i)*(m1-phu_rf);
    end
    figure();
    p=plot(beta,y,'b');
    grid on
    title1=['Plot of Security market line for stock ' num2str(xx)];
    title(sprintf('%s',title1));
    xlabel('Beta');ylabel('expected return of a security');
    %saveas(p,title1, 'jpg');
end

    
    