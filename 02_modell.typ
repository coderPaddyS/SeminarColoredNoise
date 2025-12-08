#import "/00_definitions.typ": *

#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

= Mathematische Beschreibung
== Stochastischer Prozess
Rauschen wird als ein zeitabhängiger stochastischer Prozess modelliert. Ein stochastischer Prozess über einem Wahrscheinlichkeitsraum $(Omega, scr(F), P)$, einem Messraum $(Z, scr(Z))$ und einer Indexmenge $cal(T)$ ist eine Familie an Zufallsvariablen $X_t: Omega arrow Z ,omega mapsto X_t (omega)$, also eine implizite Abbildung
$ X: Omega times cal(T) arrow Z, (omega, t) mapsto X(, omega, t), $
so dass $X_t$ für alle $t in cal(T)$ $scr(F)"-"scr(Z)$ messbar ist.
Dabei ist $Omega$ eine beliebige Ereignismenge, $scr(F)$ eine $sigma$-Algebra über $Omega$ und $P$ ein Wahrscheinlichkeitsmaß über $Omega$  sowie $scr(Z)$ eine $sigma$-Algebra über $Z$ .

Ein stochastischer Prozess ist linear, wenn alle $X_t$ lineare Abbildungen sind und stationär (im engeren Sinne), wenn alle $X_t$ translationsinvariant sind, also falls $forall s in cal(T)$ und $(t_1, dots, t_n) subset.eq cal(T)$ mit $(t_1 + s, dots, t_n + s) subset.eq cal(T)$ dann auch $(X_(t_1), dots, X_(t_n)) = (X_(t_1 + s), dots, X_(t_n + s))$ gilt.

Falls $cal(T) subset.eq RR$ überabzählbar, also ein Teilintervall von $RR$ ist, so heißt der stochastischer Prozess zeitstetig, andernfalls zeitdiskret.
Ist $Z subset.eq RR$ überabzählbar, so heißt der stochastische Prozess wertestetig, andernfalls wertediskret.

Ein klassisches Beispiel eines wertediskreten stochastischer Prozess ist eine endliche Markovkette, gegeben z.$thin$B. durch das Zufallsexperiment des Münzwurfs mit der Zufallsvariable $X_t = $ "Kopf -- Zahl nach $t$ Würfen". Da der Münzwurf unabhängige Wahrscheinlichkeit hat, ist $X_t$ stationär. 
Der Irrweg#footnote[eng. Random walk] auf reellen Zahlen ist hingegen ein wertestetiger und zeitdiskreter stochastischer Prozess beschrieben durch
$ cases(X_0 &= thick 0, X_n &= thick X_(n-1) + thick  omega_n) $<Irrweg> mit $w_n$ unabhängige und identische verteilte Zufallsvariablen über $Z$. 
#topcol[#figure(image("plots/random_walk.svg"), caption: [
  Normalverteilter, zeitdiskreter Irrweg#footnote[engl. Randowm walk] mit 1000 Schritten
])]

  // - Stochastischer Prozess
  //   - Wahrscheinlichkeitsraum $(Omega, cal(F), P)$, $(Z, cal(Z))$ Raum mit $sigma$-Algebra $cal(Z)$
  //   - Menge an Zufallsvariablen $ X_t: Omega arrow Z ,omega mapsto X_t (omega)$ mit $t in RR_+$
  //   - Prozess ist linear wenn alle $X_t$ lineare Abbildungen sind
  //   - Hier meist $x(t) := X_t$
  //   - Stationär (im engeren Sinne) wenn translationsinvariant, d.h. $(x(t_1), dots, x(t_n)) = (x(t_1 + s), dots, x(t_n + s))$ 
  //   - Hier verwendete Definition sind zeitstetig
  //     - überabzählbare Indexmenge, genauer Teilintervall von $RR$
  //   - Wertestetig falls $Z subset.eq RR$, sonst wertediskret.
  // - Klassisches Model eines wertediskreten Stochastischen Prozesses ist eine endliche Markovkette, z.B.
  //   - Münzwurf, gleiche, unabhängige Wahrscheinlichkeit pro Münzwurf für Kopf/Zahl
  //   - Zufallsvariable $X_t$ beschreibt dabei die Differenz "Kopf - Zahl" nach $t$ Würfen
  //   - Hängt nicht davon ab, wann geworfen wird $arrow$ unabhängige Zuwächse
  // - Wertestetig, zeitdiskret ist ein Irrweg auf reellen Zahlen
  //   - 
  
== Rausch-Modell 
Eine mögliche mathematische Modellierung für Rauschen ist die Überlagerung von beliebig vielen (allerdings höchstens abzählbar viele) harmonische Schwingungen, also $ f(t) = sum_i a_i dot sin(omega_i t - phi.alt_i), $
wobei $a_i subset RR, omega_i subset RR, phi_i subset [0, 2pi]$ für alle $i in NN$ sofern $ sum_i abs(a_i dot sin(omega_i t - phi.alt_i)) < infinity $.

Nach diesem Modell ist $f$ automatisch eine glatte, periodische Funktion. Die Fourier-Transformation ist durch 
$ cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) dif t $ und überträgt eine periodische Funktion von der Zeit-Domäne in die Frequenz-Domäne. Für ein hier modelliertes Rauschen ist $f$ damit 

  - Rauschen ist im Allgemeinen eine Überlagerung von beliebig vielen harmonischen Schwingungen
    - $ f(t) = sum_i a_i dot sin(omega_i t - phi.alt_i) $
    - $(a_i)_(i in NN) subset RR, (omega_i)_(i in NN) subset RR, (phi_i)_(i in NN) subset [0, 2pi]$
    - Perfektes/echtes Rauschen kann nicht diskret generiert werden
    - Da sehr kompliziert ist Rauschen effektiv zufällig und üblicherweise als zeitstetiger und wertestetiger stochastischer Prozess modelliert
  - Rauschen nach dieser Definition periodisches Signal
    - Fourier-Transformation
      - $cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) d t$
      - Überträgt eine Funktion vom Zeit-Bereich in den Frequenz-Bereich
    - Inverse Fourier-Transformation
      - $f(t) = 1/sqrt(2 pi) integral_(-infinity)^(+infinity) cal(F)(f)(omega)e^(i omega t) d t$
      - Überträgt eine Funktion vom Frequenz-Bereich in den Zeit-Bereich
  - Rauschen kann durch verschiedene Eigenschaften klassifiziert werden, z.B. wie ähnlich ist es zu sich selbst
  - Autokorrelationsfunktion
    - $ &R(t_1,t_2)  colon.eq E{x(t_1)x(t_2)} \
                    &= integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f(x_1, x_2; t_1, t_2) d x_1 d x_2 $
    - Dabei ist $f$ die Produktdichte der Zufallsvariablen
    - Symmetrische Definition:
      $ R(t, tau) colon.eq R(t - tau / 2, t + tau / 2) $
    - $R(tau)$ ist gerade, d.h. $R(tau) = R(-tau)$
    - Für stationäre Prozesse $ R(tau) colon.eq R(t + tau, t) $ mit beliebigem $t$ da invariant unter translation.
    - Nicht jeder stochastische Prozess ist stationär, deswegen
    - Asymptotisch stationärer Prozess wenn $ lim_(t arrow infinity) R(t, tau) eq R(tau) $
  - Spektrale Leistungsdichte (PSD)
    - Klassifikation verschiedener Rauschsignale
    - $S(omega) colon.eq cal(F)(R(tau))(omega) = integral_(-infinity)^infinity R(tau)e^(-j omega tau) d tau$
    - Fouriertransformierte der Autokorrelationsfunktion
    - Für die Konvergenz der Fouriertransformation muss die Autokorrelationsfunktion absolut integrierbar sein
      - $integral_(-infinity)^(+infinity) |R(tau) d tau| < infinity$
    - Für reelle $R(tau)$ Vereinfachung $ S(omega) = 2 integral_0^infinity R(tau) cos(omega tau) d tau $<FTReelEinfach>
    - Gibt den Anteil an Leistung des Signals pro Frequenz an
      - Also auch maßgeblich die Form des Rauschsignals
  - Computer können nur zeitdiskret und wertediskret simulieren. Eine Diskretisierung von @Irrweg kann als Differenzgleichung geschrieben werden:
    $ x_(k+1) &= sum_(n=0)^k integral_(t_n)^(t_(n+1)) omega(tau) d tau \
              &= sum_(n=0)^(k-1) omega_n + integral_(t_k)^(t_(k+1)) omega(tau) d tau
              &= x_k + omega_k $
    - Das resultiert in der Spektralenleistungsdichte
      $ S_d = Q/(2 sin(omega (Delta t)/2))^2 tilde.eq Q/(omega^2) $
      wobei die Approximation für Frequenzen gilt und $Q$ die Varianz von dem gewählten $w_k$ Prozess ist.
  - Brownsche Bewegung
    - Stochastischer Prozess mit den Bedingungen
      1. $B_0 = 0$
      2. Für $0 <= t_0 < t_1 < ... < t_m, m in NN$ ist $B_t_i - B_t_(i-1)$ stochastisch unabhängig und normalverteilt
      3. $B(I), I subset RR$ ist stetig 
    - Eine Realisierung eines Wiener-Prozess, wobei ein Wiener-Prozess ein stochastischer Prozess mit Bedingungen 2 und 3 ist
    - @Irrweg ist ein Modell einer Brownschen Bewegung.
  - Fraktionale Brownsche Bewegung
    - Verallgemeinerung von Brownscher Bewegung
    - Auf stochastische Unabhängigkeit der Zuwächse in 2. wird verzichtet
  - Fraktionale Differenzierung