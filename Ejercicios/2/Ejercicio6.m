clear;

syms x1 x2 

global gamma

gamma=1;

f=zeros(2,1);
f=sym(f);

f(1,:)=x2;
f(2,:)=-x1^3-gamma*x2;

[x01,x02]=solve(f(:,1),[x1 x2]);

X0=[x01 x02];

J=jacobian(f(:,1),[x1 x2]);

for i=1:size(X0,1)
    JJ=subs(J,[x1 x2],X0(i,:));
    V=double(eig(JJ));
    M=zeros(size(X0,1),2);
    M(i,:)=V';
end

Lim=1.5;
Paso=0.25;
t1=0;
t2=10;

X0
M

V= x1^2 + x2^2;
grV = gradient(V);
dV = simplify(grV'*f);

subplot(3,1,1)
fsurf(V,[-Lim Lim -Lim Lim])
subplot(3,1,2)
fsurf(dV,[-Lim Lim -Lim Lim])

for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        [t,x]=ode45(@f1,[t1 t2],[i;j]);
        subplot(3,1,3)
        plot(x(:,1),x(:,2))
        hold on
        plot(i,j,'or')
        hold on
    end
end
axis([-Lim-1 Lim+1 -Lim-1 Lim+1])

function dx=f1(t,x)
	global gamma
	dx=zeros(2,1);
	dx(1)=x(2);
	dx(2)=-x(1)^3-gamma*x(2);
end



