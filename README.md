# rom-2

# HalloweenSpill

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


to run :
npm install 
npm run dev