org 100h

mov ax, 01h     
int 10h
      
call menu

ret
   
regles dw 'Pour afficher les regles appuyer sur :                     P$'   
question dw 'Comment jouer a notre superbe jeu video$' 
etape dw 'Etape 1 -> Obtenir les cles         Etape 2 -> Deverrouiller les portes         Etape 3 -> Repeter les etapes            Etape 4 -> Gagner la partie $'
retour dw 'Revenir au menu : Delete$' 
   
bienvenue dw 'Bienvenue dans le labyrinte. $' 
touches dw 'Haut : z                    Gauche : q   Bas : s   Droite : d $' 
jouer dw   'Pour jouer appuyer sur :                         Espace $'  32
quitter dw 'Pour quitter appuyer sur :                         Echap $'  27
rien dw '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         $'   
 
tableGauche dw 373h,37Bh,0B3h,0BBh,0C3h,0CBh,0D3h,0DBh,2B3h,2BBh,653h,65Bh,663h,66Bh
tableDroite dw 37Bh,383h,0BBh,0C3h,0CBh,0D3h,0DBh,0E3h,2BBh,2C3h,65Bh,663h,66Bh,673h
tableHaute dw 0A3h,193h,283h,373h,463h,553h,0B3h,1A3h,293h,383h,473h,563h,573h,2A3h,1B3h,0C3h,583h,493h,3A3h,2B3h,2C3h,3B3h,4A3h,593h
tableBasse dw 193h,283h,373h,463h,553h,643h,1A3h,293h,383h,473h,563h,653h,663h,393h,2A3h,1B3h,673h,583h,493h,3A3h,3B3h,4A3h,593h,683h
  
tableau dw 0A3h,0B3h,0BBh,0C3h,0CBh,0D3h,0DBh,0E3h,193h,1A3h,1B3h,283h,293h,2A3h,2B3h,2BBh,2C3h,373h,37Bh,383h,393h,3A3h,3B3h,463h,473h,493h,4A3h,553h,563h,573h,583h,593h,643h,653h,65Bh,663h,66Bh,673h,683h                         
                           



;
;'0A3h'     0B3h 0BBh 0C3h 0CBh 0D3h 0DBh'0E3h'
;                                         
;                                         
; 
; 193h      1A3h      1B3h
;                                         
;                                         
; 
; 283h      293h      2A3h      2B3h 2BBh 2C3h
;                                         
;                                         
;
; 373h 37Bh 383h     '393h'     3A3h      3B3h
;                                         
;                                         
;                                
; 463h      473h                493h      4A3h
;                                         
;                                         
;
; 553h      563h     '573h'     583h      593h
;                                         
;                                         
;
;'643h'     653h 65Bh 663h 66Bh 673h      683h
;


proc debut
    
mov ax, 1003h
mov bx, 00h
int 10h

mov ax, 0b800h
mov ds, ax   

mov ax, 02000h  ; On initialise le registre ES a 2000h pour stocker des valeurs necessaires au fonctionnement du jeu
mov es, ax    

mov es:[0], 1   ; Numero de la porte
mov es:[2], 0   ; Numero de la cle
mov es:[4], 683h; Position du personnage 
mov es:[6], 0FCh; Couleur de la cle
mov es:[8], 66Bh; Position de la cle


call plateau

call portes

call cle                                     

call personnage 


win:

call deplacement

cmp es:[0], 6        ; Condition de victoire
jne win 


call victoire
 
 
 ret
 
endp debut


menu proc 
    menuPrincipal:
    
        mov ah, 02h
        mov dh, 3
        mov dl, 6
        int 10h
        
        mov dx, offset Rien
        mov ah, 09h
        int 21h
    
    
    mov ah, 02h    ;Ah = 02h
    mov dh, 3      ;Vertical
    mov dl, 6      ;Horizontal 
    int 10h
    
    mov dx, offset Bienvenue
    mov ah, 09h
    int 21h 
    
    
    mov ah, 02h
    mov dh, 8
    mov dl, 1
    int 10h
    
    mov dx, offset regles
    mov ah, 09h
    int 21h
     
     
    mov ah, 02h
    mov dh, 14
    mov dl, 9
    int 10h
    
    mov dx, offset jouer
    mov ah, 09h
    int 21h
     
     
    mov ah, 02h
    mov dh, 18
    mov dl, 8
    int 10h
    
    mov dx, offset quitter
    mov ah, 09h
    int 21h
    
    choix:
        mov ax, 0
        int 16h
        cmp al, 32
        je jeu
        cmp al, 27
        je quit 
        cmp al, 112
        je regle
        jmp choix
    
    regle:
         mov ah, 02h
         mov dh, 7
         mov dl, 0
         int 10h
            
         mov dx, offset Rien
         mov ah, 09h
         int 21h
         
                 
            mov ah, 02h
            mov dh, 2
            mov dl, 0
            int 10h
            
            mov dx, offset question
            mov ah, 09h
            int 21h 
             
                 
            mov ah, 02h
            mov dh, 7
            mov dl, 6
            int 10h
            
            mov dx, offset etape
            mov ah, 09h
            int 21h
                    
                    
                    
             
            mov ah, 02h
            mov dh, 14
            mov dl, 15
            int 10h
            
            mov dx, offset touches
            mov ah, 09h
            int 21h
             
             
             
             
            mov ah, 02h
            mov dh, 18
            mov dl, 8
            int 10h
            
            mov dx, offset retour
            mov ah, 09h
            int 21h
            
            
            
            mov ax, 0
            int 16h
            cmp al, 8
            je menuPrincipal
             
                  
    jeu:
        mov ah, 02h
        mov dh, 3
        mov dl, 6
        int 10h
        
        mov dx, offset Rien
        mov ah, 09h
        int 21h
        call debut
    
        ret
    
    quit:
        mov ah, 02h
        mov dh, 3
        mov dl, 6
        int 10h
        
        mov dx, offset Rien
        mov ah, 09h
        int 21h
        
        ret
endp menu


deplacement proc 
    
    push ax
    push bx
    push cx
    push dx
    
    mov dx, 0       
    mov ax, 0       
                    
    
    int 16h          ; entree clavier
    
    
;-----LES DIRECTIONS-----;
    
    cmp al, 122     ; en haut    'Z'
    je vers_le_haut
               
    cmp al, 115     ; en bas     'S'
    je vers_le_bas
               
    cmp al, 113     ; a gauche   'Q'
    je vers_la_gauche
    
    cmp al, 100     ; a droite   'D'
    je vers_la_droite
    
    jmp fin
          
    
          
    vers_le_haut:
     
        mov ax, es:[4]
        sub ax, 0F0h
        
        mov cx, 18h
        
        mov di, 0h
        
        haut:
        
        cmp ax, cs:tableHaute[di]
        je collisionHaute
        
        add di, 2h
        loop haut
        
        jmp fin
         
            collisionHaute:
            cmp ax, es:[8]
            jne key_jump_haut

                call effacer_cle
 
            key_jump_haut:
        
        cmp ax, 0A3h
        je porte_Rouge 
        cmp ax, 573h
        je porte_Verte
        
        jmp passe_haut
        
        porte_Rouge:
         mov bx, es:[2]
         
         cmp bx, 1
         jne mauvais
         
         mov bx, es:[0]
         
         cmp bx, 1
         jne mauvais
         
         jmp CleRougeCorrect
         
        porte_Verte:
         mov bx, es:[2]
         
         cmp bx, 2
         jne mauvais
         
         mov bx, es:[0]
         
         cmp bx, 2
         jne mauvais
         
        CleRougeCorrect:
        call effacer_porte
        call cle
        passe_haut:
        
        call personnageNon
        
        mov ax, es:[4]
        sub ax, 0F0h
        mov es:[4], ax
        jmp suite
    
    
    
    vers_le_bas:
    
    
        mov ax, es:[4]
        add ax, 0F0h
        
        mov cx, 18h
        
        mov di, 0h
        
        bas:
        
        cmp ax, cs:tableBasse[di]
        je collisionBasse
        
        add di, 2h
        loop bas
        
        jmp fin
         
            collisionBasse: 
        
            cmp ax, es:[8]
            jne key_jump_bas

                call effacer_cle
            
            
            key_jump_bas:
        
        
        cmp ax, 393h
        je porte_Jaune 
        cmp ax, 643h
        je porte_rose
        
        jmp passe_bas
        
        porte_Jaune:
         mov bx, es:[2]
         
         cmp bx, 5
         jne mauvais
         
         mov bx, es:[0]
         
         cmp bx, 5
         jne mauvais
         jmp CleJauneCorrect: 
         
        porte_Rose:
         mov bx, es:[2]
         
         cmp bx, 4
         jne mauvais
         
         mov bx, es:[0]
         
         cmp bx, 4
         jne mauvais
            
        CleJauneCorrect:    
        call effacer_porte
        call cle
        passe_bas:
        
        
        call personnageNon
        mov ax, es:[4]
        add ax, 0F0h 
        mov es:[4], ax
        
        jmp suite
    
          
          
    vers_la_gauche:
    
        mov ax, es:[4]
        sub ax, 8h
        
        mov cx, 0Eh
        
        mov di, 0h
        
        gauche:
        
        cmp ax, cs:tableGauche[di]
        je collisionGauche
        
        add di, 2h
        loop gauche
        
        jmp fin
         
            collisionGauche:
            
            cmp ax, es:[8]
            jne key_jump_gauche
    
                call effacer_cle
    
            key_jump_gauche:
        
        
        call personnageNon 
        mov ax, es:[4]
        sub ax, 8h 
        mov es:[4], ax 
        
        jmp suite
       
       
       
       
    vers_la_droite:
    
        mov ax, es:[4]
        add ax, 8h
        
        mov cx, 0Eh
        
        mov di, 0h
        
        droite:
        
        cmp ax, cs:tableDroite[di]
        je collisionDroite
        
        add di, 2h
        loop droite
        
        jmp fin
         
            collisionDroite:
        
            cmp ax, es:[8]
            jne key_jump_droite
            
                call effacer_cle
             
            key_jump_droite:
               
               
               
        cmp ax, 0E3h
        je porte_Bleue
        
        jmp passe_Droite
        
        porte_Bleue:
         mov bx, es:[2]
         
         cmp bx, 3
         jne mauvais
         
         mov bx, es:[0]
         
         cmp bx, 3
         jne mauvais
         
        call effacer_porte
        call cle
        passe_Droite:
        
        call personnageNon
        mov ax, es:[4]
        add ax, 8h 
        mov es:[4], ax 
        
        jmp suite
       
             
    suite:
        call personnage
        
            
        jmp fin
                
    mauvais:
    
            mov ah, 02h
            mov dl, 07h
            int 21h
            
    
    fin:
    
        pop ax
        pop bx
        pop cx
        pop dx
        
    
    ret

deplacement endp



cle proc                 ; Creation de la cle
    
    mov di, es:[8]
    mov ax, es:[6]
    
    add ax, 1600h
    
    mov [di - 54h], ax 
    mov [di - 52h], ax 
    mov [di - 50h], ax
     
    
    sub ax, 0100h 
    
    mov [di - 4Eh], ax 
    mov [di - 4Ch], ax
    
    sub ax, 0200h
            
    mov [di - 04h], ax 
    mov [di - 02h], ax 
    
    ret 

    

cle endp
                
                
                
                
effacer_cle proc         ; Destruction de la cle
    
    mov di, es:[8]
    
    
    mov [di - 53h], ' '
    mov [di - 51h], ' '                                                                                                                                                                                                                                                                                                                                              
    mov [di - 4Fh], ' ' 
    
    mov [di - 4Dh], ' ' 
    mov [di - 4Bh], ' '
    mov [di - 49h], ' '
    
            
    mov [di - 03h], ' ' 
    mov [di - 01h], ' '
    mov [di - 01h], ' ' 
    
    mov es:[8], 800h
    
    add es:[2], 1h
    

    
    ret 

effacer_cle endp
 

personnage proc         ; Creation du personnage


    mov ax, es:[4]
    
    mov di, ax 
    mov [di], 11000000b
       
    add di, 2h 
    mov [di], 11000000b
    add di, 2h
    sub di, 0A6h
    mov [di], 11000000b  
    
    add di, 6h
    mov [di], 11000000b
    
             
    ret
     
personnage endp
   
      
personnageNon proc       ; Destruction du personnage 
     
     
    mov ax, es:[4]
    
    mov di, ax
    mov [di], 11110000b
       
    add di, 2h 
    mov [di], 11110000b
    add di, 2h
    
    sub di, 0A6h
    mov [di], 11110000b  
    
    add di, 6h
    mov [di], 11110000b
    
     
    ret

personnageNon endp  

  
portes proc               ; Creation des portes

    mov [001h], 11000000b       ;La
    mov [003h], 11000000b        ;Porte
    mov [005h], 11000000b         ;Rouge
    mov [007h], 11000000b          ;
                                   ;
    mov [051h], 11000000b          ;
    mov [053h], 01110000b          ;
    mov [055h], 01110000b          ;
    mov [057h], 11000000b          ;
                                   ;
    mov [0A1h], 11000000b          ;
    mov [0A3h], 11000000b          ;
    mov [0A5h], 11000000b          ;
    mov [0A7h], 11000000b          ;    
                       
                       
    mov [041h], 10010000b       ;La
    mov [043h], 10010000b        ;Porte
    mov [045h], 10010000b         ;Bleu
    mov [047h], 10010000b          ;
                                   ;
    mov [091h], 10010000b          ;
    mov [093h], 01110000b          ;
    mov [095h], 01110000b          ;
    mov [097h], 10010000b          ;
                                   ;
    mov [0E1h], 10010000b          ;
    mov [0E3h], 10010000b          ;
    mov [0E5h], 10010000b          ;
    mov [0E7h], 10010000b          ;  
    
    mov [2F1h], 11100000b       ;La
    mov [2F3h], 11100000b        ;Porte
    mov [2F5h], 11100000b         ;Jaune
    mov [2F7h], 11100000b          ;
                                   ;
    mov [341h], 11100000b          ;
    mov [343h], 01110000b          ;
    mov [345h], 01110000b          ;
    mov [347h], 11100000b          ;
                                   ;
    mov [391h], 11100000b          ;
    mov [393h], 11100000b          ;
    mov [395h], 11100000b          ;
    mov [397h], 11100000b          ; 
    
    mov [4D1h], 10100000b       ;La
    mov [4D3h], 10100000b        ;Porte
    mov [4D5h], 10100000b         ;Verte
    mov [4D7h], 10100000b          ;
                                   ;
    mov [521h], 10100000b          ;
    mov [523h], 01110000b          ;
    mov [525h], 01110000b          ;
    mov [527h], 10100000b          ;
                                   ;
    mov [571h], 10100000b          ;
    mov [573h], 10100000b          ;
    mov [575h], 10100000b          ;
    mov [577h], 10100000b          ; 
    
    mov [5A1h], 11010000b       ;La
    mov [5A3h], 11010000b        ;Porte
    mov [5A5h], 11010000b         ;Rose
    mov [5A7h], 11010000b          ;
                                   ;
    mov [5F1h], 11010000b          ;
    mov [5F3h], 01110000b          ;
    mov [5F5h], 01110000b          ;
    mov [5F7h], 11010000b          ;
                                   ;
    mov [641h], 11010000b          ;
    mov [643h], 11010000b          ;
    mov [645h], 11010000b          ;
    mov [647h], 11010000b          ; 
            
    ret

portes endp


effacer_porte proc       ; Destruction de la porte
    
    sub ax, 0A2h
    mov di, ax
    mov bx, 0
    
    effacer:
        
    mov cx,4
    boucle_Effacement:
        mov [di], 11110000b
        add di, 2h
        loop boucle_Effacement 
    
    add di, 48h 
    inc bx
      
    cmp bx, 3
    jne effacer              
     
    
    add es:[0], 1h
    
    
    
    mov bx, es:[2]
    
    cmp bx, 1h
    je verte
    
    cmp bx, 2h
    je bleu
    
    cmp bx, 3h
    je rose
    
    cmp bx, 4h
    je jaune
     
     
    mov es:[8],0FFFh 
    jmp finCle
    
    verte:
        mov ax, 0BBh
        mov es:[6], 00FAh
        mov es:[8], ax
        jmp finCle 
    
    bleu:
        mov ax, 2BBh
        mov es:[6], 0F9h
        mov es:[8], ax
        jmp finCle
        
    rose:
        mov ax, 65Bh
        mov es:[6], 0FDh
        mov es:[8], ax
        jmp finCle
        
    jaune:
        mov ax, 0D3h          
        mov es:[6], 0FEh
        mov es:[8], ax
    
    finCle:
    
    
ret

effacer_porte endp  


victoire proc 
    
                                 ; Destruction du plateau
    mov cx,350h
    
    mov di, 01h
    noir:
        mov [di], 00000000b
        add di, 2h
        loop noir

                                 ; Affichage Victoire
    
    mov [00FBh], 11100000b              ; Y
    mov [00FDh], 11100000b              ;
                                        ;
    mov [0103h], 11100000b              ;
    mov [0105h], 11100000b              ;
                                        ;
                                        ;
    mov [014Bh], 11100000b              ;
    mov [014Dh], 11100000b              ;
                                        ;
    mov [0153h], 11100000b              ;
    mov [0155h], 11100000b              ;
                                        ;
                                        ;
    mov [019Bh], 11100000b              ;
    mov [019Dh], 11100000b              ;
                                        ;
    mov [01A3h], 11100000b              ;
    mov [01A5h], 11100000b              ;
                                        ;
                                        ;
    mov [01EDh], 11100000b              ;
    mov [01EFh], 11100000b              ;
    mov [01F1h], 11100000b              ;
    mov [01F3h], 11100000b              ;
                                        ;
                                        ;
    mov [023Fh], 11100000b              ;
    mov [0241h], 11100000b              ;
                                        ;
    mov [028Fh], 11100000b              ;
    mov [0291h], 11100000b              ;
                                        ;
    mov [02DFh], 11100000b              ;
    mov [02E1h], 11100000b              ;
                                                                   
                              
    mov [0113h], 11100000b              ; O
    mov [0115h], 11100000b              ; 
    mov [0117h], 11100000b              ;
    mov [0119h], 11100000b              ;
    mov [011Bh], 11100000b              ;
                                        ;
    mov di, 0161h                       ;
    mov cx, 5                           ;
    Le_O:                               ;
        mov [di], 11100000b             ;
        mov [di + 02h], 11100000b       ;
                                        ;
        mov [di + 0Ah], 11100000b       ;
        mov [di + 0Ch], 11100000b       ;
        add di, 50h                     ;
        loop Le_O                       ;
                                        ; 
    mov [02F3h], 11100000b              ;                                        
    mov [02F5h], 11100000b              ;
    mov [02F7h], 11100000b              ;
    mov [02F9h], 11100000b              ;
    mov [02FBh], 11100000b              ;
    

    
    
    
    mov di, 0129h                       ; U
    mov cx, 6                           ;
    Le_U:                               ;
        mov [di], 11100000b             ;
        mov [di + 02h], 11100000b       ;
                                        ;
        mov [di + 0Ah], 11100000b       ;
        mov [di + 0Ch], 11100000b       ;
        add di, 50h                     ;
        loop Le_U                       ;
                                        ; 
                                        ;                   
    mov [030Bh], 11100000b              ;
    mov [030Dh], 11100000b              ;
    mov [030Fh], 11100000b              ;
    mov [0311h], 11100000b              ;
    mov [0313h], 11100000b              ;
    
    
    
    
    
    mov di, 0419h                       ; W
    mov cx, 7                           ;
    Le_W:                               ;
        mov [di], 11100000b             ;
        mov [di + 02h], 11100000b       ;
                                        ;
        mov [di + 0Eh], 11100000b       ;
        mov [di + 10h], 11100000b       ;
        add di, 50h                     ;
        loop Le_W                       ;
                                        ;                    
    mov [05FDh], 11100000b              ;
    mov [05AFh], 11100000b              ;
    mov [0561h], 11100000b              ;
    mov [05B3h], 11100000b              ;
    mov [0605h], 11100000b              ;
    
    
    
    mov [0433h], 11100000b              ; O
    mov [0435h], 11100000b              ; 
    mov [0437h], 11100000b              ;
    mov [0439h], 11100000b              ;
    mov [043Bh], 11100000b              ;
                                        ;
    mov di, 0481h                       ;
    mov cx, 5                           ;
    Le_2_O:                             ;
        mov [di], 11100000b             ;
        mov [di + 02h], 11100000b       ;
                                        ;
        mov [di + 0Ah], 11100000b       ;
        mov [di + 0Ch], 11100000b       ;
        add di, 50h                     ;
        loop Le_2_O                     ;
                                        ; 
    mov [0613h], 11100000b              ;                                        
    mov [0615h], 11100000b              ;
    mov [0617h], 11100000b              ;
    mov [0619h], 11100000b              ;
    mov [061Bh], 11100000b              ;
    
    
    mov di, 0447h                       ; N
    mov cx, 7                           ;
    Le_N:                               ;
        mov [di], 11100000b             ;
        mov [di + 02h], 11100000b       ;
                                        ;
        mov [di + 0Eh], 11100000b       ;
        mov [di + 10h], 11100000b       ;
        add di, 50h                     ;
        loop Le_N                       ;
                                        ;
          ;
    mov [049Bh], 11100000b              ;
    mov [04EDh], 11100000b              ;
    mov [053Fh], 11100000b              ;
    mov [0591h], 11100000b              ;
    mov [05E3h], 11100000b

ret

victoire endp


plateau proc                 ; Creation du plateau
        mov bh, 0h
        
        mov di, 0h
        
        plateauBoucle:
        
            mov ax, cs:tableau[di]
            sub ax, 0A2h
            
            push di
            
            mov di, ax
            mov bl, 0
        
            case_blanche:
                
                mov cx,4
                boucle2:
                    mov [di], 11110000b
                    add di, 2h
                    loop boucle2 
            
                add di, 48h 
            
            inc bl
          
            cmp bl, 3
            jne case_blanche
             
            pop di
            
            add di, 2h 
             
        inc bh
        
        cmp bh, 27h
        jne plateauBoucle  
        
        
        
    ret  
  
endp plateau