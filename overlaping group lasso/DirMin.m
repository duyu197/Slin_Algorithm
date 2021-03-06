function [x,t] = DirMin(func,x0,input,d,s0,val0,t0,toldir)

% Line search with bisection on directional derivative
% Makes sense only with analytical gradients of func
% No testing of erroneous input is performed

% func   -- the name of the objective function
% x0     -- starting point
% d      -- direction (must be a descent direction)
% t0     -- initial stepsize (must be positive)
% toldir -- stopping test on directional derivative

itmax = 50;
small = 1.0e-8 * t0;
cut = 0.1;
increase = 3;

tR = 0;
tL = 0;
sL = s0;
vL = val0;
vR = val0;
val = val0;
if (t0 > 0)
    t = t0;
else
    t = 1;
end
iterdir = 0;

while ( (t > small) && (iterdir < itmax) )
    iterdir = iterdir + 1;
    x = x0 + t*d;
    [val,grad] = func(x,input);
    s = dot(d,grad);
    if ( (abs(s)<toldir) && (val<val0) )
        break;
    end
    if ( (s > 0) || (val > val0) )
        tR = t;
        sR = s;
        vR = val;
    else       
        tL = t;
        sL = s;
        vL = val;
    end
    
    % cubic interpolation in (tL,tR)
    % the length of the interval has to decrease by cut
    
    if ( tR > 0 ) 
        a = sL + sR - 3*(vR - vL)/(tR-tL);
        b = sqrt(a^2-sL*sR);
        t = tR - (tR-tL)*(sR+b-a)/(sR-sL+2*b);
        t = max(t,tL + cut*(tR - tL));
        t = min(t,tL + (1-cut)*(tR - tL));
    else
         t = increase*t;
    end
end
if (vL < val)
    t = tL;
    val = vL;
    x = x0 + tL*d;
end
if (vR < val)
    t = tR;
    val = vR;
    x = x0 + tR*d;
end
    
if ( val >= val0 )
    t = 0;
    x = x0;
end
end