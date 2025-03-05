function [roots, iterations] = find_roots2(coefficients, max_iter, tol, x_poczatkowy)
% Argumenty wejściowe:
% coeffcients - wspólczynniki wielomianu od a_n do a_0.
% max_iter - maksymalna liczba iteracji szukania miejsca zerowego funkcji f
% tol - tolerancja - jeżeli |x_k - x_k-1| < tol, funkcja uzna, że znalazła
% miejsce zerowe
% x_poczatkowy - poczatkowe przyblizenie miejsca zerowego
%
% Argumenty wyjściowe:
% roots - wszystkie znalezione miejsca zerowe funkcji, w kolejności
% znalezienia
% iterations - liczba iteracji potrzebna do znalezienia kolejnych miejsc
% zerowych (lub max_iter, jeżeli przekroczono limit iteracji)

    % Inicjalizacja z NaN
    roots = NaN(length(coefficients) - 1, 1); % Prealokacja miejsca na pierwiastki
    iterations = NaN(length(coefficients) - 1, 1); % Prealokacja miejsca na iteracje
    n = length(coefficients) - 1; % Stopień wielomianu
    found_roots = 0; % Zmienna do liczenia znalezionych pierwiastków
    
    for i = 1:n % Tyle pierwiastków szukamy
        % Wybór początkowego przybliżenia
        x0 = x_poczatkowy; % Losowa wartość początkowa z przedziału [-5, 5]

        iter = 0;
        zmieniono = false;
        while iter < max_iter
            % Obliczanie wartości wielomianu i jego pochodnej metodą Hornera
            [fx, dfx] = myhorner(coefficients, x0);
            
            if abs(dfx) == 0
                % Jeśli pochodna jest zerowa, zmieniamy punkt początkowy
                x0 = -1000 + 2000 * rand();
                iter = 0; % Losowanie nowego punktu
                continue;
            end
            
            % Aktualizacja przybliżenia za pomocą metody Newtona
            x1 = x0 - (fx / dfx);
            
            % Sprawdzenie, czy przybliżenie spełnia warunek tolerancji
            if abs(x1 - x0) < tol
                found_roots = found_roots + 1; % Zwiększ licznik znalezionych pierwiastków
                roots(found_roots) = x1; % Zapis znalezionego pierwiastka
                iterations(found_roots) = iter;
                zmieniono = true;
                break;
            end
            x0 = x1;
            iter = iter + 1;
        end
        
        % Sprawdzenie, czy po przekroczeniu maksymalnej liczby iteracji nie znaleziono pierwiastka
        if iter == max_iter
            disp(['Nie znaleziono pierwiastka po maksymalnej liczbie iteracji w kroku ' num2str(i)]);
        end
        
        % Deflacja wielomianu
        if zmieniono == true
            coefficients = deflate(coefficients, roots(found_roots));
        end
    end
    
    % Sprawdzamy, czy znaleźliśmy jakieś pierwiastki
    if all(isnan(roots))
        disp('Brak pierwiastków rzeczywistych.');
    end

end