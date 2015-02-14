function[m,v]=normalised_monthly(a)
q=size(a);
for j =1:q(2)
        for i=2:q(1)
           r(i-1,j)=((a(i-1,j)-a(i,j))/a(i,j))*12;
        end        
        m(j)=mean(r(:, j));  
        v(j)=sqrt(var(r(:,j)));

end
r1=r;
x=-50:1:50;
binranges=x;
y=normpdf(x,0,1);

%% only superimposing remains
for j=1:q(2)
    %p=u(j);
    r1(:,j)=(r1(:,j)-m(j))/v(j);
    bincounts = histc(r1(:,j),binranges);
    bincounts = histc(r(:,j),binranges);
    bincounts=bincounts/sum(bincounts);
    bincounts=bincounts/(1); %getting heights
    figure(j)
    hold on;
    bar(binranges,bincounts);
    plot(x,y,'r');
    hold off;
end  

end