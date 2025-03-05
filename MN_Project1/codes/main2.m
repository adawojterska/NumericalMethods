
format long

% POKAZANIE DZIAŁANIA PROGRAMU

% wielomian 1x^3 -2x^2-9x+18
coefficients1 = [1, -2, -9, 18];

max_iter = 100000; % Maksymalna liczba iteracji
tol1 = 1e-6;    % Tolerancja
x_poczatkowy = 1000; % poczatkowy x
    
 % Znajdowanie zer wielomianu w(x)
 [roots_w, iterations_w] = find_roots2(coefficients1, max_iter, tol1, x_poczatkowy);
 disp('Znalezione zera wielomianu w(x):');
 disp(roots_w);
 disp('Liczba iteracji dla każdego pierwiastka:');
 disp(iterations_w);

 % Tworzenie współczynników w(x)^2
 coefficients_squared = conv(coefficients1, coefficients1);
 % Znajdowanie zer wielomianu w(x)^2
 [roots_w_squared, iterations_w_squared] = find_roots2(coefficients_squared, max_iter, tol1, x_poczatkowy);
 disp('Znalezione zera wielomianu w(x)^2:');
 disp(roots_w_squared);
 disp('Liczba iteracji dla każdego pierwiastka:');
 disp(iterations_w_squared);
