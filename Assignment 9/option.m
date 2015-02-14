function[]=option()
    cd('/home/mathsuser/nik/lab 9/q1');
    opt=csvread('NIFTYOptionData.csv',1,3,[1,3,729,6]);
    strike_pr=opt(:,1);
    put_pr=opt(:,2);
    call_pr=opt(:,3);
    maturity=opt(:,4);
    plotting_func(strike_pr,maturity,call_pr,' Call ');
    plotting_func(strike_pr,maturity,put_pr,' Put ');
    plotting(call_pr,strike_pr,'Call price','Strike price');
    plotting(call_pr,maturity,'Call price','maturity');
    plotting(put_pr,strike_pr,'Put price','strike price');
    plotting(put_pr,maturity,'Put price','maturity');
    
end

function[]=plotting_func(strike_pr,maturity,call_pr,given)

    title=['Plot of' given 'option along with maturity and strike price'];
    p=figure('Name',title);
    plot3(strike_pr,maturity,call_pr, 'x')
    xlabel('Strike price');
    ylabel('Maturity');
    zlabel(sprintf('%s option price',given));
    saveas(p,title,'png');

end

function[]=plotting(a,b,title1,title2)

    title=['Plot of ' title1 'with respect to ' title2];
    p=figure('Name',title);
    plot(b,a,'x')
    xlabel(sprintf('%s',title2));
    ylabel(sprintf('%s',title1));
    saveas(p,title,'png');

end