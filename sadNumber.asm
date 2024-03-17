%include "io64.inc"

section .data
    var1 db 0
    string db "", 0
    input db "INPUT: ", 0

section .text

global main
main:
    PRINT_STRING "SAD NUMBER CALCULATOR"
    NEWLINE
    NEWLINE
    
    START:
        
        PRINT_STRING "Enter a digit: "
        GET_DEC 8, rax 
        GET_STRING string, 50
        
        mov dil, [string]
        cmp dil, 0 
        JE VALIDATION
        
        cmp dil, 10
        JE VALIDATION
        
        JMP XYZ
        
 ;INPUTCHECKER:
 ;   CMP RDI, 0
 ;   JL NegativeInput
 ;   CALL is_sad_number
 ;   TEST RAX, RAX
 ;   JZ PrintNotSad
 ;   PRINT_STRING "Sad Number: Yes"
 ;   NEWLINE
 ;   RET   
        
    VALIDATION:
        cmp rax, 0
        JL NEGINPUT
    
        mov rbx, 10
        mov r8, 0
        mov sil, 0
        
        PRINT_STRING "Input Number: "
        PRINT_DEC 8, rax
        NEWLINE
        PRINT_STRING "Iterations: "
        PRINT_DEC 8, rax
        ; NEWLINE
        PRINT_STRING ", "
        
        ;ask_to_continue:
            ;PRINT_STRING "Do you want to continue (y/n)? "
            ;NEWLINE
           ; GET_CHAR rax 
           ; GET_CHAR rcx  
           ; CMP al, 'y'
           ; JE prompt_for_input
            ;RET  ; Exit if not 'y'
        
    SQUARELOOP:
        cdq 
        idiv rbx
        imul rdx, rdx
        add r8, rdx 
        CMP rax, 0
        
        JE COMPARE
        JMP SQUARELOOP
        
    COMPARE:
        PRINT_DEC 8, r8
        
        inc sil
        cmp r8, 1
        ;JE EXIT
        JE FINISH
        
        
        cmp sil, 19
        ;JE EXIT
        JE FINISH
        
        mov rax, r8
        mov r8, 0
        PRINT_STRING ", "
        JMP SQUARELOOP
        
 ; CHECKINPUTSIGN:
  ;  TEST rdi, rdi
 ;   JS display_error_for_negative_input  
 ;   CALL is_sad_number  ; Otherwise, check if it's a "sad" number
  ;  TEST rax, rax
  ;  JZ display_not_sad
  ;  PRINT_STRING "Sad Number: Yes"
 ;   NEWLINE
  ;  RET
  
    FINISH:
        inc SIL 
        NEWLINE
        PRINT_STRING "Sad Number: "
        cmp r8, 1
        JE PRINTNOTSAD
        PRINT_STRING "Yes."
        NEWLINE
        PRINT_STRING "----------------------------"
        JMP LOOP
    PRINTNOTSAD:
        PRINT_STRING "No."
        NEWLINE
        PRINT_STRING "----------------------------"
    LOOP:
        NEWLINE
        JMP CONTINUE
    
    XYZ:
        PRINT_STRING string
        PRINT_STRING "Error: Invalid Input."
        NEWLINE
        JMP CONTINUE
    
    NEGINPUT:    
        PRINT_DEC 8, rax
        NEWLINE    
        PRINT_STRING "Error: negative number input "
        NEWLINE
        JMP CONTINUE
        
;    NegativeInput:
;        PRINT_STRING "Error: Negative number input"
;       NEWLINE
;        RET
    
;    PrintNotSad:
;        PRINT_STRING "Sad Number: No"
;        NEWLINE
;        RET
    
;    InvalidInput:
;        PRINT_STRING "Error: Invalid input"
;        NEWLINE
;        RET
    
    
    CONTINUE:
        NEWLINE
        mov rax, 0
        PRINT_STRING "Do you want to continue (Y/N)? "

        GET_STRING var1, 100
        mov dl, [var1]
        NEWLINE
        PRINT_STRING " "
        PRINT_CHAR dl
        PRINT_STRING " "

        cmp dl, 'y'
        JE REPEATPROCESS
        cmp dl, 'n'
        JE EXIT
        
        PRINT_STRING "Invalid input. "
        NEWLINE
        JMP CONTINUE
        
    EXIT:
        xor rax, rax
        ret
    
    REPEATPROCESS:
        NEWLINE
        NEWLINE
        JMP START
