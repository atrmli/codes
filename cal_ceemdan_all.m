function [rslt,contribution,period]=cal_ceemdan_all(x)

Nstd = 0.2;
NR = 500;
MaxIter = 5000;

[rslt its]=ceemdan(x,Nstd,NR,MaxIter);

[m,n] = size(rslt);

component    = rslt';
contribution = std(component).^2/sum(std(component).^2)*100;
contribution = contribution';

for i=1:m
    period(i,1)  = cal_ceemdan_t(rslt(i,:),1);
end

