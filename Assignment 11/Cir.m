function [p] = Cir(b,a,x,sig,r_t)
    g=sqrt(a*a+2*sig*sig);
    B=(2*(exp(g*x)-1))/((g+a)*(exp(g*x)-1)+2*g);
    A0=((2*g*exp((a+g)*(x/2)))/((g+a)*(exp(g*x)-1)+2*g))^((2*a*b)/(sig*sig));
    p=A0*exp(-B*r_t);
end