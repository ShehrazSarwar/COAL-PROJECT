.model small
.stack 100h

NEW_LINE MACRO 
    MOV AH,02H
    MOV DL,0DH
    INT 21h
    MOV DL,0AH
    INT 21h
ENDM

.data
jline0000 db '                             ASM              ','$'
jline00 db '                                              ','$'
jline0  db '                   _                 _     __                      ','$'
jline1  db '                  |_) _  __ |  o __ (_|   (_  \/ _ _|_ _ __        ','$'
jline2  db '                  |  (_| |  |< | | |__|   __) / _>  |_(/_|||       ','$'

line00 db '                          Project By              ','$'
line0012 db '                                              ','$'
line001 db '                              __                         ','$'
line002 db '                             (_ |_  _ |_  __ _  __        ','$'
line003 db '                             __)| |(/_| | | (_| /_       ','$'
line004 db '                                __                         ','$'
line005 db '                               (_  _  __    _  __          ','$'
line006 db '                               __)(_| | \^/(_| |           ','$'


line1 db '    ______                                  ', '$'
line2 db '   /|_||_\`.__                              ', '$'
line3 db '  (   _    _ _\                             ', '$'
line4 db '  =`-(_)--(_)-''                            ', '$'

line7 db '      ,_o                                   ', '$'
line8 db '   .-/c-/,::                               ', '$'
line9 db '   (_)==(_)                                ', '$'

line12 db '   __________________                         ', '$'
line13 db '  |   |    |    | |  \                        ', '$'
line14 db '  |___|____|____|_|___\                       ', '$'
line15 db '  |             | |    \                      ', '$'
line16 db "  `--(o)(o)-------(o)--'                      ", '$'


line17 db '********* Capacity Of Parking Lot ********* ','$'
line18 db '                Bikes: 9                ','$'
line19 db '              Rickshaws: 5                ','$'
line20 db '                Cars: 8                ','$'
line21 db '                Buses: 7                ','$'


menu db '*****************MENU*********************','$'
menu1 db 'Press 1 For Bike      (RS 200)','$'
menu2 db 'Press 2 For Car       (RS 300)','$'
menu3 db 'Press 3 For Bus       (RS 500)','$'
menu7 db 'Press 4 For Rickshaw  (RS 250)','$'
menu4 db 'Press 5 To Show The Record','$'
menu8 db 'Press 6 To Delete Single Vehicle','$'
menu5 db 'Press 7 To Delete The Record','$'
menu6 db 'Press 8 To Exit','$'


msg1 db 'Parking Is Full!','$'
msg2 db 'Wrong Input','$'
msg11 db '***Record***','$'

msgg1 db 'Press 1 For Bike          ','$'
msgg2 db 'Press 2 For Car           ','$'
msgg3 db 'Press 3 For Bus           ','$'
msgg4 db 'Press 4 For Rickshaw      ','$'
msgg5 db 'Press 5 To Return To Menu ','$'
msg_del db '***Vehicle Deleted Successfully***','$'
del_INV db 'Reached Zero Value, You Can not Delete More Now!!','$'


msg3 db 'Record: ','$'
msg4 db 'Total Amount Earned Today = ','$'
msg5 db 'The Total Numbers Of Vehicles Parked = ','$'
msg6 db 'The Total Numbers Of Bikes Parked = ','$'
msg7 db 'The Total Numbers Of Cars Parked = ','$'
msg10 db 'The Total Numbers Of Rickshaw Parked = ','$'
msg8 db 'The Total Numbers Of Buses Parked = ','$'
msg9 db '***Record Deleted Successfully***','$'

delaytime db 31   ;for delay of 31 Ticks (3 Seconds) ( 1 second = 18.22 Ticks )

;Here '0' or 48 Means 30H
Amount dw 0     ;for Total Amount
Count dw  0   ;for Total Vehicles Parked 

;Total Counts For Individual Vehicles
Bi db '0'    ;for bike count   
Ca db '0'    ;for car count
Bu db '0'    ;for bus count
Ri db '0'    ;for rickshaw count

.code 
Main Proc 
    MOV AX, @data
    MOV DS, AX     

    ; Set Video Mode for Scroll Up Window (25 x 80) To move up # of lines from Bottom
    MOV AH, 06H   ; Scroll Up Window -> Function to change Background Color
    MOV AL, 0     ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    MOV BH, 3FH   ; Left Char for Background (4) & Right Char for Foreground (E)
    MOV CH, 0     ; CH Upper Row # minimum can be 0
    MOV CL, 0     ; CL Left column # minimum can be 0
    MOV DH, 24    ; Lower row # maximum can be 24
    MOV DL, 79    ; Right column # maximum can be 79
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Set Cursor Position
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Set 1st page number, Welcome Page of Game for example
    MOV DL, 8     ; Set DL for cursor column position
    MOV DH, 3     ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    MOV DX, OFFSET jline0000
    MOV AH, 09H            
    INT 21H 

    ; Set Cursor Position
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Set 1st page number, Welcome Page of Game for example
    MOV DL, 8     ; Set DL for cursor column position
    MOV DH, 4     ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Print String
    MOV DX, OFFSET jline00   ; Load the offset address of the string 'line0' into the DX register
    MOV AH, 09H            ; Set AH register to 09H (function to print a string)
    INT 21H                ; Call interrupt 21H (DOS services)

    NEW_LINE

    MOV DX, OFFSET jline0
    MOV AH, 09H
    INT 21H

    NEW_LINE

    MOV DX, OFFSET jline1
    MOV AH, 09H
    INT 21H

    NEW_LINE

    MOV DX, OFFSET jline2
    MOV AH, 09H
    INT 21H

    ; Set Video Mode for Scroll Up Window II To move up # of lines from Bottom
    MOV AH, 06H   ; Scroll Up Window -> Function to change Background Color
    MOV AL, 0     ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    MOV BH, 7FH   ; Left Char for Background (4) & Right Char for Foreground (E)
    MOV CH, 12    ; CH Upper Row # minimum can be 0
    MOV CL, 0     ; CL Left column # minimum can be 0
    MOV DH, 24    ; Lower row # maximum can be 24
    MOV DL, 79    ; Right column # maximum can be 79
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Set Cursor Position 2
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Set 1st page number, Welcome Page of Game for example
    MOV DL, 8     ; Set DL for cursor column position
    MOV DH, 14    ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Print String
    MOV DX, OFFSET line00   ; Load the offset address of the string 'line00' into the DX register
    MOV AH, 09H             ; Set AH register to 09H (function to print a string)
    INT 21H                 ; Call interrupt 21H (DOS services)

    ; Set Cursor Position 3
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Set 1st page number, Welcome Page of Game for example
    MOV DL, 8     ; Set DL for cursor column position
    MOV DH, 15    ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    LEA DX, line0012
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line001
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line002
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line003
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line004
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line005
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line006
    MOV AH, 09H
    INT 21H

    ; Set Cursor Position out of Window
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Set 1st page number, Welcome Page of Game for example
    MOV DL, 0     ; Set DL for cursor column position
    MOV DH, 24    ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Switching to Page # 02 if We Press Enter Key from Keyboard
    ; Take Input For Enter
    PAGE2:
    MOV AH, 08H   ; Input a character from Keyboard without displaying on the screen
    INT 21H

    CMP AL, 13    ; Check if 'Enter' key is pressed (ASCII 13)
    JNE PAGE2     ; Jump back to PAGE2 if Enter is not pressed

    ;////////////////////////////////////////// Page 2 //////////////////////////////////////////

    ; Select Page
    MOV AH, 05H
    MOV AL, 02H   ; This shows it is page # 02
    INT 10H

    ; Set Video Mode for Scroll Up Window (25 x 80) To move up # of lines from Bottom
    MOV AH, 06H   ; Scroll Up Window -> Function to change Background Color
    MOV AL, 0     ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    MOV BH, 3FH   ; Left Char for Background (4) & Right Char for Foreground (E)
    MOV CH, 0     ; CH Upper Row # minimum can be 0
    MOV CL, 0     ; CL Left column # minimum can be 0
    MOV DH, 24    ; Lower row # maximum can be 24
    MOV DL, 79    ; Right column # maximum can be 79
    INT 10H       ; Call interrupt 10H (BIOS video services)

    ; Set Cursor Position On Page # 02
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 2     ; Set 2nd page number, Page # 02 For Game Rules
    MOV DL, 0     ; Set DL for cursor column position
    MOV DH, 1     ; Set DH for Cursor row position
    INT 10H       ; Call interrupt 10H (BIOS video services)

    LEA DX, line1
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line2
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line3
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line4
    MOV AH, 09H
    INT 21H
    NEW_LINE
    NEW_LINE

    LEA DX, line7
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line8
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line9
    MOV AH, 09H
    INT 21H
    NEW_LINE
    NEW_LINE

    LEA DX, line12
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line13
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line14
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line15
    MOV AH, 09H
    INT 21H
    NEW_LINE

    LEA DX, line16
    MOV AH, 09H
    INT 21H
    NEW_LINE
    NEW_LINE
    NEW_LINE

    LEA DX, line17
    MOV AH, 09H
    INT 21H

    NEW_LINE
    NEW_LINE

    LEA DX, line18
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line19
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line20
    MOV AH, 09H
    INT 21H

    NEW_LINE

    LEA DX, line21
    MOV AH, 09H
    INT 21H

    NEW_LINE
    NEW_LINE

    ClearScreen:
	MOV AH, 08h ; input a character from Keyboard withouot displaying on the screen
	INT 21h
	
	CMP AL, 13
	JNE ClearScreen

    ; Shifting Video Mode to Text Mode Means it Clears the Screen
    MOV AL, 03H   ; Function code for setting the text mode (80x25 text mode)
    MOV AH, 00H   ; Video Mode (0 for text mode)
    INT 10H       ; BIOS interrupt to switch to text mode (clears the screen)

MENU_LOOP PROC

    NEW_LINE
    NEW_LINE

    LEA DX,menu
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu1
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu2
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu3
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu7
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu4
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu8
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu5
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,menu6
    MOV AH,09H
    INT 21H

    NEW_LINE

    MOV AH,01H
    INT 21H

    ; Comparing User Input Here
    CMP AL,'1'
    JE BIKE_

    CMP AL,'2'
    JE CAR_

    CMP AL,'3'
    JE BUS_

    CMP AL,'4'
    JE RICKSHAW_

    CMP AL,'5'
    JE RECORD_

    CMP AL,'6'
    JE DEL_SINGLE_

    CMP AL,'7'
    JE DEL_REC

    CMP AL,'8'
    JE END_PROGRAM

    NEW_LINE

    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    JMP MENU_LOOP_
    RET 

MENU_LOOP Endp


CAR_:
CALL CAR

BUS_:
CALL BUS

BIKE_:
CALL BIKE

RICKSHAW_:
CALL RICKSHAW

RECORD_:
CALL RECORDD

DEL_SINGLE_:
CALL DEL_SINGLE

DEL_REC:
CALL DEL_RECORDD 

MENU_LOOP_:
CALL MENU_LOOP

END_PROGRAM:
    
    ; Shifting Video Mode to Text Mode Means it Clears the Screen
    MOV AL, 03H   ; Function code for setting the text mode (80x25 text mode)
    MOV AH, 00H   ; Video Mode (0 for text mode)
    INT 10H       ; BIOS interrupt to switch to text mode (clears the screen)

    MOV AH,4CH
    INT 21H
    Main Endp

    ; In Case Of Wrong Input Display Its Wrong
    NEW_LINE

    LEA DX,msg2
    MOV AH,09H
    INT 21H

    NEW_LINE

    JMP MENU_LOOP_  ; LOOP AGAIN

FULL proc
    NEW_LINE
    LEA DX,msg1
    MOV AH,09H
    INT 21H

    call delay

    NEW_LINE
    JMP MENU_LOOP_
    ret  
    
FULL endp

FULL_: 
    call FULL

BIKE proc
    CMP Bi,'8'              ; NO MORE THAN 9 BIKES CAN PARKED
    JA FULL_
    
    MOV AX, 200
    ADD Amount,AX
    INC Count               ; ADD ONE VEHICLE IN TOTAL VEHICLE COUNTER
    INC Bi                  ; ADD ONE BIKE IN TOTAL BIKE COUNTER

    JMP MENU_LOOP_
    ret 

BIKE endp

CAR proc
    CMP Ca,'7'              ; NO MORE THAN 8 CARS CAN PARKED
    JA FULL_

    MOV AX, 300
    ADD Amount,AX
    INC Count               ; ADD ONE VEHICLE IN TOTAL VEHICLE COUNTER
    INC Ca                  ; ADD ONE CAR IN TOTAL CAR COUNTER

    JMP MENU_LOOP_
    ret

CAR endp

BUS proc
    CMP Bu,'6'              ; NO MORE THAN 7 BUS CAN PARKED
    JA FULL_

    MOV AX, 500
    ADD Amount,AX
    INC Count               ; ADD ONE VEHICLE IN TOTAL VEHICLE COUNTER
    INC Bu                  ; ADD ONE BUS IN TOTAL BUS COUNTER

    JMP MENU_LOOP_
    ret

BUS endp

RICKSHAW proc 
    CMP Ri,'4'              ; NO MORE THAN 5 RICKSHAW CAN PARKED
    JA FULL_

    MOV AX, 250
    ADD Amount,AX
    INC Count               ; ADD ONE VEHICLE IN TOTAL VEHICLE COUNTER
    INC Ri                  ; ADD ONE RICKSHAW IN TOTAL RICKSHAW COUNTER

    JMP MENU_LOOP_
    ret

RICKSHAW endp

RECORDD proc
    ; Shifting Video Mode to Text Mode Means it Clears the Screen
    MOV AL, 03H   ; Function code for setting the text mode (80x25 text mode)
    MOV AH, 00H   ; Video Mode (0 for text mode)
    INT 10H       ; BIOS interrupt to switch to text mode (clears the screen)

    NEW_LINE
    NEW_LINE

    LEA DX,msg11
    MOV AH,09H
    INT 21H 

    NEW_LINE
    NEW_LINE

    LEA DX,msg6
    MOV AH,09H
    INT 21H

    MOV DL,Bi
    MOV AH,02H
    INT 21H

    NEW_LINE

    LEA DX,msg7
    MOV AH,09H
    INT 21H

    MOV DL,Ca
    MOV AH,02H
    INT 21H

    NEW_LINE

    LEA DX,msg8
    MOV AH,09H
    INT 21H

    MOV DL,Bu
    MOV AH,02H
    INT 21H

    NEW_LINE

    LEA DX,msg10
    MOV AH,09H
    INT 21H

    MOV DL,Ri
    MOV AH,02H
    INT 21H


    NEW_LINE

    LEA DX,msg5
    MOV AH,09H
    INT 21H

; For Total Count
    MOV AX, Count
    MOV DX, 0
    MOV BX, 10
    MOV CX, 0

C_PUSHH:

    DIV BX
    PUSH DX
    MOV DX, 0
    INC CX
    CMP AX, 0
    JNE C_PUSHH

C_PRINTT:

    POP DX
    ADD DX, 48
    MOV AH, 02H
    INT 21H
    LOOP C_PRINTT

    NEW_LINE

    LEA DX,msg4
    MOV AH,09H
    INT 21H

; For Total Amount
    MOV AX, Amount
    MOV DX, 0
    MOV BX, 10
    MOV CX, 0

A_PUSHH:

    DIV BX
    PUSH DX
    MOV DX, 0
    INC CX
    CMP AX, 0
    JNE A_PUSHH
   
A_PRINTT:

    POP DX
    ADD DX, 48
    MOV AH, 02H
    INT 21H
    LOOP A_PRINTT

    JMP MENU_LOOP_
    ret 

RECORDD endp

DEL_SINGLE proc 

    NEW_LINE
    NEW_LINE
    
    LEA DX,msgg1
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,msgg2
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,msgg3
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,msgg4
    MOV AH,09H
    INT 21H

    NEW_LINE

    LEA DX,msgg5
    MOV AH,09H
    INT 21H

    NEW_LINE

    MOV AH,01H
    INT 21H

    ; Comparing User Input Here
    CMP AL,'1'
    JE BIKE_DEL_

    CMP AL,'2'
    JE CAR_DEL_

    CMP AL,'3'
    JE BUS_DEL_

    CMP AL,'4'
    JE RICKSHAW_DEL_

    CMP AL,'5'
    JE MENU_LOOP__

    NEW_LINE
    NEW_LINE

    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    JMP DEL_SINGLE_
    ret

DEL_SINGLE endp

MENU_LOOP__:
    CALL MENU_LOOP

BIKE_DEL_:
    CALL BIKE_DEL

CAR_DEL_:
    CALL CAR_DEL

BUS_DEL_:
    CALL BUS_DEL

RICKSHAW_DEL_:
    CALL RICKSHAW_DEL

DEL_INVALID_:
    CALL DEL_INVALID

DEL_INVALID proc 
    NEW_LINE
    NEW_LINE

    LEA DX, del_INV
    MOV AH,09H
    INT 21H 

    JMP DEL_SINGLE_
    ret 

DEL_INVALID endp

BIKE_DEL proc
    CMP Bi,'0'
    JE DEL_INVALID_
    DEC Bi

    CMP Count,0
    JE DEL_INVALID_
    DEC Count

    NEW_LINE
    NEW_LINE

    LEA DX,msg_del
    MOV AH,09H
    INT 21H

    CALL delay

    JMP DEL_SINGLE_
    ret

BIKE_DEL endp

CAR_DEL proc
    CMP Ca,'0'
    JE DEL_INVALID_
    DEC Ca

    CMP Count,0
    JE DEL_INVALID_
    DEC Count

    NEW_LINE
    NEW_LINE

    LEA DX,msg_del
    MOV AH,09H
    INT 21H

    CALL delay

    JMP DEL_SINGLE_
    ret

CAR_DEL endp

DEL_INVALID__:
    CALL DEL_INVALID

BUS_DEL proc
    CMP Bu,'0'
    JE DEL_INVALID__
    DEC Bu

    CMP Count,0
    JE DEL_INVALID__
    DEC Count

    NEW_LINE
    NEW_LINE

    LEA DX,msg_del
    MOV AH,09H
    INT 21H

    CALL delay

    JMP DEL_SINGLE_
    ret

BUS_DEL endp

RICKSHAW_DEL proc
    CMP Ri,'0'
    JE DEL_INVALID__
    DEC Ri

    CMP Count,0
    JE DEL_INVALID__
    DEC Count

    NEW_LINE
    NEW_LINE

    LEA DX,msg_del
    MOV AH,09H
    INT 21H

    CALL delay

    JMP DEL_SINGLE_
    ret

RICKSHAW_DEL endp

DEL_RECORDD proc
    ; Shifting Video Mode to Text Mode Means it Clears the Screen
    MOV AL, 03H   ; Function code for setting the text mode (80x25 text mode)
    MOV AH, 00H   ; Video Mode (0 for text mode)
    INT 10H       ; BIOS interrupt to switch to text mode (clears the screen)

    NEW_LINE
    NEW_LINE

    MOV Count, 0
    MOV Amount, 0
    MOV Bi, '0'
    MOV Ca, '0'
    MOV Bu, '0'
    MOV Ri, '0'

    LEA DX,msg9
    MOV AH,09H
    INT 21H

    JMP MENU_LOOP_
    ret

DEL_RECORDD endp

delay proc 
    MOV AH, 00H        
    INT 1AH            
    MOV BX, DX         

jmp_delay:
    INT 1AH           
    SUB DX, BX         
    CMP DL, delaytime  
    JL jmp_delay     
    ret                    
    
delay endp

End Main