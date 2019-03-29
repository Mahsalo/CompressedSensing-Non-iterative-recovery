% This utility multiplies an nx1 vector x by an nxm binary matrix A
% of order q^2 x n , where q is any integer (though in compressed
% sensing applications q is a prime number).
% The matrix A is represented by an equivalent matrix B of order qxn.

function y = Exp_mult_noisy(B,x) %%%only E values of the noise are non-zero, the rest are zero 

S = size(B) ;
q = S(1) ; n = S(2) ; m = q^2  ;

% Initialize
y = 0*ones(m,1) ;

for j=1:n
for l=1:m
b = floor((l-1)/q) + 1 ;
c = l - 1 - (b-1)*q ;
if B(b,j) == c
y(l) = y(l) + x(j) ;
end
end
end
% 
% %%%gerenrating G random gaussian error values and adding them to "y"
% eta=zeros(m,1);
% ind = randperm(m,E);
% nval=randn(1,E);
% for i=1:E
%    eta(ind(i),1)=nval(1,i); 
% end
% yy=y+eta;

end
