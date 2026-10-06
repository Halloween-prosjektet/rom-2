# rom-2

# HalloweenSpill

pov: On top, som pokemon spill 

Idee 

   [ StartScene ]
      │
      ├── Passcode Correct? ── No ──► [ Show Error / Retry ]
      │
     Yes
      ▼
[ MainGameScene ] ──► Player interacts with hallway & solves riddle
      │
      ▼
[ Touches Stairs ]
      │
      ├── Riddle Solved? ── No ──► [ Display: "The door down is locked!" ]
      │
     Yes
      ▼
[ Disable Player Controls ]
      │
      ▼
[ Play Fade/Movement Tweens ]
      │
      ▼
[ Transition to Next Level ]

story: 
At du kommer til etasjen, du går bot dil trappa, finner ut at den er låst.

Oppgaven din er å finne hints gjennom mappet for å få koden til trappa.
eller 
du går rundt for å jage spøkelser som gir deg hints. 
eller
som doors lvl 50 hvor du går rundt mappet å finne bostaver/symboler for passordet. 


når du går gjennom trappa så starter lyset å flickere/bli mørkere. 

to run :
npm install 
npm run dev