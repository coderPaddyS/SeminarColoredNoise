#import "ieee-template.typ": ieee

#show: ieee.with(
  title: [
    Generierung von Samples von farbigem Rauschen – Methoden, Implementierung und Vergleich],
  abstract: [

  ],
  authors: (
    (
      name: "Patrick Schneider",
    ),
    (
      name: "Markus Walker",
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Figur.],
  paper-size: "a4"
)

= Einleitung
  - Was ist Rauschen?
  - Wofür wird Rauschen benötigt?
  - Was ist farbiges Rauschen?
= Mathematische Beschreibung
  - Stochastischer Prozess
  - Autokorrelationsfunktion
  - Power-Density Spectrum
= Rauscharten
  - Weißes Rauschen
  - Braunes Rauschen
  - Pinkes Rauschen
= Rauschberechnungsmöglichkeiten
  - Phasenrandomisierung (Timmer95, Eq. 1)
  - Power Law Spectrum (Algorithmus von Timmer95)
  - Fraktionale Brownsche Bewegung (Kasdin, V)?
  - Fraktionale Differenzierung (Kasdin, VI)
= Vergleich
  - Geschwindigkeit
  - Schwere der Implementierung
  - Güte der Rauschapproximationen
    - Wie gut ist die Approximation im Spektrum?
= Zusammenfasung/Ausblick
  - 1 - 2 Sätze pro Abschnitt
  - Empfehlung je nach Anwendungsfall
    - Echtzeitgenerierung: Stand jetzt bin ich bei Timmer95
    - Approximationsgüte: Einer von Kasdin, bin ich gerade nicht sicher welcher
    - Einfachheit: Phasenrandomisierung oder Timmer95, tendiere aber zu Phasenrandomisierung
