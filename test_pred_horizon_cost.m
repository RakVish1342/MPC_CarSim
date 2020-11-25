horiz_len = 3;
ref = 1:1:horiz_len;
x = 1:2:2*horiz_len;

u = sym('u', [horiz_len,1], 'Real');
%y = sym('y', [horiz_len,1], 'Real');

% y = a*x + b*u ... ignore integration.
y = @(i) (5*x(i) + 1*u(i));

yerr = @(i) (y(i)-x(i))^2;


totCost = 0;
for i = 1:1:horiz_len
    totCost = totCost + J( y(i), u(i), x(i) );
end

% F = matlabFunction(totCost);
F = matlabFunction(totCost, 'Vars', [{u}, {y}]);
F([2;2;2], [3;3;3])

% We need sequence of u, each indep of other

A = []; Aeq = []; lb = []; 
b = []; beq = []; ub = [];

x0 = [[1;1;1], [2;2;2]];
% [x,fval,exitflag] = fmincon(F,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
[x,fval,exitflag] = fmincon(F,x0,A,b,Aeq,beq,lb,ub)

function out = J(y, u, x)
% out = 2*y + 2*u; % test
out = (y-x)^2 + u^2; % fix to include dynamic ref signal, fix to calc delta_u, make y-ref a function of u (like in dyn sys eqn)
end



%% Testing use of function within the same file. 
% Functions should be defined at the end of the file...after all calls are
% made to them

% func(2)
% function o = func(i)
% o = i*2;
% end