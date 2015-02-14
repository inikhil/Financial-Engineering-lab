function[m,v]=logreturn_d(a)

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
%% only superimposing remains

end