function tt = cal_ceemdan_t(c,type)
if type==1
    kk=0;
    for i=1:(length(c)-1)
        if c(i)*c(i+1)<0
            kk=kk+1;
        end
    end
    tt = length(c)*2/kk;
elseif type==2
    omega = ifndq(c,1);
    tt = 2*pi/mean(omega);
end
