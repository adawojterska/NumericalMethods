% Skrypt testowy do porównania wyników metody SOR

% Przykładowa macierz A i wektor b
A = [4, -1, 0, 0;
    -1, 4, -1, 0;
     0, -1, 4, -1;
     0, 0, -1, 3];
b = [15; 10; 10; 10];

% Obliczenie rozwiązania układu Ax = b
x_exact = A \ b;

% Wyświetlenie rozwiązania
disp('Dokładne rozwiązanie x:');
disp(x_exact);

% Parametry
omega_vals = -1.0:0.1:2.9;  % Różne wartości omega
tol = 1e-6;  % Tolerancja
max_iter = 1000;  % Maksymalna liczba iteracji

% Tablica do przechowywania liczby iteracji dla różnych omega
iter_counts = zeros(size(omega_vals));

% Pętla po różnych wartościach omega
for i = 1:length(omega_vals)
    omega = omega_vals(i);
    
    % Wywołanie funkcji SOR_solver
    [x, iter_count] = SOR_solver(A, b, omega, tol, max_iter);
    
    % Zapisz liczbę iteracji dla danego omega
    iter_counts(i) = iter_count;
    
    % Wyświetl wyniki
    disp(['Omega = ', num2str(omega), ', Iteracje: ', num2str(iter_count), ', Wynik: ', num2str(x')]);
end

% Wykres liczby iteracji w zależności od omega
figure;
plot(omega_vals, iter_counts, '-o');
title('Liczba iteracji w zależności od parametru \omega');
xlabel('\omega');
ylabel('Liczba iteracji');
grid on;