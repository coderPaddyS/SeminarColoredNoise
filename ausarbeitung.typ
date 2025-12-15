#import "ieee-template.typ": ieee
#import "/00_definitions.typ": *

#let appendix = [
  #include "appendix.typ"
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
  // appendix: appendix
)

#include "01_einleitung.typ"
#include "02_modell.typ"
#include "03_arten.typ"
#include "04_algorithmen.typ"
#include "05_vergleich.typ"

= Zusammenfassung
Rauschen kann als Überlagerung überabzählbar vieler harmonischer Schwingungen betrachtet werden und wird mathematisch als stochastischer Prozess, oftmals eine Brownsche Bewegung, modelliert.
Anhand der Spektraleleistungsdichte kann Rauschen in verschiedene Kategorien unterteilt werden.
Weißes, Pinkes und Braunes Rauschen folgen einem Potenzgesetz und können auf verschiedene Arten sowohl im Zeit- als auch im Frequenz-Bereich generiert werden.

Sowohl der Algorithmus von Timmer-Koenig als auch der FIR-Filter Algorithmus eignen sich gut für die Generierung von längenren Rauschsignalen auf einmal.
Lediglich der approximative AR-Filter Algorithmus eignet sich Streaming-Algorithmus, um Rauschen in Echtzeit zu generieren.
Der Phasenrandomisierung-Algorithmus eignet sich bei der Notwendigkeit für ein PSD das dem Potenzgesetz exakt folgt und ist auch am Einfachsten zu implementieren.


#topfull[
  #subfigure(columns: 4,
      caption: [Integral der verschiedenen generierten Rauschsignalen. Ganz links der Vergleich aller Algorithmen, in den restlichen Spalten mehrere Iterationen des selben Algorithmus],
      figure(caption: [weißes Rauschen], image("plots/1000/deviation/combined/sum-0.svg")),
      figure(caption: [Timmer-Koenig],image("plots/1000/deviation/single-repeated/Timmer-Koenig-0.svg")),
      figure(caption: [Phasenrandomisierung],image("plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-0.svg")),
      figure(caption: [Fraktionale Differenzierung],image("plots/1000/deviation/single-repeated/FracDiffTime-0.svg")),
      figure(caption: [pinkes Rauschen], image("plots/1000/deviation/combined/sum-1.svg")),
      figure(caption: [Timmer-Koenig],image("plots/1000/deviation/single-repeated/Timmer-Koenig-1.svg")),
      figure(caption: [Phasenrandomisierung],image("plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-1.svg")),
      figure(caption: [Fraktionale Differenzierung],image("plots/1000/deviation/single-repeated/FracDiffTime-1.svg")),
      figure(caption: [braunes Rauschen], image("plots/1000/deviation/combined/sum-2.svg")),
      figure(caption: [Timmer-Koenig],image("plots/1000/deviation/single-repeated/Timmer-Koenig-2.svg")),
      figure(caption: [Phasenrandomisierung],image("plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-2.svg")),
      figure(caption: [Fraktionale Differenzierung],image("plots/1000/deviation/single-repeated/FracDiffTime-2.svg")),
      label: <CompDev>
  )
]
  // - Rauschen als eigentlich Überlagerte harmonische Schwingung wird als stochastischer Prozess, oftmals als Brownsche Bewegung modelliert.
  // - Anhand der Spektralenleistungsdichte kann Rauschen in verschiedene Kategorien unterteilt werden.
  // - Weißes, Pinkes und Braunes Rauschen kann auf verschiedene Arten sowohl im Zeit- als auch im Frequenz-Bereich generiert werden
  // - Dabei ist der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich am Besten für Echtzeitgenerierung geeignet
  // - Sowohl der Timmer-Koenig-Algorithmus als auch der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich für die Generierung von längeren Rauschsignalen.
  // - Der Algorithmus nach Done @done1992x eignet sich aufgrund des exakten PSD für präzise Analysen
  // - Dieser ist auch am Einfachsten zu implementieren und zu verstehen
