clear;
cla;

global m c k 

m=2.5;
c=0.6;
k=0.4;
w=0.1;
A=10;
t1=0;
t2=200;
x1=0;
x2=0;
x0=[x1;x2];

Ft=@(t) A*sin(w*t);
[t,x]=ode45(@(t,x) f(t,x,Ft),[t1 t2],x0);


subplot(3,1,1);
plot(t,x(:,1))
xlabel('Tiempo(s)')
ylabel('x1')
subplot(3,1,2);
plot(t,x(:,2))
xlabel('Tiempo(s)')
ylabel('x2')
subplot(3,1,3);
plot(t,x(:,1))
hold on
plot(t,Ft(t))
xlabel('Tiempo(s)')
ylabel('Entrada(F) y Salida(x1)')


function dx=f(t,x,Ft)
	global m c k 
	dx=zeros(2,1);
	dx(1)=x(2);
	dx(2)=(1/m)*(-k*x(1)-c*x(2)+Ft(t));
end

