function new_coefficients = deflate(coefficients, root)
% Argumenty wejściowe:
% coefficients - wspólczynniki wielomianu w postaci [a_n, ..., a_0]
% root - znaleziony pierwiatek wielomianu, przez który bęziemy dzielić.
%
% Argumenty wyjściowe:
% new_coefficients - wspólczynniki wielomianu w postaci [a_m, ..., a_0] (gdzie m = n - 1).
% 
% Działanie funkcji:
% Zastosowałam znany ze szkoły średniej schemat Hornera dzelenia wielomianu
% przez dwumian (x - root). 

    n = length(coefficients) - 1;
    new_coefficients = coefficients(1:end-1); % Będziemy modyfikować stare wspólczynniki.

    % Stosujemy algorytm Hornera dzielenia wielomianu przez root.
    % Zaczynamy od 2 elementu, ponieważ pierwszy jest po prostu przepisywany.
    for i = 2:n 
        new_coefficients(i) = new_coefficients(i-1) * root + coefficients(i);
    end

    % n = length(coefficients) - 1; % Stopień wielomianu
    % roots_vector = root * ones(1, n); % Wektor wartości root
    % 
    % % Wektoryzowany schemat Hornera
    % new_coefficients = coefficients(1); % Inicjalizacja pierwszego współczynnika
    % new_coefficients = [new_coefficients, cumsum(coefficients(2:end) - roots_vector .* [0, new_coefficients(1:end-1)])];
    % new_coefficients = new_coefficients(1:end-1); % Odrzucenie ostatniego resztowego elementu

    % n = length(coefficients);           % Liczba współczynników
    % new_coefficients = zeros(1, n-1);   % Inicjalizacja nowego wektora współczynników
    % 
    % % Wektor pierwiastków pomnożonych przez odpowiednie współczynniki
    % temp = coefficients(1:end-1) + root * [coefficients(1), cumsum(coefficients(2:end-1))];
    % 
    % % Pierwszy współczynnik jest przepisany
    % new_coefficients(1) = temp(1);
    % new_coefficients(2:end) = temp(2:end);


end