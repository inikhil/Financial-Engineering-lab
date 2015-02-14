function[y]=vasicek(beta, mu, maturity,sigma, r)
a=beta; b=mu*beta;
B=(1/a)*(1-exp(-a*maturity));
A=((B-maturity)*(a*b-0.5*sigma*sigma)/(a*a))-(sigma*B)^2/(4*a);
p=exp(A-B*r);
y=-log(p)/maturity;
end