function[t]=normalised_daily(a)

q=size(a);
for j =1:q(2)
        for i=2:q(1)
            if(a(i,j)~=0)
                 r(i-1,j)=((a(i-1,j)-a(i,j))/a(i,j))*257; 
            else
                r(i-1,j)=-1;
            end 
        end
       if(r(q(1)-1,j)~=-1)
           p=q(1);
           
           m(j)=mean(r(1:p-1, j));
           u(j)=p-1;
           x=r(1:p-1,j);
           v(j)=sqrt(var(x));
           %v(j)=sqrt(var(r(1:p,j)));
       else
           t=find(ismember(r(:,j), -1));
           p=min(t);
           m(j)=mean(r(1:p-1, j));
           u(j)=p-1;
           x=r(1:p-1,j);
           v(j)=sqrt(var(x));
       end
       %u(j)=p;
       
 end
%nbins=500;
r1=r;
x=-50:0.1:50;
binranges=x;
y=normpdf(x,0,1);

%% only superimposing remains
for j=1:q(2)
    p=u(j);
    r1(:,j)=(r1(:,j)-m(j))/v(j);
    bincounts = histc(r1(1:p,j),binranges);
    bincounts=bincounts/sum(bincounts);
    bincounts=bincounts/(0.1); %getting heights
    figure(j)
    hold on;
    p=bar(binranges,bincounts);
    plot(x,y,'r');
    hold off;
    saveas(p,sprintf('img%d.tif',i))
end  
t=0;
end