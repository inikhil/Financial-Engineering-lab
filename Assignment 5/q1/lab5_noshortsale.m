function[]=lab5_noshortsale()
    m1=[0.1,0.2,0.15];k=1;
    C1=[.005,-.010,.004; -.010,.040, -.002; .004,-.002, 0.023];
    figure();
    for i=1:3
        for j=i+1:3
            C=[C1(i,i), C1(i,j); C1(j,i), C1(j,j)];
            x=[1,1];m=[m1(i), m1(j)];
            markowitz(C,x,m,k);k=k+1;
        end
    end
    x=[1,1,1];
    p=markowitz(C1,x,m1,4);
    grid on
    title1='Plot of Markowitz frontier varying mean return';
    title(sprintf('%s',title1));
    xlabel('sigma of portfolio'); ylabel('return of portfolio');
    legend('1-2','1-3','2-3','All');
    saveas(p,title1, 'png');
    for i=1:10000
        w1=rand(1);w2=rand(1);w3=1-w1-w2;
        if w1>=0 && w2>=0 && w3>=0
            w=[w1,w2,w3];phu=m1*w';sig=sqrt(w*C1*w');
            p=plot(sig,phu,'y');
            hold on
        end
    end
    title1='Plot of Feasible region';
    title(sprintf('%s',title1));
    xlabel('sigma of portfolio'); ylabel('return of portfolio');
    legend('1-2','1-3','2-3','All','feasible');
    saveas(p,title1, 'png');
      weights(C1,x,m1)
end

function[p]=markowitz(C,x,m,k)
    a=x*inv(C)*x.';b=x*inv(C)*m.';c=m*inv(C)*m.';
    s='kbgry';
    d=a*c-b*b; 
    phu=[0:0.01:0.3];
    for i =1:length(phu)
        sig_sq(i)=sqrt((a*phu(i)*phu(i)-2*b*phu(i)+c)/d);
    end
    p=plot(sig_sq,phu,s(k));
    hold all
end

function[]=weights(C,x,m)
    a=x*inv(C)*x.';b=x*inv(C)*m.';c=m*inv(C)*m.';d=a*c-b*b;
    phu=[0:0.01:0.3];
    u=[1, 1, 1];
    xx=u*inv(C);yy=m*inv(C);
    for i =1:length(phu)
        w(i,:)=((yy*m.'-phu(i)*xx*m.')*xx + (phu(i)*xx*u.'-yy*u.')*yy)/(xx*u.'*yy*m.' - yy*u.'*xx*m.');
    end
    syms p;
    ww=eval(((yy*m.'-p*xx*m.')*xx + (p*xx*u.'-yy*u.')*yy)/(xx*u.'*yy*m.' - yy*u.'*xx*m.'))
    figure()
    plot(w(: , 1),w(:, 2),'k');
    hold all
    x=[0:0.1:1.2];
    plot(x,1-x,'b');hold all
    plot(x,zeros(13),'r');hold all
    plot(zeros(13),x,'r');hold all
    xlim([-0.2,1.2]); ylim([-0.2,1.2]);
    title1='Plot of w1 vs w2';
    title(sprintf('%s',title1));
    xlabel('w1'); ylabel('w2');
    legend('w1 Vs w2','x+y=1','y=0','x=0');
    saveas(gcf,title1, 'png');
end