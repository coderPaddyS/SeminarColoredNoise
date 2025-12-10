#import "ieee-template.typ": ieee

#let appendix = [
  // #include "appendix.typ"
]

#show: ieee.with(
  title: [
    Generierung von Samples von farbigem Rauschen – Methoden, Implementierung und Vergleich],
  seminar: [Seminar WS25/26: Moderne Methoden der Informationsverarbeitung],
  abstract: [
    #h(0.5em)Diese Ausarbeitung stellt verschiedene Rauscharten die dem Potenzgesetz $norm(1/f^alpha)$ genügen vor,
    reißt kurz die mathematischen Grundlagen und Modellierungen von Rauschen an und vergleicht verschiedene Methoden zur Generierung von Rauschen mit gewünschter spektraler Leistungsdichte.
  ],

  authors: (
    (
      name: "Patrick Schneider",
    ),
  ),
  bibliography: bibliography("refs.bib", full: true),
  figure-supplement: [Abbildung],
  paper-size: "a4",
  appendix: appendix
)

#include "01_einleitung.typ"
#include "02_modell.typ"
// #include "03_arten.typ"
// #include "04_algorithmen.typ"
// #include "05_vergleich.typ"

// = Zusammenfasung/Ausblick
//   - Rauschen als eigentlich Überlagerte harmonische Schwingung wird als stochastischer Prozess, oftmals als Brownsche Bewegung modelliert.
//   - Anhand der Spektralenleistungsdichte kann Rauschen in verschiedene Kategorien unterteilt werden.
//   - Weißes, Pinkes und Braunes Rauschen kann auf verschiedene Arten sowohl im Zeit- als auch im Frequenz-Bereich generiert werden
//   - Dabei ist der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich am Besten für Echtzeitgenerierung geeignet
//   - Sowohl der Timmer-Koenig-Algorithmus als auch der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich für die Generierung von längeren Rauschsignalen.
//   - Der Algorithmus nach Done @done1992x eignet sich aufgrund des exakten PSD für präzise Analysen
//   - Dieser ist auch am Einfachsten zu implementieren und zu verstehen
