clf;

s = tf([1 0], 1);
Hs = 2.3/(s + 1.75);

[y,tOut] = step(Hs);

n = 0.03*randn(size(tOut));
yn = y + n;

% ---------------------------- RESOLUÇÃO ---------------------------
% Só temos acesso a yn e tOut

tiledlayout(3, 1);

y_end = (yn(end) + yn(end - 1) + yn(end - 2)) / 3;

idx1 = find( yn >= 0.632*y_end, 1, 'first' );
idx2 = find( yn <= 0.632*y_end, 1, 'last' );

a = 2 / (tOut(idx1) + tOut(idx2)); % inverso da constante de tempo

K = y_end; % ganho
newHs = K*a / (s + a);
[yNew, tNew] = step(newHs);

nexttile
plot(tOut, yn)
xlabel('Tempo');
ylabel('y(t)');
title('Sinal com ruído');

nexttile
plot(tNew, yNew);
xlabel('Tempo');
ylabel('y(t)');
title('Resultado do modelo da função de transferência');

nexttile
plot(tNew, yNew);
hold on
plot(tOut, yn);
xlabel('Tempo');
ylabel('y(t)');
title('Comparação');