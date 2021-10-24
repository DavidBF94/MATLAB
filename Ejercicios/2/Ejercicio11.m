clear;
cla;

syms x1 x2 real

f=zeros(2,1);
f=sym(f);
xx=[x1;x2];
Q=eye(2);

f(1,:)=x2;
f(2,:)=-x1-x2+x1*x2;

[x01,x02]=solve(f(:,1),[x1 x2]);

X0=[x01 x02];

J=jacobian(f(:,1),[x1 x2]);

vectfL=sym(zeros(1,size(X0,1)));
grV=sym(zeros(2,size(X0,1)));
dV=sym(zeros(1,size(X0,1)));

for i=1:size(X0,1)
    JJ=subs(J,[x1 x2],X0(i,:));
    P=lyap(double(JJ'),Q);
    vectfL(i)=xx'*P*xx;
    V=double(eig(JJ));
    M=zeros(size(X0,1),2);
    M(i,:)=V';
    grV(:,i)=gradient(vectfL(i));
    dV(1,i)=(grV(:,i))'*f;
end


Lim=1.5;
Paso=0.25;
t1=0;
t2=10;
X0
M
vectfL
grV
dV


subplot(3,1,1)
fsurf(vectfL(1),[-Lim Lim -Lim Lim])
subplot(3,1,2)
fsurf(dV(1),[-Lim Lim -Lim Lim])


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
	dx=zeros(2,1);
	dx(1)=x(2);
	dx(2)=-x(1)-x(2)+x(1)*x(2);
end







