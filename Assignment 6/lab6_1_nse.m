disp('Choose data to plot 1. daily 2. monthly 3. yearly');
h=input('');

if(h==1)
    a=xlsread('nsedaily.xlsx');
    a(isnan(a))=0;
    q=size(a);
    for i=1:q(2)
        t=find(ismember(a(:,i), 0));
        p=min(t);
        figure(i)
        p=plot(flipud(a(1:p-1,i)));
        if(i~=10)
            saveas(p,sprintf('img%d.tif',i))
        end
    end
    
    
end
if(h==2)
    a=xlsread('nsedata.xls');
    a(isnan(a))=0;
    q=size(a);
    for i=1:q(2)
        figure(i)
        p=plot(flipud(a(:,i)));
        saveas(p,sprintf('img%d.tif',i))
    end
end

if(h==3)
    a=xlsread('nseyearly.xlsx');
    a(isnan(a))=0;
    q=size(a);
    for i=1:q(2)
        figure(i)
        p=plot(flipud(a(:,i)));
        saveas(p,sprintf('img%d.tif',i));
        plot(flipud(a(:,i)));
    end
end