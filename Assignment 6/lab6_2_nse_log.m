disp('Choose option 1. daily 2. monthly 3. yearly');
h=input('');

if(h==1)
    a=xlsread('nsedaily.xlsx');
    a(isnan(a))=0;
    t=logreturn_daily(a);
end
if(h==2)
    a=xlsread('nsedata.xls');
    a(isnan(a))=0;
    t=logreturn_monthly(a);
end

if(h==3)
    a=xlsread('nseyearly.xlsx');
    a(isnan(a))=0;
    t=logreturn_yearly(a);
end