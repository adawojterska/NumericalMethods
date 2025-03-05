function [x, iter_count] = SOR_solver(A, b, omega, tol, max_iter)
    % ARGUMENTY WEJŚCIOWE:
    % A: macierz współczynników (n x n)
    % b: wektor wyników (n x 1)
    % omega: parametr relaksacji
    % tol: tolerancja dla dokładności rozwiązania
    % max_iter: maksymalna liczba iteracji
    % ARGUMENTY WYJŚCIOWE
    % x – znalezione przybliżenie lub NaN, jeżeli nie udało się znaleźć
    % iter_count – liczba iteracji potrzebnych do znalezienia (lub -1, gdy nie znaleziono)
    
    n = length(b);
    x = zeros(n, 1);  % Inicjalizacja wektora x jako wektor zerowy
    iter_count = 0;
    
    while iter_count < max_iter
        x_old = x;
        
        % algorytm z wykładu
        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            x(i) = (1 - omega) * x_old(i) + omega / A(i, i) * (b(i) - sum1 - sum2);
        end
        
        iter_count = iter_count + 1;
        % Sprawdzenie kryterium zbieżności - norma maksimum
        if norm(x - x_old, inf) < tol
            return;
        end
    end

     % Jeśli nie osiągnięto zbieżności w zadanej liczbie iteracji, zwróć NaN
    x = NaN * ones(n, 1);  % Zwrócenie NaN jako wynik
    iter_count = -1;

end