function[]=markowitz()
    m=[0.1,0.2,0.15];
    C=[.005,-.010,.004; -.010,.040, -.002; .004,-.002, 0.023];
    x=[1,1,1]; a=x*inv(C)*x.';b=x*inv(C)*m.';c=m*inv(C)*m.';
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
    %saveas(p,title1, 'png');
    weights(m,C,phu,x,sig_sq,a,b,c,d,10);
    risk(a,b,c,d,phu,C,x,m);
    min_risk(a,b,c,d,phu,C,x,m);
    riskfree(m,C,x,a,b,c,d);
end

function[]=risk(a,b,c,d,phu,C,x,m)
    sig_sq=[0.15*0.15, 0.15*0.15];
    sym x;
    phu=eval(solve('a*x*x-2*b*x+c-d*0.15*0.15'));
    fprintf('\n');
    weights(m,C,phu,x,sig_sq,a,b,c,d,2);
    
end
function[]=min_risk(a,b,c,d,phu,C,x,m)
    xx=0.18;
    sig_sq=(a*xx*xx-2*b*xx+c)/d;
    fprintf('\n');
    weights(m,C,0.18,x,sig_sq,a,b,c,d,1);
end

function[]=weights(m,C,phu,x,sig_sq,a,b,c,d,yy)
    for i=1:yy
        lambda_1=((c-b*phu(i))/d);lambda_2=((a*phu(i)-b)/d);
        k=lambda_1*x.' + lambda_2* m.';
        w=inv(C)*k;
        xx(i,: )=w;
    end
    print(xx,phu,sig_sq,yy);
end

function[]=riskfree(m,C,x,a,b,c,d)
    phu_rf=0.1;
    xx=(m-phu_rf*x)*inv(C);
    y=xx * x.';
    w=xx/y;
    fprintf('\n');
    for j=1:3
       fprintf('%f ',w(j));
    end
       fprintf('\n');
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
    sig=[0.1, 0.25];
    for i =1:length(sig)
        pu(i)=phu_rf+((phu-phu_rf)*sig(i))/sqrt(sig_sq);
        ww(i)=(pu(i)-phu_rf)/(phu-phu_rf);%weight of risky asset
    end
    fprintf('\n');
    for i=1:2
        fprintf('%f %f\n',ww(i),1-ww(i));
    end
end

function[]=print(xx,phu,sig_sq,yy)
    for i=1:yy
        fprintf('%f %f ',phu(i),sig_sq(i));
        for j=1:3
            fprintf('%f ',xx(i,j));
        end
        fprintf('\n');
    end
end

    
    