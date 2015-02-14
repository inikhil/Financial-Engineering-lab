function[m,v]=logreturn_y(a)
q=size(a);
for j =1:q(2)
        for i=2:q(1)
           u(i-1,j)=log(a(i-1,j)/a(i,j));
        end
       
        m(j)=mean(u(:, j));  
        v(j)=sqrt(var(u(:,j)));

end

x=-50:0.5:50;
binranges=x;
y=normpdf(x,0,1);

%% only superimposing remains
end
