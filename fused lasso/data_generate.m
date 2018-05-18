%n is number of oberservations
% p is number of attributes
n=2^10;
p=2^14;
beta=zeros(p,1);
%value=unifrnd(-5,5,10);
pos=unidrnd(p,160,1);
for i=1:numel(pos)
    if (mod(pos(i),2)==1) beta(pos(i))=1;
    else
        beta(pos(i))=-1;
    end
end
%Generate data from multivariate normal random distribution
X=rand(n,p);
%Generate response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y=X*beta + normrnd(0,10^(-4),size(X,1),1);
tau=0.1*norm(X'*y,Inf);
