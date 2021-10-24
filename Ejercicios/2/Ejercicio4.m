clear;

syms x1 x2 x3

global a b c

a=0.1;
b=0.1;
c=14;

f=zeros(3,1);
f=sym(f);

f(1,:)=x1-x1*x2-x3;
f(2,:)=x1^2-a*x2;
f(3,:)=b*x1-c*x3;

[x01,x02,x03]=solve(f(:,1),[x1 x2 x3]);

X0=[x01 x02 x03];

J=jacobian(f(:,1),[x1 x2 x3]);

for i=1:size(X0,1)
    JJ=subs(J,[x1 x2 x3],X0(i,:));
    V=double(eig(JJ));
    M=zeros(size(X0,1),3);
    M(i,:)=V';
end

Lim=1;
Paso=0.25;
t1=0;
t2=10;
X0
M

for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        for k=-Lim:Paso:Lim
            
            [t,x]=ode45(@f1,[t1 t2],[i;j;k]);
        
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
	global a b c
	dx=zeros(3,1);
	dx(1)=x(1)-x(1)*x(2)-x(3);
	dx(2)=x(1)^2-a*x(2);
	dx(3)=b*x(1)-c*x(3);
end


