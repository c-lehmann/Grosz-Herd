# Groszherd Button-Generator

## Was gibt es zu beachten?

Ein Button hat eine Auflösung von 1535*1535 bei ~600 <acronym lang="en" title="dots per inch">dpi</acronym>. Dadurch hat der Button einen Durchmesser von ~65 <acronym title="Millimeter">mm</acronym>.
      
Beim Drucken sollte man auf die Druckeinstellungen achten! Die Größe des Bildes muss auf «Originalgröße» oder auf «100%» oder etwas anderes relevantes gestellt werden, je nach Druckertreiber oder Programm.

## Install 

```
$ bundle install
```

## Usage

Ganzen Bogen erstellen mit z.B. 2020 als Jahr:

```
$ ruby run.rb 2020 > buttons.png
```

Einzelnen Button erstellen mit z.B. 2020 als Jahr:


```
$ ruby run.rb 2020 button > button.png
```

### Docker

Aus als Docker-Image ist der Generator verfügbar

```
$ docker run --rm grunwalski/grosz_herd_buttons 2020 > buttons.png

# oder
$ docker run --rm grunwalski/grosz_herd_buttons 2020 button > button.png
```