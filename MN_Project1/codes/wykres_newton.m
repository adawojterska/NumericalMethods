% Definicja funkcji i jej pochodnej (anonimowe funkcje)
f = @(x) x.^2 - 2;  % Funkcja
f_prime = @(x) 2*x;  % Pochodna funkcji

% Parametry początkowe
x0 = 6;  % Początkowe przybliżenie
max_iter = 10;  % Maksymalna liczba iteracji
tol = 1e-6;  % Tolerancja

% Tworzenie wykresu funkcji
x = linspace(-10, 10, 400);
y = f(x);
figure;
plot(x, y, 'b', 'LineWidth', 2);  % Wykres funkcji
hold on;

% Rysowanie osi
plot(x, zeros(size(x)), 'k--');  % Oś X
title('Metoda Newtona - Wizualizacja (f(x) = x^2 - 2)');
xlabel('x');
ylabel('f(x)');
grid on;

% Przeprowadzanie iteracji metody Newtona
xk = x0;  % Inicjalizacja punktu początkowego
for k = 1:max_iter
    % Obliczanie wartości funkcji i jej pochodnej
    fxk = f(xk);
    fpxk = f_prime(xk);
    
    % Aktualizacja przybliżenia
    xk1 = xk - fxk / fpxk;
    
    % Rysowanie punktów przybliżenia na wykresie
    plot([xk, xk], [0, fxk], 'r--', 'LineWidth', 1.5);  % Linia do funkcji
    plot([xk, xk1], [fxk, 0], 'g-', 'LineWidth', 2);  % Linia do nowego przybliżenia
    
    % Rysowanie punktów
    plot(xk, fxk, 'ro', 'MarkerFaceColor', 'r');  % Punkt aktualny
    plot(xk1, 0, 'go', 'MarkerFaceColor', 'g');  % Punkt nowy
    
    % Sprawdzanie warunku zakończenia
    if abs(xk1 - xk) < tol
        break;
    end
    
    % Aktualizacja xk
    xk = xk1;
end

% Wyświetlenie wyniku
disp(['Znaleziony pierwiastek: ', num2str(xk)]);