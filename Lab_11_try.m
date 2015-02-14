function output = Lab_11_try()

paramSets = {[5.9, 0.2, 0.3, 0.1], [3.9, 0.1, 0.3, 0.2], [0.1, 0.4, 0.11, 0.1]};
times = 0.5:0.5:5;
for i=1:length(paramSets)
    for j=1:length(times)
        yields(j) = computeVasicek(times(j), paramSets{i});
    end
    figure(i);
    plot([0, times], [paramSets{i}(4), yields], 'r');
    hold on;
    scatter([0, times], [paramSets{i}(4), yields], '*');
    hold off;
end

function [yield] = computeVasicek(T, paramSet)
r0 = paramSet(4);
beta = paramSet(1);
sigma = paramSet(3);
mu = paramSet(2);

%mean = r0 * exp(-beta * T) + (mu*(1-exp(-beta * T)));
%stddev = sqrt(((sigma^2)/(2*beta))*(1 - exp(-2*beta*T)));
%r = randn(1)*stddev + mean;
B = (1/beta)*(1-exp(-beta*T));
A = ((B - T)*(beta^2*mu - 0.5*sigma^2))/(beta^2) - ((sigma^2*B^2)/(4*beta));
P = exp(A - B*r0);
yield = -log(P)/T;