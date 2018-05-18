clear;
clc;

%% Prepare the data
n_list=[100]; %list of n values to try
p=10;
time2list= zeros(length(n_list),1);

time_2list= zeros(length(n_list),1);


for j = 1:length(n_list) %go through all n values

n = n_list(j);
input.EPI = 1e-3;
input.n = n;
input.p = p;
x=zeros(p,1);
pos=unidrnd(p,160,1);
for i=1:numel(pos)
    if (mod(pos(i),2)==1) 
        x(pos(i))=1;
    else
        x(pos(i))=-1;
    end
end
R = zeros(p-1,p);
for i = 1:(p-1)
    R(i,i) = -1;
    R(i,i+1) = 1;
end

input.A=rand(n,p);
%for sparsity
for k = 1:p
    s= randperm(n);
s= s(1:0.8*n);
   input.A(s,k)=0;
end

A = input.A;
input.b=A*x + normrnd(0,10^(-4),size(A,1),1);
b = input.b;
tau=0.1*norm(A'*b,Inf);
input.lambda1 =  0.5;%0.01*tau
input.lambda2 = 0.5;

%% Call the method
[time2list(j), v2, v2_m, x2, iter_num2, optimal_value_mark2, optimal_value2] = main_alin(input, 2);%slin
end
