function[]=BSM_1()
    T=1;K=1;r=0.05;sigma=0.6;s=1;t=0;
    m=call(T,K,r,sigma,t,s)
    n=put(T,K,r,sigma,t,s,m)
    
end
    
function[root]=call(T,K,r,sigma,t,s)
    d1=1/(sigma*sqrt(T-t))*(log(s/K)+(r+0.5*sigma*sigma)*(T-t));
    d2=1/(sigma*sqrt(T-t))*(log(s/K)+(r-0.5*sigma*sigma)*(T-t));
    root=normcdf(d1)*s-normcdf(d2)*K*exp(-r*(T-t));
    
end

function[root]=put(T,K,r,sigma,t,s,m)
    root=K*exp(-r*(T-t))-s+m;
end