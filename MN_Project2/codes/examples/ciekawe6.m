% Parametry
omega_vals = -0.2:0.2:2.2;  % Różne wartości omega
tol = 1e-6;  % Tolerancja
max_iter = 1000;  % Maksymalna liczba iteracji

% Macierz A1 i b1 (daleko od osobliwości)
A1 = [0, 1, 1;
      1, 4, 1;
      1, 1, 10];
b1 = [1; 2; 3];
x1_exact = A1 \ b1;
disp(det(A1));

% Rozkład macierzy A1 na D, L, U
D1 = diag(diag(A1));
L1 = tril(A1, -1);
U1 = triu(A1, 1);

% Macierz A2 i b2 (bliżej osobliwości)
A2 = [100, 1, 1;
      1, 0, 1;
      1, 1, 300];
b2 = [1; 2; 3];
x2_exact = A2 \ b2;
disp(det(A2));

% Rozkład macierzy A2 na D, L, U
D2 = diag(diag(A2));
L2 = tril(A2, -1);
U2 = triu(A2, 1);

% Macierz A3 i b3 (jeszcze bliżej osobliwości)
A3 = [102, 1, 3;
      1, 200, 1;
      3, 1, 0];
b3 = [1; 2; 3];
x3_exact = A3 \ b3;
disp(det(A3));

% Rozkład macierzy A3 na D, L, U
D3 = diag(diag(A3));
L3 = tril(A3, -1);
U3 = triu(A3, 1);

% Macierz A4 i b4 (bardzo bliska osobliwości)
A4 = [100, 1, 2;
      2, 20, 1;
      1, 1, 0];
b4 = [1; 2; 3];
x4_exact = A4 \ b4;
disp(det(A4));

% Rozkład macierzy A4 na D, L, U
D4 = diag(diag(A4));
L4 = tril(A4, -1);
U4 = triu(A4, 1);

% Funkcja do obliczania wyników dla danej macierzy
function results = compute_results(A, b, x_exact, D, L, U, omega_vals, tol, max_iter)
    results = cell(length(omega_vals), 6);
    for i = 1:length(omega_vals)
        omega = omega_vals(i);
        [x, iter_count] = SOR_solver(A, b, omega, tol, max_iter);
        rel_error = norm(x - x_exact) / norm(x_exact);
        B_SOR = inv(D + omega * L) * ((1 - omega) * D - omega * U);
        rho_B = max(abs(eig(B_SOR)));
        x_str = sprintf('[%.4f, %.4f, %.4f]', x(1), x(2), x(3));
        results{i, 1} = omega;
        results{i, 2} = iter_count;
        results{i, 3} = rel_error;
        results{i, 4} = rho_B;
        results{i, 5} = norm(x - x_exact);
        results{i, 6} = x_str;
    end
end

% Obliczanie wyników dla wszystkich macierzy
results_A1 = compute_results(A1, b1, x1_exact, D1, L1, U1, omega_vals, tol, max_iter);
results_A2 = compute_results(A2, b2, x2_exact, D2, L2, U2, omega_vals, tol, max_iter);
results_A3 = compute_results(A3, b3, x3_exact, D3, L3, U3, omega_vals, tol, max_iter);
results_A4 = compute_results(A4, b4, x4_exact, D4, L4, U4, omega_vals, tol, max_iter);

% Tworzenie tabel
T1 = cell2table(results_A1, 'VariableNames', {'Omega', 'Iteracje', 'BladWzgledny', 'PromienSpektralny', 'Blad', 'x'});
T2 = cell2table(results_A2, 'VariableNames', {'Omega', 'Iteracje', 'BladWzgledny', 'PromienSpektralny', 'Blad', 'x'});
T3 = cell2table(results_A3, 'VariableNames', {'Omega', 'Iteracje', 'BladWzgledny', 'PromienSpektralny', 'Blad', 'x'});
T4 = cell2table(results_A4, 'VariableNames', {'Omega', 'Iteracje', 'BladWzgledny', 'PromienSpektralny', 'Blad', 'x'});

% Wyświetlenie tabel
disp('x1 dokładne:');
disp(x1_exact)
disp('Tabela wyników dla A1:');
disp(T1);
disp('x2 dokładne:');
disp(x2_exact)
disp('Tabela wyników dla A2:');
disp(T2);
disp('x3 dokładne:');
disp(x3_exact)
disp('Tabela wyników dla A3:');
disp(T3);
disp('x4 dokładne:');
disp(x4_exact)
disp('Tabela wyników dla A4:');
disp(T4);

% Wykres porównawczy liczby iteracji
figure;
plot(omega_vals, cell2mat(results_A1(:, 2)), '-o', 'DisplayName', 'A1');
hold on;
plot(omega_vals, cell2mat(results_A2(:, 2)), '-x', 'DisplayName', 'A2');
plot(omega_vals, cell2mat(results_A3(:, 2)), '-s', 'DisplayName', 'A3');
plot(omega_vals, cell2mat(results_A4(:, 2)), '-d', 'DisplayName', 'A4');
title('Porównanie liczby iteracji w zależności od \omega');
xlabel('\omega');
ylabel('Liczba iteracji');
legend show;
grid on;