clear;

A=[-1 -1;1 0];
B=[1;0];
C=[0 1];
D=0;

% a

syms t
simplify(expm(A*t));

% b

syms s 
sys=ss(A,B,C,D);
G1=tf(sys);
G2=1/(s^2+s+1);

% c

% La forma de la ecuación diferencial es (para R=L=C=1) :
% dy^2/dt^2 + dy/dt + y = u 

% d

FunPon=ilaplace(G2);

% e

x01=1;
x02=1;
x0=[x01;x02];
x1=expm(A*t)*x0;
y1=C*expm(A*t)*x0;

% f

x2=(A^-1)*(expm(A*t)-eye(2))*B;
y2=C*(A^-1)*(expm(A*t)-eye(2))*B+D;

% g 

x3=x1+x2;
y3=y1+y2;

% h 

w=0.1;
u=(w/(w^2+s^2));
x4=((s*eye(2)-A)^-1)*x0+((s*eye(2)-A)^-1)*B*u;
y4=C*((s*eye(2)-A)^-1)*x0+C*(((s*eye(2)-A)^-1)*B+D)*u;
x4=ilaplace(x4);
y4=ilaplace(y4);
yy1=ilaplace(G2*u);

% i 

u=1/(s^2);
x5=((s*eye(2)-A)^-1)*x0+((s*eye(2)-A)^-1)*B*u;
y5=C*((s*eye(2)-A)^-1)*x0+C*(((s*eye(2)-A)^-1)*B+D)*u;
x5=ilaplace(x5);
y5=ilaplace(y5);
yy2=ilaplace(G2*u);




