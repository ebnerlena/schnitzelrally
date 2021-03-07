# SchnitzelRally
## MMP2a Anna Seidl und Lena Ebner

## Description

Schnitzelrally is an app with which you can create and plan a scavenger hunt alias Schnitzeljagd together with others online and then carry it out in the real wilderness.
Everyone who participates in the same route can create tasks and place them on the map and so link them to the real space with GPS coordinates.
Tasks can be multiple-choice questions, a task formulated in text for the whole team, a quiz question or photo upload.
Similar to geocaching but wilder!

## User Testing Notes
input field max length und word break
game_tasks über path visting - should redirect to home
hint - auf map finden :)
User foreign key error...
start geht nur bei allen wenn auf map oder tasks (nicht wenn man noch aufgabe erstellt)


## Improvements
- Usability and Style (more elegant)
- other paths den HAPPY Paths (handle form errors, fix request)
- validations0
- fix game flow - improve state machines (websockets and map)
- tests
- Result Page
- Imprint and About Page maybe

## Features
-  Auswertung der Route am Ende
-  Multiple Choice und True/False Aufgabenformat Eingabe "professioneller" intuitiver machen
-  Routen Name teilen oder irgendwie sichtbar machen für andere
- Start kann erst gedrückt werden wenn alle Teilnehmer sich für bereit gemeldet haben

## Done
- fix game flow - improve state machines (websockets and map)
- Usability and Style (more elegant)
- input fields max length
- Start kann erst gedrückt werden wenn alle Teilnehmer sich für bereit gemeldet haben

## User testing Full Stack
- everyone gets the same task or another?
- disadvantaged if randomized - a lot to travel

- forget password not working
- click on the map
- creator of route wants to see participants
- go back to route if visiting other pages

- photo upload verification by route creator
- see all tasks
- task completion overview of each player