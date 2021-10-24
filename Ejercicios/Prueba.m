function[V,E,DerivadasParciales]=Prueba(M,I,R,K)
	%M es un vector columna con cada fila conteniendo una función distinta
	%I es la matriz en la que cada fila contiene las distintas variables de su
	%correspondiente función en M
	%R es la matriz en la que cada fila contiene los distintos valores de una
	%misma variable,las variables se introducen en el mismo orden que en I
	%K es la matriz en la que cada fila contiene los distintos valores de los 
	%errores de una misma variable,los errores de las variables se introducen 
	%en el mismo orden que en I
	disp('Las respuestas deben introducirse entre comillas')
	if nargin==2
		Nombrefichero=input('Nombre del fichero: ');
		Nombrehoja=input('Nombre de la hoja: ');
		RangoDatosValores=input('Rango de los datos de los valores: ');
		RangoDatosErrores=input('Rango de los datos de los errores: ');
		R=xlsread(Nombrefichero,Nombrehoja,RangoDatosValores);
		K=xlsread(Nombrefichero,Nombrehoja,RangoDatosErrores);
	end
	Respuesta1=input('¿Se muestran las derivadas parciales?(Sí/No): ');
	while strcmp(Respuesta1,{'Sí','No'})==0
		disp('Las únicas respuestas posibles son Sí o No')
		Respuesta1=input('¿Se muestran las derivadas parciales?(Sí/No): ');
	end
	Respuesta2=input('¿Se muestran los resultados en un archivo de Excel?(Sí/No): ');
	while strcmp(Respuesta2,{'Sí','No'})==0
		disp('Las únicas respuestas posibles son Sí o No')
		Respuesta2=input('¿Se muestran los resultados en un archivo de Excel?(Sí/No): ');
	end
	Dimens=size(R);
	n1=length(M);
	for t=1:n1
		b=[];
		c=[];
		Inc=[];
		Q=[];
		W=[];
		V=[];
		E=[];
		F=M(t,:);
		a=I(t,:);
		a(a==0)=[];
		n2=length(a);
		Q1=R(1:n2,:);
		W1=K(1:n2,:);
		for u=1:n2
			Q2=Q1(u,:);
			W2=W1(u,:);
			Q2(Q2==0)=[];
			W2(W2==0)=[];
			Q(u,:)=Q2;
			W(u,:)=W2;
		end
		%F es la función en simbólico
		%a es un vector con las variables en simbólico
		%Q es una matriz (o vector columna) en la que cada fila tiene los distintos
		%valores de la misma variable
		%W es una matriz (o vector columna) en la que cada fila tiene los distintos
		%valores de los errores de la misma variable
		m=size(W);
		r=m(1,2);
		l=m(1,1);
		DerivadasParciales=sym(zeros(1,l));
		for j=1:r
			for k=1:l
			   b(k)=Q(k,j);
			   c(k)=W(k,j);
			end
			for i=1:l
				Inc(i)=(subs(diff(F,a(i)),a,b)*c(i))^2;
			end
			V(j)=vpa(subs(F,a,b));
			E(j)=vpa(sqrt(sum(Inc)));
		end
		for i1=1:l
			DerivadasParciales(i1)=vpa(diff(F,a(i1)));
		end
		DimensV=length(V);
		DimensE=length(E);
		VExcel(t,:)=[V zeros(1,(Dimens(2)-DimensV))];
		EExcel(t,:)=[E zeros(1,(Dimens(2)-DimensE))];
		if strcmp({Respuesta1;Respuesta2},{'Sí';'No'})==[1;1]
			DerivadasParciales
			V
			E
		elseif strcmp({Respuesta1;Respuesta2},{'No';'No'})==[1;1]
			V
			E
		elseif strcmp({Respuesta1;Respuesta2},{'Sí';'Sí'})==[1;1]  
			DerivadasParciales
		end
		R(1:n2,:)=[];
		K(1:n2,:)=[];
	end
	if strcmp(Respuesta2,'Sí')==1
		fprintf('La dimensión de la matriz de resultados es de %d x %d\n',n1,Dimens(2));
		Nombrefichero2=input('Nombre del fichero: ');
		Nombrehoja2=input('Nombre de la hoja: ');
		RangoDatosValores2=input('Rango de los datos de los valores: ');
		RangoDatosErrores2=input('Rango de los datos de los errores: ');
		V=xlswrite(Nombrefichero2,VExcel,Nombrehoja2,RangoDatosValores2);
		E=xlswrite(Nombrefichero2,EExcel,Nombrehoja2,RangoDatosErrores2); 
	end
end