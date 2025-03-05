% jezeli macierz symetryczna i dodatnio okreslona tozbiezna na calym
% przedziale (0,2)

% Przykładowa macierz A i wektor b
A = [4, 1, 2;
    1, 3, 1;
     2, 1, 5];
b = [60; 43; 7];

eig_A = eig(A);
disp(eig_A)

% Obliczenie dokładnego rozwiązania układu Ax = b
x_exact = A \ b;

% Wyświetlenie dokładnego rozwiązania
disp('Dokładne rozwiązanie x:');
disp(x_exact);

% Parametry
omega_vals = -0.5:0.1:2.2;  % Różne wartości omega
tol = 1e-6;  % Tolerancja
max_iter = 1000;  % Maksymalna liczba iteracji

% Tablica do przechowywania wyników
results = cell(length(omega_vals), 6);  % 6 kolumn: omega, iter_count, błąd względny, promień spektralny, błąd, x

% Rozkład macierzy A na D, L, U
D = diag(diag(A));  % Diagonalna część macierzy A
L = tril(A, -1);    % Dolna część macierzy A (bez diagonali)
U = triu(A, 1);     % Górna część macierzy A (bez diagonali)

% Pętla po różnych wartościach omega
for i = 1:length(omega_vals)
    omega = omega_vals(i);
    
    % Wywołanie funkcji SOR_solver
    [x, iter_count] = SOR_solver(A, b, omega, tol, max_iter);
    
    % Obliczenie błędu względnego
    rel_error = norm(x - x_exact) / norm(x_exact);
    
    % Obliczenie B_SOR i promienia spektralnego
    B_SOR = inv(D + omega * L) * ((1 - omega) * D - omega * U);
    rho_B = max(abs(eig(B_SOR)));
    
    % Zamiana wektora x na ciąg znaków
    x_str = sprintf('[%.4f, %.4f, %.4f]', x(1), x(2), x(3));  % Formatujemy wektor jako ciąg
    
    % Zapisz wyniki w tabeli
    results{i, 1} = omega;  % Omega
    results{i, 2} = iter_count;  % Liczba iteracji
    results{i, 3} = rel_error;  % Błąd względny
    results{i, 4} = rho_B;  % Promień spektralny
    results{i, 5} = norm(x - x_exact);  % Błąd
    results{i, 6} = x_str;  % Wektor x jako ciąg znaków
    
    % Wyświetl wyniki
    disp(['Omega = ', num2str(omega), ', Iteracje: ', num2str(iter_count), ...
        ', Błąd względny: ', num2str(rel_error), ', Pr. spek.: ', num2str(rho_B), ...
        ', Błąd: ', num2str(norm(x - x_exact)), ', Wynik: ', x_str]);
end

% Tworzenie tabeli wyników
T = cell2table(results, 'VariableNames', {'Omega', 'Iteracje', 'BladWzgledny', 'PromienSpektralny', 'Blad', 'x'});

% Wyświetlenie tabeli wyników
disp('Tabela wyników:');
disp(T);

% Wykres liczby iteracji w zależności od omega
figure;
plot(omega_vals, cell2mat(results(:, 2)), '-o');
title('Liczba iteracji w zależności od parametru \omega');
xlabel('\omega');
ylabel('Liczba iteracji');
grid on;