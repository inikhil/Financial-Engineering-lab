function [p] = Vasicek(b,a,t,T,sig,r_t)
    B=(1-exp(-a*(T-t)))/a;
    A=(((B-T+t)*(a*b-0.5*sig*sig))/(a*a))-((sig*sig*B*B)/(4*a));
    p=exp(A-B*r_t);
end