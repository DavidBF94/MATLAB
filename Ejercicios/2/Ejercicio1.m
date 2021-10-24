clear;

syms x1 x2

f=zeros(2,6);
f=sym(f);

f(1,1)=x2;
f(2,1)=-x1+x2*(1-x2^2);
f(1,2)=x2-x1*abs(x1);
f(2,2)=1-x1;
f(1,3)=x1*(1-x2);
f(2,3)=x2*(x1-1);

[x011,x021]=solve(f(:,1),[x1 x2]);
[x012,x022]=solve(f(:,2),[x1 x2]);
[x013,x023]=solve(f(:,3),[x1 x2]);

X1=[x011,x021];
X2=[x012,x022];
X3=[x013,x023];

J1=jacobian(f(:,1),[x1 x2]);
J2=jacobian(f(:,2),[x1 x2]);
J3=jacobian(f(:,3),[x1 x2]);

for i=1:size(X1,1)
    J11=subs(J1,[x1 x2],X1(i,:));
    V1=double(eig(J11));
    M1=zeros(size(X1,1),2);
    M1(i,:)=V1';
end
for i=1:size(X2,1)
    J22=subs(J2,[x1 x2],X2(i,:));
    V2=double(eig(J22));
    M2=zeros(size(X2,1),2);
    M2(i,:)=V2';
end
for i=1:size(X3,1)
    J33=subs(J3,[x1 x2],X3(i,:));
    V3=double(eig(J33));
    M3=zeros(size(X3,1),2);
    M3(i,:)=V3';
end

Lim=1.5;
Paso=0.25;
t1=0;
t2=10;
X1
X2
X3
M1
M2
M3

for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        [t,x]=ode45(@f1,[t1 t2],[i;j]);
        subplot(3,1,1)
        plot(x(:,1),x(:,2))
        hold on
        subplot(3,1,1)
        plot(i,j,'or')
        hold on
    end
end
axis([-Lim-1 Lim+1 -Lim-1 Lim+1])  
for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        [t,x]=ode45(@f2,[t1 t2],[i;j]);
        subplot(3,1,2)
        plot(x(:,1),x(:,2))
        hold on
        subplot(3,1,2)
        plot(i,j,'or')
        hold on
    end
end
axis([-Lim-1 Lim+1 -Lim-1 Lim+1])  
for i=-Lim:Paso:Lim
    for j=-Lim:Paso:Lim
        [t,x]=ode45(@f3,[t1 t2],[i;j]);
        subplot(3,1,3)
        plot(x(:,1),x(:,2))
        hold on
        subplot(3,1,3)
        plot(i,j,'or')
        hold on
    end
end
axis([-Lim-1 Lim+1 -Lim-1 Lim+1])        


function dx=f1(t,x)
	dx=zeros(2,1);
	dx(1)=x(2);
	dx(2)=-x(1)+x(2)*(1-x(2)^2);
end
function dx=f2(t,x)
	dx=zeros(2,1);
	dx(1)=x(2)-x(1)*abs(x(1));
	dx(2)=1-x(1);
end
function dx=f3(t,x)
	dx=zeros(2,1);
	dx(1)=x(1)*(1-x(2));
	dx(2)=x(2)*(x(1)-1);
end













