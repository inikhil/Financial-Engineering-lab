function[m,v]=normalised_yearly(a)
q=size(a);
for j =1:q(2)
        for i=2:q(1)
           u(i-1,j)=((a(i-1,j)-a(i,j))/a(i,j));
        end
       
        m(j)=mean(u(:, j));  
        v(j)=sqrt(var(u(:,j)));

end

x=-50:0.5:50;
binranges=x;
y=normpdf(x,0,1);

%% only superimposing remains

for j=1:q(2)
    %p=u(j);
    u1(:,j)=(u(:,j)-m(j))/v(j);
    %bincounts = histc(r1(:,j),binranges);
    bincounts = histc(u1(:,j),binranges);
    sum(bincounts)
    bincounts=bincounts/sum(bincounts);
    bincounts=bincounts/(0.5); %getting heights
    figure(j)
    hold on;
    bar(binranges,bincounts);
    plot(x,y,'r');
    hold off;

end
end
