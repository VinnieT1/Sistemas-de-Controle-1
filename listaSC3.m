clf;

s = tf([1 0], 1);
Gs = 2.3 * (s + 8) / ((s^2 + 1.7*s + 9)*(s + 8.5));

[y, tOut] = step(Gs);

Tpf = 0.6;
UPf = 0.25;
Tsf = 7.3;

zeta = -log(UPf)/sqrt(pi^2 + (log(UPf))^2);
wn = pi / (Tpf*sqrt(1 - zeta^2));

Hfs = wn^2 / ((s^2 + 2*zeta*wn*s + wn^2));
Controle = Hfs / Gs;
SistemaResultante = Controle * Gs;
step(SistemaResultante);