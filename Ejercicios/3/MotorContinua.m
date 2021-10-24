clear;

% a

% En base a la función de transferencia G(s)=6/(s^2+3.45*s)
% la ecuación diferencial toma la forma dy^2/dt^2 + 3.45 dy/dt = 6u 
% donde y = Theta y u = V
% Los parámetros del motor son : p=3.45; kl=6; km=0;

% b

% En éstas condiciones podemos obtener una representación en variables
% de estado:

p=3.45;
kl=6;

A=[0 1;0 -p];
B=[0;kl];
C=[1 0];
D=0;

% c

syms s t 
sys=ss(A,B,C,D);
G1=tf(sys);
G2=kl/(s^2+p*s);

FunPon=ilaplace(G2);

% d

x01=1;
x02=1;
x0=[x01;x02];
x1=expm(A*t)*x0;
y1=C*expm(A*t)*x0;

% e

u=1/s;
x2=((s*eye(2)-A)^-1)*B*u;
y2=C*(((s*eye(2)-A)^-1)*B+D)*u;
x2=ilaplace(x2);
y2=ilaplace(y2);

% f 

x3=x1+x2;
y3=y1+y2;

% g 

w=0.1;
u=(w/(w^2+s^2));
x4=((s*eye(2)-A)^-1)*x0+((s*eye(2)-A)^-1)*B*u;
y4=C*((s*eye(2)-A)^-1)*x0+C*(((s*eye(2)-A)^-1)*B+D)*u;
x4=ilaplace(x4);
y4=ilaplace(y4);
yy1=ilaplace(G2*u);

% h 

u=1/(s^2);
x5=((s*eye(2)-A)^-1)*x0+((s*eye(2)-A)^-1)*B*u;
y5=C*((s*eye(2)-A)^-1)*x0+C*(((s*eye(2)-A)^-1)*B+D)*u;
x5=ilaplace(x5);
y5=ilaplace(y5);
yy2=ilaplace(G2*u);










