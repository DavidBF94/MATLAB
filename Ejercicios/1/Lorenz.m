clear;
cla;

global sigma beta rho

sigma=10;
beta=8/3;
rho=28;
t1=0;
t2=1e3;
x1=1;
x2=1;
x3=1;
x0=[x1;x2;x3];

[t,x]=ode45(@f,[t1 t2],x0);


subplot(4,1,1);
plot(t,x(:,1))
xlabel('Tiempo')
ylabel('x1')
subplot(4,1,2);
plot(t,x(:,2))
xlabel('Tiempo')
ylabel('x2')
subplot(4,1,3);
plot(t,x(:,3))
xlabel('Tiempo')
ylabel('x3')
subplot(4,1,4)
plot3(x(:,1),x(:,2),x(:,3))
title('Diagrama de Fase')

function dx=f(t,x)
	global sigma beta rho
	dx=zeros(2,1);
	dx(1)=sigma*(x(2)-x(1));
	dx(2)=x(1)*(rho-x(3))-x(2);
	dx(3)=x(1)*x(2)-beta*x(3);
end

