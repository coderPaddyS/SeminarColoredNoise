#import "@preview/subpar:0.2.2"
#import "/00_definitions.typ": *

= Vergleich
Auch wenn alle vorgestellten Algorithmen weiße, pinke und braune Rauschsignale erzeugen können, so unterscheiden sie sich in einigen Punkten enorm.

#heading(level: 2,numbering: none)[Geschwindigkeit]
  Der Phasenrandomisierung-Algorithmus betrachtet für jeden Zeitpunkt alle Frequenzen, weshalb dieser sehr langsam ist.
  Auch der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich ist sehr langsam, da in jedem Schritt ein weiterer Koeffizient beachtet werden muss.
  Eine Approximation im Zeit-Bereich beschleunigt den Algorithmus allerdings wesentlich.
  Timmer-Koenig und sowie der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich sind bezüglich der Laufzeit beide sehr ähnlich.

  Das ist in @Comparison dargestellt.
  Dabei ist $n$ die Anzahl an generierten Datenpunkten und $p$ der Approximationsparameter für die Filter-Algorithmen, so dass nur die ersten/letzten $p$ Filterkoeffizienten verwendet werden.
  Die Limitierungsspalte gibt den Teil des Algorithmus an, der die Laufzeit festlegt.
  In @Laufzeiten sind die Laufzeiten auf einer doppelt-logarithmischen Skala dargestellt. Die Unstimmigkeit der Laufzeit des Phasenrandomisierung-Algorithmus im Vergleich zu @Comparison lässt sich durch Optimierungen von #emph("numpy") erklären.

#colbreak(weak: true)

#figure(
  caption: [Vergleich der Komplexitätsklassen der Algorithmen und die \ limitierende Faktoren],
  table(columns: 3,
    table.header(
      [Algorithmus], [Laufzeit], [Limitierung]
    ),
    [Phasenrandomisierung], [$O(n^2)$], [$n$ Summen über $n$ Einträge],
    [Timmer-Koenig], [$O(n log(n))$], [Fourier-Transformation],
    [FIR-Filter], [$O(n log(n) + p)$], [Fourier-Transformation],
    [AR-Filter], [$O(n dot p)$], [$n$ Summen über $p$ Einträge]
  )
)<Comparison>




#topcol[
    #figure(caption: [
    Vergleich Berechnungszeit der Algorithmen in Sekunden bei $n = 10000$ mit unterschiedlichen Zufallszahlen. 
    Die eingezogene Linie entspricht dem Zentralwert, die hellen Bereiche beinhalten alle Werte im 25. und 75. Perzentil.
  ],image(width: 75%, "time/10000/combined/all.svg"))<Laufzeiten>
]

#heading(level: 2,numbering: none)[Speicheraufwand]

  Bis auf den AR-Filter sind alle Algorithmen sogenannte Batch-Algorithmen. Sie generieren immer ein Signal von im Vorhinein definierter Länge.
  Das führt dazu, dass alle einen Speicheraufwand von $O(n)$, wobei der FIR-Filter zusätzlich $O(p)$ Speicher für die Filterkoeffizienten benötigt.

  Im Gegensatz dazu benötigt der AR-Filter nur die letzten $p$ Zeitschritte und die letzten $p$ Filterkoeffizienten. Das macht ihn für kleine $p$ zu einem guten Streaming-Algorithmus mit niedrigen Speicheraufwand von $O(p)$.

  Für beide Filter-Algorithmen können die Filter-Koeffizienten für ein fixes $p$ vorberechnet werden, was den Speicheraufwand bei vielen Generierungen vernachlässigbar macht. 

  Unabhängig von der Laufzeit, eignet sich der AR-Filter mit kleinem $p$ besonders gut dafür längere Signale zu generieren. 

  
  //   - Phasenrandomisierung sehr langsam
  //   - Timmer-Koenig-Algorithmus sehr schnell
  //   - Wie zu erwarten sind die beiden Fraktionale Differenzierung Methoden ähnlich
  // - Komplexitätsklassen
  //   - Timmer-Koenig-Algorithmus $O(n log(n))$ wegen Fourier-Transformation
  //   - Phasenrandomisierung ist $O(n^2)$ wegen $n$ Summen über $n/2$ Frequenzen
  //   - Fraktionale Differenzierungsmethoden sind in $O(n log(n) + p)$ und $O(n dot p)$
  // - Phasenrandomisierung, Timmer-Koenig-Algorithmus und der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich nur für die Generierung von langen Rauschsignalen
  // - Der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich kann für Echtzeitgenerierung verwendet werden
  //   - Es werden nur wenige alte Werte für einen neuen Wert benötigt. Die Koeffizientenfolge kann einmal vorberechnet werden.
  // 
  // 

#heading(level: 2,numbering: none)[Qualität des erzeugten Rauschsignals]

  Alle Algorithmen erzeugen Rausch gemäß dem gewünschten PSD.
  Der Phasenrandomisierung-Algorithmus erzeugt ein periodisches Rauschsignal und hat als einziges ein "Perfektes" PSD aufgrund der Wahl der Amplitude.

  Entsprechend @Pfad und @AbbRauschartenPhasenrandomisierung sind in @CompDev die Pfade zu weißem, pinkem und braunen Rauschen dargestellt. Da die beiden Fraktionale Differenzierungsmethoden dasselbe Rauschen erzeugen, stimmen diese hier auch überein.

  Auffallend ist die Unbeschränktheit der Fraktionale-Differenzierung-Algorithmen, während der Phasenrandomisierung-Algorithmus per Konstruktion periodisch ist und der Timmer-Koenig-Algorithmus deutlich langsamer divergiert.
  Außerdem ist der Timmer-Koenig-Algorithmus der einzige, der sich mit Wahl von mehr Simulationsschritten komplett verändert.

  // - Güte der Rauschapproximationen
  //   - Nur Phasenrandomisierung trifft das Potenzgesetz für Rauschen punktgenau
  //   - Dafür große Varianz
