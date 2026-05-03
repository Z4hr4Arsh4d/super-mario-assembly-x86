INCLUDE Irvine32.inc

; --------------- CONSTANTS -----------------
STATE_TITLE        EQU 0
STATE_MENU         EQU 1
STATE_GAME         EQU 2
STATE_PAUSE        EQU 3
STATE_INSTRUCTIONS EQU 4
STATE_EXIT         EQU 5

HUD_ROW            EQU 0
GROUND_ROW         EQU 29
MAX_SCORES         EQU 10
EXTERN PlaySoundA : PROTO :DWORD, :DWORD, :DWORD

; --------------- DATA ----------------------
.data

titleMain1  BYTE "|||||||  ||  ||  ||||||  ||||||| ||||||||    |||    |||  |||||  ||||||  ||  ||||||  ",0
titleMain2  BYTE "||       ||  ||  ||  ||  ||      ||    ||    ||||  |||| ||   || ||   || || ||    || ",0
titleMain3  BYTE "|||||||  ||  ||  ||||||  ||||||| ||||||||    || |||| || ||||||| ||||||  || ||    || ",0
titleMain4  BYTE "     ||  ||  ||  ||      ||      ||   ||     ||  ||  || ||   || ||   || || ||    || ",0
titleMain5  BYTE "|||||||  ||||||  ||      ||||||| ||   |||    ||      || ||   || ||   || ||   ||||   ",0

debugMarioX BYTE "MarioX = ",0
debugCam    BYTE "Camera = ",0

cloud1X     DWORD 30
cloud2X     DWORD 90
cloud3X     DWORD 150
cloudScroll DWORD 0

headerRank  BYTE "RANK",0
headerName  BYTE "NAME",0
headerScore BYTE "SCORE",0

; High Score Data Structure
topScores       DWORD MAX_SCORES DUP(0)
topNames        BYTE  MAX_SCORES*32 DUP(0)
scoreCount      DWORD 0
playerName      BYTE 32 DUP(0)
highScore       DWORD 0

cloudA1 BYTE "  .--.      ",0
cloudA2 BYTE " (    )     ",0
cloudA3 BYTE "(__.__)     ",0
cloudB1 BYTE "   .----.      ",0
cloudB2 BYTE " _(      )_    ",0
cloudB3 BYTE "(__________)   ",0
cloudC1 BYTE "   .------.      ",0
cloudC2 BYTE " _(        )_    ",0
cloudC3 BYTE "(____________)   ",0

;----------------TREES FOR LEVEL 1---------------------
treeTop1    BYTE "  /\  ",0
treeTop2    BYTE " /  \ ",0
treeTop3    BYTE "/____\",0
treeTrunk   BYTE "  ||  ",0

tree1X      DWORD 15
tree2X      DWORD 45
tree3X      DWORD 85
tree4X      DWORD 115
tree5X      DWORD 165
tree6X      DWORD 195


;----------------BIRDS FOR LEVEL 1---------------------
bird1X      DWORD 20
bird1Y      BYTE 6
bird1Dir    BYTE 1
bird1Frame  BYTE 0

bird2X      DWORD 70
bird2Y      BYTE 8
bird2Dir    BYTE 0
bird2Frame  BYTE 0

bird3X      DWORD 120
bird3Y      BYTE 5
bird3Dir    BYTE 1
bird3Frame  BYTE 0

bird4X      DWORD 180
bird4Y      BYTE 7
bird4Dir    BYTE 0
bird4Frame  BYTE 0

birdCounter DWORD 0

;----------------DECORATION---------------------
; Victory screen messages
victoryMsg1     BYTE "***** YOU WON! *****",0
victoryMsg2     BYTE "CONGRATULATIONS!",0
victoryMsg3     BYTE "THE MAZE IS CONQUERED!",0

; Fireworks ASCII art
firework1       BYTE "*\\ | //*",0
firework2       BYTE " *\\|//* ",0
firework3       BYTE "---|||---",0
firework4       BYTE " *//|\\* ",0
firework5       BYTE "*// | \\*",0

; Spaceship ASCII art for Level 2
ship1           BYTE "  /\  ",0
ship2           BYTE " |==| ",0
ship3           BYTE "/|  |\",0
ship4           BYTE " |  | ",0
ship5           BYTE " \||/ ",0

; Spaceship positions 
ship1X          DWORD 25
ship2X          DWORD 85
ship3X          DWORD 145
shipScroll      DWORD 0

; Super Jump Block
superJumpBlockX     DWORD 140
superJumpBlockY     BYTE 27
superJumpBlockW     DWORD 3
superJumpActive     BYTE 1
superJumpTimer      DWORD 0
normalJumpHeight    DWORD 3
superJumpHeight     DWORD 6
currentJumpHeight   DWORD 3


;------------------ENEMY DATA------------------
goombaX         DWORD 60
goombaY         BYTE 28
goombaActive    BYTE 1
goombaDir       BYTE 1          ; 1 = right, 0 = left
goombaMinX      DWORD 60
goombaMaxX      DWORD 80
goombaCounter   DWORD 0         ; For automatic movement
hitTimer        DWORD 0 


;-----------------sounds------------------
coinSound BYTE "coin.wav",0
bgMusic         BYTE "bgmusic.wav", 0
jumpSound       BYTE "jump.wav", 0
deathSound      BYTE "death.wav", 0
hitSound        BYTE "ohno.wav", 0
winSound        BYTE "win.wav", 0
powerSound      BYTE "power.wav", 0


bgMusicPlaying  BYTE 0
;------------------TEXT DATA------------------
titleRoll       BYTE "Roll No: 24I-0630",0
titlePress      BYTE "Press ENTER to open Menu",0

menuTitle       BYTE "MAIN MENU",0
menuOpt1        BYTE "1 - PLAY GAME",0
menuOpt2        BYTE "2 - HIGH SCORES",0
menuOpt3        BYTE "3 - INSTRUCTIONS",0
menuOpt4        BYTE "4 - EXIT",0

titleHighLabel  BYTE "HIGH SCORE:",0

levelEndFlag    BYTE 0

instrLine1      BYTE "INSTRUCTIONS:",0
instrLine2      BYTE "Use A / D to move left / right.",0
instrLine3      BYTE "Press W to jump.",0
instrLine4      BYTE "Press P to pause during game.",0
instrLine5      BYTE "Press X to return to Menu.",0
instrBack       BYTE "Press B to go back to Menu.",0

levelStartMsg   BYTE "LEVEL 1 STARTED - PRESS ANY KEY",0
levelEndMsg     BYTE "LEVEL 1 COMPLETED! PRESS ANY KEY",0


pauseTitle      BYTE "GAME PAUSED",0
pauseOpt1       BYTE "R - Resume",0
pauseOpt2       BYTE "Q - Quit to Menu",0

hsTitle         BYTE "HIGH SCORES",0
hsLine1         BYTE "No high scores yet.",0
hsBack          BYTE "Press B to go back to Menu.",0
exitMsg         BYTE "Exiting... Bye!",0

hudMarioLabel   BYTE "MARIO",0
hudScoreLabel   BYTE "SCORE:",0
hudCoinLabel    BYTE "COINS:",0
hudWorldLabel   BYTE "WORLD:",0
hudTimeLabel    BYTE "TIME:",0
hudLivesLabel   BYTE "LIVES:",0

ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
highFileBuf BYTE 512 DUP(0)    
currentState    BYTE ?
inputChar       BYTE ?
score           DWORD 0
coins           DWORD 0
lives           DWORD 5
worldNum        DWORD 1
levelNum        DWORD 1
timeLeft        DWORD 400
xPos            BYTE 20
yPos            BYTE 28
cameraPos       DWORD 0
marioWorldX     DWORD 0
levelLength     DWORD 250

marioVelY       DWORD 0

pipe1X DWORD 40
pipe2X DWORD 80
pipe3X DWORD 135
pipe4X DWORD 175
flagPoleX DWORD 200

highscoreFile     BYTE "highscores.txt",0
lineBuffer        BYTE 128 DUP(0)


mushroomX      DWORD 130
mushroomY      BYTE 28
mushroomActive BYTE 1

invincibleActive BYTE 0
invincibleTimer  DWORD 0

platform1Width DWORD 10
platform2Width DWORD 10
platform3Width DWORD 10
platform4Width DWORD 11
platform5Width DWORD 11

platform1X DWORD 45
platform1Y BYTE 21

platform2X DWORD 100
platform2Y BYTE 24

platform3X DWORD 70
platform3Y BYTE 22

platform4X DWORD 120
platform4Y BYTE 24

platform5X DWORD 150
platform5Y BYTE 23


platform6X DWORD 150
platform6Y BYTE 20
platform6Width DWORD 8

platform7X DWORD 175
platform7Y BYTE 23
platform7Width DWORD 10

platform8X DWORD 30
platform8Y BYTE 23
platform8Width DWORD 15


goombaL1_2X     DWORD 140
goombaL1_2Y     BYTE 28
goombaL1_2Active BYTE 1
goombaL1_2Dir   BYTE 0
goombaL1_2MinX  DWORD 135
goombaL1_2MaxX  DWORD 155
goombaL1_2Counter DWORD 0

isJumping BYTE 0

plat1CoinCount dd 4
plat1CoinX DWORD 4 DUP(?)
plat1CoinY BYTE 4 DUP(?)
plat1CoinActive BYTE 4 DUP(?)


plat2CoinX DWORD 7 DUP(?)
plat2CoinY BYTE 7 DUP(?)
plat2CoinActive BYTE 7 DUP(?)

plat3CoinX DWORD 7 DUP(?)
plat3CoinY BYTE 7 DUP(?)
plat3CoinActive BYTE 7 DUP(?)

plat4CoinX DWORD 10 DUP(?)
plat4CoinY BYTE 10 DUP(?)
plat4CoinActive BYTE 10 DUP(?)

plat5CoinX DWORD 9 DUP(?)
plat5CoinY BYTE 9 DUP(?)
plat5CoinActive BYTE 9 DUP(?)


plat6CoinX DWORD 8 DUP(?)
plat6CoinY BYTE 8 DUP(?)
plat6CoinActive BYTE 8 DUP(?)

plat7CoinX DWORD 10 DUP(?)
plat7CoinY BYTE 10 DUP(?)
plat7CoinActive BYTE 10 DUP(?)

plat8CoinX DWORD 8 DUP(?)
plat8CoinY BYTE 8 DUP(?)
plat8CoinActive BYTE 8 DUP(?)

namePrompt      BYTE "Enter your name (max 31 chars): ",0
savedHighScore  DWORD 0
savedLevel      DWORD 0

; Text buffers for file I/O
scoreBuffer     BYTE 12 DUP(0)
tempBuffer      BYTE 256 DUP(0)



;-----------------------Level 2 declarations-----------------------

level2Msg       BYTE "LEVEL 2 - THE DARK MAZE - PRESS ANY KEY",0
level2EndMsg    BYTE "YOU ESCAPED THE MAZE!",0
gameOverMsg     BYTE "GAME OVER",0

; Level 2 enemies (3 Goombas, 2 Koopas, 2 Piranhas)
goomba1X        DWORD 80
goomba1Y        BYTE 28
goomba1Active   BYTE 0
goomba1Dir      BYTE 1
goomba1Counter  DWORD 0

goomba2X        DWORD 150
goomba2Y        BYTE 28
goomba2Active   BYTE 0
goomba2Dir      BYTE 0
goomba2Counter  DWORD 0

goomba3X        DWORD 200
goomba3Y        BYTE 28
goomba3Active   BYTE 0
goomba3Dir      BYTE 1
goomba3Counter  DWORD 0

koopa1X         DWORD 100
koopa1Y         BYTE 28
koopa1Active    BYTE 0
koopa1Dir       BYTE 1
koopa1IsShell   BYTE 0
koopa1Counter   DWORD 0

koopa2X         DWORD 180
koopa2Y         BYTE 28
koopa2Active    BYTE 0
koopa2Dir       BYTE 0
koopa2IsShell   BYTE 0
koopa2Counter   DWORD 0

piranha1X       DWORD 120
piranha1Active  BYTE 0
piranha1Out     BYTE 0
piranha1Timer   DWORD 0

piranha2X       DWORD 200
piranha2Active  BYTE 0
piranha2Out     BYTE 0
piranha2Timer   DWORD 0

; Level 2 maze platforms (7 platforms creating maze)
level2Platform1X DWORD 30
level2Platform1Y BYTE 26
level2Platform1W DWORD 15

level2Platform2X DWORD 60
level2Platform2Y BYTE 22
level2Platform2W DWORD 12

level2Platform3X DWORD 90
level2Platform3Y BYTE 18
level2Platform3W DWORD 10

level2Platform4X DWORD 120
level2Platform4Y BYTE 24
level2Platform4W DWORD 14

level2Platform5X DWORD 150
level2Platform5Y BYTE 20
level2Platform5W DWORD 10

level2Platform6X DWORD 180
level2Platform6Y BYTE 23
level2Platform6W DWORD 12

level2Platform7X DWORD 210
level2Platform7Y BYTE 19
level2Platform7W DWORD 15

level2MushroomX DWORD 95
level2FlagPoleX DWORD 240




;------------------------secret room declarations------------------------
; Secret Room Data
inSecretRoom    BYTE 0
secretRoomMsg   BYTE ">>> SECRET ROOM <<<",0
secretRoomMsg2  BYTE "Collect coins and extra lives!",0
secretExitMsg   BYTE "Returning to Level 2...",0

savedMarioX     DWORD 0
savedCameraPos  DWORD 0

secretPlatformX DWORD 5
secretPlatformY BYTE 26
secretPlatformW DWORD 65

secretCoinX     DWORD 8, 14, 20, 26, 32, 38, 44, 50, 56, 62
secretCoinY     BYTE 25, 25, 25, 25, 25, 25, 25, 25, 25, 25
secretCoinActive BYTE 10 DUP(1)


secretLifeX     DWORD 18, 35, 52
secretLifeY     BYTE 25, 25, 25
secretLifeActive BYTE 3 DUP(1)


triggerCoinX    DWORD 232
triggerCoinY    BYTE 24
triggerCoinActive BYTE 1

secretExitX     DWORD 60
secretFlagX     DWORD 62

secretStar1     BYTE "*..*..*..*..*..*",0
secretStar2     BYTE "..*..*..*..*..*.",0
secretBorder    BYTE "################",0

.code

; ==============================================
; MAIN PROGRAM
; ==============================================
main PROC
    call InitGame
    call LoadAllHighScores      ; Load high scores at startup
    mov currentState, STATE_TITLE

MainLoop LABEL NEAR
    mov al, currentState
    cmp al, STATE_TITLE
    je  TitleState
    cmp al, STATE_MENU
    je  MenuState
    cmp al, STATE_GAME
    je  GameState
    cmp al, STATE_PAUSE
    je  PauseState
    cmp al, STATE_INSTRUCTIONS
    je  InstructionsState
    cmp al, STATE_EXIT
    je  ExitState
    jmp MainLoop

TitleState:
    call DrawTitleScreen
    mov currentState, STATE_MENU
    jmp MainLoop

MenuState:
    call DrawMenuScreen
MenuLoop:
    call ReadChar
    mov inputChar, al
    cmp inputChar, '1'
    je MenuStartGame
    cmp inputChar, '2'
    je MenuHighScores
    cmp inputChar, '3'
    je MenuInstructions
    cmp inputChar, '4'
    je MenuExit
    jmp MenuLoop

MenuStartGame:
    ; Clear playerName buffer
    mov ecx, 32
    mov edi, OFFSET playerName
    xor eax, eax
    rep stosb
   
    mov score, 0
    mov coins, 0
    mov lives, 5
    mov worldNum, 1
    mov levelNum, 1
    mov timeLeft, 400
   
    mov eax, platform1X
    add eax, 1
    mov plat1CoinX[0], eax
    add eax, 2
    mov plat1CoinX[4], eax
    add eax, 2
    mov plat1CoinX[8], eax
    add eax, 2
    mov plat1CoinX[12], eax
   
    mov al, platform1Y
    dec al
    mov plat1CoinY[0], al
    mov plat1CoinY[1], al
    mov plat1CoinY[2], al
    mov plat1CoinY[3], al
   
    mov plat1CoinActive[0], 1
    mov plat1CoinActive[1], 1
    mov plat1CoinActive[2], 1
    mov plat1CoinActive[3], 1
   

        ; ===== PLATFORM 2 COINS =====
    mov eax, platform2X
    add eax, 1
    mov plat2CoinX[0], eax
    add eax, 1
    mov plat2CoinX[4], eax
    add eax, 1
    mov plat2CoinX[8], eax
    add eax, 1
    mov plat2CoinX[12], eax
    add eax, 1
    mov plat2CoinX[16], eax
    add eax, 1
    mov plat2CoinX[20], eax
    add eax, 1
    mov plat2CoinX[24], eax

    mov al, platform2Y
    dec al
    mov plat2CoinY[0], al
    mov plat2CoinY[1], al
    mov plat2CoinY[2], al
    mov plat2CoinY[3], al
    mov plat2CoinY[4], al
    mov plat2CoinY[5], al
    mov plat2CoinY[6], al

    mov plat2CoinActive[0], 1
    mov plat2CoinActive[1], 1
    mov plat2CoinActive[2], 1
    mov plat2CoinActive[3], 1
    mov plat2CoinActive[4], 1
    mov plat2CoinActive[5], 1
    mov plat2CoinActive[6], 1

        ; ===== PLATFORM 3 COINS =====
    mov eax, platform3X
    add eax, 1
    mov plat3CoinX[0], eax
    add eax, 1
    mov plat3CoinX[4], eax
    add eax, 1
    mov plat3CoinX[8], eax
    add eax, 1
    mov plat3CoinX[12], eax
    add eax, 1
    mov plat3CoinX[16], eax
    add eax, 1
    mov plat3CoinX[20], eax
    add eax, 1
    mov plat3CoinX[24], eax

    mov al, platform3Y
    dec al
    mov plat3CoinY[0], al
    mov plat3CoinY[1], al
    mov plat3CoinY[2], al
    mov plat3CoinY[3], al
    mov plat3CoinY[4], al
    mov plat3CoinY[5], al
    mov plat3CoinY[6], al

    mov plat3CoinActive[0], 1
    mov plat3CoinActive[1], 1
    mov plat3CoinActive[2], 1
    mov plat3CoinActive[3], 1
    mov plat3CoinActive[4], 1
    mov plat3CoinActive[5], 1
    mov plat3CoinActive[6], 1

        ; ===== PLATFORM 4 COINS =====
    mov eax, platform4X
    add eax, 1
    mov plat4CoinX[0], eax
    add eax, 1
    mov plat4CoinX[4], eax
    add eax, 1
    mov plat4CoinX[8], eax
    add eax, 1
    mov plat4CoinX[12], eax
    add eax, 1
    mov plat4CoinX[16], eax
    add eax, 1
    mov plat4CoinX[20], eax
    add eax, 1
    mov plat4CoinX[24], eax
    add eax, 1
    mov plat4CoinX[28], eax
    add eax, 1
    mov plat4CoinX[32], eax
    add eax, 1
    mov plat4CoinX[36], eax

    mov al, platform4Y
    dec al
    mov plat4CoinY[0], al
    mov plat4CoinY[1], al
    mov plat4CoinY[2], al
    mov plat4CoinY[3], al
    mov plat4CoinY[4], al
    mov plat4CoinY[5], al
    mov plat4CoinY[6], al
    mov plat4CoinY[7], al
    mov plat4CoinY[8], al
    mov plat4CoinY[9], al

    mov ecx, 10
    mov edi, OFFSET plat4CoinActive
initP4Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initP4Loop

        ; ===== PLATFORM 5 COINS =====
    mov eax, platform5X
    add eax, 1
    mov plat5CoinX[0], eax
    add eax, 1
    mov plat5CoinX[4], eax
    add eax, 1
    mov plat5CoinX[8], eax
    add eax, 1
    mov plat5CoinX[12], eax
    add eax, 1
    mov plat5CoinX[16], eax
    add eax, 1
    mov plat5CoinX[20], eax
    add eax, 1
    mov plat5CoinX[24], eax
    add eax, 1
    mov plat5CoinX[28], eax
    add eax, 1
    mov plat5CoinX[32], eax

    mov al, platform5Y
    dec al
    mov plat5CoinY[0], al
    mov plat5CoinY[1], al
    mov plat5CoinY[2], al
    mov plat5CoinY[3], al
    mov plat5CoinY[4], al
    mov plat5CoinY[5], al
    mov plat5CoinY[6], al
    mov plat5CoinY[7], al
    mov plat5CoinY[8], al

    mov ecx, 9
    mov edi, OFFSET plat5CoinActive
initP5Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initP5Loop


    ; ===== PLATFORM 6 COINS =====
    mov eax, platform6X
    add eax, 1
    mov plat6CoinX[0], eax
    add eax, 1
    mov plat6CoinX[4], eax
    add eax, 1
    mov plat6CoinX[8], eax
    add eax, 1
    mov plat6CoinX[12], eax
    add eax, 1
    mov plat6CoinX[16], eax
    add eax, 1
    mov plat6CoinX[20], eax
    add eax, 1
    mov plat6CoinX[24], eax
    add eax, 1
    mov plat6CoinX[28], eax

    mov al, platform6Y
    dec al
    mov plat6CoinY[0], al
    mov plat6CoinY[1], al
    mov plat6CoinY[2], al
    mov plat6CoinY[3], al
    mov plat6CoinY[4], al
    mov plat6CoinY[5], al
    mov plat6CoinY[6], al
    mov plat6CoinY[7], al

    mov ecx, 8
    mov edi, OFFSET plat6CoinActive
initP6Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initP6Loop

    ; ===== PLATFORM 7 COINS =====
    mov eax, platform7X
    add eax, 1
    mov plat7CoinX[0], eax
    add eax, 1
    mov plat7CoinX[4], eax
    add eax, 1
    mov plat7CoinX[8], eax
    add eax, 1
    mov plat7CoinX[12], eax
    add eax, 1
    mov plat7CoinX[16], eax
    add eax, 1
    mov plat7CoinX[20], eax
    add eax, 1
    mov plat7CoinX[24], eax
    add eax, 1
    mov plat7CoinX[28], eax
    add eax, 1
    mov plat7CoinX[32], eax
    add eax, 1
    mov plat7CoinX[36], eax

    mov al, platform7Y
    dec al
    mov plat7CoinY[0], al
    mov plat7CoinY[1], al
    mov plat7CoinY[2], al
    mov plat7CoinY[3], al
    mov plat7CoinY[4], al
    mov plat7CoinY[5], al
    mov plat7CoinY[6], al
    mov plat7CoinY[7], al
    mov plat7CoinY[8], al
    mov plat7CoinY[9], al

    mov ecx, 10
    mov edi, OFFSET plat7CoinActive
initP7Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initP7Loop

    ; ===== PLATFORM 8 COINS =====
    mov eax, platform8X
    add eax, 1
    mov plat8CoinX[0], eax
    add eax, 1
    mov plat8CoinX[4], eax
    add eax, 1
    mov plat8CoinX[8], eax
    add eax, 1
    mov plat8CoinX[12], eax
    add eax, 1
    mov plat8CoinX[16], eax
    add eax, 1
    mov plat8CoinX[20], eax
    add eax, 1
    mov plat8CoinX[24], eax
    add eax, 1
    mov plat8CoinX[28], eax

    mov al, platform8Y
    dec al
    mov plat8CoinY[0], al
    mov plat8CoinY[1], al
    mov plat8CoinY[2], al
    mov plat8CoinY[3], al
    mov plat8CoinY[4], al
    mov plat8CoinY[5], al
    mov plat8CoinY[6], al
    mov plat8CoinY[7], al

    mov ecx, 8
    mov edi, OFFSET plat8CoinActive
initP8Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initP8Loop


    mov cameraPos, 0
    mov marioWorldX, 20
    mov xPos, 20
    mov yPos, 28
   
    mov mushroomActive, 1
    mov invincibleActive, 0
    mov invincibleTimer, 0
    ;----ENEMY INITIALIZATION----
    mov goombaX, 60
    mov goombaY, 28
    mov goombaActive, 1
    mov goombaDir, 1
    mov goombaCounter, 0
    mov hitTimer, 0
    call Clrscr
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET levelStartMsg
    call WriteString
    call ReadChar
    call PlayBGMusic
    mov currentState, STATE_GAME
    jmp MainLoop

MenuHighScores:
    call DisplayHighScoresScreen
    jmp MenuState

MenuInstructions:
    mov currentState, STATE_INSTRUCTIONS
    jmp MainLoop

MenuExit:
    mov currentState, STATE_EXIT
    jmp MainLoop

InstructionsState:
    call Clrscr
    call DrawInstructions
InstrLoop:
    call ReadChar
    mov inputChar, al
    cmp inputChar, 'b'
    je InstrBackToMenu
    cmp inputChar, 'B'
    je InstrBackToMenu
    jmp InstrLoop

InstrBackToMenu:
    mov currentState, STATE_MENU
    jmp MainLoop

GameState:
    mov levelEndFlag, 0
    call RedrawFrame

GameInputLoop:
    
    cmp levelEndFlag, 1
    je LevelCompleteFromGame

    ; Update enemies based on level
    mov eax, levelNum
    cmp eax, 2
    je GIL_level2Update
    
    ; Level 1 - update original goomba
    call UpdateGoomba
    call UpdateGoombaL1_2   
    call UpdateBirds    
    jmp GIL_afterUpdate
    
GIL_level2Update:
    call UpdateLevel2Enemies
    
GIL_afterUpdate:
    ; Check collisions based on level (BEFORE redraw for immediate response)
    mov eax, levelNum
    cmp eax, 2
    je GIL_level2Collision
    
    ; Level 1 collision
    call CheckGoombaCollision
    call checkGoombaL1_2Collision
    jmp GIL_afterCollision
    
GIL_level2Collision:
    ; Level 2 collisions
    call CheckLevel2Collisions
    
GIL_afterCollision:
    ; Redraw the frame
    call RedrawFrame

    mov eax, 50
    call Delay

    call ReadKey
    jz GameInputLoop        
    mov inputChar, al  

    cmp al, 'x'
    je GameToMenu
    cmp al, 'X'
    je GameToMenu
    cmp al, 'p'
    je GameToPause
    cmp al, 'P'
    je GameToPause
    cmp al, 'a'
    je MoveLeft
    cmp al, 'A'
    je MoveLeft
    cmp al, 'd'
    je MoveRight
    cmp al, 'D'
    je MoveRight
    cmp al, 'w'
    je MoveJump
    cmp al, 'W'
    je MoveJump
    jmp GameInputLoop

GameToMenu:
    call StopBGMusic
    mov currentState, STATE_MENU
    jmp MainLoop

GameToPause:
    mov currentState, STATE_PAUSE
    jmp MainLoop

MoveRight:
    mov eax, marioWorldX
    cmp eax, flagPoleX
    jge MR_noMove
   
    mov edx, eax
    inc edx
   
    mov al, yPos
    cmp al, GROUND_ROW-2
    jl MR_skipSolidRight
   
    ; Only check pipes in Level 1
    push eax
    mov eax, levelNum
    cmp eax, 2
    pop eax
    je MR_skipSolidRight      ; Skip pipe check in Level 2
    
    mov eax, edx
    cmp eax, pipe1X
    je MR_noMove
    cmp eax, pipe2X
    je MR_noMove
    cmp eax, pipe3X     
    je MR_noMove        
    cmp eax, pipe4X      
    je MR_noMove       

MR_skipSolidRight:
    mov marioWorldX, edx
    mov eax, marioWorldX
    mov edx, eax
    sub edx, cameraPos
    cmp edx, 35
    jle MR_noCam
   
    mov ebx, cameraPos
    inc ebx
    cmp ebx, levelLength
    jge MR_noCam
   
    mov cameraPos, ebx
    mov eax, cloudScroll
    inc eax
    mov cloudScroll, eax

    mov eax, shipScroll
    inc eax
    mov shipScroll, eax

MR_noCam:
MR_noMove:
    call RedrawFrame
    jmp GameInputLoop

MoveLeft:
    mov eax, marioWorldX
    cmp eax, 0
    jle ML_noMove
   
    mov edx, eax
    dec edx
   
    mov al, yPos
    cmp al, GROUND_ROW-2
    jl ML_skipSolidLeft
   
    push eax
    mov eax, levelNum
    cmp eax, 2
    pop eax
    je ML_skipSolidLeft     
    
    mov eax, edx
    cmp eax, pipe1X
    je ML_noMove
    cmp eax, pipe2X
    je ML_noMove
    cmp eax, pipe3X   
    je MR_noMove      
    cmp eax, pipe4X     
    je MR_noMove     

ML_skipSolidLeft:
    mov marioWorldX, edx
    mov eax, marioWorldX
    mov edx, eax
    sub edx, cameraPos
    cmp edx, 12
    jge ML_noCam
   
    cmp cameraPos, 0
    jle ML_noCam
   
    dec cameraPos
    mov eax, cloudScroll
    dec eax
    mov cloudScroll, eax
    mov eax, shipScroll
    dec eax
    mov shipScroll, eax

ML_noCam:
ML_noMove:
    call RedrawFrame
    jmp GameInputLoop


MoveJump:
    cmp isJumping, 1
    je GameInputLoop        
    
    call PlayJumpSound
    mov isJumping, 1
    mov ecx, 3            

JumpUpLoop:
    push ecx
    call CheckAirInput
    pop ecx
    
    mov al, yPos
    cmp al, 18             
    jbe JumpUpDone
   
    dec yPos
    call RedrawFrame
    mov eax, 30
    call Delay
    loop JumpUpLoop

JumpUpDone:
FallDownLoop:
    call CheckAirInput
    
    mov al, yPos
    cmp al, GROUND_ROW - 1
    jae EndJump           
   
    cmp inSecretRoom, 1
    je FDL_secretPlatform
    
    call CheckPlatforms
    cmp eax, 1
    je EndJump
    jmp FDL_fall
    
FDL_secretPlatform:
    call CheckSecretPlatform
    cmp eax, 1
    je EndJump
    
FDL_fall:
    inc yPos
    call RedrawFrame
    mov eax, 25
    call Delay
    jmp FallDownLoop

EndJump:
    mov isJumping, 0
    call RedrawFrame
    jmp GameInputLoop

CheckAirInput PROC
    call ReadKey
    jz CAI_done
   
    cmp al, 'a'
    je AirLeft
    cmp al, 'A'
    je AirLeft
    cmp al, 'd'
    je AirRight
    cmp al, 'D'
    je AirRight

CAI_done:
    ret

AirLeft:
    mov eax, marioWorldX
    cmp eax, 0
    jle CAI_done
   
    dec eax
    mov marioWorldX, eax
    mov edx, eax
    sub edx, cameraPos
    cmp edx, 12
    jge CAI_done
   
    cmp cameraPos, 0
    jle CAI_done
   
    dec cameraPos
    ret

AirRight:
    mov eax, marioWorldX
    cmp eax, levelLength
    jge CAI_done
   
    inc eax
    mov marioWorldX, eax
    mov edx, eax
    sub edx, cameraPos
    cmp edx, 35
    jle CAI_done
   
    mov ebx, cameraPos
    inc ebx
    mov cameraPos, ebx
    ret
CheckAirInput ENDP

PauseState:
    call Clrscr
    call DrawPauseScreen

PauseLoop:
    call ReadChar
    mov inputChar, al
    cmp inputChar, 'r'
    je PauseResume
    cmp inputChar, 'R'
    je PauseResume
    cmp inputChar, 'q'
    je PauseQuit
    cmp inputChar, 'Q'
    je PauseQuit
    jmp PauseLoop

PauseResume:
    call PlayBGMusic
    mov currentState, STATE_GAME
    jmp MainLoop

PauseQuit:
    call StopBGMusic
    mov currentState, STATE_MENU
    jmp MainLoop

ExitState:
    call Clrscr
    mov dl, 20
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET exitMsg
    call WriteString
    call Crlf
    exit

main ENDP

; ==============================================
; HELPER PROCEDURES
; ==============================================

InitGame PROC
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    ret
InitGame ENDP

DrawTitleScreen PROC
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 40
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET titleHighLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, highScore
    call WriteInt
   
    call DrawMarioLogo
    call DrawTitleGround
   
    mov dl, 40
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET titleRoll
    call WriteString
   
    mov dl, 37
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET titlePress
    call WriteString

WaitEnter:
    call ReadChar
    cmp al, 13
    jne WaitEnter
    ret
DrawTitleScreen ENDP

DrawMarioLogo PROC
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET titleMain1
    call WriteString
   
    mov dl, 5
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET titleMain2
    call WriteString
   
    mov dl, 5
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET titleMain3
    call WriteString
   
    mov dl, 5
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET titleMain4
    call WriteString
   
    mov dl, 5
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET titleMain5
    call WriteString
   
    ret
DrawMarioLogo ENDP

DrawTitleGround PROC
    mov eax, green + (black * 16)
    call SetTextColor
   
    mov dl, 0
    mov dh, 17
    call Gotoxy
    mov ecx, 100
   
GroundLoop:
    mov al, '-'
    call WriteChar
    loop GroundLoop
   
    mov dl, 0
    mov dh, 16
    call Gotoxy
    mov ecx, 100
   
QuestionLoop:
    mov al, '?'
    call WriteChar
    loop QuestionLoop
   
    mov eax, red + (black * 16)
    call SetTextColor
    mov ecx, 5
    mov dl, 1
    mov dh, 15
   
pipeloop:
    call Gotoxy
    mov al, '|'
    call WriteChar
    dec dh
    loop pipeloop
   
    mov ecx, 5
    mov dl, 2
    mov dh, 15
   
pipeloop2:
    call Gotoxy
    mov al, '|'
    call WriteChar
    dec dh
    loop pipeloop2
   
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 3
    mov dh, 15
    call Gotoxy
    mov al, 'M'
    call WriteChar
   
    ret
DrawTitleGround ENDP

DrawMenuScreen PROC
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 40
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET menuTitle
    call WriteString
   
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET menuOpt1
    call WriteString
   
    mov dl, 30
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET menuOpt2
    call WriteString
   
    mov dl, 30
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET menuOpt3
    call WriteString
   
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET menuOpt4
    call WriteString
   
    ret
DrawMenuScreen ENDP

DrawInstructions PROC
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET instrLine1
    call WriteString
   
    mov dl, 5
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET instrLine2
    call WriteString
   
    mov dl, 5
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET instrLine3
    call WriteString
   
    mov dl, 5
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET instrLine4
    call WriteString
   
    mov dl, 5
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET instrLine5
    call WriteString
   
    mov dl, 5
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET instrBack
    call WriteString
   
    ret
DrawInstructions ENDP

DrawPauseScreen PROC
    mov eax, yellow + (black * 16)
    call SetTextColor
    call Clrscr
   
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET pauseTitle
    call WriteString
   
    mov dl, 28
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET pauseOpt1
    call WriteString
   
    mov dl, 28
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET pauseOpt2
    call WriteString
   
    ret
DrawPauseScreen ENDP


; =====================================================
; DRAW VICTORY SCREEN WITH FIREWORKS
; =====================================================
DrawVictoryScreen PROC
    push eax
    push ebx
    push ecx
    push edx
    
    call Clrscr
    
    ; Draw black background with colored fireworks
    mov eax, black + (black * 16)
    call SetTextColor
    
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    mov dl, 10
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET firework1
    call WriteString
    mov dl, 10
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET firework2
    call WriteString
    mov dl, 10
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    mov dl, 10
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET firework4
    call WriteString
    mov dl, 10
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET firework5
    call WriteString
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET firework1
    call WriteString
    mov dl, 25
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET firework2
    call WriteString
    mov dl, 25
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    mov dl, 25
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET firework4
    call WriteString
    mov dl, 25
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET firework5
    call WriteString
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov dl, 50
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET firework1
    call WriteString
    mov dl, 50
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET firework2
    call WriteString
    mov dl, 50
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    mov dl, 50
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET firework4
    call WriteString
    mov dl, 50
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET firework5
    call WriteString


    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    
    mov dl, 65
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET firework1
    call WriteString
    mov dl, 65
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET firework2
    call WriteString
    mov dl, 65
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    mov dl, 65
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET firework4
    call WriteString
    mov dl, 65
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET firework5
    call WriteString
    
    ; Draw main victory message - YELLOW
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 30
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET victoryMsg1
    call WriteString
    
    ; Draw congratulations - WHITE
    mov eax, white + (black * 16)
    call SetTextColor
    
    mov dl, 32
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET victoryMsg2
    call WriteString
    
    ; Draw maze conquered - GREEN
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    
    mov dl, 28
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET victoryMsg3
    call WriteString
    
    ; Draw score
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 30
    mov dh, 19
    call Gotoxy
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
    
    ; Draw coins
    mov dl, 30
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET hudCoinLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, coins
    call WriteInt
    
    ; Draw bottom fireworks
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    mov dl, 20
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov dl, 55
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET firework3
    call WriteString
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawVictoryScreen ENDP



; =====================================================
; DRAW SPACESHIPS FOR LEVEL 2
; =====================================================
DrawSpaceships PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    ; Draw spaceship 1
    mov eax, ship1X
    sub eax, shipScroll
    cmp eax, 0
    jl DS_ship2
    cmp eax, 74
    jg DS_ship2
    
    mov dl, al
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET ship1
    call WriteString
    
    mov dl, al
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET ship2
    call WriteString
    
    mov dl, al
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET ship3
    call WriteString
    
DS_ship2:
    ; Draw spaceship 2
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    
    mov eax, ship2X
    sub eax, shipScroll
    cmp eax, 0
    jl DS_ship3
    cmp eax, 74
    jg DS_ship3
    
    mov dl, al
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET ship1
    call WriteString
    
    mov dl, al
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET ship2
    call WriteString
    
    mov dl, al
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET ship3
    call WriteString
    
DS_ship3:
    ; Draw spaceship 3
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    
    mov eax, ship3X
    sub eax, shipScroll
    cmp eax, 0
    jl DS_done
    cmp eax, 74
    jg DS_done
    
    mov dl, al
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET ship1
    call WriteString
    
    mov dl, al
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET ship2
    call WriteString
    
    mov dl, al
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET ship3
    call WriteString
    
DS_done:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawSpaceships ENDP

; =====================================================
; DRAW SUPER JUMP BLOCK
; =====================================================
DrawSuperJumpBlock PROC
    ; Only in Level 2
    mov eax, levelNum
    cmp eax, 2
    jne DSJB_done
    
    cmp inSecretRoom, 1
    je DSJB_done
    
    mov eax, superJumpBlockX
    sub eax, cameraPos
    cmp eax, 0
    jl DSJB_done
    cmp eax, 76
    jg DSJB_done
    
    ; Draw with special color - yellow/gold
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, al
    mov dh, superJumpBlockY
    call Gotoxy
    
    mov al, '['
    call WriteChar
    mov al, '^'
    call WriteChar
    mov al, ']'
    call WriteChar
    
DSJB_done:
    ret
DrawSuperJumpBlock ENDP

; =====================================================
; CHECK SUPER JUMP BLOCK COLLISION
; =====================================================
CheckSuperJumpBlock PROC
    push ebx
    push ecx
    
    xor eax, eax     ; assume not on block
    
    ; Only in Level 2
    mov ebx, levelNum
    cmp ebx, 2
    jne CSJB_none
    
    cmp inSecretRoom, 1
    je CSJB_none
    
    ; Check Y - Mario must be 1 row above block
    movzx ecx, yPos
    movzx ebx, superJumpBlockY
    dec ebx
    cmp ecx, ebx
    jne CSJB_none
    
    ; Check X bounds
    mov ecx, marioWorldX
    cmp ecx, superJumpBlockX
    jl CSJB_none
    
    mov ebx, superJumpBlockX
    add ebx, superJumpBlockW
    cmp ecx, ebx
    jg CSJB_none
    
    ; On the block!
    mov eax, 1
    jmp CSJB_exit
    
CSJB_none:
    xor eax, eax
    
CSJB_exit:
    pop ecx
    pop ebx
    ret
CheckSuperJumpBlock ENDP

; =====================================================
; UPDATE SUPER JUMP TIMER
; =====================================================
UpdateSuperJumpTimer PROC
    cmp superJumpTimer, 0
    je USJT_reset
    
    dec superJumpTimer
    cmp superJumpTimer, 0
    jg USJT_done
    
USJT_reset:
    mov currentJumpHeight, 3    ; Reset to normal jump
    
USJT_done:
    ret
UpdateSuperJumpTimer ENDP


; Helper: Convert EAX (DWORD) to string at EDI
WriteIntToBuffer PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi
   
    mov ebx, 10
    mov ecx, 0
   
    ; Count digits
WITB_countLoop:
    xor edx, edx
    div ebx
    inc ecx
    cmp eax, 0
    jne WITB_countLoop
   
    ; Write digits
    mov eax, ecx
    mov esi, edi
    add esi, eax
    mov BYTE PTR [esi], 0
   
    dec esi
    mov eax, [esp + 16]         ; Restore original value
   
WITB_writeLoop:
    xor edx, edx
    mov ecx, 10
    div ecx
    add dl, '0'
    mov [esi], dl
    dec esi
    cmp eax, 0
    jne WITB_writeLoop
   
    add edi, [esp]              ; EDI += digit count
   
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
WriteIntToBuffer ENDP

; Helper: Write string at EDX to file handle EBX
WriteStringToFile PROC
    push eax
    push ecx
    push edx
   
    mov edx, [esp + 12]         ; String pointer
    xor ecx, ecx
   
WSFS_countLoop:
    mov al, [edx + ecx]
    cmp al, 0
    je WSFS_write
    inc ecx
    jmp WSFS_countLoop
   
WSFS_write:
    mov eax, [esp + 8]          ; File handle
    call WriteToFile
   
    pop edx
    pop ecx
    pop eax
    ret
WriteStringToFile ENDP



; DisplayHighScoresScreen
DisplayHighScoresScreen PROC
    push eax
    push ecx
    push edx
   
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 35
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET hsTitle
    call WriteString
   
    mov eax, scoreCount
    cmp eax, 0
    jne DHS_show
   
    mov dl, 30
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET hsLine1
    call WriteString
    jmp DHS_wait
   
DHS_show:
    ; Headers
    mov eax, white + (black * 16)
    call SetTextColor
   
    mov dl, 15
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET headerRank
    call WriteString
   
    mov dl, 30
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET headerName
    call WriteString
   
    mov dl, 60
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET headerScore
    call WriteString
   
    xor ecx, ecx                ; ECX = index
   
DHS_loop:
    cmp ecx, scoreCount
    jge DHS_wait
    cmp ecx, MAX_SCORES
    jge DHS_wait
   
    mov eax, white + (black * 16)
    call SetTextColor
   
    ; Rank
    mov dl, 15
    mov dh, 6
    movzx eax, cl
    add dh, al
    call Gotoxy
   
    mov eax, ecx
    inc eax
    call WriteInt
    mov al, '.'
    call WriteChar
    mov al, ' '
    call WriteChar
   
    ; Name
    mov dl, 30
    mov dh, 6
    movzx eax, cl
    add dh, al
    call Gotoxy
   
    mov eax, ecx
    imul eax, 32
    mov edx, OFFSET topNames
    add edx, eax
    call WriteString
   
    ; Score
    mov dl, 60
    mov dh, 6
    movzx eax, cl
    add dh, al
    call Gotoxy
   
    mov eax, ecx
    shl eax, 2
    mov eax, topScores[eax]
    call WriteInt
   
    inc ecx
    jmp DHS_loop
   
DHS_wait:
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 25
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET hsBack
    call WriteString
   
DHS_waitKey:
    call ReadChar
    cmp al, 'b'
    je DHS_done
    cmp al, 'B'
    je DHS_done
    jmp DHS_waitKey
   
DHS_done:
    pop edx
    pop ecx
    pop eax
    ret
DisplayHighScoresScreen ENDP
; Complete game rendering procedures


;---------------------------------------------------
; IntToStr
;---------------------------------------------------
;---------------------------------------------------
; IntToStr
; EAX = non-negative number
; EDI = destination buffer
; Output: writes digits, NO null at end,
;         EDI = pointer just after last digit
;---------------------------------------------------
IntToStr PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi

    cmp eax, 0
    jne ITS_notZero
    mov al, '0'
    stosb
    jmp ITS_done

ITS_notZero:
    mov esi, OFFSET scoreBuffer
    add esi, 11
    mov BYTE PTR [esi], 0
    dec esi

ITS_divLoop:
    xor edx, edx
    mov ebx, 10
    div ebx             
    add dl, '0'
    mov [esi], dl
    dec esi
    cmp eax, 0
    jne ITS_divLoop

    inc esi                 

ITS_copyLoop:
    mov al, [esi]
    cmp al, 0
    je  ITS_done
    stosb
    inc esi
    jmp ITS_copyLoop

ITS_done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
IntToStr ENDP


LevelCompleteFromGame:
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    ; Check which level just completed
    mov eax, levelNum
    cmp eax, 1
    je LCG_level1Done
    
    ; Level 2 completed - go to final completion
    jmp LCG_finalComplete
    
LCG_level1Done:
    ; Level 1 complete message
    mov dl, 25
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET levelEndMsg
    call WriteString
    
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
   
    call ReadChar
    
    ; Show Level 2 intro
    call Clrscr
    mov eax, red + (black * 16)
    call SetTextColor
    
    mov dl, 15
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET level2Msg
    call WriteString
    
    mov dl, 20
    mov dh, 12
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
    
    call ReadChar
    
    ; Setup Level 2
    call InitLevel2
     call PlayBGMusic
    mov levelEndFlag, 0
    
    ; Start Level 2
    mov currentState, STATE_GAME
    jmp MainLoop

LCG_finalComplete:
    ; Show victory screen FIRST, THEN play music
    call DrawVictoryScreen
    
    ; Now play win sound (async so screen stays visible)
    call StopBGMusic
    INVOKE PlaySoundA, ADDR winSound, 0, 20001h   ; Async play
    
    ; Wait for a few seconds while showing the screen
    mov eax, 4000
    call Delay
    
    ; Stop any remaining sound
    call StopBGMusic
    
    call Clrscr
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 15
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET level2EndMsg
    call WriteString
   
    call ReadChar
   
    ; Show final score
    call Clrscr
    mov dl, 20
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET level2EndMsg
    call WriteString
   
    mov dl, 20
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
   
    mov dl, 20
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET hudCoinLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, coins
    call WriteInt
   
    ; Get player name
    mov dl, 10
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET namePrompt
    call WriteString
   
    ; Clear playerName
    mov ecx, 32
    mov edi, OFFSET playerName
    xor eax, eax
    rep stosb
   
    mov edx, OFFSET playerName
    mov ecx, 31
    call ReadString
   
    ; Save high score
    mov eax, score
    mov edx, OFFSET playerName
    call CheckAndSaveHighScore
   
    ; Show results
    mov dl, 20
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET hsBack
    call WriteString

LCG_waitKey:
    call ReadChar
    cmp al, 'b'
    je LCG_return
    cmp al, 'B'
    je LCG_return
    jmp LCG_waitKey
   
LCG_return:
    mov currentState, STATE_MENU
    jmp MainLoop


RecomputeScreenX PROC
    mov eax, marioWorldX
    sub eax, cameraPos
    cmp eax, 0
    jge RS_notLess
    xor eax, eax
    jmp RS_storeX
   
RS_notLess:
    cmp eax, 79
    jle RS_inRange
    mov eax, 79
   
RS_inRange:
RS_storeX:
    mov xPos, al
    ret
RecomputeScreenX ENDP

RedrawFrame PROC
    ; Check if in secret room FIRST
    cmp inSecretRoom, 1
    je RF_secretRoom
    
    ; Normal level rendering
    mov eax, levelNum
    cmp eax, 2
    je RF_level2BG

    mov eax, white + (lightblue * 16)
    call SetTextColor
    jmp RF_clearScreen

RF_level2BG:
    mov eax, yellow + (black * 16)
    call SetTextColor

RF_clearScreen:
    call Clrscr
    call DrawHUD

    ; Draw decorations based on level
    mov eax, levelNum
    cmp eax, 1
    jne RF_checkLevel2Decor
    
    ; Level 1 decorations - draw ALL of them
    call DrawTrees
    call DrawParallaxClouds
    call DrawBirds
    jmp RF_afterDecor

RF_checkLevel2Decor:
    mov eax, levelNum
    cmp eax, 2
    jne RF_afterDecor
    call DrawSpaceships

RF_afterDecor:   
    call UpdateInvincibilityTimer
    call DrawWorld_1_1
    call DrawPlatforms
    
    ; Draw Platform 6 and trigger coin in Level 2
    call DrawPlatform6
    call DrawTriggerCoin
    
    call DrawGround
    call RecomputeScreenX
    call DrawMushroom

    call DrawPlatformCoins

    ; Draw enemies based on level
    mov eax, levelNum
    cmp eax, 2
    je RF_level2Enemies
    
    ; Level 1 enemies
    call DrawGoomba
    call DrawGoombaL1_2  
    jmp RF_afterEnemies
   
RF_level2Enemies:
    call DrawLevel2Enemies
    
RF_afterEnemies:
    call ApplyGravity
    call DrawPlayer
    call CheckCollisions
    
    cmp inSecretRoom, 1
    je RF_done
    call CheckTriggerCoin
   
    cmp inSecretRoom, 1
    je RF_done
    
    mov eax, marioWorldX
    cmp eax, flagPoleX
    jl RF_done
    
    mov levelEndFlag, 1

RF_done:
    ret
    
RF_secretRoom:
    ; Secret room rendering
    call DrawSecretRoom
    ret
    
RedrawFrame ENDP

DrawWorld_1_1 PROC
    ; Only draw pipes in Level 1
    mov eax, levelNum
    cmp eax, 2
    je DW_level2Objects
    
    ; Level 1 pipes
    mov eax, green + (lightblue * 16)
    call SetTextColor
   
    mov eax, pipe1X
    sub eax, cameraPos
    cmp eax, 0
    jl DW_pipe1Skip
    cmp eax, 79
    jg DW_pipe1Skip
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
   
DW_pipe1Skip:
    mov eax, pipe2X
    sub eax, cameraPos
    cmp eax, 0
    jl DW_pipe2Skip
    cmp eax, 79
    jg DW_pipe2Skip
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
   
DW_pipe2Skip:
    jmp DW_drawFlag

DW_level2Objects:
    ; Level 2 - draw piranha pipes
    mov eax, green + (black * 16)
    call SetTextColor
    
    ; Pipe 1 for piranha1
    mov eax, piranha1X
    sub eax, cameraPos
    cmp eax, 0
    jl DW_ppipe1Skip
    cmp eax, 79
    jg DW_ppipe1Skip
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
   
DW_ppipe1Skip:
    ; Pipe 2 for piranha2
    mov eax, piranha2X
    sub eax, cameraPos
    cmp eax, 0
    jl DW_ppipe2Skip
    cmp eax, 79
    jg DW_ppipe2Skip
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
   
DW_ppipe2Skip:

DW_drawFlag:
    ; Draw flag pole (for both levels)
    mov eax, levelNum
    cmp eax, 2
    je DW_flag2Color
    
    mov eax, black + (lightblue * 16)
    call SetTextColor
    jmp DW_flagDraw
    
DW_flag2Color:
    mov eax, white + (black * 16)
    call SetTextColor
   
DW_flagDraw:
    mov eax, flagPoleX
    sub eax, cameraPos
    cmp eax, 0
    jl DW_flagSkip
    cmp eax, 79
    jg DW_flagSkip
   
    mov dl, al
    mov dh, GROUND_ROW - 10
    call Gotoxy
    mov ecx, 10
   
DW_flagLoop:
    mov al, '|'
    call WriteChar
    inc dh
    call Gotoxy
    loop DW_flagLoop
   
DW_flagSkip:
    ret
DrawWorld_1_1 ENDP
DrawMushroom PROC
    cmp mushroomActive, 0
    je DM_done
    
    ; Set color based on level
    mov eax, levelNum
    cmp eax, 2
    je DM_level2Color
    
    mov eax, yellow + (lightblue * 16)
    call SetTextColor
    jmp DM_draw
    
DM_level2Color:
    mov eax, yellow + (black * 16)
    call SetTextColor
   
DM_draw:
    mov eax, mushroomX
    sub eax, cameraPos
    cmp eax, 0
    jl DM_done
    cmp eax, 77
    jg DM_done
   
    mov dl, al
    mov dh, mushroomY
    call Gotoxy
    mov al, '('
    call WriteChar
    inc dl
    call Gotoxy
    mov al, 'M'
    call WriteChar
    inc dl
    call Gotoxy
    mov al, ')'
    call WriteChar
   
DM_done:
    ret
DrawMushroom ENDP

UpdateInvincibilityTimer PROC
    cmp invincibleActive, 1
    jne UIT_done
   
    mov eax, invincibleTimer
    cmp eax, 0
    jle UIT_clear
   
    dec eax
    mov invincibleTimer, eax
    jmp UIT_done
   
UIT_clear:
    mov invincibleActive, 0
     mov invincibleTimer, 0
   
UIT_done:
    ret
UpdateInvincibilityTimer ENDP




;--------------------------------------------------------------
;---------------------Collision Checks-----------------------
;--------------------------------------------------------------
CheckCollisions PROC

; ------------------------------------------------------------
; MUSHROOM COLLISION
; ------------------------------------------------------------
    cmp mushroomActive, 0
    je CC_startCoins

    mov eax, marioWorldX
    cmp eax, mushroomX
    jne CC_startCoins

    mov al, yPos
    cmp al, mushroomY
    jne CC_startCoins

    mov mushroomActive, 0
    add score, 1000
    mov invincibleActive, 1
    mov invincibleTimer, 30
    call PlayPowerSound

; ------------------------------------------------------------
; START COIN COLLISIONS
; ------------------------------------------------------------
CC_startCoins:


; ============================================================
; PLATFORM 1 — 4 COINS
; X index: 0,4,8,12
; ============================================================

P1C0:
    mov al, plat1CoinActive[0]
    cmp al, 1
    jne P1C1
    mov eax, marioWorldX
    cmp eax, plat1CoinX[0]
    jne P1C1
    mov al, yPos
    cmp al, plat1CoinY[0]
    jne P1C1
    mov plat1CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound
P1C1:

    mov al, plat1CoinActive[1]
    cmp al, 1
    jne P1C2
    mov eax, marioWorldX
    cmp eax, plat1CoinX[4]
    jne P1C2
    mov al, yPos
    cmp al, plat1CoinY[1]
    jne P1C2
    mov plat1CoinActive[1], 0
    inc coins
    add score, 100
   call PlayCoinSound

P1C2:

    mov al, plat1CoinActive[2]
    cmp al, 1
    jne P1C3
    mov eax, marioWorldX
    cmp eax, plat1CoinX[8]
    jne P1C3
    mov al, yPos
    cmp al, plat1CoinY[2]
    jne P1C3
    mov plat1CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound

P1C3:

    mov al, plat1CoinActive[3]
    cmp al, 1
    jne P2C0
    mov eax, marioWorldX
    cmp eax, plat1CoinX[12]
    jne P2C0
    mov al, yPos
    cmp al, plat1CoinY[3]
    jne P2C0
    mov plat1CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound


; ============================================================
; PLATFORM 2 — 7 COINS
; X index: 0,4,8,12,16,20,24
; ============================================================

P2C0:
    mov al, plat2CoinActive[0]
    cmp al, 1
    jne P2C1
    mov eax, marioWorldX
    cmp eax, plat2CoinX[0]
    jne P2C1
    mov al, yPos
    cmp al, plat2CoinY[0]
    jne P2C1
    mov plat2CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound

P2C1:

    mov al, plat2CoinActive[1]
    cmp al, 1
    jne P2C2
    mov eax, marioWorldX
    cmp eax, plat2CoinX[4]
    jne P2C2
    mov al, yPos
    cmp al, plat2CoinY[1]
    jne P2C2
    mov plat2CoinActive[1], 0
    inc coins
    add score, 100
P2C2:

    mov al, plat2CoinActive[2]
    cmp al, 1
    jne P2C3
    mov eax, marioWorldX
    cmp eax, plat2CoinX[8]
    jne P2C3
    mov al, yPos
    cmp al, plat2CoinY[2]
    jne P2C3
    mov plat2CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound

P2C3:

    mov al, plat2CoinActive[3]
    cmp al, 1
    jne P2C4
    mov eax, marioWorldX
    cmp eax, plat2CoinX[12]
    jne P2C4
    mov al, yPos
    cmp al, plat2CoinY[3]
    jne P2C4
    mov plat2CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound

P2C4:

    mov al, plat2CoinActive[4]
    cmp al, 1
    jne P2C5
    mov eax, marioWorldX
    cmp eax, plat2CoinX[16]
    jne P2C5
    mov al, yPos
    cmp al, plat2CoinY[4]
    jne P2C5
    mov plat2CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound

P2C5:

    mov al, plat2CoinActive[5]
    cmp al, 1
    jne P2C6
    mov eax, marioWorldX
    cmp eax, plat2CoinX[20]
    jne P2C6
    mov al, yPos
    cmp al, plat2CoinY[5]
    jne P2C6
    mov plat2CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound

P2C6:

    mov al, plat2CoinActive[6]
    cmp al, 1
    jne P3C0
    mov eax, marioWorldX
    cmp eax, plat2CoinX[24]
    jne P3C0
    mov al, yPos
    cmp al, plat2CoinY[6]
    jne P3C0
    mov plat2CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound



; ============================================================
; PLATFORM 3 — 7 COINS
; Same offsets as platform 2 (0,4,8,12,16,20,24)
; ============================================================

P3C0:
    mov al, plat3CoinActive[0]
    cmp al, 1
    jne P3C1
    mov eax, marioWorldX
    cmp eax, plat3CoinX[0]
    jne P3C1
    mov al, yPos
    cmp al, plat3CoinY[0]
    jne P3C1
    mov plat3CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C1:

    mov al, plat3CoinActive[1]
    cmp al, 1
    jne P3C2
    mov eax, marioWorldX
    cmp eax, plat3CoinX[4]
    jne P3C2
    mov al, yPos
    cmp al, plat3CoinY[1]
    jne P3C2
    mov plat3CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C2:

    mov al, plat3CoinActive[2]
    cmp al, 1
    jne P3C3
    mov eax, marioWorldX
    cmp eax, plat3CoinX[8]
    jne P3C3
    mov al, yPos
    cmp al, plat3CoinY[2]
    jne P3C3
    mov plat3CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C3:

    mov al, plat3CoinActive[3]
    cmp al, 1
    jne P3C4
    mov eax, marioWorldX
    cmp eax, plat3CoinX[12]
    jne P3C4
    mov al, yPos
    cmp al, plat3CoinY[3]
    jne P3C4
    mov plat3CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C4:

    mov al, plat3CoinActive[4]
    cmp al, 1
    jne P3C5
    mov eax, marioWorldX
    cmp eax, plat3CoinX[16]
    jne P3C5
    mov al, yPos
    cmp al, plat3CoinY[4]
    jne P3C5
    mov plat3CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C5:

    mov al, plat3CoinActive[5]
    cmp al, 1
    jne P3C6
    mov eax, marioWorldX
    cmp eax, plat3CoinX[20]
    jne P3C6
    mov al, yPos
    cmp al, plat3CoinY[5]
    jne P3C6
    mov plat3CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound

P3C6:

    mov al, plat3CoinActive[6]
    cmp al, 1
    jne P4C0
    mov eax, marioWorldX
    cmp eax, plat3CoinX[24]
    jne P4C0
    mov al, yPos
    cmp al, plat3CoinY[6]
    jne P4C0
    mov plat3CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound



; ============================================================
; PLATFORM 4 — 10 COINS  
; Offsets: 0,4,8,12,16,20,24,28,32,36
; ============================================================

P4C0:
    mov al, plat4CoinActive[0]
    cmp al, 1
    jne P4C1
    mov eax, marioWorldX
    cmp eax, plat4CoinX[0]
    jne P4C1
    mov al, yPos
    cmp al, plat4CoinY[0]
    jne P4C1
    mov plat4CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C1:

    mov al, plat4CoinActive[1]
    cmp al, 1
    jne P4C2
    mov eax, marioWorldX
    cmp eax, plat4CoinX[4]
    jne P4C2
    mov al, yPos
    cmp al, plat4CoinY[1]
    jne P4C2
    mov plat4CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C2:

    mov al, plat4CoinActive[2]
    cmp al, 1
    jne P4C3
    mov eax, marioWorldX
    cmp eax, plat4CoinX[8]
    jne P4C3
    mov al, yPos
    cmp al, plat4CoinY[2]
    jne P4C3
    mov plat4CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C3:

    mov al, plat4CoinActive[3]
    cmp al, 1
    jne P4C4
    mov eax, marioWorldX
    cmp eax, plat4CoinX[12]
    jne P4C4
    mov al, yPos
    cmp al, plat4CoinY[3]
    jne P4C4
    mov plat4CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C4:

    mov al, plat4CoinActive[4]
    cmp al, 1
    jne P4C5
    mov eax, marioWorldX
    cmp eax, plat4CoinX[16]
    jne P4C5
    mov al, yPos
    cmp al, plat4CoinY[4]
    jne P4C5
    mov plat4CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C5:

    mov al, plat4CoinActive[5]
    cmp al, 1
    jne P4C6
    mov eax, marioWorldX
    cmp eax, plat4CoinX[20]
    jne P4C6
    mov al, yPos
    cmp al, plat4CoinY[5]
    jne P4C6
    mov plat4CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C6:

    mov al, plat4CoinActive[6]
    cmp al, 1
    jne P4C7
    mov eax, marioWorldX
    cmp eax, plat4CoinX[24]
    jne P4C7
    mov al, yPos
    cmp al, plat4CoinY[6]
    jne P4C7
    mov plat4CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C7:

    mov al, plat4CoinActive[7]
    cmp al, 1
    jne P4C8
    mov eax, marioWorldX
    cmp eax, plat4CoinX[28]
    jne P4C8
    mov al, yPos
    cmp al, plat4CoinY[7]
    jne P4C8
    mov plat4CoinActive[7], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C8:

    mov al, plat4CoinActive[8]
    cmp al, 1
    jne P4C9
    mov eax, marioWorldX
    cmp eax, plat4CoinX[32]
    jne P4C9
    mov al, yPos
    cmp al, plat4CoinY[8]
    jne P4C9
    mov plat4CoinActive[8], 0
    inc coins
    add score, 100
    call PlayCoinSound

P4C9:

    mov al, plat4CoinActive[9]
    cmp al, 1
    jne P5C0
    mov eax, marioWorldX
    cmp eax, plat4CoinX[36]
    jne P5C0
    mov al, yPos
    cmp al, plat4CoinY[9]
    jne P5C0
    mov plat4CoinActive[9], 0
    inc coins
    add score, 100
    call PlayCoinSound



; ============================================================
; PLATFORM 5 — 9 COINS
; Offsets: 0,4,8,12,16,20,24,28,32
; ============================================================

P5C0:
    mov al, plat5CoinActive[0]
    cmp al, 1
    jne P5C1
    mov eax, marioWorldX
    cmp eax, plat5CoinX[0]
    jne P5C1
    mov al, yPos
    cmp al, plat5CoinY[0]
    jne P5C1
    mov plat5CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C1:

    mov al, plat5CoinActive[1]
    cmp al, 1
    jne P5C2
    mov eax, marioWorldX
    cmp eax, plat5CoinX[4]
    jne P5C2
    mov al, yPos
    cmp al, plat5CoinY[1]
    jne P5C2
    mov plat5CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C2:

    mov al, plat5CoinActive[2]
    cmp al, 1
    jne P5C3
    mov eax, marioWorldX
    cmp eax, plat5CoinX[8]
    jne P5C3
    mov al, yPos
    cmp al, plat5CoinY[2]
    jne P5C3
    mov plat5CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C3:

    mov al, plat5CoinActive[3]
    cmp al, 1
    jne P5C4
    mov eax, marioWorldX
    cmp eax, plat5CoinX[12]
    jne P5C4
    mov al, yPos
    cmp al, plat5CoinY[3]
    jne P5C4
    mov plat5CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C4:

    mov al, plat5CoinActive[4]
    cmp al, 1
    jne P5C5
    mov eax, marioWorldX
    cmp eax, plat5CoinX[16]
    jne P5C5
    mov al, yPos
    cmp al, plat5CoinY[4]
    jne P5C5
    mov plat5CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C5:

    mov al, plat5CoinActive[5]
    cmp al, 1
    jne P5C6
    mov eax, marioWorldX
    cmp eax, plat5CoinX[20]
    jne P5C6
    mov al, yPos
    cmp al, plat5CoinY[5]
    jne P5C6
    mov plat5CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C6:

    mov al, plat5CoinActive[6]
    cmp al, 1
    jne P5C7
    mov eax, marioWorldX
    cmp eax, plat5CoinX[24]
    jne P5C7
    mov al, yPos
    cmp al, plat5CoinY[6]
    jne P5C7
    mov plat5CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C7:

    mov al, plat5CoinActive[7]
    cmp al, 1
    jne P5C8
    mov eax, marioWorldX
    cmp eax, plat5CoinX[28]
    jne P5C8
    mov al, yPos
    cmp al, plat5CoinY[7]
    jne P5C8
    mov plat5CoinActive[7], 0
    inc coins
    add score, 100
    call PlayCoinSound

P5C8:

    mov al, plat5CoinActive[8]
    cmp al, 1
    jne P6C0
    mov eax, marioWorldX
    cmp eax, plat5CoinX[32]
    jne P6C0
    mov al, yPos
    cmp al, plat5CoinY[8]
    jne P6C0
    mov plat5CoinActive[8], 0
    inc coins
    add score, 100
    call PlayCoinSound

    ; ============================================================
; PLATFORM 6 — 8 COINS
; ============================================================
P6C0:
    mov al, plat6CoinActive[0]
    cmp al, 1
    jne P6C1
    mov eax, marioWorldX
    cmp eax, plat6CoinX[0]
    jne P6C1
    mov al, yPos
    cmp al, plat6CoinY[0]
    jne P6C1
    mov plat6CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C1:
    mov al, plat6CoinActive[1]
    cmp al, 1
    jne P6C2
    mov eax, marioWorldX
    cmp eax, plat6CoinX[4]
    jne P6C2
    mov al, yPos
    cmp al, plat6CoinY[1]
    jne P6C2
    mov plat6CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C2:
    mov al, plat6CoinActive[2]
    cmp al, 1
    jne P6C3
    mov eax, marioWorldX
    cmp eax, plat6CoinX[8]
    jne P6C3
    mov al, yPos
    cmp al, plat6CoinY[2]
    jne P6C3
    mov plat6CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C3:
    mov al, plat6CoinActive[3]
    cmp al, 1
    jne P6C4
    mov eax, marioWorldX
    cmp eax, plat6CoinX[12]
    jne P6C4
    mov al, yPos
    cmp al, plat6CoinY[3]
    jne P6C4
    mov plat6CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C4:
    mov al, plat6CoinActive[4]
    cmp al, 1
    jne P6C5
    mov eax, marioWorldX
    cmp eax, plat6CoinX[16]
    jne P6C5
    mov al, yPos
    cmp al, plat6CoinY[4]
    jne P6C5
    mov plat6CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C5:
    mov al, plat6CoinActive[5]
    cmp al, 1
    jne P6C6
    mov eax, marioWorldX
    cmp eax, plat6CoinX[20]
    jne P6C6
    mov al, yPos
    cmp al, plat6CoinY[5]
    jne P6C6
    mov plat6CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C6:
    mov al, plat6CoinActive[6]
    cmp al, 1
    jne P6C7
    mov eax, marioWorldX
    cmp eax, plat6CoinX[24]
    jne P6C7
    mov al, yPos
    cmp al, plat6CoinY[6]
    jne P6C7
    mov plat6CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound
P6C7:
    mov al, plat6CoinActive[7]
    cmp al, 1
    jne P7C0
    mov eax, marioWorldX
    cmp eax, plat6CoinX[28]
    jne P7C0
    mov al, yPos
    cmp al, plat6CoinY[7]
    jne P7C0
    mov plat6CoinActive[7], 0
    inc coins
    add score, 100
    call PlayCoinSound

; ============================================================
; PLATFORM 7 — 10 COINS
; ============================================================
P7C0:
    mov al, plat7CoinActive[0]
    cmp al, 1
    jne P7C1
    mov eax, marioWorldX
    cmp eax, plat7CoinX[0]
    jne P7C1
    mov al, yPos
    cmp al, plat7CoinY[0]
    jne P7C1
    mov plat7CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C1:
    mov al, plat7CoinActive[1]
    cmp al, 1
    jne P7C2
    mov eax, marioWorldX
    cmp eax, plat7CoinX[4]
    jne P7C2
    mov al, yPos
    cmp al, plat7CoinY[1]
    jne P7C2
    mov plat7CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C2:
    mov al, plat7CoinActive[2]
    cmp al, 1
    jne P7C3
    mov eax, marioWorldX
    cmp eax, plat7CoinX[8]
    jne P7C3
    mov al, yPos
    cmp al, plat7CoinY[2]
    jne P7C3
    mov plat7CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C3:
    mov al, plat7CoinActive[3]
    cmp al, 1
    jne P7C4
    mov eax, marioWorldX
    cmp eax, plat7CoinX[12]
    jne P7C4
    mov al, yPos
    cmp al, plat7CoinY[3]
    jne P7C4
    mov plat7CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C4:
    mov al, plat7CoinActive[4]
    cmp al, 1
    jne P7C5
    mov eax, marioWorldX
    cmp eax, plat7CoinX[16]
    jne P7C5
    mov al, yPos
    cmp al, plat7CoinY[4]
    jne P7C5
    mov plat7CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C5:
    mov al, plat7CoinActive[5]
    cmp al, 1
    jne P7C6
    mov eax, marioWorldX
    cmp eax, plat7CoinX[20]
    jne P7C6
    mov al, yPos
    cmp al, plat7CoinY[5]
    jne P7C6
    mov plat7CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C6:
    mov al, plat7CoinActive[6]
    cmp al, 1
    jne P7C7
    mov eax, marioWorldX
    cmp eax, plat7CoinX[24]
    jne P7C7
    mov al, yPos
    cmp al, plat7CoinY[6]
    jne P7C7
    mov plat7CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C7:
    mov al, plat7CoinActive[7]
    cmp al, 1
    jne P7C8
    mov eax, marioWorldX
    cmp eax, plat7CoinX[28]
    jne P7C8
    mov al, yPos
    cmp al, plat7CoinY[7]
    jne P7C8
    mov plat7CoinActive[7], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C8:
    mov al, plat7CoinActive[8]
    cmp al, 1
    jne P7C9
    mov eax, marioWorldX
    cmp eax, plat7CoinX[32]
    jne P7C9
    mov al, yPos
    cmp al, plat7CoinY[8]
    jne P7C9
    mov plat7CoinActive[8], 0
    inc coins
    add score, 100
    call PlayCoinSound
P7C9:
    mov al, plat7CoinActive[9]
    cmp al, 1
    jne P8C0
    mov eax, marioWorldX
    cmp eax, plat7CoinX[36]
    jne P8C0
    mov al, yPos
    cmp al, plat7CoinY[9]
    jne P8C0
    mov plat7CoinActive[9], 0
    inc coins
    add score, 100
    call PlayCoinSound

; ============================================================
; PLATFORM 8 — 8 COINS
; ============================================================
P8C0:
    mov al, plat8CoinActive[0]
    cmp al, 1
    jne P8C1
    mov eax, marioWorldX
    cmp eax, plat8CoinX[0]
    jne P8C1
    mov al, yPos
    cmp al, plat8CoinY[0]
    jne P8C1
    mov plat8CoinActive[0], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C1:
    mov al, plat8CoinActive[1]
    cmp al, 1
    jne P8C2
    mov eax, marioWorldX
    cmp eax, plat8CoinX[4]
    jne P8C2
    mov al, yPos
    cmp al, plat8CoinY[1]
    jne P8C2
    mov plat8CoinActive[1], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C2:
    mov al, plat8CoinActive[2]
    cmp al, 1
    jne P8C3
    mov eax, marioWorldX
    cmp eax, plat8CoinX[8]
    jne P8C3
    mov al, yPos
    cmp al, plat8CoinY[2]
    jne P8C3
    mov plat8CoinActive[2], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C3:
    mov al, plat8CoinActive[3]
    cmp al, 1
    jne P8C4
    mov eax, marioWorldX
    cmp eax, plat8CoinX[12]
    jne P8C4
    mov al, yPos
    cmp al, plat8CoinY[3]
    jne P8C4
    mov plat8CoinActive[3], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C4:
    mov al, plat8CoinActive[4]
    cmp al, 1
    jne P8C5
    mov eax, marioWorldX
    cmp eax, plat8CoinX[16]
    jne P8C5
    mov al, yPos
    cmp al, plat8CoinY[4]
    jne P8C5
    mov plat8CoinActive[4], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C5:
    mov al, plat8CoinActive[5]
    cmp al, 1
    jne P8C6
    mov eax, marioWorldX
    cmp eax, plat8CoinX[20]
    jne P8C6
    mov al, yPos
    cmp al, plat8CoinY[5]
    jne P8C6
    mov plat8CoinActive[5], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C6:
    mov al, plat8CoinActive[6]
    cmp al, 1
    jne P8C7
    mov eax, marioWorldX
    cmp eax, plat8CoinX[24]
    jne P8C7
    mov al, yPos
    cmp al, plat8CoinY[6]
    jne P8C7
    mov plat8CoinActive[6], 0
    inc coins
    add score, 100
    call PlayCoinSound
P8C7:
    mov al, plat8CoinActive[7]
    cmp al, 1
    jne CC_checkEnemies
    mov eax, marioWorldX
    cmp eax, plat8CoinX[28]
    jne CC_checkEnemies
    mov al, yPos
    cmp al, plat8CoinY[7]
    jne CC_checkEnemies
    mov plat8CoinActive[7], 0
    inc coins
    add score, 100
    call PlayCoinSound

CC_checkEnemies:
    mov eax, levelNum
    cmp eax, 2
    je CC_level2Enemies
    
    call CheckGoombaCollision
    jmp CC_end
    
CC_level2Enemies:
    ; Level 2 - check all 7 enemies
    call CheckLevel2Collisions
    
CC_end:
    ret
CheckCollisions ENDP

  


DrawGround PROC
    ; Set color based on level
    mov eax, levelNum
    cmp eax, 2
    je DG_level2Color
    
    ; Level 1 - green ground
    mov eax, green + (black * 16)
    call SetTextColor
    jmp DG_draw
    
DG_level2Color:
    ; Level 2 - green ground on black
    mov eax, green + (black * 16)
    call SetTextColor
   
DG_draw:
    mov dl, 0
    mov dh, GROUND_ROW
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
   
    ret
DrawGround ENDP

DrawHUD PROC
    ; Set color based on level
    mov eax, levelNum
    cmp eax, 2
    je DH_level2Color
    
    mov eax, white + (lightblue * 16)
    call SetTextColor
    jmp DH_draw
    
DH_level2Color:
    mov eax, white + (black * 16)
    call SetTextColor
   
DH_draw:
    mov dl, 0
    mov dh, HUD_ROW
    call Gotoxy
    mov edx, OFFSET hudMarioLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
   
    mov dl, 30
    mov dh, HUD_ROW
    call Gotoxy
    mov edx, OFFSET hudCoinLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, coins
    call WriteInt
   
    mov dl, 50
    mov dh, HUD_ROW
    call Gotoxy
    mov edx, OFFSET hudWorldLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, worldNum
    call WriteInt
    mov al, '-'
    call WriteChar
    mov eax, levelNum
    call WriteInt
   
    mov dl, 65
    mov dh, HUD_ROW
    call Gotoxy
    mov edx, OFFSET hudTimeLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, timeLeft
    call WriteInt
   
    mov dl, 0
    mov dh, HUD_ROW+1
    call Gotoxy
    mov edx, OFFSET hudLivesLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, lives
    call WriteInt
   
    ret
DrawHUD ENDP


DrawPlatforms PROC
    ; Set color based on level
    mov eax, levelNum
    cmp eax, 2
    je DP_level2Color
    
    ; Level 1 - black platforms on light blue
    mov eax, Red + (lightblue * 16)
    call SetTextColor
    jmp DP_startDraw
    
DP_level2Color:
    ; Level 2 - magenta/pink platforms on black
    mov eax, lightMagenta + (black * 16)
    call SetTextColor

DP_startDraw:
; ==========================================================
; PLATFORM 1
; ==========================================================
    mov eax, platform1X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip1
    cmp eax, 100
    jg  DP_skip1

    mov dl, al
    mov dh, platform1Y
    call Gotoxy

    mov ecx, platform1Width
DP_loop1:
    mov al, '='
    call WriteChar
    loop DP_loop1

DP_skip1:

; ==========================================================
; PLATFORM 2
; ==========================================================
    mov eax, platform2X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip2
    cmp eax, 100
    jg  DP_skip2

    mov dl, al
    mov dh, platform2Y
    call Gotoxy

    mov ecx, platform2Width
DP_loop2:
    mov al, '='
    call WriteChar
    loop DP_loop2

DP_skip2:

; ==========================================================
; PLATFORM 3
; ==========================================================
    mov eax, platform3X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip3
    cmp eax, 100
    jg  DP_skip3

    mov dl, al
    mov dh, platform3Y
    call Gotoxy

    mov ecx, platform3Width
DP_loop3:
    mov al, '='
    call WriteChar
    loop DP_loop3

DP_skip3:

; ==========================================================
; PLATFORM 4
; ==========================================================
    mov eax, platform4X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip4
    cmp eax, 100
    jg  DP_skip4

    mov dl, al
    mov dh, platform4Y
    call Gotoxy

    mov ecx, platform4Width
DP_loop4:
    mov al, '='
    call WriteChar
    loop DP_loop4

DP_skip4:

; ==========================================================
; PLATFORM 5
; ==========================================================
    mov eax, platform5X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip5
    cmp eax, 100
    jg  DP_skip5

    mov dl, al
    mov dh, platform5Y
    call Gotoxy

    mov ecx, platform5Width
DP_loop5:
    mov al, '='
    call WriteChar
    loop DP_loop5

DP_skip5:
    ; Platform 6
    mov eax, platform6X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip6
    cmp eax, 100
    jg  DP_skip6
    mov dl, al
    mov dh, platform6Y
    call Gotoxy
    mov ecx, platform6Width
DP_loop6:
    mov al, '='
    call WriteChar
    loop DP_loop6

DP_skip6:
    ; Platform 7
    mov eax, platform7X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip7
    cmp eax, 100
    jg  DP_skip7
    mov dl, al
    mov dh, platform7Y
    call Gotoxy
    mov ecx, platform7Width
DP_loop7:
    mov al, '='
    call WriteChar
    loop DP_loop7

DP_skip7:
    ; Platform 8
    mov eax, platform8X
    sub eax, cameraPos
    cmp eax, 0
    jl  DP_skip8
    cmp eax, 100
    jg  DP_skip8
    mov dl, al
    mov dh, platform8Y
    call Gotoxy
    mov ecx, platform8Width
DP_loop8:
    mov al, '='
    call WriteChar
    loop DP_loop8

DP_skip8:
    
    ret
DrawPlatforms ENDP


DrawPlayer PROC
    ; Check if invincible from mushroom (yellow <M>)
    cmp invincibleActive, 1
    jne normalMario
    
    ; Only show invincibility effect if timer is active
    cmp invincibleTimer, 0
    jle normalMario
    
    ; Set background color based on level
    mov eax, levelNum
    cmp eax, 2
    je DP_invLevel2
    
    ; Level 1 - yellow on light blue
    mov eax, yellow + (lightblue * 16)
    call SetTextColor
    jmp DP_drawInv
    
DP_invLevel2:
    ; Level 2 - yellow on black
    mov eax, yellow + (black * 16)
    call SetTextColor
    
DP_drawInv:
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov al, '<'
    call WriteChar
    inc dl
    call Gotoxy
    mov al, 'M'
    call WriteChar
    inc dl
    call Gotoxy
    mov al, '>'
    call WriteChar
    jmp doneDrawPlayer
   
normalMario:
    ; Normal blue Mario - check level for background
    mov eax, levelNum
    cmp eax, 2
    je DP_normalLevel2
    
    ; Level 1 - blue on light blue
    mov eax, blue + (lightblue * 16)
    call SetTextColor
    jmp DP_drawNormal
    
DP_normalLevel2:
    ; Level 2 - blue on black
    mov eax, blue + (black * 16)
    call SetTextColor
    
DP_drawNormal:
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov al, 'M'
    call WriteChar
   
doneDrawPlayer:
    ; Reset to white text
    mov eax, levelNum
    cmp eax, 2
    je DP_resetLevel2
    
    mov eax, white + (lightblue * 16)
    call SetTextColor
    jmp DP_exit
    
DP_resetLevel2:
    mov eax, white + (black * 16)
    call SetTextColor
    
DP_exit:
    ret
DrawPlayer ENDP


CheckPlatforms PROC
    xor eax, eax     ; assume no platform under Mario

; ===== PLATFORM 1 =====
    mov al, yPos
    mov bl, platform1Y
    dec bl
    cmp al, bl
    jne CP_p2

    mov eax, marioWorldX
    cmp eax, platform1X
    jl  CP_p2
    mov ebx, platform1X
    add ebx, platform1Width
    cmp eax, ebx
    jg  CP_p2
    mov eax, 1
    ret

CP_p2:
; ===== PLATFORM 2 =====
    mov al, yPos
    mov bl, platform2Y
    dec bl
    cmp al, bl
    jne CP_p3

    mov eax, marioWorldX
    cmp eax, platform2X
    jl  CP_p3
    mov ebx, platform2X
    add ebx, platform2Width
    cmp eax, ebx
    jg  CP_p3
    mov eax, 1
    ret

CP_p3:
; ===== PLATFORM 3 =====
    mov al, yPos
    mov bl, platform3Y
    dec bl
    cmp al, bl
    jne CP_p4

    mov eax, marioWorldX
    cmp eax, platform3X
    jl  CP_p4
    mov ebx, platform3X
    add ebx, platform3Width
    cmp eax, ebx
    jg  CP_p4
    mov eax, 1
    ret

CP_p4:
; ===== PLATFORM 4 =====
    mov al, yPos
    mov bl, platform4Y
    dec bl
    cmp al, bl
    jne CP_p5

    mov eax, marioWorldX
    cmp eax, platform4X
    jl  CP_p5
    mov ebx, platform4X
    add ebx, platform4Width
    cmp eax, ebx
    jg  CP_p5
    mov eax, 1
    ret

CP_p5:
; ===== PLATFORM 5 =====
    mov al, yPos
    mov bl, platform5Y
    dec bl
    cmp al, bl
    jne CP_p6

    mov eax, marioWorldX
    cmp eax, platform5X
    jl  CP_p6
    mov ebx, platform5X
    add ebx, platform5Width
    cmp eax, ebx
    jg  CP_p6
    mov eax, 1
    ret

CP_p6:
; ===== PLATFORM 6 =====
    mov al, yPos
    mov bl, platform6Y
    dec bl
    cmp al, bl
    jne CP_p7

    mov eax, marioWorldX
    cmp eax, platform6X
    jl  CP_p7
    mov ebx, platform6X
    add ebx, platform6Width
    cmp eax, ebx
    jg  CP_p7
    mov eax, 1
    ret

CP_p7:
; ===== PLATFORM 7 =====
    mov al, yPos
    mov bl, platform7Y
    dec bl
    cmp al, bl
    jne CP_p8

    mov eax, marioWorldX
    cmp eax, platform7X
    jl  CP_p8
    mov ebx, platform7X
    add ebx, platform7Width
    cmp eax, ebx
    jg  CP_p8
    mov eax, 1
    ret

CP_p8:
; ===== PLATFORM 8 =====
    mov al, yPos
    mov bl, platform8Y
    dec bl
    cmp al, bl
    jne CP_none

    mov eax, marioWorldX
    cmp eax, platform8X
    jl  CP_none
    mov ebx, platform8X
    add ebx, platform8Width
    cmp eax, ebx
    jg  CP_none
    mov eax, 1
    ret

CP_none:
    xor eax, eax
    ret
CheckPlatforms ENDP

;------------------------GRAVITY------------------------;

ApplyGravity PROC
    cmp isJumping, 1
    je AG_done
    
    ; Check if in secret room
    cmp inSecretRoom, 1
    je AG_useSecret
   
    mov al, yPos
    cmp al, GROUND_ROW - 1
    jge AG_done
   
    call CheckPlatforms
    cmp eax, 1
    je AG_done
   
    inc yPos
    jmp AG_done

AG_useSecret:
    ; Use secret room gravity
    mov al, yPos
    cmp al, GROUND_ROW - 1
    jge AG_done
    
    call CheckSecretPlatform
    cmp eax, 1
    je AG_done
    
    inc yPos
   
AG_done:
    ret
ApplyGravity ENDP

DrawPlatformCoins PROC
     ; Set color based on level
    mov eax, levelNum
    cmp eax, 2
    je DPC_level2Color
    
    mov eax, yellow + (lightblue * 16)
    call SetTextColor
    jmp DPC_startDraw
    
DPC_level2Color:
    mov eax, yellow + (black * 16)
    call SetTextColor

DPC_startDraw:

; ============================================================
; PLATFORM 1 COINS
; ============================================================
    ; Coin 0
    mov al, plat1CoinActive[0]
    cmp al, 1
    jne P1C1_skip
    mov eax, plat1CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P1C1_skip
    cmp eax, 79
    jg P1C1_skip
    mov dl, al
    mov dh, plat1CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P1C1_skip:

    ; Coin 1
    mov al, plat1CoinActive[1]
    cmp al, 1
    jne P1C2_skip
    mov eax, plat1CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P1C2_skip
    cmp eax, 79
    jg P1C2_skip
    mov dl, al
    mov dh, plat1CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P1C2_skip:

    ; Coin 2
    mov al, plat1CoinActive[2]
    cmp al, 1
    jne P1C3_skip
    mov eax, plat1CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P1C3_skip
    cmp eax, 79
    jg P1C3_skip
    mov dl, al
    mov dh, plat1CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P1C3_skip:

    ; Coin 3
    mov al, plat1CoinActive[3]
    cmp al, 1
    jne P1C4_skip
    mov eax, plat1CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P1C4_skip
    cmp eax, 79
    jg P1C4_skip
    mov dl, al
    mov dh, plat1CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P1C4_skip:

; ============================================================
; PLATFORM 2 COINS (7 coins)
; ============================================================
; X offsets: 0,4,8,12,16,20,24

P2C0:
    mov al, plat2CoinActive[0]
    cmp al, 1
    jne P2C0_skip
    mov eax, plat2CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C0_skip
    cmp eax, 79
    jg P2C0_skip
    mov dl, al
    mov dh, plat2CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C0_skip:

P2C1:
    mov al, plat2CoinActive[1]
    cmp al, 1
    jne P2C1_skip
    mov eax, plat2CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C1_skip
    cmp eax, 79
    jg P2C1_skip
    mov dl, al
    mov dh, plat2CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C1_skip:

P2C2:
    mov al, plat2CoinActive[2]
    cmp al, 1
    jne P2C2_skip
    mov eax, plat2CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C2_skip
    cmp eax, 79
    jg P2C2_skip
    mov dl, al
    mov dh, plat2CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C2_skip:

P2C3:
    mov al, plat2CoinActive[3]
    cmp al, 1
    jne P2C3_skip
    mov eax, plat2CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C3_skip
    cmp eax, 79
    jg P2C3_skip
    mov dl, al
    mov dh, plat2CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C3_skip:

P2C4:
    mov al, plat2CoinActive[4]
    cmp al, 1
    jne P2C4_skip
    mov eax, plat2CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C4_skip
    cmp eax, 79
    jg P2C4_skip
    mov dl, al
    mov dh, plat2CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C4_skip:

P2C5:
    mov al, plat2CoinActive[5]
    cmp al, 1
    jne P2C5_skip
    mov eax, plat2CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C5_skip
    cmp eax, 79
    jg P2C5_skip
    mov dl, al
    mov dh, plat2CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C5_skip:

P2C6:
    mov al, plat2CoinActive[6]
    cmp al, 1
    jne P2C6_skip
    mov eax, plat2CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P2C6_skip
    cmp eax, 79
    jg P2C6_skip
    mov dl, al
    mov dh, plat2CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P2C6_skip:

; ============================================================
; PLATFORM 3 COINS (7 coins)
; EXACT SAME PATTERN AS PLATFORM 2
; ============================================================

; X index: 0,4,8,12,16,20,24

P3C0:
    mov al, plat3CoinActive[0]
    cmp al, 1
    jne P3C0_skip
    mov eax, plat3CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C0_skip
    cmp eax, 79
    jg P3C0_skip
    mov dl, al
    mov dh, plat3CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C0_skip:

P3C1:
    mov al, plat3CoinActive[1]
    cmp al, 1
    jne P3C1_skip
    mov eax, plat3CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C1_skip
    cmp eax, 79
    jg P3C1_skip
    mov dl, al
    mov dh, plat3CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C1_skip:

P3C2:
    mov al, plat3CoinActive[2]
    cmp al, 1
    jne P3C2_skip
    mov eax, plat3CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C2_skip
    cmp eax, 79
    jg P3C2_skip
    mov dl, al
    mov dh, plat3CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C2_skip:

P3C3:
    mov al, plat3CoinActive[3]
    cmp al, 1
    jne P3C3_skip
    mov eax, plat3CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C3_skip
    cmp eax, 79
    jg P3C3_skip
    mov dl, al
    mov dh, plat3CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C3_skip:

P3C4:
    mov al, plat3CoinActive[4]
    cmp al, 1
    jne P3C4_skip
    mov eax, plat3CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C4_skip
    cmp eax, 79
    jg P3C4_skip
    mov dl, al
    mov dh, plat3CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C4_skip:

P3C5:
    mov al, plat3CoinActive[5]
    cmp al, 1
    jne P3C5_skip
    mov eax, plat3CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C5_skip
    cmp eax, 79
    jg P3C5_skip
    mov dl, al
    mov dh, plat3CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C5_skip:

P3C6:
    mov al, plat3CoinActive[6]
    cmp al, 1
    jne P3C6_skip
    mov eax, plat3CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P3C6_skip
    cmp eax, 79
    jg P3C6_skip
    mov dl, al
    mov dh, plat3CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P3C6_skip:

; ============================================================
; PLATFORM 4 COINS (10 coins)
; ============================================================

; Coin 0 (index 0)
P4C0:
    mov al, plat4CoinActive[0]
    cmp al, 1
    jne P4C0_skip
    mov eax, plat4CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C0_skip
    cmp eax, 79
    jg P4C0_skip
    mov dl, al
    mov dh, plat4CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C0_skip:

; Coin 1 (index 4)
P4C1:
    mov al, plat4CoinActive[1]
    cmp al, 1
    jne P4C1_skip
    mov eax, plat4CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C1_skip
    cmp eax, 79
    jg P4C1_skip
    mov dl, al
    mov dh, plat4CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C1_skip:

; Coin 2 (index 8)
P4C2:
    mov al, plat4CoinActive[2]
    cmp al, 1
    jne P4C2_skip
    mov eax, plat4CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C2_skip
    cmp eax, 79
    jg P4C2_skip
    mov dl, al
    mov dh, plat4CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C2_skip:

; Coin 3 (index 12)
P4C3:
    mov al, plat4CoinActive[3]
    cmp al, 1
    jne P4C3_skip
    mov eax, plat4CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C3_skip
    cmp eax, 79
    jg P4C3_skip
    mov dl, al
    mov dh, plat4CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C3_skip:

; Coin 4 (index 16)
P4C4:
    mov al, plat4CoinActive[4]
    cmp al, 1
    jne P4C4_skip
    mov eax, plat4CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C4_skip
    cmp eax, 79
    jg P4C4_skip
    mov dl, al
    mov dh, plat4CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C4_skip:

; Coin 5 (index 20)
P4C5:
    mov al, plat4CoinActive[5]
    cmp al, 1
    jne P4C5_skip
    mov eax, plat4CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C5_skip
    cmp eax, 79
    jg P4C5_skip
    mov dl, al
    mov dh, plat4CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C5_skip:

; Coin 6 (index 24)
P4C6:
    mov al, plat4CoinActive[6]
    cmp al, 1
    jne P4C6_skip
    mov eax, plat4CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C6_skip
    cmp eax, 79
    jg P4C6_skip
    mov dl, al
    mov dh, plat4CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C6_skip:

; Coin 7 (index 28)
P4C7:
    mov al, plat4CoinActive[7]
    cmp al, 1
    jne P4C7_skip
    mov eax, plat4CoinX[28]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C7_skip
    cmp eax, 79
    jg P4C7_skip
    mov dl, al
    mov dh, plat4CoinY[7]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C7_skip:

; Coin 8 (index 32)
P4C8:
    mov al, plat4CoinActive[8]
    cmp al, 1
    jne P4C8_skip
    mov eax, plat4CoinX[32]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C8_skip
    cmp eax, 79
    jg P4C8_skip
    mov dl, al
    mov dh, plat4CoinY[8]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C8_skip:

; Coin 9 (index 36)
P4C9:
    mov al, plat4CoinActive[9]
    cmp al, 1
    jne P4C9_skip
    mov eax, plat4CoinX[36]
    sub eax, cameraPos
    cmp eax, 0
    jl P4C9_skip
    cmp eax, 79
    jg P4C9_skip
    mov dl, al
    mov dh, plat4CoinY[9]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P4C9_skip:

; ============================================================
; PLATFORM 5 COINS (9 coins)
; ============================================================

; Coin 0
P5C0:
    mov al, plat5CoinActive[0]
    cmp al, 1
    jne P5C0_skip
    mov eax, plat5CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C0_skip
    cmp eax, 79
    jg P5C0_skip
    mov dl, al
    mov dh, plat5CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C0_skip:

; Coin 1
P5C1:
    mov al, plat5CoinActive[1]
    cmp al, 1
    jne P5C1_skip
    mov eax, plat5CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C1_skip
    cmp eax, 79
    jg P5C1_skip
    mov dl, al
    mov dh, plat5CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C1_skip:

; Coin 2
P5C2:
    mov al, plat5CoinActive[2]
    cmp al, 1
    jne P5C2_skip
    mov eax, plat5CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C2_skip
    cmp eax, 79
    jg P5C2_skip
    mov dl, al
    mov dh, plat5CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C2_skip:

; Coin 3
P5C3:
    mov al, plat5CoinActive[3]
    cmp al, 1
    jne P5C3_skip
    mov eax, plat5CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C3_skip
    cmp eax, 79
    jg P5C3_skip
    mov dl, al
    mov dh, plat5CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C3_skip:

; Coin 4
P5C4:
    mov al, plat5CoinActive[4]
    cmp al, 1
    jne P5C4_skip
    mov eax, plat5CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C4_skip
    cmp eax, 79
    jg P5C4_skip
    mov dl, al
    mov dh, plat5CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C4_skip:

; Coin 5
P5C5:
    mov al, plat5CoinActive[5]
    cmp al, 1
    jne P5C5_skip
    mov eax, plat5CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C5_skip
    cmp eax, 79
    jg P5C5_skip
    mov dl, al
    mov dh, plat5CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C5_skip:

; Coin 6
P5C6:
    mov al, plat5CoinActive[6]
    cmp al, 1
    jne P5C6_skip
    mov eax, plat5CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C6_skip
    cmp eax, 79
    jg P5C6_skip
    mov dl, al
    mov dh, plat5CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C6_skip:

; Coin 7
P5C7:
    mov al, plat5CoinActive[7]
    cmp al, 1
    jne P5C7_skip
    mov eax, plat5CoinX[28]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C7_skip
    cmp eax, 79
    jg P5C7_skip
    mov dl, al
    mov dh, plat5CoinY[7]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P5C7_skip:

; Coin 8
P5C8:
    mov al, plat5CoinActive[8]
    cmp al, 1
    jne P5C8_skip
    mov eax, plat5CoinX[32]
    sub eax, cameraPos
    cmp eax, 0
    jl P5C8_skip
    cmp eax, 79
    jg P5C8_skip
    mov dl, al
    mov dh, plat5CoinY[8]
    call Gotoxy
    mov al, 'o'
    call WriteChar

P5C8_skip:

; ============================================================
; PLATFORM 6 COINS (8 coins)
; ============================================================
P6C0:
    mov al, plat6CoinActive[0]
    cmp al, 1
    jne P6C1_skip
    mov eax, plat6CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C1_skip
    cmp eax, 79
    jg P6C1_skip
    mov dl, al
    mov dh, plat6CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C1_skip:

    mov al, plat6CoinActive[1]
    cmp al, 1
    jne P6C2_skip
    mov eax, plat6CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C2_skip
    cmp eax, 79
    jg P6C2_skip
    mov dl, al
    mov dh, plat6CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C2_skip:

    mov al, plat6CoinActive[2]
    cmp al, 1
    jne P6C3_skip
    mov eax, plat6CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C3_skip
    cmp eax, 79
    jg P6C3_skip
    mov dl, al
    mov dh, plat6CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C3_skip:

    mov al, plat6CoinActive[3]
    cmp al, 1
    jne P6C4_skip
    mov eax, plat6CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C4_skip
    cmp eax, 79
    jg P6C4_skip
    mov dl, al
    mov dh, plat6CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C4_skip:

    mov al, plat6CoinActive[4]
    cmp al, 1
    jne P6C5_skip
    mov eax, plat6CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C5_skip
    cmp eax, 79
    jg P6C5_skip
    mov dl, al
    mov dh, plat6CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C5_skip:

    mov al, plat6CoinActive[5]
    cmp al, 1
    jne P6C6_skip
    mov eax, plat6CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C6_skip
    cmp eax, 79
    jg P6C6_skip
    mov dl, al
    mov dh, plat6CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C6_skip:

    mov al, plat6CoinActive[6]
    cmp al, 1
    jne P6C7_skip
    mov eax, plat6CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P6C7_skip
    cmp eax, 79
    jg P6C7_skip
    mov dl, al
    mov dh, plat6CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P6C7_skip:

    mov al, plat6CoinActive[7]
    cmp al, 1
    jne P7C0_skip
    mov eax, plat6CoinX[28]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C0_skip
    cmp eax, 79
    jg P7C0_skip
    mov dl, al
    mov dh, plat6CoinY[7]
    call Gotoxy
    mov al, 'o'
    call WriteChar

; ============================================================
; PLATFORM 7 COINS (10 coins)
; ============================================================
P7C0_skip:
    mov al, plat7CoinActive[0]
    cmp al, 1
    jne P7C1_skip
    mov eax, plat7CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C1_skip
    cmp eax, 79
    jg P7C1_skip
    mov dl, al
    mov dh, plat7CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C1_skip:

    mov al, plat7CoinActive[1]
    cmp al, 1
    jne P7C2_skip
    mov eax, plat7CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C2_skip
    cmp eax, 79
    jg P7C2_skip
    mov dl, al
    mov dh, plat7CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C2_skip:

    mov al, plat7CoinActive[2]
    cmp al, 1
    jne P7C3_skip
    mov eax, plat7CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C3_skip
    cmp eax, 79
    jg P7C3_skip
    mov dl, al
    mov dh, plat7CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C3_skip:

    mov al, plat7CoinActive[3]
    cmp al, 1
    jne P7C4_skip
    mov eax, plat7CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C4_skip
    cmp eax, 79
    jg P7C4_skip
    mov dl, al
    mov dh, plat7CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C4_skip:

    mov al, plat7CoinActive[4]
    cmp al, 1
    jne P7C5_skip
    mov eax, plat7CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C5_skip
    cmp eax, 79
    jg P7C5_skip
    mov dl, al
    mov dh, plat7CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C5_skip:

    mov al, plat7CoinActive[5]
    cmp al, 1
    jne P7C6_skip
    mov eax, plat7CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C6_skip
    cmp eax, 79
    jg P7C6_skip
    mov dl, al
    mov dh, plat7CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C6_skip:

    mov al, plat7CoinActive[6]
    cmp al, 1
    jne P7C7_skip
    mov eax, plat7CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C7_skip
    cmp eax, 79
    jg P7C7_skip
    mov dl, al
    mov dh, plat7CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C7_skip:

    mov al, plat7CoinActive[7]
    cmp al, 1
    jne P7C8_skip
    mov eax, plat7CoinX[28]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C8_skip
    cmp eax, 79
    jg P7C8_skip
    mov dl, al
    mov dh, plat7CoinY[7]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C8_skip:

    mov al, plat7CoinActive[8]
    cmp al, 1
    jne P7C9_skip
    mov eax, plat7CoinX[32]
    sub eax, cameraPos
    cmp eax, 0
    jl P7C9_skip
    cmp eax, 79
    jg P7C9_skip
    mov dl, al
    mov dh, plat7CoinY[8]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P7C9_skip:

    mov al, plat7CoinActive[9]
    cmp al, 1
    jne P8C0_skip
    mov eax, plat7CoinX[36]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C0_skip
    cmp eax, 79
    jg P8C0_skip
    mov dl, al
    mov dh, plat7CoinY[9]
    call Gotoxy
    mov al, 'o'
    call WriteChar

; ============================================================
; PLATFORM 8 COINS (8 coins)
; ============================================================
P8C0_skip:
    mov al, plat8CoinActive[0]
    cmp al, 1
    jne P8C1_skip
    mov eax, plat8CoinX[0]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C1_skip
    cmp eax, 79
    jg P8C1_skip
    mov dl, al
    mov dh, plat8CoinY[0]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C1_skip:

    mov al, plat8CoinActive[1]
    cmp al, 1
    jne P8C2_skip
    mov eax, plat8CoinX[4]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C2_skip
    cmp eax, 79
    jg P8C2_skip
    mov dl, al
    mov dh, plat8CoinY[1]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C2_skip:

    mov al, plat8CoinActive[2]
    cmp al, 1
    jne P8C3_skip
    mov eax, plat8CoinX[8]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C3_skip
    cmp eax, 79
    jg P8C3_skip
    mov dl, al
    mov dh, plat8CoinY[2]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C3_skip:

    mov al, plat8CoinActive[3]
    cmp al, 1
    jne P8C4_skip
    mov eax, plat8CoinX[12]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C4_skip
    cmp eax, 79
    jg P8C4_skip
    mov dl, al
    mov dh, plat8CoinY[3]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C4_skip:

    mov al, plat8CoinActive[4]
    cmp al, 1
    jne P8C5_skip
    mov eax, plat8CoinX[16]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C5_skip
    cmp eax, 79
    jg P8C5_skip
    mov dl, al
    mov dh, plat8CoinY[4]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C5_skip:

    mov al, plat8CoinActive[5]
    cmp al, 1
    jne P8C6_skip
    mov eax, plat8CoinX[20]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C6_skip
    cmp eax, 79
    jg P8C6_skip
    mov dl, al
    mov dh, plat8CoinY[5]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C6_skip:

    mov al, plat8CoinActive[6]
    cmp al, 1
    jne P8C7_skip
    mov eax, plat8CoinX[24]
    sub eax, cameraPos
    cmp eax, 0
    jl P8C7_skip
    cmp eax, 79
    jg P8C7_skip
    mov dl, al
    mov dh, plat8CoinY[6]
    call Gotoxy
    mov al, 'o'
    call WriteChar
P8C7_skip:

    mov al, plat8CoinActive[7]
    cmp al, 1
    jne DPC_done
    mov eax, plat8CoinX[28]
    sub eax, cameraPos
    cmp eax, 0
    jl DPC_done
    cmp eax, 79
    jg DPC_done
    mov dl, al
    mov dh, plat8CoinY[7]
    call Gotoxy
    mov al, 'o'
    call WriteChar

DPC_done:
    ret
DrawPlatformCoins ENDP




;-----------clouds---------------------
DrawParallaxClouds PROC
    mov eax, white + (lightblue * 16)
    call SetTextColor

    mov eax, cloud1X
    sub eax, cloudScroll
    mov bl, 5
    call DrawCloudASCII

    mov eax, cloud2X
    sub eax, cloudScroll
    mov bl, 9
    call DrawCloudASCII

    mov eax, cloud3X
    sub eax, cloudScroll
    mov bl, 7
    call DrawCloudASCII

    ret
DrawParallaxClouds ENDP


DrawCloudASCII PROC
    cmp eax, 0
    jl DCA_done

    cmp eax, 100
    jg DCA_done

    ; ------- draw row 1 -------
    mov dl, al
    mov dh, bl
    call Gotoxy
    mov edx, OFFSET cloudA1
    call WriteString

    ; ------- draw row 2 -------
    mov dl, al
    mov dh, bl
    inc dh
    call Gotoxy
    mov edx, OFFSET cloudA2
    call WriteString

    ; ------- draw row 3 -------
    mov dl, al
    mov dh, bl
    add dh, 2
    call Gotoxy
    mov edx, OFFSET cloudA3
    call WriteString

DCA_done:
    ret
DrawCloudASCII ENDP

DrawOneCloud PROC

    cmp eax, -20
    jle DC_done
    cmp eax, 80
    jge DC_done

    mov dl, al
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET cloudA1
    call WriteString

    mov dh, 6
    call Gotoxy
    mov edx, OFFSET cloudA2
    call WriteString

    mov dh, 7
    call Gotoxy
    mov edx, OFFSET cloudA3
    call WriteString

DC_done:
    ret
DrawOneCloud ENDP

;---------------------------------------------------
; LoadAllHighScores
; Reads highscores.txt into topScores/topNames
; Line format:  SCORE SPACE NAME CR LF
;---------------------------------------------------
LoadAllHighScores PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    push ebp               

    ; clear arrays
    mov ecx, MAX_SCORES
    mov edi, OFFSET topScores
    xor eax, eax
    rep stosd

    mov ecx, MAX_SCORES*32
    mov edi, OFFSET topNames
    mov al, 0
    rep stosb

    mov scoreCount, 0
    mov highScore, 0

    ; open file
    mov edx, OFFSET highscoreFile
    call OpenInputFile
    cmp eax, -1                
    je LAH_done              

    mov ebx, eax             

    mov eax, ebx
    mov edx, OFFSET highFileBuf
    mov ecx, SIZEOF highFileBuf
    call ReadFromFile         
    jc  LAH_close            

    mov edi, eax                
    mov eax, ebx
    call CloseFile

    cmp edi, 0
    jle LAH_done             

    mov esi, OFFSET highFileBuf 
    mov ebx, esi
    add ebx, edi              
    xor ebp, ebp               

nextLine_LAH:
    cmp esi, ebx
    jae finishParse_LAH
    cmp ebp, MAX_SCORES
    jge finishParse_LAH

skipBlank_LAH:
    cmp esi, ebx
    jae finishParse_LAH
    mov al, [esi]
    cmp al, 13          ; CR
    je skAdv_LAH
    cmp al, 10          ; LF
    je skAdv_LAH
    cmp al, ' '
    je skAdv_LAH
    jmp startScore_LAH
skAdv_LAH:
    inc esi
    jmp skipBlank_LAH

startScore_LAH:
    xor eax, eax

scoreLoop_LAH:
    cmp esi, ebx
    jae afterScore_LAH
    mov cl, [esi]
    cmp cl, '0'
    jb  afterScore_LAH
    cmp cl, '9'
    ja  afterScore_LAH

    mov edx, eax
    shl eax, 1           
    shl edx, 3           
    add eax, edx         
    movzx edx, cl
    sub edx, '0'
    add eax, edx

    inc esi
    jmp scoreLoop_LAH

afterScore_LAH:
    mov ecx, ebp         
    shl ecx, 2          
    mov topScores[ecx], eax

    ; skip spaces before name
skipSpaces2_LAH:
    cmp esi, ebx
    jae afterLine_LAH
    mov al, [esi]
    cmp al, ' '
    je sp2Adv_LAH
    jmp startName_LAH
sp2Adv_LAH:
    inc esi
    jmp skipSpaces2_LAH

startName_LAH:
    mov ecx, ebp
    shl ecx, 5          
    mov edi, OFFSET topNames
    add edi, ecx

    mov ecx, 0           

nameLoop_LAH:
    cmp esi, ebx
    jae endName_LAH
    mov al, [esi]
    cmp al, 13
    je endName_LAH
    cmp al, 10
    je endName_LAH
    cmp ecx, 31
    jge skipRest_LAH

    mov [edi+ecx], al
    inc ecx
    inc esi
    jmp nameLoop_LAH

skipRest_LAH:
    inc esi
    jmp nameLoop_LAH

endName_LAH:
    mov BYTE PTR [edi+ecx], 0
    inc esi                    

afterLine_LAH:
    inc ebp                  
    jmp nextLine_LAH

finishParse_LAH:
    mov scoreCount, ebp       
    cmp ebp, 0
    jle LAH_done
    mov eax, topScores[0]
    mov highScore, eax

    jmp LAH_done

LAH_close:
    mov eax, ebx
    call CloseFile

LAH_done:
    pop ebp
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
LoadAllHighScores ENDP

;---------------------------------------------------
; SaveHighScores
;---------------------------------------------------
SaveHighScores PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov edx, OFFSET highscoreFile
    call CreateOutputFile
    cmp eax, -1
    je  SH_exit

    mov ebx, eax        ; handle

    xor esi, esi        ; index = 0

SH_outer:
    cmp esi, scoreCount
    jge SH_done
    cmp esi, MAX_SCORES
    jge SH_done

    mov edi, OFFSET lineBuffer

    ; convert score to text
    mov eax, esi
    shl eax, 2
    mov eax, topScores[eax]
    call IntToStr          ; EDI now at end of digits

    ; add space
    mov al, ' '
    stosb

    ; copy name
    mov eax, esi
    shl eax, 5             ; *32
    mov edx, OFFSET topNames
    add edx, eax           ; EDX = name ptr

SH_copyName:
    mov al, [edx]
    cmp al, 0
    je  SH_addCRLF
    stosb
    inc edx
    jmp SH_copyName

SH_addCRLF:
    mov al, 13
    stosb
    mov al, 10
    stosb

    ; write this line
    mov eax, ebx           ; handle
    mov edx, OFFSET lineBuffer
    mov ecx, edi
    sub ecx, edx           ; length
    call WriteToFile

    inc esi
    jmp SH_outer

SH_done:
    mov eax, ebx
    call CloseFile

SH_exit:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
SaveHighScores ENDP
 


;---------------------------------------------------
CheckAndSaveHighScore PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ebx, eax          ; newScore
    mov esi, edx          ; player name pointer

    ; if no scores yet
    mov eax, scoreCount
    cmp eax, 0
    jne CSH_hasScores

    ; first record
    mov scoreCount, 1
    mov topScores[0], ebx

    mov edi, OFFSET topNames
    mov ecx, 31
CSH_copyFirst:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    dec ecx
    jz  CSH_firstEnd
    cmp al, 0
    jne CSH_copyFirst
CSH_firstEnd:
    mov BYTE PTR [edi], 0
    jmp CSH_afterInsert

CSH_hasScores:

    mov eax, scoreCount
    cmp eax, MAX_SCORES
    jl  CSH_useEnd

    mov ecx, 0          
    mov edx, topScores[0]
    mov edi, 1

CSH_findMinLoop:
    cmp edi, scoreCount
    jge CSH_checkNew
    mov eax, edi
    shl eax, 2
    mov eax, topScores[eax]
    cmp eax, edx
    jge CSH_nextMin
    mov edx, eax         
    mov ecx, edi         
CSH_nextMin:
    inc edi
    jmp CSH_findMinLoop

CSH_checkNew:
    ; EBX = newScore, EDX = minScore
    cmp ebx, edx
    jle CSH_done         ; new score not good enough ? ignore
    ; else replace slot idxMin
    mov edi, ecx         ; insertIndex = idxMin
    jmp CSH_writeEntry

CSH_useEnd:
    ; insert at end (append)
    mov edi, scoreCount
    inc scoreCount

CSH_writeEntry:
    ; store score at index EDI
    mov eax, edi
    shl eax, 2
    mov topScores[eax], ebx

    mov eax, edi
    shl eax, 5          
    mov edi, OFFSET topNames
    add edi, eax

    mov ecx, 31
CSH_copyName:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    dec ecx
    jz  CSH_nameEnd
    cmp al, 0
    jne CSH_copyName
CSH_nameEnd:
    mov BYTE PTR [edi], 0

CSH_afterInsert:
    mov eax, scoreCount
    cmp eax, 1
    jle CSH_updateTitle

    mov esi, 0                  ; outer index i

CSH_outerLoop:
    mov edi, 0                  ; inner index j
    mov ebx, scoreCount
    dec ebx
    sub ebx, esi                ; ebx = last j

CSH_innerLoop:
    cmp edi, ebx
    jge CSH_outerNext

    ; score[j] in EDX
    mov eax, edi
    shl eax, 2
    mov edx, topScores[eax]

    ; score[j+1] in EAX
    mov eax, edi
    inc eax
    shl eax, 2
    mov eax, topScores[eax]

    cmp edx, eax                
    jge CSH_noSwap

    ; swap scores
    mov ecx, edi
    shl ecx, 2
    mov topScores[ecx], eax

    mov ecx, edi
    inc ecx
    shl ecx, 2
    mov topScores[ecx], edx

    ; swap names (32 bytes)
    mov ecx, 32
    mov eax, edi
    shl eax, 5
    mov esi, OFFSET topNames
    add esi, eax                ; ptr1

    mov eax, edi
    inc eax
    shl eax, 5
    mov edi, OFFSET topNames
    add edi, eax                ; ptr2

CSH_swapNameLoop:
    mov al, [esi]
    mov ah, [edi]
    mov [esi], ah
    mov [edi], al
    inc esi
    inc edi
    dec ecx
    jnz CSH_swapNameLoop

CSH_noSwap:
    inc edi
    jmp CSH_innerLoop

CSH_outerNext:
    inc esi
    mov eax, scoreCount
    dec eax
    cmp esi, eax
    jl CSH_outerLoop

CSH_updateTitle:
    ; update highScore for title screen
    cmp scoreCount, 0
    jle CSH_done
    mov eax, topScores[0]
    mov highScore, eax

    ; save to file
    call SaveHighScores

CSH_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CheckAndSaveHighScore ENDP
;--------------------SOUND FUNCTIONS-----------------------
PlayCoinSound PROC
    INVOKE PlaySoundA, ADDR coinSound, 0, 2001h
    ret
PlayCoinSound ENDP


PlayBGMusic PROC
    cmp bgMusicPlaying, 1
    je PBM_done               
    
    INVOKE PlaySoundA, ADDR bgMusic, 0, 20009h
    mov bgMusicPlaying, 1
    
PBM_done:
    ret
PlayBGMusic ENDP

StopBGMusic PROC
    INVOKE PlaySoundA, 0, 0, 0
    mov bgMusicPlaying, 0
    ret
StopBGMusic ENDP

PlayJumpSound PROC
    INVOKE PlaySoundA, ADDR jumpSound, 0, 20001h
    ret
PlayJumpSound ENDP


PlayDeathSound PROC
    call StopBGMusic
    INVOKE PlaySoundA, ADDR deathSound, 0, 20000h
    ret
PlayDeathSound ENDP

PlayHitSound PROC
    INVOKE PlaySoundA, ADDR hitSound, 0, 20001h
    ret
PlayHitSound ENDP

PlayWinSound PROC
    call StopBGMusic
    INVOKE PlaySoundA, ADDR winSound, 0, 20000h
    ret
PlayWinSound ENDP

PlayPowerSound PROC
    INVOKE PlaySoundA, ADDR powerSound, 0, 20001h
    ret
PlayPowerSound ENDP


;--------------------ENEMY FUNCTIONS-----------------------
DrawGoomba PROC
    cmp goombaActive, 0
    je DG_done
    
    mov eax, red + (lightblue * 16)
    call SetTextColor
    
    mov eax, goombaX
    sub eax, cameraPos
    cmp eax, 0
    jl DG_done
    cmp eax, 79
    jg DG_done
    
    mov dl, al
    mov dh, goombaY
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
DG_done:
    ret
DrawGoomba ENDP

; ==============================================
; ADD THIS PROCEDURE AFTER DrawGoomba
; ==============================================

UpdateGoomba PROC
    cmp goombaActive, 0
    je UG_done
    
    ; Increment counter for automatic movement
    inc goombaCounter
    mov eax, goombaCounter
    cmp eax, 3              ; Move every 3 frames
    jl UG_done
    mov goombaCounter, 0    ; Reset counter
    
    ; Move goomba based on direction
    cmp goombaDir, 1
    je UG_moveRight
    
UG_moveLeft:
    mov eax, goombaX
    cmp eax, goombaMinX
    jle UG_changeToRight
    dec goombaX
    jmp UG_done
    
UG_changeToRight:
    mov goombaDir, 1
    jmp UG_done
    
UG_moveRight:
    mov eax, goombaX
    cmp eax, goombaMaxX
    jge UG_changeToLeft
    inc goombaX
    jmp UG_done
    
UG_changeToLeft:
    mov goombaDir, 0
    
UG_done:
    ret
UpdateGoomba ENDP

; ==============================================
; ADD THIS PROCEDURE AFTER UpdateGoomba
; ==============================================


CheckGoombaCollision PROC
    cmp goombaActive, 0
    je CGC_done
    
    ; Check X collision - Mario needs to be within goomba's range
    ; Goomba occupies 1 char: G
    ; Mario occupies 1 or 3 chars depending on invincibility
    
    mov eax, marioWorldX
    mov ebx, goombaX
    
    ; Check if Mario is too far left
    add ebx, 1              ; goombaX + 1 (right edge of goomba)
    cmp eax, ebx
    jg CGC_done             ; Mario is to the right, no collision
    
    mov ebx, goombaX
    sub ebx, 1              ; goombaX - 1 (left edge accounting for Mario)
    cmp eax, ebx
    jl CGC_done             ; Mario is to the left, no collision
    
    ; X collision confirmed, now check Y
    mov al, yPos
    mov bl, goombaY
    
    ; Check if Mario is jumping on goomba from above
    ; Mario must be 1-2 rows above goomba
    sub bl, 1
    cmp al, bl
    je CGC_fromTop
    sub bl, 1
    cmp al, bl
    je CGC_fromTop
    
    ; Check if Mario is at same level as goomba (side collision)
    mov al, yPos
    mov bl, goombaY
    cmp al, bl
    jne CGC_checkBelow
    
    ; Same Y level - side collision
    cmp invincibleActive, 1
    je CGC_done             ; Invincible, no damage
    
    jmp CGC_hitFromSide
    
CGC_checkBelow:
    ; Check if Mario is 1 below (still counts as side hit)
    inc bl
    cmp al, bl
    jne CGC_done
    
    cmp invincibleActive, 1
    je CGC_done
    
CGC_hitFromSide:
    mov eax, lives
    cmp eax, 0
    jle CGC_gameOver
    dec lives
    
    call PlayHitSound
    mov hitTimer, 30
    
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    mov eax, marioWorldX
    cmp eax, goombaX
    jl CGC_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CGC_done
    
CGC_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CGC_pushOK
    mov eax, 0
CGC_pushOK:
    mov marioWorldX, eax
    jmp CGC_done
    
CGC_fromTop:
    ; Mario jumped on goomba - kill it and add score
    cmp invincibleActive, 1
    je CGC_killGoomba
    
    ; Give Mario a small bounce
    mov al, yPos
    sub al, 2
    mov yPos, al
    
CGC_killGoomba:
    mov goombaActive, 0
    add score, 100
    jmp CGC_done
    
CGC_gameOver:
    ; Handle game over - return to menu
    mov currentState, STATE_MENU
    
CGC_done:
    ret
CheckGoombaCollision ENDP

UpdateHitTimer PROC
    cmp hitTimer, 0
    je UHT_done
    
    dec hitTimer
    
UHT_done:
    ret
UpdateHitTimer ENDP

HandleGameOver PROC

    call PlayDeathSound

    call Clrscr
    
    mov eax, red + (black * 16)
    call SetTextColor
    
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET hudScoreLabel
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, score
    call WriteInt
    
    call ReadChar
    
    ; Go to name entry
    call Clrscr
    mov dl, 10
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET namePrompt
    call WriteString
    
    mov ecx, 32
    mov edi, OFFSET playerName
    xor eax, eax
    rep stosb
    
    mov edx, OFFSET playerName
    mov ecx, 31
    call ReadString
    
    mov eax, score
    mov edx, OFFSET playerName
    call CheckAndSaveHighScore
    
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET hsBack
    call WriteString

HGO_wait:
    call ReadChar
    cmp al, 'b'
    je HGO_menu
    cmp al, 'B'
    je HGO_menu
    jmp HGO_wait

HGO_menu:
    mov currentState, STATE_MENU
    jmp MainLoop
    
    ret
HandleGameOver ENDP


UpdateLevel2Enemies PROC
    call UpdateGoomba1
    call UpdateGoomba2
    call UpdateGoomba3
    call UpdateKoopa1
    call UpdateKoopa2
    call UpdatePiranha1
    call UpdatePiranha2
    ret
UpdateLevel2Enemies ENDP

UpdateGoomba1 PROC
    cmp goomba1Active, 0
    je UG1_done
    inc goomba1Counter
    cmp goomba1Counter, 3
    jl UG1_done
    mov goomba1Counter, 0
    cmp goomba1Dir, 1
    je UG1_right
    dec goomba1X
    cmp goomba1X, 0
    jle UG1_rev
    jmp UG1_done
UG1_right:
    inc goomba1X
    cmp goomba1X, 250
    jge UG1_rev
    jmp UG1_done
UG1_rev:
    xor goomba1Dir, 1
UG1_done:
    ret
UpdateGoomba1 ENDP

UpdateGoomba2 PROC
    cmp goomba2Active, 0
    je UG2_done
    inc goomba2Counter
    cmp goomba2Counter, 3
    jl UG2_done
    mov goomba2Counter, 0
    cmp goomba2Dir, 1
    je UG2_right
    dec goomba2X
    cmp goomba2X, 0
    jle UG2_rev
    jmp UG2_done
UG2_right:
    inc goomba2X
    cmp goomba2X, 250
    jge UG2_rev
    jmp UG2_done
UG2_rev:
    xor goomba2Dir, 1
UG2_done:
    ret
UpdateGoomba2 ENDP

UpdateGoomba3 PROC
    cmp goomba3Active, 0
    je UG3_done
    inc goomba3Counter
    cmp goomba3Counter, 3
    jl UG3_done
    mov goomba3Counter, 0
    cmp goomba3Dir, 1
    je UG3_right
    dec goomba3X
    cmp goomba3X, 0
    jle UG3_rev
    jmp UG3_done
UG3_right:
    inc goomba3X
    cmp goomba3X, 250
    jge UG3_rev
    jmp UG3_done
UG3_rev:
    xor goomba3Dir, 1
UG3_done:
    ret
UpdateGoomba3 ENDP

UpdateKoopa1 PROC
    cmp koopa1Active, 0
    je UK1_done
    cmp koopa1IsShell, 1
    je UK1_done
    inc koopa1Counter
    cmp koopa1Counter, 4
    jl UK1_done
    mov koopa1Counter, 0
    cmp koopa1Dir, 1
    je UK1_right
    dec koopa1X
    cmp koopa1X, 0
    jle UK1_rev
    jmp UK1_done
UK1_right:
    inc koopa1X
    cmp koopa1X, 250
    jge UK1_rev
    jmp UK1_done
UK1_rev:
    xor koopa1Dir, 1
UK1_done:
    ret
UpdateKoopa1 ENDP

UpdateKoopa2 PROC
    cmp koopa2Active, 0
    je UK2_done
    cmp koopa2IsShell, 1
    je UK2_done
    inc koopa2Counter
    cmp koopa2Counter, 4
    jl UK2_done
    mov koopa2Counter, 0
    cmp koopa2Dir, 1
    je UK2_right
    dec koopa2X
    cmp koopa2X, 0
    jle UK2_rev
    jmp UK2_done
UK2_right:
    inc koopa2X
    cmp koopa2X, 250
    jge UK2_rev
    jmp UK2_done
UK2_rev:
    xor koopa2Dir, 1
UK2_done:
    ret
UpdateKoopa2 ENDP

UpdatePiranha1 PROC
    cmp piranha1Active, 0
    je UP1_done
    inc piranha1Timer
    mov eax, marioWorldX
    sub eax, piranha1X
    cmp eax, -3
    jl UP1_toggle
    cmp eax, 3
    jg UP1_toggle
    mov piranha1Out, 0
    jmp UP1_done
UP1_toggle:
    cmp piranha1Timer, 60
    jl UP1_done
    xor piranha1Out, 1
    mov piranha1Timer, 0
UP1_done:
    ret
UpdatePiranha1 ENDP

UpdatePiranha2 PROC
    cmp piranha2Active, 0
    je UP2_done
    inc piranha2Timer
    mov eax, marioWorldX
    sub eax, piranha2X
    cmp eax, -3
    jl UP2_toggle
    cmp eax, 3
    jg UP2_toggle
    mov piranha2Out, 0
    jmp UP2_done
UP2_toggle:
    cmp piranha2Timer, 60
    jl UP2_done
    xor piranha2Out, 1
    mov piranha2Timer, 0
UP2_done:
    ret
UpdatePiranha2 ENDP


; ==============================================
; ENEMY DRAW PROCEDURES
; ==============================================

DrawLevel2Enemies PROC
    call DrawGoomba1
    call DrawGoomba2
    call DrawGoomba3
    call DrawKoopa1
    call DrawKoopa2
    call DrawPiranha1
    call DrawPiranha2
    ret
DrawLevel2Enemies ENDP

DrawGoomba1 PROC
    cmp goomba1Active, 0
    je DG1_done
    
    mov eax, brown + (black * 16)
    call SetTextColor
    
    mov eax, goomba1X
    sub eax, cameraPos
    cmp eax, 0
    jl DG1_done
    cmp eax, 79
    jg DG1_done
    
    mov dl, al
    mov dh, goomba1Y
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
DG1_done:
    ret
DrawGoomba1 ENDP

DrawGoomba2 PROC
    cmp goomba2Active, 0
    je DG2_done
    
    mov eax, brown + (black * 16)
    call SetTextColor
    
    mov eax, goomba2X
    sub eax, cameraPos
    cmp eax, 0
    jl DG2_done
    cmp eax, 79
    jg DG2_done
    
    mov dl, al
    mov dh, goomba2Y
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
DG2_done:
    ret
DrawGoomba2 ENDP

DrawGoomba3 PROC
    cmp goomba3Active, 0
    je DG3_done
    
    mov eax, brown + (black * 16)
    call SetTextColor
    
    mov eax, goomba3X
    sub eax, cameraPos
    cmp eax, 0
    jl DG3_done
    cmp eax, 79
    jg DG3_done
    
    mov dl, al
    mov dh, goomba3Y
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
DG3_done:
    ret
DrawGoomba3 ENDP

DrawKoopa1 PROC
    cmp koopa1Active, 0
    je DK1_done
    
    mov eax, koopa1X
    sub eax, cameraPos
    cmp eax, 0
    jl DK1_done
    cmp eax, 79
    jg DK1_done
    
    mov dl, al
    mov dh, koopa1Y
    call Gotoxy
    
    cmp koopa1IsShell, 1
    je DK1_shell
    
    ; Normal koopa - green
    mov eax, green + (black * 16)
    call SetTextColor
    mov al, 'K'
    call WriteChar
    jmp DK1_done
    
DK1_shell:
    ; Shell - cyan
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov al, 'o'
    call WriteChar
    
DK1_done:
    ret
DrawKoopa1 ENDP

DrawKoopa2 PROC
    cmp koopa2Active, 0
    je DK2_done
    
    mov eax, koopa2X
    sub eax, cameraPos
    cmp eax, 0
    jl DK2_done
    cmp eax, 79
    jg DK2_done
    
    mov dl, al
    mov dh, koopa2Y
    call Gotoxy
    
    cmp koopa2IsShell, 1
    je DK2_shell
    
    ; Normal koopa - red
    mov eax, red + (black * 16)
    call SetTextColor
    mov al, 'K'
    call WriteChar
    jmp DK2_done
    
DK2_shell:
    ; Shell - light red
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov al, 'o'
    call WriteChar
    
DK2_done:
    ret
DrawKoopa2 ENDP

DrawPiranha1 PROC
    cmp piranha1Active, 0
    je DP1_done
    
    cmp piranha1Out, 0
    je DP1_done
    
    mov eax, piranha1X
    sub eax, cameraPos
    cmp eax, 0
    jl DP1_done
    cmp eax, 79
    jg DP1_done
    
    ; Draw pipe first
    mov eax, green + (black * 16)
    call SetTextColor
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    ; Draw piranha on top
    mov eax, piranha1X
    sub eax, cameraPos
    mov dl, al
    mov dh, GROUND_ROW - 3
    call Gotoxy
    mov eax, red + (black * 16)
    call SetTextColor
    mov al, 'P'
    call WriteChar
    
DP1_done:
    ret
DrawPiranha1 ENDP

DrawPiranha2 PROC
    cmp piranha2Active, 0
    je DP2_done
    
    cmp piranha2Out, 0
    je DP2_done
    
    mov eax, piranha2X
    sub eax, cameraPos
    cmp eax, 0
    jl DP2_done
    cmp eax, 79
    jg DP2_done
    
    ; Draw pipe
    mov eax, green + (black * 16)
    call SetTextColor
    mov dl, al
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    ; Draw piranha
    mov eax, piranha2X
    sub eax, cameraPos
    mov dl, al
    mov dh, GROUND_ROW - 3
    call Gotoxy
    mov eax, red + (black * 16)
    call SetTextColor
    mov al, 'P'
    call WriteChar
    
DP2_done:
    ret
DrawPiranha2 ENDP

; ==============================================
; ENEMY COLLISION PROCEDURES
; ==============================================

CheckLevel2Collisions PROC
    call CheckGoomba1Collision
    call CheckGoomba2Collision
    call CheckGoomba3Collision
    call CheckKoopa1Collision
    call CheckKoopa2Collision
    call CheckPiranha1Collision
    call CheckPiranha2Collision
    ret
CheckLevel2Collisions ENDP

CheckGoomba1Collision PROC
    cmp goomba1Active, 0
    je CG1C_done
    
    mov eax, marioWorldX
    mov ebx, goomba1X
    
    add ebx, 1
    cmp eax, ebx
    jg CG1C_done
    
    mov ebx, goomba1X
    sub ebx, 1
    cmp eax, ebx
    jl CG1C_done
    
    ; X collision confirmed, check Y
    mov al, yPos
    mov bl, goomba1Y
    
    sub bl, 1
    cmp al, bl
    je CG1C_fromTop
    sub bl, 1
    cmp al, bl
    je CG1C_fromTop
    
    mov al, yPos
    mov bl, goomba1Y
    cmp al, bl
    jne CG1C_checkBelow
    
    cmp invincibleActive, 1
    je CG1C_done
    
    jmp CG1C_hitFromSide
    
CG1C_checkBelow:
    inc bl
    cmp al, bl
    jne CG1C_done
    
    cmp invincibleActive, 1
    je CG1C_done
    
CG1C_hitFromSide:
    mov eax, lives
    cmp eax, 0
    jle CG1C_gameOver
    dec lives
    call PlayHitSound
    
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    mov eax, marioWorldX
    cmp eax, goomba1X
    jl CG1C_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CG1C_done
    
CG1C_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CG1C_pushOK
    mov eax, 0
CG1C_pushOK:
    mov marioWorldX, eax
    jmp CG1C_done
    
CG1C_fromTop:
    cmp invincibleActive, 1
    je CG1C_killGoomba
    
    mov al, yPos
    sub al, 2
    mov yPos, al
    
CG1C_killGoomba:
    mov goomba1Active, 0
    add score, 100
    jmp CG1C_done
    
CG1C_gameOver:
    call HandleGameOver
    
CG1C_done:
    ret
CheckGoomba1Collision ENDP

; ==============================================
; GOOMBA 2 COLLISION
; ==============================================

CheckGoomba2Collision PROC
    cmp goomba2Active, 0
    je CG2C_done
    
    mov eax, marioWorldX
    mov ebx, goomba2X
    
    add ebx, 1
    cmp eax, ebx
    jg CG2C_done
    
    mov ebx, goomba2X
    sub ebx, 1
    cmp eax, ebx
    jl CG2C_done
    
    mov al, yPos
    mov bl, goomba2Y
    
    sub bl, 1
    cmp al, bl
    je CG2C_fromTop
    sub bl, 1
    cmp al, bl
    je CG2C_fromTop
    
    mov al, yPos
    mov bl, goomba2Y
    cmp al, bl
    jne CG2C_checkBelow
    
    cmp invincibleActive, 1
    je CG2C_done
    
    jmp CG2C_hitFromSide
    
CG2C_checkBelow:
    inc bl
    cmp al, bl
    jne CG2C_done
    
    cmp invincibleActive, 1
    je CG2C_done
    
CG2C_hitFromSide:
    mov eax, lives
    cmp eax, 0
    jle CG2C_gameOver
    dec lives
     call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    mov eax, marioWorldX
    cmp eax, goomba2X
    jl CG2C_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CG2C_done
    
CG2C_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CG2C_pushOK
    mov eax, 0
CG2C_pushOK:
    mov marioWorldX, eax
    jmp CG2C_done
    
CG2C_fromTop:
    cmp invincibleActive, 1
    je CG2C_killGoomba
    
    mov al, yPos
    sub al, 2
    mov yPos, al
    
CG2C_killGoomba:
    mov goomba2Active, 0
    add score, 100
    jmp CG2C_done
    
CG2C_gameOver:
    call HandleGameOver
    
CG2C_done:
    ret
CheckGoomba2Collision ENDP

; ==============================================
; GOOMBA 3 COLLISION
; ==============================================

CheckGoomba3Collision PROC
    cmp goomba3Active, 0
    je CG3C_done
    
    mov eax, marioWorldX
    mov ebx, goomba3X
    
    add ebx, 1
    cmp eax, ebx
    jg CG3C_done
    
    mov ebx, goomba3X
    sub ebx, 1
    cmp eax, ebx
    jl CG3C_done
    
    mov al, yPos
    mov bl, goomba3Y
    
    sub bl, 1
    cmp al, bl
    je CG3C_fromTop
    sub bl, 1
    cmp al, bl
    je CG3C_fromTop
    
    mov al, yPos
    mov bl, goomba3Y
    cmp al, bl
    jne CG3C_checkBelow
    
    cmp invincibleActive, 1
    je CG3C_done
    
    jmp CG3C_hitFromSide
    
CG3C_checkBelow:
    inc bl
    cmp al, bl
    jne CG3C_done
    
    cmp invincibleActive, 1
    je CG3C_done
    
CG3C_hitFromSide:
    mov eax, lives
    cmp eax, 0
    jle CG3C_gameOver
    dec lives
    call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    mov eax, marioWorldX
    cmp eax, goomba3X
    jl CG3C_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CG3C_done
    
CG3C_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CG3C_pushOK
    mov eax, 0
CG3C_pushOK:
    mov marioWorldX, eax
    jmp CG3C_done
    
CG3C_fromTop:
    cmp invincibleActive, 1
    je CG3C_killGoomba
    
    mov al, yPos
    sub al, 2
    mov yPos, al
    
CG3C_killGoomba:
    mov goomba3Active, 0
    add score, 100
    jmp CG3C_done
    
CG3C_gameOver:
    call HandleGameOver
    
CG3C_done:
    ret
CheckGoomba3Collision ENDP

; ==============================================
; KOOPA 1 COLLISION
; ==============================================



CheckKoopa1Collision PROC
    cmp koopa1Active, 0
    je CK1C_done
    
    ; Check X collision
    mov eax, marioWorldX
    mov ebx, koopa1X
    
    ; Check if Mario is too far right
    mov ecx, ebx
    add ecx, 1
    cmp eax, ecx
    jg CK1C_done
    
    ; Check if Mario is too far left
    mov ecx, ebx
    sub ecx, 1
    cmp eax, ecx
    jl CK1C_done
    
    ; X collision confirmed, check Y
    movzx eax, yPos
    movzx ebx, koopa1Y
    
    ; Check if Mario is above koopa (jumping on it)
    ; Mario Y should be 1-3 rows above koopa Y
    mov ecx, ebx
    sub ecx, 1          ; koopa1Y - 1
    cmp eax, ecx
    je CK1C_fromTop
    
    mov ecx, ebx
    sub ecx, 2          ; koopa1Y - 2
    cmp eax, ecx
    je CK1C_fromTop
    
    mov ecx, ebx
    sub ecx, 3          ; koopa1Y - 3
    cmp eax, ecx
    je CK1C_fromTop
    
    ; Check if Mario is at same level as koopa (side collision)
    cmp eax, ebx
    jne CK1C_checkBelow
    
    ; Same Y level - side collision
    cmp koopa1IsShell, 1
    je CK1C_kickShell       ; If already shell, kick it
    
    cmp invincibleActive, 1
    je CK1C_done
    
    jmp CK1C_hitFromSide
    
CK1C_checkBelow:
    ; Check if Mario is 1 below
    mov ecx, ebx
    add ecx, 1
    cmp eax, ecx
    jne CK1C_done
    
    cmp koopa1IsShell, 1
    je CK1C_kickShell
    
    cmp invincibleActive, 1
    je CK1C_done
    
CK1C_hitFromSide:
    ; Mario hit koopa from side - lose life
    mov eax, lives
    cmp eax, 0
    jle CK1C_gameOver
    dec lives
     call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    ; Push Mario back
    mov eax, marioWorldX
    cmp eax, koopa1X
    jl CK1C_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CK1C_done
    
CK1C_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CK1C_pushOK
    mov eax, 0
CK1C_pushOK:
    mov marioWorldX, eax
    jmp CK1C_done
    
CK1C_fromTop:
    ; Mario jumped on koopa from above
    cmp koopa1IsShell, 1
    je CK1C_kickShell       ; Already a shell, kick it
    
    ; Turn koopa into shell
    mov koopa1IsShell, 1
    add score, 100
    
    ; Bounce Mario up
    mov al, yPos
    sub al, 2
    mov yPos, al
    
    jmp CK1C_done
    
CK1C_kickShell:
    ; Kick the shell (for now just deactivate it)
    mov koopa1Active, 0
    add score, 200
    jmp CK1C_done
    
CK1C_gameOver:
    call HandleGameOver
    
CK1C_done:
    ret
CheckKoopa1Collision ENDP

; ==============================================
; KOOPA 2 COLLISION - FIXED
; ==============================================

CheckKoopa2Collision PROC
    cmp koopa2Active, 0
    je CK2C_done
    
    ; Check X collision
    mov eax, marioWorldX
    mov ebx, koopa2X
    
    ; Check if Mario is too far right
    mov ecx, ebx
    add ecx, 1
    cmp eax, ecx
    jg CK2C_done
    
    ; Check if Mario is too far left
    mov ecx, ebx
    sub ecx, 1
    cmp eax, ecx
    jl CK2C_done
    
    ; X collision confirmed, check Y
    movzx eax, yPos
    movzx ebx, koopa2Y
    
    ; Check if Mario is above koopa (jumping on it)
    ; Mario Y should be 1-3 rows above koopa Y
    mov ecx, ebx
    sub ecx, 1          ; koopa2Y - 1
    cmp eax, ecx
    je CK2C_fromTop
    
    mov ecx, ebx
    sub ecx, 2          ; koopa2Y - 2
    cmp eax, ecx
    je CK2C_fromTop
    
    mov ecx, ebx
    sub ecx, 3          ; koopa2Y - 3
    cmp eax, ecx
    je CK2C_fromTop
    
    ; Check if Mario is at same level as koopa (side collision)
    cmp eax, ebx
    jne CK2C_checkBelow
    
    ; Same Y level - side collision
    cmp koopa2IsShell, 1
    je CK2C_kickShell       ; If already shell, kick it
    
    cmp invincibleActive, 1
    je CK2C_done
    
    jmp CK2C_hitFromSide
    
CK2C_checkBelow:
    ; Check if Mario is 1 below
    mov ecx, ebx
    add ecx, 1
    cmp eax, ecx
    jne CK2C_done
    
    cmp koopa2IsShell, 1
    je CK2C_kickShell
    
    cmp invincibleActive, 1
    je CK2C_done
    
CK2C_hitFromSide:
    ; Mario hit koopa from side - lose life
    mov eax, lives
    cmp eax, 0
    jle CK2C_gameOver
    dec lives
    call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    ; Push Mario back
    mov eax, marioWorldX
    cmp eax, koopa2X
    jl CK2C_pushLeft
    
    add eax, 5
    mov marioWorldX, eax
    jmp CK2C_done
    
CK2C_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CK2C_pushOK
    mov eax, 0
CK2C_pushOK:
    mov marioWorldX, eax
    jmp CK2C_done
    
CK2C_fromTop:
    ; Mario jumped on koopa from above
    cmp koopa2IsShell, 1
    je CK2C_kickShell       ; Already a shell, kick it
    
    ; Turn koopa into shell
    mov koopa2IsShell, 1
    add score, 100
    
    ; Bounce Mario up
    mov al, yPos
    sub al, 2
    mov yPos, al
    
    jmp CK2C_done
    
CK2C_kickShell:
    ; Kick the shell (for now just deactivate it)
    mov koopa2Active, 0
    add score, 200
    jmp CK2C_done
    
CK2C_gameOver:
    call HandleGameOver
    
CK2C_done:
    ret
CheckKoopa2Collision ENDP
; ==============================================
; PIRANHA 1 COLLISION
; ==============================================

CheckPiranha1Collision PROC
    cmp piranha1Active, 0
    je CP1C_done
    
    cmp piranha1Out, 0
    je CP1C_done
    
    mov eax, marioWorldX
    mov ebx, piranha1X
    
    add ebx, 1
    cmp eax, ebx
    jg CP1C_done
    
    mov ebx, piranha1X
    sub ebx, 1
    cmp eax, ebx
    jl CP1C_done
    
    ; Check Y - piranha is 3 rows above ground
    mov al, yPos
    mov bl, GROUND_ROW
    sub bl, 3
    
    ; Check if Mario is within 2 rows of piranha
    sub al, bl
    cmp al, -2
    jl CP1C_done
    cmp al, 2
    jg CP1C_done
    
    ; Hit piranha
    cmp invincibleActive, 1
    je CP1C_done
    
    mov eax, lives
    cmp eax, 0
    jle CP1C_gameOver
    dec lives
    call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    jmp CP1C_done
    
CP1C_gameOver:
    call HandleGameOver
    
CP1C_done:
    ret
CheckPiranha1Collision ENDP

; ==============================================
; PIRANHA 2 COLLISION
; ==============================================

CheckPiranha2Collision PROC
    cmp piranha2Active, 0
    je CP2C_done
    
    cmp piranha2Out, 0
    je CP2C_done
    
    mov eax, marioWorldX
    mov ebx, piranha2X
    
    add ebx, 1
    cmp eax, ebx
    jg CP2C_done
    
    mov ebx, piranha2X
    sub ebx, 1
    cmp eax, ebx
    jl CP2C_done
    
    mov al, yPos
    mov bl, GROUND_ROW
    sub bl, 3
    
    sub al, bl
    cmp al, -2
    jl CP2C_done
    cmp al, 2
    jg CP2C_done
    
    cmp invincibleActive, 1
    je CP2C_done
    
    mov eax, lives
    cmp eax, 0
    jle CP2C_gameOver
    dec lives
     call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    jmp CP2C_done
    
CP2C_gameOver:
    call HandleGameOver
    
CP2C_done:
    ret
CheckPiranha2Collision ENDP

InitLevel2 PROC
    push eax
    push ecx
    push edi
    
    mov levelNum, 2
    mov levelLength, 280
    
    ; Reset Mario
    mov marioWorldX, 20
    mov xPos, 20
    mov yPos, 28
    mov cameraPos, 0
    mov cloudScroll, 0
    
    ; IMPORTANT: Move Level 1 pipes off the map so Mario doesn't get stuck
    mov pipe1X, 9999
    mov pipe2X, 9999
    
    ; Setup maze platforms
    mov eax, level2Platform1X
    mov platform1X, eax
    mov al, level2Platform1Y
    mov platform1Y, al
    mov eax, level2Platform1W
    mov platform1Width, eax
    
    mov eax, level2Platform2X
    mov platform2X, eax
    mov al, level2Platform2Y
    mov platform2Y, al
    mov eax, level2Platform2W
    mov platform2Width, eax
    
    mov eax, level2Platform3X
    mov platform3X, eax
    mov al, level2Platform3Y
    mov platform3Y, al
    mov eax, level2Platform3W
    mov platform3Width, eax
    
    mov eax, level2Platform4X
    mov platform4X, eax
    mov al, level2Platform4Y
    mov platform4Y, al
    mov eax, level2Platform4W
    mov platform4Width, eax
    
    mov eax, level2Platform5X
    mov platform5X, eax
    mov al, level2Platform5Y
    mov platform5Y, al
    mov eax, level2Platform5W
    mov platform5Width, eax
    
    ; ===== INITIALIZE PLATFORM 1 COINS =====
    mov eax, platform1X
    add eax, 1
    mov plat1CoinX[0], eax
    add eax, 2
    mov plat1CoinX[4], eax
    add eax, 2
    mov plat1CoinX[8], eax
    add eax, 2
    mov plat1CoinX[12], eax
    
    mov al, platform1Y
    dec al
    mov plat1CoinY[0], al
    mov plat1CoinY[1], al
    mov plat1CoinY[2], al
    mov plat1CoinY[3], al
    
    mov plat1CoinActive[0], 1
    mov plat1CoinActive[1], 1
    mov plat1CoinActive[2], 1
    mov plat1CoinActive[3], 1
    
    ; ===== INITIALIZE PLATFORM 2 COINS =====
    mov eax, platform2X
    add eax, 1
    mov plat2CoinX[0], eax
    add eax, 1
    mov plat2CoinX[4], eax
    add eax, 1
    mov plat2CoinX[8], eax
    add eax, 1
    mov plat2CoinX[12], eax
    add eax, 1
    mov plat2CoinX[16], eax
    add eax, 1
    mov plat2CoinX[20], eax
    add eax, 1
    mov plat2CoinX[24], eax

    mov al, platform2Y
    dec al
    mov plat2CoinY[0], al
    mov plat2CoinY[1], al
    mov plat2CoinY[2], al
    mov plat2CoinY[3], al
    mov plat2CoinY[4], al
    mov plat2CoinY[5], al
    mov plat2CoinY[6], al

    mov plat2CoinActive[0], 1
    mov plat2CoinActive[1], 1
    mov plat2CoinActive[2], 1
    mov plat2CoinActive[3], 1
    mov plat2CoinActive[4], 1
    mov plat2CoinActive[5], 1
    mov plat2CoinActive[6], 1

    ; ===== INITIALIZE PLATFORM 3 COINS =====
    mov eax, platform3X
    add eax, 1
    mov plat3CoinX[0], eax
    add eax, 1
    mov plat3CoinX[4], eax
    add eax, 1
    mov plat3CoinX[8], eax
    add eax, 1
    mov plat3CoinX[12], eax
    add eax, 1
    mov plat3CoinX[16], eax
    add eax, 1
    mov plat3CoinX[20], eax
    add eax, 1
    mov plat3CoinX[24], eax

    mov al, platform3Y
    dec al
    mov plat3CoinY[0], al
    mov plat3CoinY[1], al
    mov plat3CoinY[2], al
    mov plat3CoinY[3], al
    mov plat3CoinY[4], al
    mov plat3CoinY[5], al
    mov plat3CoinY[6], al

    mov plat3CoinActive[0], 1
    mov plat3CoinActive[1], 1
    mov plat3CoinActive[2], 1
    mov plat3CoinActive[3], 1
    mov plat3CoinActive[4], 1
    mov plat3CoinActive[5], 1
    mov plat3CoinActive[6], 1

    ; ===== INITIALIZE PLATFORM 4 COINS =====
    mov eax, platform4X
    add eax, 1
    mov plat4CoinX[0], eax
    add eax, 1
    mov plat4CoinX[4], eax
    add eax, 1
    mov plat4CoinX[8], eax
    add eax, 1
    mov plat4CoinX[12], eax
    add eax, 1
    mov plat4CoinX[16], eax
    add eax, 1
    mov plat4CoinX[20], eax
    add eax, 1
    mov plat4CoinX[24], eax
    add eax, 1
    mov plat4CoinX[28], eax
    add eax, 1
    mov plat4CoinX[32], eax
    add eax, 1
    mov plat4CoinX[36], eax

    mov al, platform4Y
    dec al
    mov plat4CoinY[0], al
    mov plat4CoinY[1], al
    mov plat4CoinY[2], al
    mov plat4CoinY[3], al
    mov plat4CoinY[4], al
    mov plat4CoinY[5], al
    mov plat4CoinY[6], al
    mov plat4CoinY[7], al
    mov plat4CoinY[8], al
    mov plat4CoinY[9], al

    mov ecx, 10
    mov edi, OFFSET plat4CoinActive
initL2P4Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initL2P4Loop

    ; ===== INITIALIZE PLATFORM 5 COINS =====
    mov eax, platform5X
    add eax, 1
    mov plat5CoinX[0], eax
    add eax, 1
    mov plat5CoinX[4], eax
    add eax, 1
    mov plat5CoinX[8], eax
    add eax, 1
    mov plat5CoinX[12], eax
    add eax, 1
    mov plat5CoinX[16], eax
    add eax, 1
    mov plat5CoinX[20], eax
    add eax, 1
    mov plat5CoinX[24], eax
    add eax, 1
    mov plat5CoinX[28], eax
    add eax, 1
    mov plat5CoinX[32], eax

    mov al, platform5Y
    dec al
    mov plat5CoinY[0], al
    mov plat5CoinY[1], al
    mov plat5CoinY[2], al
    mov plat5CoinY[3], al
    mov plat5CoinY[4], al
    mov plat5CoinY[5], al
    mov plat5CoinY[6], al
    mov plat5CoinY[7], al
    mov plat5CoinY[8], al

    mov ecx, 9
    mov edi, OFFSET plat5CoinActive
initL2P5Loop:
    mov BYTE PTR [edi], 1
    inc edi
    loop initL2P5Loop
    
    ; Setup mushroom and flag
    mov eax, level2MushroomX
    mov mushroomX, eax
    mov mushroomY, 28
    mov mushroomActive, 1
    
    mov eax, level2FlagPoleX
    mov flagPoleX, eax
    
    ; Activate Level 2 enemies
    mov goomba1X, 80
    mov goomba1Y, 28
    mov goomba1Active, 1
    mov goomba1Dir, 1
    mov goomba1Counter, 0
    
    mov goomba2X, 150
    mov goomba2Y, 28
    mov goomba2Active, 1
    mov goomba2Dir, 0
    mov goomba2Counter, 0
    
    mov goomba3X, 200
    mov goomba3Y, 28
    mov goomba3Active, 1
    mov goomba3Dir, 1
    mov goomba3Counter, 0
    
    mov koopa1X, 100
    mov koopa1Y, 28
    mov koopa1Active, 1
    mov koopa1Dir, 1
    mov koopa1IsShell, 0
    mov koopa1Counter, 0
    
    mov koopa2X, 180
    mov koopa2Y, 28
    mov koopa2Active, 1
    mov koopa2Dir, 0
    mov koopa2IsShell, 0
    mov koopa2Counter, 0
    
    mov piranha1X, 120
    mov piranha1Active, 1
    mov piranha1Out, 0
    mov piranha1Timer, 0
    
    mov piranha2X, 200
    mov piranha2Active, 1
    mov piranha2Out, 0
    mov piranha2Timer, 0
    
    ; Deactivate Level 1 goomba
    mov goombaActive, 0
    
    mov invincibleActive, 0
    mov invincibleTimer, 0
    call InitSecretTrigger
    
    mov shipScroll, 0
    
    mov currentJumpHeight, 3
    mov superJumpTimer, 0

    pop edi
    pop ecx
    pop eax
    ret
InitLevel2 ENDP

; =====================================================
; INITIALIZE SECRET ROOM TRIGGER (call in InitLevel2)
; =====================================================

InitSecretTrigger PROC
    ; Platform 6 is already set in data section
    ; Just make sure trigger coin is active
    mov triggerCoinActive, 1
    mov inSecretRoom, 0
    
    ; Reset secret room items
    mov ecx, 10
    mov edi, OFFSET secretCoinActive
ResetSecretCoins:
    mov BYTE PTR [edi], 1
    inc edi
    loop ResetSecretCoins
    
    mov secretLifeActive[0], 1
    mov secretLifeActive[1], 1
    mov secretLifeActive[2], 1
    
    ret
InitSecretTrigger ENDP





; =====================================================
; ENTER SECRET ROOM
; =====================================================
EnterSecretRoom PROC
    push eax
    
    ; Save current Level 2 position
    mov eax, marioWorldX
    mov savedMarioX, eax
    mov eax, cameraPos
    mov savedCameraPos, eax
    
    ; Show entrance message
    call Clrscr
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 25
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET secretRoomMsg
    call WriteString
    
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET secretRoomMsg2
    call WriteString
    
    mov eax, 2000
    call Delay
    
    ; Set secret room state
    mov inSecretRoom, 1
    
    ; Set Mario position for secret room
    ; Platform is at Y=26, so Mario stands at Y=25
    mov marioWorldX, 10
    mov xPos, 10
    mov yPos, 25
    mov cameraPos, 0
    mov isJumping, 0
    
    pop eax
    ret
EnterSecretRoom ENDP

; =====================================================
; EXIT SECRET ROOM 
; =====================================================
ExitSecretRoom PROC
    push eax
    push ebx
    
    ; CRITICAL: Clear secret room flag FIRST
    mov inSecretRoom, 0
    
    call Clrscr
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET secretExitMsg
    call WriteString
    
    mov eax, 1500
    call Delay
    
    ; Restore position past trigger coin
    mov eax, savedMarioX
    add eax, 3            
    mov marioWorldX, eax
    
    mov eax, savedCameraPos
    mov cameraPos, eax
    
    mov yPos, 28
    mov isJumping, 0
    
    ; CRITICAL: Reset level end flag so it can be triggered again
    mov levelEndFlag, 0
    
    ; Make sure flag pole is set correctly for Level 2
    mov eax, level2FlagPoleX
    mov flagPoleX, eax
    
    pop ebx
    pop eax
    ret
ExitSecretRoom ENDP

; ====================================================
; DRAW SECRET ROOM 
; =====================================================
DrawSecretRoom PROC
    ; Clear screen with black background
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    
    ; Draw HUD
    call DrawHUD
    
    ; Draw decorative stars
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 5
    mov dh, 5
    call Gotoxy
    mov al, '.'
    call WriteChar
    
    mov dl, 15
    mov dh, 4
    call Gotoxy
    mov al, '*'
    call WriteChar
    
    mov dl, 30
    mov dh, 6
    call Gotoxy
    mov al, '.'
    call WriteChar
    
    mov dl, 45
    mov dh, 5
    call Gotoxy
    mov al, '*'
    call WriteChar
    
    mov dl, 60
    mov dh, 7
    call Gotoxy
    mov al, '.'
    call WriteChar
    
    mov dl, 70
    mov dh, 4
    call Gotoxy
    mov al, '*'
    call WriteChar
    
    ; Draw secret platform at Y=26
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    
    mov dl, 5
    mov dh, 26
    call Gotoxy
    
    mov ecx, 65
DSR_platLoop:
    cmp dl, 70
    jge DSR_platDone
    mov al, '='
    call WriteChar
    inc dl
    loop DSR_platLoop
    
DSR_platDone:
    
    ; Draw hearts at Y=25
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    cmp secretLifeActive[0], 1
    jne DSR_skipH0
    mov dl, 18
    mov dh, 25
    call Gotoxy
    mov al, 'H'
    call WriteChar
DSR_skipH0:

    cmp secretLifeActive[1], 1
    jne DSR_skipH1
    mov dl, 35
    mov dh, 25
    call Gotoxy
    mov al, 'H'
    call WriteChar
DSR_skipH1:

    cmp secretLifeActive[2], 1
    jne DSR_skipH2
    mov dl, 52
    mov dh, 25
    call Gotoxy
    mov al, 'H'
    call WriteChar
DSR_skipH2:

    ; Draw coins at Y=25
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    cmp secretCoinActive[0], 1
    jne DSR_skipC0
    mov dl, 8
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC0:

    cmp secretCoinActive[1], 1
    jne DSR_skipC1
    mov dl, 14
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC1:

    cmp secretCoinActive[2], 1
    jne DSR_skipC2
    mov dl, 20
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC2:

    cmp secretCoinActive[3], 1
    jne DSR_skipC3
    mov dl, 26
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC3:

    cmp secretCoinActive[4], 1
    jne DSR_skipC4
    mov dl, 32
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC4:

    cmp secretCoinActive[5], 1
    jne DSR_skipC5
    mov dl, 38
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC5:

    cmp secretCoinActive[6], 1
    jne DSR_skipC6
    mov dl, 44
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC6:

    cmp secretCoinActive[7], 1
    jne DSR_skipC7
    mov dl, 50
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC7:

    cmp secretCoinActive[8], 1
    jne DSR_skipC8
    mov dl, 56
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC8:

    cmp secretCoinActive[9], 1
    jne DSR_skipC9
    mov dl, 62
    mov dh, 25
    call Gotoxy
    mov al, 'o'
    call WriteChar
DSR_skipC9:

    ; Draw exit portal
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 66
    mov dh, 20
    call Gotoxy
    mov al, 'E'
    call WriteChar
    mov al, 'X'
    call WriteChar
    mov al, 'I'
    call WriteChar
    mov al, 'T'
    call WriteChar
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov dl, 66
    mov dh, 21
    call Gotoxy
    mov al, '['
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ']'
    call WriteChar
    
    mov ecx, 4
    mov dh, 22
DSR_portalLoop:
    mov dl, 66
    call Gotoxy
    mov al, '|'
    call WriteChar
    mov dl, 69
    call Gotoxy
    mov al, '|'
    call WriteChar
    inc dh
    loop DSR_portalLoop
    
    ; Draw ground
    mov eax, green + (black * 16)
    call SetTextColor
    
    mov dl, 0
    mov dh, GROUND_ROW
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    ; Apply gravity BEFORE drawing Mario
    call ApplySecretGravity
    
    ; Draw Mario at marioWorldX (no camera offset in secret room)
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov eax, marioWorldX
    mov dl, al
    mov dh, yPos
    call Gotoxy
    mov al, 'M'
    call WriteChar
    
    ; Check collisions
    call CheckSecretCollisions
    
    ret
DrawSecretRoom ENDP

; =====================================================
; DRAW MARIO IN SECRET ROOM 
; =====================================================

DrawSecretMario PROC
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    call RecomputeScreenX
    
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov al, 'M'
    call WriteChar
    
    ret
DrawSecretMario ENDP

; =====================================================
; CHECK SECRET ROOM PLATFORMS
; =====================================================


CheckSecretPlatform PROC
    push ebx
    push ecx
    
    xor eax, eax     ; assume not on platform
    
    ; Mario must be at Y=25 to stand on platform at Y=26
    movzx ecx, yPos
    cmp ecx, 25
    jne CSP_none
    
    ; Check X bounds (platform from X=5 to X=70)
    mov ecx, marioWorldX
    cmp ecx, 5
    jl CSP_none
    cmp ecx, 70
    jg CSP_none
    
    ; On platform!
    mov eax, 1
    jmp CSP_exit
    
CSP_none:
    xor eax, eax
    
CSP_exit:
    pop ecx
    pop ebx
    ret
CheckSecretPlatform ENDP

; =====================================================
; APPLY SECRET GRAVITY 
; =====================================================

ApplySecretGravity PROC
    ; Don't apply gravity if jumping
    cmp isJumping, 1
    je ASG_done
    
    ; Check if at ground level
    movzx eax, yPos
    cmp eax, GROUND_ROW - 1
    jge ASG_done
    
    ; Check if on secret platform (Y=25, platform at Y=26)
    cmp yPos, 25
    jne ASG_checkGround
    
    ; Check X bounds for platform
    mov eax, marioWorldX
    cmp eax, 5
    jl ASG_fall
    cmp eax, 70
    jg ASG_fall
    
    ; On platform, don't fall
    jmp ASG_done
    
ASG_checkGround:
    ; Check if at ground
    cmp yPos, 28
    jge ASG_done
    
ASG_fall:
    ; Fall down
    inc yPos
    
ASG_done:
    ret
ApplySecretGravity ENDP

; =====================================================
; CHECK SECRET COLLISIONS - FIXED
; =====================================================

; =====================================================
; CHECK SECRET COLLISIONS - FIXED
; =====================================================



 CheckSecretCollisions PROC
    
    ; Coins at Y=25, various X positions
    cmp secretCoinActive[0], 1
    jne CSC_coin1
    mov eax, marioWorldX
    cmp eax, 8
    jne CSC_coin1
    cmp yPos, 25
    jne CSC_coin1
    mov secretCoinActive[0], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin1:
    cmp secretCoinActive[1], 1
    jne CSC_coin2
    mov eax, marioWorldX
    cmp eax, 14
    jne CSC_coin2
    cmp yPos, 25
    jne CSC_coin2
    mov secretCoinActive[1], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin2:
    cmp secretCoinActive[2], 1
    jne CSC_coin3
    mov eax, marioWorldX
    cmp eax, 20
    jne CSC_coin3
    cmp yPos, 25
    jne CSC_coin3
    mov secretCoinActive[2], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin3:
    cmp secretCoinActive[3], 1
    jne CSC_coin4
    mov eax, marioWorldX
    cmp eax, 26
    jne CSC_coin4
    cmp yPos, 25
    jne CSC_coin4
    mov secretCoinActive[3], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin4:
    cmp secretCoinActive[4], 1
    jne CSC_coin5
    mov eax, marioWorldX
    cmp eax, 32
    jne CSC_coin5
    cmp yPos, 25
    jne CSC_coin5
    mov secretCoinActive[4], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin5:
    cmp secretCoinActive[5], 1
    jne CSC_coin6
    mov eax, marioWorldX
    cmp eax, 38
    jne CSC_coin6
    cmp yPos, 25
    jne CSC_coin6
    mov secretCoinActive[5], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin6:
    cmp secretCoinActive[6], 1
    jne CSC_coin7
    mov eax, marioWorldX
    cmp eax, 44
    jne CSC_coin7
    cmp yPos, 25
    jne CSC_coin7
    mov secretCoinActive[6], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin7:
    cmp secretCoinActive[7], 1
    jne CSC_coin8
    mov eax, marioWorldX
    cmp eax, 50
    jne CSC_coin8
    cmp yPos, 25
    jne CSC_coin8
    mov secretCoinActive[7], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin8:
    cmp secretCoinActive[8], 1
    jne CSC_coin9
    mov eax, marioWorldX
    cmp eax, 56
    jne CSC_coin9
    cmp yPos, 25
    jne CSC_coin9
    mov secretCoinActive[8], 0
    inc coins
    add score, 200
    call PlayCoinSound
    
CSC_coin9:
    cmp secretCoinActive[9], 1
    jne CSC_checkLives
    mov eax, marioWorldX
    cmp eax, 62
    jne CSC_checkLives
    cmp yPos, 25
    jne CSC_checkLives
    mov secretCoinActive[9], 0
    inc coins
    add score, 200
    call PlayCoinSound

CSC_checkLives:
    ; Hearts at Y=25
    cmp secretLifeActive[0], 1
    jne CSC_life1
    mov eax, marioWorldX
    cmp eax, 18
    jne CSC_life1
    cmp yPos, 25
    jne CSC_life1
    mov secretLifeActive[0], 0
    inc lives
    add score, 1000
    call PlayPowerSound
    
CSC_life1:
    cmp secretLifeActive[1], 1
    jne CSC_life2
    mov eax, marioWorldX
    cmp eax, 35
    jne CSC_life2
    cmp yPos, 25
    jne CSC_life2
    mov secretLifeActive[1], 0
    inc lives
    add score, 1000
    call PlayPowerSound
    
CSC_life2:
    cmp secretLifeActive[2], 1
    jne CSC_checkExit
    mov eax, marioWorldX
    cmp eax, 52
    jne CSC_checkExit
    cmp yPos, 25
    jne CSC_checkExit
    mov secretLifeActive[2], 0
    inc lives
    add score, 1000
    call PlayPowerSound

CSC_checkExit:
    ; Exit portal at X=66-70
    mov eax, marioWorldX
    cmp eax, 66
    jl CSC_done
    cmp eax, 70
    jg CSC_done
    
    ; Any Y position near bottom half works
    cmp yPos, 20
    jl CSC_done
    
    ; Exit!
    call ExitSecretRoom
    
CSC_done:
    ret
CheckSecretCollisions ENDP

; =====================================================
; DRAW PLATFORM 6 
; =====================================================

DrawPlatform6 PROC
    mov eax, levelNum
    cmp eax, 2
    jne DP6_done
    
    cmp inSecretRoom, 1
    je DP6_done
    
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    
    mov eax, platform6X
    sub eax, cameraPos
    cmp eax, 0
    jl DP6_done
    cmp eax, 79
    jg DP6_done
    
    mov dl, al
    mov dh, platform6Y
    call Gotoxy
    
    mov ecx, platform6Width
DP6_loop:
    mov al, '='
    call WriteChar
    loop DP6_loop
    
DP6_done:
    ret
DrawPlatform6 ENDP

; =====================================================
; DRAW TRIGGER COIN 
; =====================================================

DrawTriggerCoin PROC
    ; Only in Level 2, not in secret room
    mov eax, levelNum
    cmp eax, 2
    jne DTC_done
    
    cmp inSecretRoom, 1
    je DTC_done
    
    cmp triggerCoinActive, 1
    jne DTC_done
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov eax, triggerCoinX
    sub eax, cameraPos
    cmp eax, 0
    jl DTC_done
    cmp eax, 79
    jg DTC_done
    
    mov dl, al
    mov dh, triggerCoinY
    call Gotoxy
    mov al, '*'     ; Star to show it's special
    call WriteChar
    
DTC_done:
    ret
DrawTriggerCoin ENDP

; =====================================================
; CHECK TRIGGER COIN
; =====================================================

CheckTriggerCoin PROC
    ; Only in Level 2, not in secret room
    mov eax, levelNum
    cmp eax, 2
    jne CTC_done
    
    cmp inSecretRoom, 1
    je CTC_done
    
    cmp triggerCoinActive, 1
    jne CTC_done
    
    ; Check collision
    mov eax, marioWorldX
    cmp eax, triggerCoinX
    jne CTC_done
    
    movzx eax, yPos
    movzx ebx, triggerCoinY
    cmp eax, ebx
    jne CTC_done
    
    ; Collected trigger coin - enter secret room!
    mov triggerCoinActive, 0
    inc coins
    add score, 500
    call PlayCoinSound
    
    call EnterSecretRoom
    
CTC_done:
    ret
CheckTriggerCoin ENDP


;=====================================================
; DRAW TREES FOR LEVEL 1
;=====================================================
DrawTrees PROC
    push eax
    push ebx
    push edx
    
    mov eax, levelNum
    cmp eax, 1
    jne DT_done
    
    ; Draw all 6 trees
    mov eax, tree1X
    call DrawSingleTree
    mov eax, tree2X
    call DrawSingleTree
    mov eax, tree3X
    call DrawSingleTree
    mov eax, tree4X
    call DrawSingleTree
    mov eax, tree5X
    call DrawSingleTree
    mov eax, tree6X
    call DrawSingleTree
    
DT_done:
    pop edx
    pop ebx
    pop eax
    ret
DrawTrees ENDP

; Draw single tree at world X in EAX
DrawSingleTree PROC
    push eax
    push ebx
    push edx
    
    sub eax, cameraPos
    cmp eax, 0
    jl DST_done
    cmp eax, 74
    jg DST_done
    
    mov ebx, eax
    
    ; Draw foliage (green)
    mov eax, green + (lightblue * 16)
    call SetTextColor
    
    mov dl, bl
    mov dh, GROUND_ROW - 6
    call Gotoxy
    mov edx, OFFSET treeTop1
    call WriteString
    
    mov dl, bl
    mov dh, GROUND_ROW - 5
    call Gotoxy
    mov edx, OFFSET treeTop2
    call WriteString
    
    mov dl, bl
    mov dh, GROUND_ROW - 4
    call Gotoxy
    mov edx, OFFSET treeTop3
    call WriteString
    
    ; Draw trunk (brown)
    mov eax, brown + (lightblue * 16)
    call SetTextColor
    
    mov dl, bl
    mov dh, GROUND_ROW - 3
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    
    mov dl, bl
    mov dh, GROUND_ROW - 2
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    
    mov dl, bl
    mov dh, GROUND_ROW - 1
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    
DST_done:
    pop edx
    pop ebx
    pop eax
    ret
DrawSingleTree ENDP

;=====================================================
; DRAW BIRDS FOR LEVEL 1
;=====================================================
DrawBirds PROC
    push eax
    push edx
    
    mov eax, levelNum
    cmp eax, 1
    jne DB_done
    
    mov eax, black + (lightblue * 16)
    call SetTextColor
    
    ; Bird 1
    mov eax, bird1X
    sub eax, cameraPos
    cmp eax, 0
    jl DB_bird2
    cmp eax, 79
    jg DB_bird2
    mov dl, al
    mov dh, bird1Y
    call Gotoxy
    cmp bird1Frame, 0
    je DB_b1_down
    mov al, '^'
    jmp DB_b1_draw
DB_b1_down:
    mov al, 'v'
DB_b1_draw:
    call WriteChar
    
DB_bird2:
    mov eax, bird2X
    sub eax, cameraPos
    cmp eax, 0
    jl DB_bird3
    cmp eax, 79
    jg DB_bird3
    mov dl, al
    mov dh, bird2Y
    call Gotoxy
    cmp bird2Frame, 0
    je DB_b2_down
    mov al, '^'
    jmp DB_b2_draw
DB_b2_down:
    mov al, 'v'
DB_b2_draw:
    call WriteChar
    
DB_bird3:
    mov eax, bird3X
    sub eax, cameraPos
    cmp eax, 0
    jl DB_bird4
    cmp eax, 79
    jg DB_bird4
    mov dl, al
    mov dh, bird3Y
    call Gotoxy
    cmp bird3Frame, 0
    je DB_b3_down
    mov al, '^'
    jmp DB_b3_draw
DB_b3_down:
    mov al, 'v'
DB_b3_draw:
    call WriteChar
    
DB_bird4:
    mov eax, bird4X
    sub eax, cameraPos
    cmp eax, 0
    jl DB_done
    cmp eax, 79
    jg DB_done
    mov dl, al
    mov dh, bird4Y
    call Gotoxy
    cmp bird4Frame, 0
    je DB_b4_down
    mov al, '^'
    jmp DB_b4_draw
DB_b4_down:
    mov al, 'v'
DB_b4_draw:
    call WriteChar
    
DB_done:
    pop edx
    pop eax
    ret
DrawBirds ENDP


;=====================================================
; UPDATE BIRDS MOVEMENT AND ANIMATION
;=====================================================
UpdateBirds PROC
    push eax
    
    mov eax, levelNum
    cmp eax, 1
    jne UB_done
    
    inc birdCounter
    cmp birdCounter, 5
    jl UB_done
    mov birdCounter, 0
    
    ; Toggle animation
    xor bird1Frame, 1
    xor bird2Frame, 1
    xor bird3Frame, 1
    xor bird4Frame, 1
    
    ; Move bird 1
    cmp bird1Dir, 1
    je UB_b1_right
    dec bird1X
    cmp bird1X, 0
    jg UB_b2
    mov bird1Dir, 1
    jmp UB_b2
UB_b1_right:
    inc bird1X
    cmp bird1X, 250
    jl UB_b2
    mov bird1Dir, 0
    
UB_b2:
    cmp bird2Dir, 1
    je UB_b2_right
    dec bird2X
    cmp bird2X, 0
    jg UB_b3
    mov bird2Dir, 1
    jmp UB_b3
UB_b2_right:
    inc bird2X
    cmp bird2X, 250
    jl UB_b3
    mov bird2Dir, 0
    
UB_b3:
    cmp bird3Dir, 1
    je UB_b3_right
    dec bird3X
    cmp bird3X, 0
    jg UB_b4
    mov bird3Dir, 1
    jmp UB_b4
UB_b3_right:
    inc bird3X
    cmp bird3X, 250
    jl UB_b4
    mov bird3Dir, 0
    
UB_b4:
    cmp bird4Dir, 1
    je UB_b4_right
    dec bird4X
    cmp bird4X, 0
    jg UB_done
    mov bird4Dir, 1
    jmp UB_done
UB_b4_right:
    inc bird4X
    cmp bird4X, 250
    jl UB_done
    mov bird4Dir, 0
    
UB_done:
    pop eax
    ret
UpdateBirds ENDP

;=====================================================
; SECOND GOOMBA FOR LEVEL 1
;=====================================================
DrawGoombaL1_2 PROC
    cmp goombaL1_2Active, 0
    je DGL2_done
    
    mov eax, levelNum
    cmp eax, 1
    jne DGL2_done
    
    mov eax, red + (lightblue * 16)
    call SetTextColor
    
    mov eax, goombaL1_2X
    sub eax, cameraPos
    cmp eax, 0
    jl DGL2_done
    cmp eax, 79
    jg DGL2_done
    
    mov dl, al
    mov dh, goombaL1_2Y
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
DGL2_done:
    ret
DrawGoombaL1_2 ENDP

UpdateGoombaL1_2 PROC
    cmp goombaL1_2Active, 0
    je UGL2_done
    
    inc goombaL1_2Counter
    cmp goombaL1_2Counter, 3
    jl UGL2_done
    mov goombaL1_2Counter, 0
    
    cmp goombaL1_2Dir, 1
    je UGL2_right
    
    mov eax, goombaL1_2X
    cmp eax, goombaL1_2MinX
    jle UGL2_changeRight
    dec goombaL1_2X
    jmp UGL2_done
    
UGL2_changeRight:
    mov goombaL1_2Dir, 1
    jmp UGL2_done
    
UGL2_right:
    mov eax, goombaL1_2X
    cmp eax, goombaL1_2MaxX
    jge UGL2_changeLeft
    inc goombaL1_2X
    jmp UGL2_done
    
UGL2_changeLeft:
    mov goombaL1_2Dir, 0
    
UGL2_done:
    ret
UpdateGoombaL1_2 ENDP

CheckGoombaL1_2Collision PROC
    cmp goombaL1_2Active, 0
    je CGL2_done
    
    mov eax, marioWorldX
    mov ebx, goombaL1_2X
    
    add ebx, 1
    cmp eax, ebx
    jg CGL2_done
    
    mov ebx, goombaL1_2X
    sub ebx, 1
    cmp eax, ebx
    jl CGL2_done
    
    mov al, yPos
    mov bl, goombaL1_2Y
    
    sub bl, 1
    cmp al, bl
    je CGL2_fromTop
    sub bl, 1
    cmp al, bl
    je CGL2_fromTop
    
    mov al, yPos
    mov bl, goombaL1_2Y
    cmp al, bl
    jne CGL2_checkBelow
    
    cmp invincibleActive, 1
    je CGL2_done
    jmp CGL2_hitSide
    
CGL2_checkBelow:
    inc bl
    cmp al, bl
    jne CGL2_done
    cmp invincibleActive, 1
    je CGL2_done
    
CGL2_hitSide:
    dec lives
    cmp lives, 0
    jle CGL2_gameOver
    call PlayHitSound
    mov invincibleActive, 1
    mov invincibleTimer, 60
    
    mov eax, marioWorldX
    cmp eax, goombaL1_2X
    jl CGL2_pushLeft
    add eax, 5
    mov marioWorldX, eax
    jmp CGL2_done
    
CGL2_pushLeft:
    sub eax, 5
    cmp eax, 0
    jge CGL2_pushOK
    mov eax, 0
CGL2_pushOK:
    mov marioWorldX, eax
    jmp CGL2_done
    
CGL2_fromTop:
    mov al, yPos
    sub al, 2
    mov yPos, al
    mov goombaL1_2Active, 0
    add score, 100
    jmp CGL2_done
    
CGL2_gameOver:
    call HandleGameOver
    
CGL2_done:
    ret
CheckGoombaL1_2Collision ENDP

END main
