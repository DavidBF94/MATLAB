function[]=PLANCK
	tic
	syms x n
	h=6.626070*10^-34;
	Kb=1.380648*10^-23;
	c=299792458;
	T1=input('Valor de T1: ');
	T2=input('Valor de T2: ');
	T=[T1 T2];
	E1=input('Valor de la emisividad a T1: ');
	E2=input('Valor de la emisividad a T2: ');
	E=[E1 E2];
	n1=input('Valor de n: ');
	aprox1=input('Valor de la aproximación a cero: ');
	aprox2=input('Valor de la aproximación a infinito: ');
	for i=1:2
		x0(i)=(h*c)/(aprox1*T(i)*Kb);
		x1(i)=(h*c)/((400*10^-9)*T(i)*Kb);
		x2(i)=(h*c)/((750*10^-9)*T(i)*Kb); 
		x3(i)=(h*c)/(aprox2*T(i)*Kb); 
		Termino1(i)=E(i)*((2*pi)*(((Kb*T(i))^4)/((h^3)*(c^2))));
	end
	for i=1:2
		Integrales(i,1)=int((x^3)*(exp(1)^(-n*x)),x,x0(i),x1(i));
		Integrales(i,2)=int((x^3)*(exp(1)^(-n*x)),x,x1(i),x2(i));
		Integrales(i,3)=int((x^3)*(exp(1)^(-n*x)),x,x2(i),x3(i));
	end
	Integrales=vpa(Integrales);
	for i=1:2
		for j=1:3
			for k=1:n1
				y(k)=subs(Integrales(i,j),n,k);
				Integrales1(i,j)=sum(y);
			end
		end
	end
	for i=1:2
		Integrales2(i,:)=Termino1(i)*Integrales1(i,:);
	end
	Integrales2=(abs(Integrales2));
	for i=1:2
		fprintf('La potencia por unidad de área emitida en el ultravioleta a %f K es %f W/m^2 \n',T(i),double(Integrales2(i,1)))
		fprintf('La potencia por unidad de área emitida en el visible a %f K es %f W/m^2 \n',T(i),double(Integrales2(i,2)))
		fprintf('La potencia por unidad de área emitida en el infrarrojo a %f K es %f W/m^2 \n',T(i),double(Integrales2(i,3)))
	end
	toc
end
    
    
    
    
    
