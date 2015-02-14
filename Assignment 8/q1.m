function[]=q1()
    
    a=csvread('bsedaily.csv');
    b=a(1:30,:);
    %length(b(1,:))
    hist_var_bse=volatility(b)
    c=csvread('nsedaily.csv');
    d=c(1:30,:);
    hist_var_nse=volatility(d)
    fprintf('Bse price of European call and put : \n\n ');
    BSM_price(b,hist_var_bse);
    fprintf('\n\n Nse price of European call and put : \n\n ');
    BSM_price(d,hist_var_nse);
    fprintf('\n\n BSE price of European call and put varying k: \n\n ');
    BSMvaryingk(b,hist_var_bse);
    fprintf('\n\n NSE price of European call and put varying k: \n\n ');
    BSMvaryingk(d,hist_var_nse);
    %%%--------------------Part C--------------------%%
    
    len_a=length(a(:,1));
    len_c=length(c(:,1));
    vol_bse=bse_nse(a,65,len_a);
    vol_nse=bse_nse(c,66,len_c);
    BSMvaryingk_partc(a,vol_bse);   
    BSMvaryingk_partc(a,vol_nse); 
        
    
end

function[root]=volatility(b)
    t=length(b(:,1));
    m=length(b(1,:));
    for i=1:t-1
        for j=1:m
            r(i,j)=(b(i,j)-b(i+1,j))/b(i+1,j);
        end
    end 
    for i=1:m
        variance(i)=sqrt(var(r(:,i)));
    end
    hist_vol=sqrt(252)*variance;
    root=hist_vol;  
end

function[]=BSMvaryingk(b,vari)
    s=b(1,:);
    for i=1:length(s)
        fprintf('\n\n for stock %d the value is \n\n', i);
        for j= 0.5:.1:1.5
            k=j*s(i);
            call1(i)=call(0.5,k,0.05,vari(i),0,s(i));
            put1(i)=put(0.5,k,0.05,vari(i),0,s(i),call1(i));
            fprintf('for k= %f, \t call price is %f, \t put price is %f\n',k,call1(i),put1(i));
        end
    end
end

function[]=BSM_price(b,vari)
    for i=1:length(b(1,:))
        k=b(1,i);
        call1(i)=call(0.5,k,0.05,vari(i),0,k);
        put1(i)=put(0.5,k,0.05,vari(i),0,k,call1(i));
        fprintf('for k= %f, \t call price is %f, \t put price is %f\n',k,call1(i),put1(i));
    end
end

function[root]=BSM_price_partc(b,vari)
    for i=1:length(b(1,:))
        k=b(1,i);
        call1(i)=call(0.5,k,0.05,vari(i),0,k);
        put1(i)=put(0.5,k,0.05,vari(i),0,k,call1(i));
        root(i,1)=call1(i);root(i,2)=put1(i);
        %fprintf('for k= %f, \t call price is %f, \t put price is %f\n',k,call1(i),put1(i));
    end
end


function[root]=call(T,K,r,sigma,t,s)
    d1=1/(sigma*sqrt(T-t))*(log(s/K)+(r+0.5*sigma*sigma)*(T-t));
    d2=1/(sigma*sqrt(T-t))*(log(s/K)+(r-0.5*sigma*sigma)*(T-t));
    root=normcdf(d1)*s-normcdf(d2)*K*exp(-r*(T-t));
    
end

function[root]=put(T,K,r,sigma,t,s,m)
    root=K*exp(-r*(T-t))-s+m;
end

function[]=plot_volatility(hist_var_bse,title)
    len_var_row=length(hist_var_bse(:,1));
    len_var_col=length(hist_var_bse(1,:));
    tim=[30:30:len_var_row*30];
    col = hsv(len_var_col);
    p=figure('Name',title);
    for i=1:len_var_col
        temp=hist_var_bse(:,i);
        plot(tim,temp, 'color', col(i,:));
        hold on
    end
    hold off
    legend('location', 'westoutside','sensex','wipro','LNT','Airtel','Tatapower','Hul','Sunpharma','maruti','ongc','cipla','Allahabad Bank','Blue dart','Corporation Bank','Hmt Ltd','Bharat elect','Essar oil','Crisil','bata');
    xlabel('time varying One month');
    ylabel('Historical volatility');
    saveas(p,title,'png');
    
end

function[]=plot_price(price,j,title,jj)
    tim=[30:30:jj*30];
    col = hsv(20);
    p=figure('Name',title);
    for i=1:length(price(1,:,j))
        plot(tim,price(:,i,j),'color',col(i,:));
        hold on
    end
    hold off
    legend('location', 'westoutside','sensex','wipro','LNT','Airtel','Tatapower','Hul','Sunpharma','maruti','ongc','cipla','Allahabad Bank','Blue dart','Corporation Bank','Hmt Ltd','Bharat elect','Essar oil','Crisil','bata');
    xlabel('time varying One month');
    ylabel('Call price');
    saveas(p,title,'png');
end

function[root]=bse_nse(a,jj,len_a)
    for i=1:jj
        t=30*i;
        b=[];
        b=a(1:t,:);
        hist_var(i,:)=volatility(b);
        price(i,:,:)=BSM_price_partc(b,hist_var(i,:));
        
        %price1{i}{:}{:}=BSM_price_partc(b,hist_var_bse(i,:));
        
    end
    b=a(1:len_a,:);
    hist_var(i+1,:)=volatility(b);
    
    if jj==65
        plot_volatility(hist_var,'Historical volatility for Bse Data');
        plot_price(price,1,'Call Price for Bse Data',jj);
        plot_price(price,2,'put price for BSE data',jj);
    else
        plot_volatility(hist_var,'Historical volatility for Nse Data');
         plot_price(price,1,'Call Price for Nse Data',jj);
         plot_price(price,2,'put price for Nse data',jj);
    end
    root=hist_var;
end

function[root1,root2]=BSMvaryingk_partc(a,vari)
    s=a(1,:);
    for j= 0.5:.1:1.5
        for i=1:length(s)
            k=s(i)*j;
            for jj=1:length(vari(:,i))
                call1(jj)=call(0.5,k,0.05,vari(jj,i),0,k);
                put1(jj)=put(0.5,k,0.05,vari(jj,i),0,k,call1(jj));
            end
            figure();
            plot(tim,call1);
        end
    end
end

