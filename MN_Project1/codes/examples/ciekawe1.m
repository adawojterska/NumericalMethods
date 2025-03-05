 % CIEKAWE PRZYPADKI 1

% Współczynniki wielomianu w(x) = (x−1)(x−2)(x−3)(x−4)(x−5)
coefficients_p1 = [1, -15, 85, -225, 274, -120];
max_iter_1 = 1000000;
tol1 = 1e-6;
x_poczatkowe = 4.23;
%tol2 = 1e-2;

% Współczynniki dla w^2(x) = ((x−1)(x−2)(x−3)(x−4)(x−5))^2
coefficients_p2 = conv(coefficients_p1, coefficients_p1);  % Mnożenie przez siebie

[roots_p1, iterations_p1] = find_roots2(coefficients_p1, max_iter_1, tol1, x_poczatkowe);
[roots_p2, iterations_p2] = find_roots2(coefficients_p2, max_iter_1, tol1, x_poczatkowe);

% ----------------------------------sortowanie do tabelki w(x)-----------------------------------

% Znajdowanie pierwiastków funkcją MATLAB dla w(x)
roots_ref_p1 = roots(coefficients_p1);
disp(roots_p1)
disp(roots_ref_p1)
% Tutaj nie mamy zer wielokrotnych i NaN więć zwykłe sortowanie lub
% szukanie najbliższego pierwiastka spokojnie dawało radę, ale zrobiłam to
% już podobnie do 2 przypadku
roots_p1_manual = [roots_p1(3), roots_p1(1), roots_p1(4), roots_p1(5), roots_p1(2)];
iterations_p1_manual = [iterations_p1(3), iterations_p1(1), iterations_p1(4), iterations_p1(5), iterations_p1(2)];
disp(roots_p1_manual)

% Błędy bezwzględne
errors_abs_p1 = abs(roots_ref_p1 - roots_p1_manual);

% Błędy względne
errors_rel_p1 = errors_abs_p1 ./ abs(roots_ref_p1);

% ----------------------------------sortowanie do tabelki w^2(x)-----------------------------------
roots_ref_p2 = roots(coefficients_p2);
disp(roots_p2)
disp(roots_ref_p2)
% niestety nawet bardziej skomplikowane próby sortowania do tabelki zawodziły przy
% wartościach NaN i powtarzających się zerach, dlatego sortuję ręcznie
% sortowanie dla 4.23
roots_p2_manual = [roots_p2(5), roots_p2(6), roots_p2(1), roots_p2(2), roots_p2(7), roots_p2(8), roots_p2(3), roots_p2(9), roots_p2(4), roots_p2(10)];
iterations_p2_manual = [iterations_p2(5), iterations_p2(6), iterations_p2(1), iterations_p2(2), iterations_p2(7), iterations_p2(8), iterations_p2(3), iterations_p2(9), iterations_p2(4), iterations_p2(10)];
disp(roots_p2_manual)


% Błędy bezwzględne
errors_abs_p2 = abs(roots_ref_p2 - roots_p2_manual);

% Błędy względne
errors_rel_p2 = errors_abs_p2 ./ abs(roots_ref_p2);

% ----------------------------------tabelki-----------------------------------

% Wyświetlenie tabeli wyników dla w(x)
disp('Tabelka porównawcza dla w(x) (pierwiastki jednokrotne):');
disp('-----------------------------------------------------------');
disp('Pierwiastek (MATLAB) | Pierwiastek (Newton) | Iteracje | Błąd bezwzględny | Błąd względny');
disp('-----------------------------------------------------------');
for i = 1:length(roots_ref_p1)
    fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
        roots_ref_p1(i), roots_p1_manual(i), iterations_p1_manual(i), errors_abs_p1(i), errors_rel_p1(i));
end
disp('-----------------------------------------------------------');

% Wyświetlenie tabeli wyników dla w^2(x)
disp('Tabelka porównawcza dla w^2(x) (pierwiastki podwójne):');
disp('-----------------------------------------------------------');
disp('Pierwiastek (MATLAB) | Pierwiastek (Newton) | Iteracje | Błąd bezwzględny | Błąd względny');
disp('-----------------------------------------------------------');
for i = 1:length(roots_ref_p2)
    fprintf('  %18.15f | %18.15f | %9d | %15.2e | %15.2e\n', ...
        roots_ref_p2(i), roots_p2_manual(i), iterations_p2_manual(i), errors_abs_p2(i), errors_rel_p2(i));
end
disp('-----------------------------------------------------------');
