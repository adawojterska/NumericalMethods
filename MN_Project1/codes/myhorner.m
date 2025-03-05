function [w, p] = myhorner(coefficients, x)
% Argumenty wejściowe:
% coeffcients - wspólczynniki wielomianu od a_n do a_0.
% x - argument x dla którego obliczana jest wartość funkcji i pierwsza pochodna.
%
% Argumenty wyjściowe:
% w - wartość wielomianu w punkcie x.
% p - wartość pochodnej wielomianu w punkcie x.
%
% Działanie funkcji:
% Zastosowałam zaprezentowany na wykładzie zoptymalizowany algorytm Hornera obliczania
% wartości wielomianu i jego pochodnej.

    n = length(coefficients);
    w = coefficients(1);
    p = w;
    for i = 2:1:n-1
        w = coefficients(i) + x * w;
        p = w + x * p;
    end
    w = coefficients(n) + x * w;

end