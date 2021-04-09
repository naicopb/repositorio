clear;clc;
% En este ejercicio se va a tratar de aproximar la función f(t)=sin(pit/2)
% por medio de la familia de funciones que dicta el enunciado.
% Para ello,

disp("a)")
apartadoA(4);
disp("b)")
%apartadoB(5)
disp("b)")
%apartadoB(10)
disp("b)")
apartadoB(20)


function y = apartadoA(n)
   % En primer lugar, divido el intervalo en nodos equiespaciados
   nodos=getNodos(n);
   % En segundo lugar, calculo la matriz A.
   A=getA(nodos, n);
   % En tercer lugar, calculo la matriz B.
   B=getB(nodos, n);
   % Resuelvo el sistema
   y=inv(transpose(A)*A)*transpose(A)*B;
   disp("La aproximación es:")
   for i=0:length(y)-1
       disp("t + " + y(i+1) + "t(1+t)t^" + i + " +")
   end
end

function y = apartadoB(n)
   % En primer lugar, divido el intervalo en nodos equiespaciados
   nodos = getNodos(n);
   % En segundo lugar, replico todo lo que se hace en el apartado a para 5,
   % 10 y 20
   intervalo_para_representar=0:0.01:1; 
   B = apartadoA(n);
   func1 = getFunction(intervalo_para_representar, B);
   func2 = sin((pi/2)*intervalo_para_representar);
   plot(intervalo_para_representar, func2, 'g-o', intervalo_para_representar, func1, '--r');
   title('Gráficas de la función f(x) y de la función que aproxima por mínimos cuadrados a f')
   legend('f(x)','Función que aproxima por mínimos cuadrados a f')
   A = getA(nodos, n);
   c = cond(transpose(A)*A);
   disp("El número de condición de la matriz es " + c);
end

function y = getFunction(intervalo_para_representar, coeficientes)
  y = intervalo_para_representar;
  for i=0:length(coeficientes)-1
      y = y + coeficientes(i+1).*intervalo_para_representar.*(1-intervalo_para_representar).*intervalo_para_representar.^(i);
  end
end

function y = getA(nodos, n)
   A=zeros(n-1, n-1);
   for i=1:n-1
       for j=1:i
           A(i, j)=nodos(i+1)*(nodos(i+1)-1)*(nodos(i+1))^2;
       end
   end 
   y=A;
end

function y = getB(nodos, n)
   B=zeros(n-1, 1);
   for i=1:n-1
       B(i, 1)=sin(pi*nodos(i)/2)-i;
   end 
   y=B;
end

function y = getNodos(n)
   y = 0:1/n:1; 
end
