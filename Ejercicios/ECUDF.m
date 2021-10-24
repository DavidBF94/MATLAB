function[]=ECUDF
	%El programa da soluciones aproximadas por el m�todo de diferencias finitas
	%para la ecuaci�n unidimensional del calor (u't=u'xx), ecuaci�n en la cual
	%las constantes f�sicas se toman con unidades para las cuales son iguales a
	%uno
	syms x
	L=input('Introduzca la longitud de la varilla problema: ');
	t=input('Introduzca el tiempo m�ximo: ');
	C1=input('Introduzca la primera condici�n de contorno (T(x=0,t)=C1): ');
	C2=input('Introduzca la segunda condici�n de contorno (T(x=L,t)=C2): ');
	C3=input('Introduzca la tercera condici�n de contorno (T(x,t=0)=C3): ');
	m=input('Introduzca el n�mero de iteraciones para la distancia(x): ');
	n=input('Introduzca el n�mero de iteraciones para el tiempo(t): ');
	EleccionGrafico=input('Elija el gr�fico de salida: T(x,t)(Temperatura)/Q(x,t)(Producci�n local Entrop�a): ');
	M=L/m;
	N=t/n;
	xi=0:M:L;
	ti=0:N:t;
	lti=length(ti);
	lxi=length(xi);
	for j=1:lti
		U=sym('u',[1 lxi]);
		for i=1:lxi
			if j==1
			   if i==1
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i+1)+2*U(i))==subs(C3,x,xi(i))+(N/(M^2))*C1;
			   elseif i==lxi
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i)+2*U(i-1))==subs(C3,x,xi(i))+(N/(M^2))*C2;
			   else
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i+1)+2*U(i)-U(i-1))==subs(C3,x,xi(i));
			   end
			elseif i==1
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i+1)+2*U(i))==MatSol(j-1,i)+(N/(M^2))*C1;
			elseif i==lxi
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i)+2*U(i-1))==MatSol(j-1,i)+(N/(M^2))*C2;
			else
				   MatEc(j,i)=U(i)+(N/(M^2))*(-U(i+1)+2*U(i)-U(i-1))==MatSol(j-1,i);
			end
		end
		[A,B]=equationsToMatrix(MatEc(j,:),U);
		MatSol(j,:)=linsolve(A,B);
	end
	vpa(MatSol);
	if strcmp(EleccionGrafico,'T(x,t)')==1
		[t,x]=meshgrid(ti,xi);
		mesh(t',x',vpa(MatSol))
		xlabel('Tiempo(t)');
		ylabel('Posici�n(x)');
		zlabel('Temperatura(T(x,t))');
		%Ahora tratamos de calcular de manera aproximada la producci�n local de
		%entrop�a a partir de los valores obtenidos de las iteraciones para la
		%posici�n y la temperatura
	elseif strcmp(EleccionGrafico,'Q(x,t)')==1
		for j=1:lti-1
			for i=1:lxi-1
				Q(j,i)=(1/(MatSol(j,i)^2))*((MatSol(j,i+1)-MatSol(j,i))/(xi(i+1)-xi(i)))*((MatSol(j,i+1)-MatSol(j,i))/(xi(i+1)-xi(i)));
			end
		end
		hold on
		[t,x]=meshgrid(ti(1:lti-1),xi(1:lxi-1));
		mesh(t',x',Q);
		xlabel('Tiempo(t)');
		ylabel('Posici�n(x)');
		zlabel('Producci�n local de Entrop�a');
	end
end
