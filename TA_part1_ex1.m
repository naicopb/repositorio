clc; clear;

% La función main toma un número de nodos
%                      una función f
% y lo que hace es:
%
% 1) Calcula el spline cúbico natural que interpola la función en n nodos
% equiespaciados
%
% 2) Pinta una gráfica con la función y el spline cúbico natural que
% interpola la función
%
% 3) Calcula el error cometido al aproximar f(t) por el spline que
% interpola la función. Entendiendo el error como el error que se obtiene
% al maximizar la función que da la norma infinito del valor absoluto de la
% diferencia entre la función y su aproximación
%
% 4) Calcula el error cometido al aproximar la pendiente de f(t) con el spline que
% interpola la función. Para ello, busca el máximo de la norma infinito del
% valor absoluto de la diferencia entre la derivada de la función y la
% derivada del polinomio a trozos que interpola la función.

n = 10; 
syms x;
f = @(x) 5*sin(3*x)+log(3*x);

main(n, f)

function y = main(n, f)
syms x;
fprima = diff(f, x);

intervalo_equiespaciado = linspace(1, 3, n);
intervalo_para_representar = linspace(1, 3, 1000);

p = spline(intervalo_equiespaciado, [0 f(intervalo_equiespaciado) 0]);
[nodos, coefs, nrodetrozos] = unmkpp(p);

%Paso 1: Pintar las dos funcines
plot(intervalo_para_representar, f(intervalo_para_representar), 'g-o', intervalo_para_representar, ppval(p, intervalo_para_representar), '--r');
title('Gráficas de la función f(x) y del spline cúbico natural que lo interpola')
legend('f(x)','Spline cúbico natural que interpola f(x)')

%Paso 2: Estime el valor del error máximo cometido al aproximar f(t) por el
%spline construido
disp('Error al aproximar la función con el spline');
error_simple(intervalo_para_representar, nrodetrozos, coefs, nodos, f)


%Paso 3: Estime el valor del error máximo cometido al aproximar la pendiente
%de f(t) por la del spline construido en el intervalo [1,3]
disp('Error al aproximar la pendiente de la función con el spline');
error_compuesto(intervalo_para_representar, nrodetrozos, coefs, nodos, fprima)

end

%Función que calcula el error al aproximar la función
function y = error_simple(intervalo, nrodetrozos, coefs, nodos, f)
 y = zeros(1, length(intervalo));
 for i = 1:length(intervalo)
     y(i) = abs(f(intervalo(i)) - pp(intervalo(i), nrodetrozos, coefs, nodos));
 end
 y = max(y);
end

%Función que calcula el error al aproximar la pendientede la función
function y = error_compuesto(intervalo, nrodetrozos, coefs, nodos, fprima)
 y = zeros(1, length(intervalo));
 for i = 1:length(intervalo)
     x = intervalo(i);
     y(i) = abs(eval(fprima) - ppprima(intervalo(i), nrodetrozos, coefs, nodos));
 end
 y = max(y);
end

%Función que evalua el spline en un determinado punto
function y = pp(x, nrodetrozos, coefs, nodos)
    y = 0;
    for i = 1:nrodetrozos
        if (x >= nodos(i)) && (x <= nodos(i+1))
            y = coefs(1, 1)*x*x*x + coefs(1, 2)*x*x + coefs(1, 3)*x + coefs(1, 4);
        end
    end
end

%Función que evalua la derivada del spline en un determinado punto
function y = ppprima(x, nrodetrozos, coefs, nodos)
    y = 0;
    for i = 1:nrodetrozos
        if (x >= nodos(i)) && (x <= nodos(i+1))
            y = 3*coefs(1, 1)*x*x + 2*coefs(1, 2)*x + coefs(1, 3);
        end
    end
end
