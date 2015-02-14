function[]=betas()
    file='bsedata.xls';filea='bsedatanonindex.xls';
    fileb='nsedata.xls';filec='nsedatanoindex.xls';
    warning('off','all');
    a=xlsread(file);b=xlsread(filea);c=xlsread(fileb);d=xlsread(filec);
    [x_ibse,y_ibse]=output(a,11); [x_noibse,y_noibse]=output(b,10);
    [x_inse,y_inse]=output(c,11);[x_noinse,y_noinse]=output(d,10);
    [B_ibse,B_inobse]=Beta_calc(x_ibse,x_noibse);
    [B_inse,B_inonse]=Beta_calc(x_inse,x_noinse);
    fprintf('Values of Beta for bse indexed for all 10 stocks are \n');
    disp(B_ibse);
    fprintf('Values of Beta for bse non-indexed for all 10 stocks are \n');
    disp(B_inobse);
    fprintf('Values of Beta for nse indexed for all 10 stocks are \n');
    disp(B_inse);
    fprintf('Values of Beta for nse non-indexed for all 10 stocks are \n');
    disp(B_inonse);
end

function[x,y]=output(a,k,k1)

    for j =1:k
        for i=2:96
            r(i-1,j)=(a(i-1,j)-a(i,j))/a(i,j);   
        end
        m(j)=mean(r(:, j))*12;
    end
    for i=1:k
        for j=1:k
            t=cov(r(:,i),r(:,j));
            C(i,j)=t(1,2);
        end
    end
    x=m;y=C;
end

function[B_i1,B_ino1]=Beta_calc(x,y)
    rf=.07;
    for i=2:11
        B_i(i-1)=(x(i)-.07)/(x(1)-.07);
    end
    for i=1:10
        B_ino(i)=(y(i)-.07)/(x(1)-.07);
    end
    B_i1=B_i;B_ino1=B_ino;
end