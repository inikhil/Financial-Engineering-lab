function[]=option2()
    cd('/home/mathsuser/nik/lab 9/q2');clc;
    format long;
    opt=csvread('NIFTYOptionData.csv',1,3,[1,3,729,6]);
    strike_pr=opt(:,1);
    put_pr=opt(:,2);
    call_pr=opt(:,3);
    maturity=opt(:,4);
    s=5663.85;sig=0.5;
    for i=1:length(strike_pr)
        imp_vol(i)=newton(maturity(i),strike_pr(i),sig,s,call_pr(i));
    end
    plotting_3d(imp_vol,strike_pr,maturity);
    plotting(imp_vol,strike_pr,'implied volatility','strike price');
    plotting(imp_vol,maturity,'implied volatility','maturity');
    
end

function[root]=newton(maturity,strike_pr,sig,s,call_pr)
    sig_new=sig;sig_old=0;
    while ((sig_new>0) && (abs(sig_new-sig_old) > 10^-6))
         init=call(maturity,strike_pr,0.05,sig_new,0,s)-call_pr;
         init_diff=diffcall(maturity,strike_pr,0.05,sig_new,0,s);
         sig_old=sig_new;
         sig_new=sig_old-init/init_diff;
    end
    root=sig_old;
end
    

function[root]=call(T,K,r,sigma,t,s)
    d1=1/(sigma*sqrt(T-t))*(log(s/K)+(r+0.5*sigma*sigma)*(T-t));
    d2=1/(sigma*sqrt(T-t))*(log(s/K)+(r-0.5*sigma*sigma)*(T-t));
    root=normcdf(d1)*s-normcdf(d2)*K*exp(-r*(T-t));
    
end

function[root]=diffcall(T,K,r,sigma,t,s)
    d1=1/(sigma*sqrt(T-t))*(log(s/K)+(r+0.5*sigma*sigma)*(T-t));
    d2=1/(sigma*sqrt(T-t))*(log(s/K)+(r-0.5*sigma*sigma)*(T-t));
    root=s*normpdf(d1)*sqrt(T-t);
end

function[root]=put(T,K,r,sigma,t,s,m)
    root=K*exp(-r*(T-t))-s+m;
end

function[]=plotting(a,b,title1,title2)

    title=['Plot of ' title1 'with respect to ' title2];
    p=figure('Name',title);
    plot(b,a,'x');
    axis([min(b) max(b) 0 1]);
    xlabel(sprintf('%s',title2));
    ylabel(sprintf('%s',title1));
    saveas(p,title,'png');

end

function[]=plotting_3d(imp_vol,strike_pr,maturity)

    title=['Plot of implied volatility along with maturity and strike price'];
    p=figure('Name',title);
    plot3(strike_pr,maturity,imp_vol,'x');
    axis([min(strike_pr) max(strike_pr) min(maturity) max(maturity) 0 1]);
    %stem3(strike_pr,maturity,imp_vol);
    xlabel('Strike price');
    ylabel('Maturity');
    zlabel('Volatility');
    saveas(p,title,'png');

end