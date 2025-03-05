% CIEKAWE PRZYPADKI 5

 format long

 % wielomian w(x) = (x^3 - 2x + 2)
coefficients_p3 = [1, 0, -2, 2];
max_iter_2 = 1000000;
tol2 = 1e-6;
x_poczatkowe2 = 0.14;

% Współczynniki dla w^2(x)
coefficients_p4 = conv(coefficients_p3, coefficients_p3);  % Mnożenie przez siebie

[roots_p3, iterations_p3] = find_roots2(coefficients_p3, max_iter_2, tol2, x_poczatkowe2);
[roots_p4, iterations_p4] = find_roots2(coefficients_p4, max_iter_2, tol2, x_poczatkowe2);

% ----------------------------------sortowanie do tabelki w(x)-----------------------------------

% Znajdowanie pierwiastków funkcją MATLAB dla w(x)
roots_ref_p3 = roots(coefficients_p3);
 
[roots_p3_manual, sort_idx_p3] = sort(roots_p3); % Sortowanie pierwiastków
iterations_p3_manual = iterations_p3(sort_idx_p3); % Iteracje uporządkowane według pierwiastków

% Błędy bezwzględne
errors_abs_p3 = abs(roots_ref_p3 - roots_p3_manual);

% Błędy względne
errors_rel_p3 = errors_abs_p3 ./ abs(roots_ref_p3);


% ----------------------------------sortowanie do tabelki w^2(x)-----------------------------------
roots_ref_p4 = roots(coefficients_p4);

[roots_p4_manual, sort_idx_p4] = sort(roots_p4); % Sortowanie pierwiastków
iterations_p4_manual = iterations_p4(sort_idx_p4); % Iteracje uporządkowane według pierwiastków


%% Błędy bezwzględne
errors_abs_p4 = abs(roots_ref_p4 - roots_p4_manual);

% Błędy względne
errors_rel_p4 = errors_abs_p4 ./ abs(roots_ref_p4);
% ----------------------------------tabelki-----------------------------------

% Wyświetlenie tabeli wyników dla w(x)
disp('Tabelka porównawcza dla w(x) (pierwiastki jednokrotne):');
disp('-----------------------------------------------------------');
disp('Pierwiastek (MATLAB) | Pierwiastek (Newton) | Iteracje | Błąd bezwzględny | Błąd względny');
disp('-----------------------------------------------------------');
for i = 1:length(roots_ref_p3)
    %fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
    %    roots_ref_p3(i), roots_p3_manual(i), iterations_p3_manual(i), errors_abs_p3(i), errors_rel_p3(i));
     if isnan(roots_p3_manual(i))
        fprintf('  %18.15f | %18.15f | %9d | %15s | %15s\n', ...
            roots_ref_p3(i), roots_p3_manual(i), iterations_p3_manual(i), 'NaN', 'NaN');
    else
        fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
            roots_ref_p3(i), roots_p3_manual(i), iterations_p3_manual(i), errors_abs_p3(i), errors_rel_p3(i));
    end
end
disp('-----------------------------------------------------------');

% Wyświetlenie tabeli wyników dla w^2(x)
disp('Tabelka porównawcza dla w^2(x) (pierwiastki podwójne):');
disp('-----------------------------------------------------------');
disp('Pierwiastek (MATLAB) | Pierwiastek (Newton) | Iteracje | Błąd bezwzględny | Błąd względny');
disp('-----------------------------------------------------------');
for i = 1:length(roots_ref_p4)
    %fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
    %    roots_ref_p4(i), roots_p4_manual(i), iterations_p4_manual(i), errors_abs_p4(i), errors_rel_p4(i));
    % Sprawdzamy, czy błąd jest NaN
    if isnan(roots_p4_manual(i))
        fprintf('  %18.15f | %18.15f | %9d | %15s | %15s\n', ...
            roots_ref_p4(i), roots_p4_manual(i), iterations_p4_manual(i), 'NaN', 'NaN');
    else
        fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
            roots_ref_p4(i), roots_p4_manual(i), iterations_p4_manual(i), errors_abs_p4(i), errors_rel_p4(i));
    end
end
disp('-----------------------------------------------------------');