clear;clc;

disp('Apartado A')
apartadoA(5);
disp('Apartado B')
apartadoB(1);
apartadoB(2);
apartadoB(3);
apartadoB(4);
apartadoB(5);
apartadoB(6);
apartadoB(7);
apartadoB(8);
disp('Apartado C')
apartadoC(3);
function y = apartadoA(n)
 [A, B] = getAandB(n);
 disp('El sistema de ecuaciones normales es: A*x=B')
 disp('con A=')
 disp(A)
 disp('y B=')
 disp(B)
 y=A;
end

function y = apartadoB(n)
 T=zeros(1,n+2);
 [A, B] = getAandB(n);
 Q = A/B;
 T(1,1) = n;
 T(1,n+2) = cond(A);
 for i = 1:n
     T(1,i+1) = Q(i);
 end 
 disp('n - solución - numero de condicion');
 T
end

function y = apartadoC(n)
 [A, B] = getAandB(n);
 intervalo_para_representar=0:0.1:5; 
 Q = A/B;
 res = 0;
 for i = 1:length(Q)
     g = Q(i)*exp(-1*i*intervalo_para_representar);
     res = res + g;
 end
 %y1 = polyval(g(intervalo_para_representar), intervalo_para_representar);
 fplot(1,[0 1],'g-o');
 hold on;
 fplot(0,[1 5],'g-o');
 hold on;
 plot(intervalo_para_representar, res, '--r');
end

function [A,B] = getAandB(n)
A=zeros(n);
B=zeros(1,n);
 for i = 1:n
     B(1,i)= i*i;
     for j = 1:n
        A(i,j)=10/(i+j);
     end
 end
end

