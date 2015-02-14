function[m,v]=logreturn_m(a)
q=size(a);
for j =1:q(2)
        for i=2:q(1)
           %r(i-1,j)=((a(i-1,j)-a(i,j))/a(i,j))*12;
           r(i-1,j)=log(a(i-1,j)/a(i,j))*12;
        end
       
        m(j)=mean(r(:, j));  
        v(j)=sqrt(var(r(:,j)));

end
r1=r;
x=-50:1:50;
binranges=x;
y=normpdf(x,0,1);


t=0;end