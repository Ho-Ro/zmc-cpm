#include <stdio.h>

/* Usamos tu motor de teclado por hardware */
unsigned char wait_key_hw(void) {
    #asm
    loophw_sniff:
	    ld c, 06h    ; Función 6: Direct I/O
	    ld e, 0FFh   ; Modo entrada
	    call 0005h   ; Llamada al BDOS
	    or a         ; ¿Hay tecla?
	    jr z, loophw_sniff
	    ld l, a      ; Retornar tecla en HL
	    ld h, 0
    #endasm
}

int main() {
    unsigned char k;
    printf("\x1b[2J\x1b[H"); // Limpiar pantalla
    printf("--- SNIFFER DE TECLADO ZMC ---\r\n");
    printf("Presiona teclas para ver su HEX (Ctrl+C para salir en CP/M)\r\n");
    printf("----------------------------------------------------------\r\n");

    while(1) {
        k = wait_key_hw();
        
        // Imprimir el valor en HEX y el caracter si es imprimible
        if (k >= 32 && k <= 126) {
            printf("HEX: 0x%02X  |  CHAR: '%c'\r\n", k, k);
        } else {
            printf("HEX: 0x%02X  |  CONTROL\r\n", k);
        }

        // Si es un ESC, probablemente vengan mas bytes seguidos
        if (k == 27) printf("^^^ Posible inicio de secuencia ^^^\r\n");
    }
    return 0;
}
