function[]=geometric_brown()
    cd('/home/mathsuser/nik/lab 10');clc;
    format long;
    phu=0.1;sigma=0.2;r=.05;s0=100;
    %%%%%%%%%%%% GBM paths %%%%%%%%%%%%%%%%%%
    gbm_init(s0,phu,sigma,'real world');
    gbm_init(s0,r,sigma,'risk neutral world');
    %%%%%%%%%%%%%%%%%%Asian option %%%%%%%%%%%%%%%%%%%%
    fprintf('With 95%% confidence interval \n\n for k = 105 :\n');
    [call_payoff,put_payoff]=asian_option(s0,r,sigma,105,100,0.5);
    fprintf('for k = 110 :\n');
    [call_payoff,put_payoff]=asian_option(s0,r,sigma,110,100,0.5);
    fprintf('for k = 90 :\n');
    [call_payoff,put_payoff]=asian_option(s0,r,sigma,90,100,0.5);
    %%%%%%%%%%%%%%% Sensitivity analysis %%%%%%%%%%%%%%%
    sensitivity_s0(s0,r,sigma);
    sensitivity_r(s0,r,sigma);
    sensitivity_sigma(s0,r,sigma);
    sensitivity_k(s0,r,sigma);
    sensitivity_T(s0,r,sigma);
end

function[]=gbm_init(s0,phu,sigma,x)
    t=[0:0.01:1];
    for i=1:10
        stock_pr(i,:) = gbm(s0,phu,sigma);
    end
    plotting(stock_pr,t,x);
end

function[]=sensitivity_s0(s0,phu,sigma)
    s1=[50:1:150];
    for i=1:101
       [call_payoff(i),put_payoff(i)]= asian_option(s1(i),phu,sigma,105,1,0.5);
    end
    plotting_sensitivity(call_payoff,s1,'Call','initial stock_price');
    plotting_sensitivity(put_payoff,s1,'Put','initial stock_price');
end

function[]=sensitivity_r(s0,phu,sigma)
    r=[0:0.01:0.4];
    for i=1:length(r)
       [call_payoff(i),put_payoff(i)]= asian_option(s0,r(i),sigma,105,1,0.5);
    end
    plotting_sensitivity(call_payoff,r,'Call','r');
    plotting_sensitivity(put_payoff,r,'Put','r');
end

function[]=sensitivity_sigma(s0,phu,sigma)
    sigma=[0:0.01:0.5];
    for i=1:length(sigma)
       [call_payoff(i),put_payoff(i)]= asian_option(s0,phu,sigma(i),105,1,0.5);
    end
    plotting_sensitivity(call_payoff,sigma,'Call','Sigma');
    plotting_sensitivity(put_payoff,sigma,'Put','Sigma');
end

function[]=sensitivity_k(s0,phu,sigma)
    k=[50:1:150];
    for i=1:length(k)
       [call_payoff(i),put_payoff(i)]= asian_option(s0,phu,sigma,k(i),1,0.5);
    end
    plotting_sensitivity(call_payoff,k,'Call','K');
    plotting_sensitivity(put_payoff,k,'Put','K');
end

function[]=sensitivity_T(s0,phu,sigma)
    T=[0.2:.01:1.2];
    for i=1:length(T)
       [call_payoff(i),put_payoff(i)]= asian_option(s0,phu,sigma,105,1,T(i));
    end
    plotting_sensitivity(call_payoff,T,'Call','T');
    plotting_sensitivity(put_payoff,T,'Put','T');
end


function[root]=gbm(s0,phu,sig)
    s(1)=s0;
    for i=2:101
        z=randn(1);
        s(i)=s(i-1)*exp((phu-0.5*sig*sig)*0.01+sig*sqrt(.01)*z);
    end
    root=s;
end

function[root1,root2]=asian_option(s0,phu,sigma,k,j,T)
    for i=1:j
        [payoff_call(i),payoff_put(i)]=gbm_init_asian(s0,phu,sigma,k,T);
    end
    if j==100 
        confidence(payoff_call,payoff_put);
    end
    root1=payoff_call;
    root2=payoff_put;
end

function[root1,root2]=gbm_init_asian(s0,phu,sigma,k,T)
    t=[0:0.01:T];
    for i=1:1000
        stock_pr(i,:) = gbm_asian(s0,phu,sigma,t);
        est_stock(i)=mean(stock_pr(i,:));
        pay_off_call(i)=max(est_stock(i)-k,0);
        pay_off_put(i)=max(k-est_stock(i),0);
    end
    est_payoff_call=mean(pay_off_call);
    dis_payoff_call=exp(-phu*T)*est_payoff_call;
    est_payoff_put=mean(pay_off_put);
    dis_payoff_put=exp(-phu*T)*est_payoff_put;
    root1=dis_payoff_call;
    root2=dis_payoff_put;
end

function[root]=gbm_asian(s0,phu,sig,t)
    s(1)=s0;
    for i=2:length(t)
        z=randn(1);
        s(i)=s(i-1)*exp((phu-0.5*sig*sig)*0.01+sig*sqrt(.01)*z);
    end
    root=s;
end

function[root]=confidence(call,put)
    exp_payoff_call=mean(call);
    var_payoff_call=sqrt(var(call));
    exp_payoff_put=mean(put);
    var_payoff_put=sqrt(var(put));
    conf(exp_payoff_call,var_payoff_call,'call')
    conf(exp_payoff_put,var_payoff_put,'put')
end

function[]=conf(a,b,name)
    st=a-(1.96*b)/10;
    en=a+(1.96*b)/10;
    fprintf('for %s option confidence intervals are: [%f , %f]\n',name,st,en);
end



function[]=plotting(stock_pr,t,x)
    col = hsv(10);
    name=['10 Different GBM paths in ' x];
    p=figure('Name',name);
    for i=1:10
        plot(t,stock_pr(i,:),'color',col(i,:));
        hold on
    end
    title(name);
    grid on
    xlabel('time');
    ylabel('GBM paths');
    saveas(p,name,'png');
end

function[]=plotting_sensitivity(pay_off,s0,name1,name2)
    name=['plot of ' name1 ' payoff by varying ' name2];
    p=figure('Name',name);
    plot(s0,pay_off,'b');
    title(name);
    grid on
    xlabel(sprintf('Varying %s',name2));
    ylabel(sprintf('%s payoff',name1));
    saveas(p,name,'png');
end
