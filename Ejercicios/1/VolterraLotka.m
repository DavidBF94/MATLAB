clear;
cla;

global a b c d

a=10;
b=30;
c=1;
d=1;
t1=0;
t2=1e1;
x1=1e2;
x2=1e1;
x0=[x1;x2];

[t,x]=ode45(@f,[t1 t2],x0);


subplot(3,1,1);
plot(t,x(:,1))
xlabel('Tiempo')
ylabel('x1')
subplot(3,1,2);
plot(t,x(:,2))
xlabel('Tiempo')
ylabel('x2')
subplot(3,1,3);
plot(x(:,1),x(:,2))
xlabel('x1')
ylabel('x2')


function dx=f(t,x)
	global a b c d
	dx=zeros(2,1);
	dx(1)=a*x(1)-c*x(1)*x(2);
	dx(2)=-b*x(2)+d*x(1)*x(2);
end


