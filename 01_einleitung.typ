= Einleitung
Als Rauschen werden Signale bezeichnet, deren Verhalten nicht durch systematische Sachverhalte beschrieben werden können oder die aufgrund der Komplexität der Erzeugersysteme nicht vorhersehbar sind.
Rauschen tritt häufig in natürlichen Beobachtungen auf, z.$thin$B. klassisches Meeresrauschen -- Schall einer brechenden Welle -- oder die anliegende Spannung an einem offenen Ende eines Leiters.
Solche Erzeugersysteme haben eine hohe Entropie und damit viele Informationen, im vorherigen Beispiel die Bewegungen, Phasen, etc. aller Elementarleiter in einem Leiter.
Aufgrund der hohen Entropie erschweren Rauschsignale die Beobachtung und Messung der gewünschten Signale.
Um an das gewünschte Signal zu kommen, muss das Rauschen erkannt und entfernt werden.
Dieses Erkennungsproblem tritt in verschiedenen Anwendungsgebieten auf, so z.$thin$B. in der Aufnahme und Verarbeitung von Audiosignalen @prasadh2017efficiency oder auch medizinische Bildaufnahmen wie MRT und Ultraschall @yousuf2011new.
Aufgrund dem zufälligen Verhalten von Rauschen werden zur systematischen Erkennung Merkmale benötigt. Diese werden durch mathematische Beschreibung gefunden, ermöglichen eine Klassifizierung und auch Verfahren um Rauschsignale zu synthetisieren.

Im Abschnitt II werden zunächst die mathematischen Grundlagen zur Beschreibung von Rauschsignalen sowie verwendete Notation nahegelegt. Abschnitt III stellt drei Klassen an Rauschsignalen aufgrund der Spektralenleistungsdichte $norm(1/f^alpha)$ vor und Abschnitt IV stellt Generierungsmethoden von @done1992x, @timmer1995generating und @kasdin1995discrete vor. Diese werden dann im Abschnitt V verglichen.

  // - Rauschen beschreibt zufällige Signale
  // - d.h. Beobachtungen die zufällig wirken, nicht berechenbar sind
  // - Tritt natürlich auf, z.B. Schall einer (Meeres-)Welle, Spannungsschwankungen in einem Leiter
  // - Oftmals eine Beschreibung großer und komplizierter Systeme mit vielen Unbekannten
  // - Repräsentieren einen Zustand hoher Entropie und vieler Informationen
  // - Rauschen ist zumeist unerwünscht und lenkt vom gewünschten Ergebnis ab
  //   - Z.b. Audioaufnahmen @prasadh2017efficiency, Medizinische Bildaufnahmen wie MRT und Ultraschall @yousuf2011new
  // - Um Rauschen zu erkennen muss man Rauschen verstehen
  // - Damit auch eine Klassifizierung/Differenzierung von Rauscharten
  // - Und Möglichkeiten Rausch selbst zu generieren
  // - Diese Ausarbeitung über die Arbeiten von Timmer und Koenig @timmer1995generating sowie Kasdin @kasdin1995discrete aus 1995 geht auf die unterschiedlichen Rauschfarben anhand des $1/f^alpha$ Potenzgesetzes ein und vergleicht vorgestellte Methoden zur Generierung von farbigem Rauschen.
