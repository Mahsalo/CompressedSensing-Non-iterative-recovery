function xhat = MVID_noisy( y , q , n,  B ,k,r,eta)
m = q^2 ;
c = (q+1)/2 ;
eps = 10^(-5) ;
xh = 0*ones(n,1) ;
yhat = 0*ones(m,1) ; 
  
%%%finding the number of non-zero values of the noise added to the
%%%measurements

[L1,L2]=find(eta~=0);
E=length(L1);

for j=1:n
    
    vec = 0*ones(q,1) ;
    for i=1:q
        vec(i) = (i-1)*q + B(i,j) + 1 ;
    end  
    
    yred=y(vec);%%%reduced y
    
    [m1,m2]=find(abs(yred)>eps);
    d=length(m1);%%%the number of nonzero "x"'s, belong to the support of "x"
    
    if d>=(q-(k-1)*(r-1)-E)
        yred_sort=sort(yred,'descend');
        for i=1:c-2
           if yred_sort(i)-yred_sort(i+c-1)<eps && (abs(yred_sort(i+c-1)) > eps )
               xh(j)=yred_sort(i);
           end
        end
    else
       xh(j)=0;
    end
end
xhat=xh;
    end

