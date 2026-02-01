======================================================================
         Z80 MANAGEMENT COMMANDER (ZMC) - Version 1.1
            "The Clean & Pro Release" por Volney Torres
======================================================================

1. DESCRIPCIÓN
--------------
ZMC es un gestor de archivos de doble panel inspirado en Norton Commander,
diseñado específicamente para sistemas CP/M basados en procesadores Z80.
Esta versión 1.1 prioriza la compatibilidad con hardware real y la 
eficiencia en terminales seriales.

2. NOVEDADES V1.1
-----------------
- SELECCIÓN MÚLTIPLE: Soporte para marcar archivos con [ESPACIO] .
- OPERACIONES EN LOTE: Copia (F5) y Borrado (F8) de archivos seleccionados.
- UI LIMPIA: Eliminación de bloques de color para evitar artefactos en 
  emuladores y terminales modernas. Texto en Blanco/Gris sobre Negro.
- TECLADO UNIVERSAL: Implementación vía BDOS Función 6 (Direct I/O) para
  evitar bloqueos de buffer y mejorar la respuesta.
- COMPATIBILIDAD DUAL: Soporte para secuencias de escape ANSI/VT100 
  tanto de hardware real (ESC P) como de emuladores (ESC O P).

3. MAPA DE TECLAS
-----------------
- [Flechas Arriba/Abajo] : Navegación por la lista de archivos.
- [Page Up / Page Down]  : Salto de página (18 archivos).
- [TAB]                  : Cambiar de panel (A <-> B).
- [Espacio / Insert]     : Seleccionar archivo para operación múltiple (*).
- [F1]                   : Ayuda rápida en línea 31.
- [F3]                   : Ver contenido de archivo (TYPE mode).
- [F4]                   : Volcado hexadecimal (DUMP mode).
- [F5]                   : Copiar seleccionado(s) al panel opuesto.
- [F8]                   : Borrar seleccionado(s) o archivo bajo el cursor.
- [U]                    : Cambiar unidad de disco (A-Z).
- [Ctrl + X]             : Salir al prompt del sistema.

4. ESPECIFICACIONES TÉCNICAS (ANSI/VT100)
-----------------------------------------
ZMC utiliza secuencias de escape estándar para optimizar el refresco:
- Posicionamiento: \x1b[y;xH
- Video Inverso : \x1b[7m  (Usado para el cursor de selección)
- Reset Atrib.  : \x1b[0m  (Usado para el dibujo de marcos)
- Erase Line    : \x1b[K   (Usado para diálogos en línea 31 sin rastro)
- Ocultar Cursor: \x1b[?25l (Mantiene la UI limpia durante la navegación)

5. COMPILACIÓN
--------------
Requiere el compilador Aztec C o similar con soporte para ensamblado en línea.
Ejecutar: bash make.sh

(c) 2026 - Proyecto Abierto para la Comunidad CP/M y VCFed.
======================================================================


6. INSPIRACION Y CREDITOS
-------------------------
ZMC es un homenaje al legendario Norton Commander. 
Quiero dedicar una mención especial a Peter Norton, cuyo ingenio en el diseño 
inspiró a generaciones de desarrolladores a lograr una gestión de archivos 
eficiente e intuitiva. 
Este proyecto aporta esa esencia clásica al ecosistema Z80 CP/M


License: This project is licensed under the GPLv3 License - see the LICENSE file for details
