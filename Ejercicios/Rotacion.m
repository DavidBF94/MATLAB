n=10;                                                                       %n�mero de intervalos
D=input('Introduzca el di�metro de la cabeza (mm): ');
Re=D/2;                                                                     %Radio esfera
syms u v 
x1=Re*cos(u)*sin(v);                                                        %Coordenadas esf�ricas
x2=Re*sin(u)*sin(v);
x3=Re*cos(v);
u1=0:(2*pi/n):2*pi;                                                         %Definici�n esfera
v1=0:(pi/n):pi;
xe1=zeros(n,n);
xe2=zeros(n,n);
xe3=zeros(n,n);
for i=1:n+1                                                                 %Construcci�n esfera
    for j=1:n+1
        xe1(i,j)=subs(x1,[u v],[u1(i) v1(j)]);
        xe2(i,j)=subs(x2,[u v],[u1(i) v1(j)]);
        xe3(i,j)=subs(x3,[u v],[u1(i) v1(j)]);
    end
end
surf(xe1,xe2,xe3);                                                          %Plot esfera
hold on
ncil=input('Introduzca el n�mero de cilindros: ');                          %N�mero de cilindros
for m=1:ncil                                                                
    d=input('Introduzca el di�metro del cilindro (mm): ');
    Rc=d/2;                                                                 %Radio cilindro
    H=input('Introduzca la altura del cilindro (mm): ');
    puntox=input('Introduzca punto x: ');                                   %posici�n x cilindro en la esfera
    puntoy=input('Introduzca punto y: ');                                   %posici�n y cilindro en la esfera
    puntoz=((Re)^2-(puntox^2)-(puntoy^2))^0.5;                              %posici�n z cilindro en la esfera (obligado)
    syms w 
    x11=Rc*cos(u);                                                          %Coordenadas cil�ndricas
    x22=Rc*sin(u);
    x33=w;
    w1=Re:((H)/n):Re+H;                                                     %Definici�n cilindro
    xc1=zeros(n,n);
    xc2=zeros(n,n);
    xc3=zeros(n,n);
    for i=1:n+1                                                            %Construcci�n cilindro
       for j=1:n+1
           xc1(i,j)=subs(x11,[u w],[u1(i) w1(j)]);
           xc2(i,j)=subs(x22,[u w],[u1(i) w1(j)]);
           xc3(i,j)=subs(x33,[u w],[u1(i) w1(j)]);
       end
    end
    %Construcci�n matriz cambio de base
    if isreal(puntoz)==0                                                    %Si el punto no es un numero real, se usa su parte imaginaria
    puntoz=imag(puntoz);
    end
    if puntoz>0                                                             %Deficici�n de theta en funci�n del signo del punto z
        theta=atan((sqrt(puntox^2+puntoy^2))/puntoz);                       %theta entre 0-90�
    elseif puntoz==0
        theta=(pi/2);                                                       %si z=0, theta=90�
    elseif puntoz<0
        theta=pi+atan((sqrt(puntox^2+puntoy^2))/puntoz);                    %theta entre 90-180�
    end
    if puntox>0 && puntoy>0                                                 %Definici�n de phi en funci�n de los signos de los puntos x e y
        phi=atan(puntoy/puntox);                                            %phi entre 0-90�
    elseif puntox<0
        phi=pi+atan(puntoy/puntox);                                         %phi entre 90-270�
    elseif puntox>0 && puntoy<0
        phi=2*pi+atan(puntoy/puntox);                                       %phi entre 270-360�
    end
    if puntox==0                                                            %si x=0, phi=90 � 270�
        if puntoy>0
            phi=pi/2;
        else
            phi=3*pi/2;
        end                                                   
    elseif puntoy==0                                                        %si y=0, phi=0 � 180�
        if puntox<0
            phi=pi;
        else
            phi=0;
        end
    end
    vectortang1=[cos(v)*cos(u),cos(v)*sin(u),-sin(v)];                      %Vectores tangentes a la esfera en el punto
    vectortang2=[-sin(u),cos(u),0];
    vectornormal=cross(vectortang1,vectortang2);                            %Vector perpendiculara a la esfera en el punto
    vectortang11=subs(vectortang1,[u v],[phi theta]);
    vectortang22=subs(vectortang2,[u v],[phi theta]);
    vectornormal2=subs(vectornormal,[u v],[phi theta]);
    A(:,1)=vectortang11;                                                    %Asignaci�n de valores a los elementos de la matriz
    A(:,2)=vectortang22;
    A(:,3)=vectornormal2;
    Matrizcambio=A;                                                         %Inversa de la matriz para obtener la de cambio de base
    %
    %Construcci�n matriz campo vectorial
    FieldMat(:,1)=r*cos(u);
    FieldMat(:,2)=r*sin(u);
    FieldMat(:,3)=z;
    FieldMat(:,4)=Br*cos(u);
    FieldMat(:,5)=Br*sin(u);
    FieldMat(:,6)=Bz;
    for i=1:n+1                                                             %plot campo vectorial
        matsubs=subs(FieldMat,u,2*pi*i/n);
        %transf=Matrizcambio*[matsubs(:,1);matsubs(:,2);matsubs(:,3)];      %Intento de cambio de base XD
        quiver3(matsubs(:,1),matsubs(:,2),matsubs(:,3)+Re+H/2,matsubs(:,4),matsubs(:,5),matsubs(:,6));
        hold on
    end
    %
    xc11=zeros(n,n);
    xc22=zeros(n,n);
    xc33=zeros(n,n);
    for i=1:n+1                                                             %Cambio de base y rotaci�n cilindro
       for j=1:n+1
            XC=Matrizcambio*[xc1(i,j);xc2(i,j);xc3(i,j)];
            xc11(i,j)=XC(1,1);
            xc22(i,j)=XC(2,1);
            xc33(i,j)=XC(3,1);
       end
    end
    surf(xc11,xc22,xc33);                                                   %Plot cilindro
    hold on
end