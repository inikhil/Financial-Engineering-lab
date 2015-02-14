function[m,v]=logreturn_daily(a)

q=size(a);
for j =1:q(2)
        for i=2:q(1)
            if(a(i,j)~=0)
                  r(i-1,j)=log(a(i-1,j)/a(i,j))*257; 
            else
                r(i-1,j)=2*257;
            end 
        end
       if(r(q(1)-1,j)~=2*257)
           p=q(1);
           
           m(j)=mean(r(1:p-1, j));
           u(j)=p-1;
           x=r(1:p-1,j);
           v(j)=sqrt(var(x));
           %v(j)=sqrt(var(r(1:p,j)));
       else
           t=find(ismember(r(:,j), 2*257));
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
    %r1(:,j)=(r1(:,j)-m(j))/v(j);
    %figure(j)
    %hist(y,nbins)
    %h1 = findobj(gca,'Type','patch');
    %hold on;
    %hist(r(1:p,j),nbins);
    %h = findobj(gca,'type','patch');
    %h2 = setdiff(h,h1);
    %set(h1,'FaceColor','w','EdgeColor','r');
    %set(h2,'FaceColor','w','EdgeColor','b');
    bincounts = histc(r(1:p,j),binranges);
    bincounts=bincounts/sum(bincounts);
    bincounts=bincounts/(0.1); %getting heights
    figure(j)
    hold on;
    bar(binranges,bincounts);
    plot(x,y,'r');
    hold off;
end  
t=0;
%}
end