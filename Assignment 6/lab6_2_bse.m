disp('Choose option 1. daily 2. monthly 3. yearly');
h=input('');

if(h==1)
    a=xlsread('bsedaily.xlsx');
    a(isnan(a))=0;
    t=normalised_daily(a);
end
if(h==2)
    a=xlsread('bsedata.xls');
    a(isnan(a))=0;
    t=normalised_monthly(a);
end

if(h==3)
    a=xlsread('bseyearly.xlsx');
    a(isnan(a))=0;
    t=normalised_yearly(a);
end