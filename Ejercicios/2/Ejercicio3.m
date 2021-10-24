clear;

syms x1 x2 x3

global sigma lambda b 

sigma=10;
lambda=28;
b=8/3;

f=zeros(3,1);
f=sym(f);

f(1,:)=sigma*(x2-x1);
f(2,:)=(lambda-x3)*x1-x2;
f(3,:)=x1*x2-b*x3;

[x01,x02,x03]=solve(f(:,1),[x1 x2 x3]);

X0=[x01 x02 x03];

J=jacobian(f(:,1),[x1 x2 x3]);

for i=1:size(X0,1)
    JJ=subs(J,[x1 x2 x3],X0(i,:));
    V=double(eig(JJ));
    M=zeros(size(X0,1),3);
    M(i,:)=V';
end

Lim=30;
Paso=5;
t1=0;
t2=10;
X0
M

for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        for k=-Lim:Paso:Lim
            
            [t,x]=ode15s(@f1,[t1 t2],[i;j;k]);
        
            subplot(4,1,1)
            plot(t,x(:,1))
            hold on
        
            subplot(4,1,2)
            plot(t,x(:,2))
            hold on
        
            subplot(4,1,3)
            plot(t,x(:,3))
            hold on
        
            subplot(4,1,4)
            plot3(x(:,1),x(:,2),x(:,3))
            hold on
            plot3(i,j,k,'or')
            hold on
        end
    end
end
axis([-Lim-1 Lim+1 -Lim-1 Lim+1 -Lim-1 Lim+1])

function dx=f1(t,x)
	global sigma lambda b 
	dx=zeros(3,1);
	dx(1)=sigma*(x(2)-x(1));
	dx(2)=(lambda-x(3))*x(1)-x(2);
	dx(3)=x(1)*x(2)-b*x(3);
end






