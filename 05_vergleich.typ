#import "@preview/subpar:0.2.2"

= Vergleich
  - Geschwindigkeit
    - Phasenrandomisierung sehr langsam
    - Timmer-Koenig-Algorithmus sehr schnell
    - Wie zu erwarten sind die beiden Fraktionale Differenzierung Methoden ähnlich
  - Komplexitätsklassen
    - Timmer-Koenig-Algorithmus $O(n log(n))$ wegen Fourier-Transformation
    - Phasenrandomisierung ist $O(n^2)$ wegen $n$ Summen über $n/2$ Frequenzen
    - Fraktionale Differenzierungsmethoden sind in $O(n log(n) + p)$ und $O(n dot p)$
  - Phasenrandomisierung, Timmer-Koenig-Algorithmus und der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich nur für die Generierung von langen Rauschsignalen
  - Der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich kann für Echtzeitgenerierung verwendet werden
    - Es werden nur wenige alte Werte für einen neuen Wert benötigt. Die Koeffizientenfolge kann einmal vorberechnet werden.
  #figure(caption: [
    Berechnungszeit der Algorithmen in Sekunden.
  ],image("time/100000.0/combined/all.svg"))
  - Güte der Rauschapproximationen
    - Nur Phasenrandomisierung trifft das Potenzgesetz für Rauschen punktgenau
    - Dafür große Varianz
    #subpar.grid(columns: 2,
      caption: [Links: Integral der verschiedenen generierten Rauschsignalen. Rechts: Normierung von links auf den Bereich $[-1,1]^2$. \ $n$-te Reihe: $alpha = n - 1$.],
      figure(image("plots/1000/deviation/combined/sum-0.svg")),
      figure(image("plots/1000/deviation/combined/scaled-0.svg")),
      figure(image("plots/1000/deviation/combined/sum-1.svg")),
      figure(image("plots/1000/deviation/combined/scaled-1.svg")),
      figure(image("plots/1000/deviation/combined/sum-2.svg")),
      figure(image("plots/1000/deviation/combined/scaled-2.svg")),
    )