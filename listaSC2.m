clf;

s = tf([1 0], 1);
Hs = 2/(s^2 + 4.2*s + 18);

[y, tOut] = step(Hs);

n = 0.003*randn(size(tOut));
yn = y + n;

tiledlayout(3, 1);
nexttile
plot(tOut, yn);
xlabel('Tempo');
ylabel('y(t)');
title('Saída com ruído');

% ---------------------------- RESOLUÇÃO ---------------------------
% Temos apenas acesso a tOut e yn

yMax = max(yn);
Tp = tOut(find(yn == yMax, 1, 'first'));
yInf = (yn(end) + yn(end - 1) + yn(end - 2)) / 3;
UP = (yMax - yInf) / yInf;
zeta = -log(UP) / sqrt(pi^2 + (log(UP)^2));
wn = pi / (Tp * sqrt(1 - zeta^2));
K = yInf;

Gs = K*wn^2 / (s^2 + 2*zeta*wn*s + wn^2); % padrão de 2 º ordem subamortecido
[yNew, tNew] = step(Gs, tOut);

nexttile
plot(tNew, yNew);
xlabel('Tempo');
ylabel('y(t)');
title('Resultado do modelo da função de transferência');

nexttile
plot(tNew, yNew);
hold on;
plot(tOut, yn);
xlabel('Tempo');
ylabel('y(t)');
title('Comparação');