```
======================================================================
           Z80 MANAGEMENT COMMANDER (ZMC) - Version 2.0-rc4
                    "The USER Support Release"
  VCFed team: Volney Torres & Martin Homuth-Rosemann & Steven Hirsch
======================================================================
```

## DESCRIPTION
ZMC is a dual-panel file manager inspired by Norton Commander,
specifically designed for CP/M systems based on Z80 processors.

## WHAT'S NEW IN V1.2 (The Ho-Ro Update)
- CP/M 3 SUPPORT: Native display of file date and time stamps.
- ALPHABETIC SORTING: Fast QSort implementation for quick navigation.
- ATTRIBUTE MANAGEMENT: View Read-Only, System, and Archive flags.
- OPTIMIZED ENGINE: Drastically improved file size calculation.
- MODULAR CORE: Separated into globals.c and operations.c for stability.
- TECHNICAL TRANSLATION: Standardized English UI and code comments.

## WHAT'S NEW IN V1.3 (The shirsch Update)
- Z3 VLIB & TCAP: Full abstract for video control (cursor addressing and video attributes).
- Z3 DSLIB & SYSLIB ready: Z80 optimised functions for directory access can replace C code.
- Loadable environment file for non-Z3 systems.

## WHAT'S NEW IN V2.0-rc4 (The Ho-Ro Update)
- Handle `USER` for the panels:
  - Open panels on start: `zmc i 1j` opens panels I: (left) and 1J: (right).
  - Change active panel drive/user from cmd line with e.g. K:, 1:, 1K: or K1: terminated by <CR>.
  - Copy from panel to panel also possible for different user on the same drive.
- `MOVE`: Transfer file(s) from one panel to the other with overwrite confirmation.
- `DUP`: Duplicate active file on the same panel (`DUP FILENAME.NEW`) with overwrite confirmation.
- `REN`: Rename the active file on the same panel (`REN FILENAME.NEW`) with collision check.
- `SET`: Set or reset the file attributes (only CP/M3): +R/-R (or RO/RW), +S/-S (or SYS/DIR), +A/-A.
- `SEL`/`DES`: Mass-select/deselect files with CP/M-style wildcards (`SEL *.COM`, `DES *.BAK`).
- `+` / `-` shortcuts: Same as `SEL` / `DES`.
- `<ESC><CR>`: Copy active filename to the command line (Midnight Commander style).
- `^U` (Ctrl U) exchanges left and right panel (Midnight Commander style).
- Fixed: CP/M 3 multi-sector copy (buffer overflow, exact-multiple truncation, false "directory full").
- Fixed: DMA pointer corruption in copy engine.
- Fixed: File list sorting for big files with many extents.

## TERMINAL ADAPTION
By calling the program with `ZMC --TCAP [TCAPFILE]`, you can load the a 128 byte TCAP file
with the definitions of the terminal functions.
This allows the program to be adapted to different types of terminal. The project
provides environment files `vt100.tcp` (this is the same as the ZMC default setting),
Lear Siegler ADM-3A `adm-3a.tcp` (untested), Heath/Zenith19 `heath19.tcp` (untested),
and the test file `vt100_ul.tcp`, the VT100 setting with underline instead of invers.

## KEYMAP
|  KEY                | Function                             |
|---------------------|--------------------------------------|
| `[Arrows Up/Down]`  | Navigate the file list               |
| `[TAB]`             | Switch active panel (L <-> R)        |
| `[^U]`              | Exchange panels (L <-> R)            |
| `[Space]`           | Tag file for batch operations (*)    |
| `[ESC][CR]`         | Copy active filename to command line |
| `[F1]`  or `[ESC]1` | Quick HELP and version credits       |
| `[F3]`  or `[ESC]3` | VIEW file with MORE/ESC support      |
| `[F4]`  or `[ESC]4` | DUMP file with MORE/ESC support      |
| `[F5]`  or `[ESC]5` | Batch COPY                           |
| `[F6]`  or `[ESC]6` | Batch MOVE                           |
| `[F8]`  or `[ESC]8` | Batch DELETE                         |
| `[F10]` or `[ESC]0` | EXIT to system prompt                |
| `[ESC][ESC]`        | EXIT to system prompt                |

The key handling suports the standard `VT100` and some `VT52` cursor and function keys
as well as the wordstar key bindings:

`^E` = UP, `^X` = DOWN, `^R` = PAGEUP, `^C` = PAGEDOWN

The function keys `F1`...`F10` can be substituted by the midnight commander solution
`[ESC]1` ... `[ESC]0`, i.e. type `[ESC]` and then the digit.

ZMC allows also to enter commands in the prompt line `A> ` followed by `[CR]`,
i.e.

- `A:`...`P:`    (Select drive for active panel)
- `0:`...`15:`   (Select user for active panel)
- `0A:`...`15P:` (Select user and drive for active panel)
- `A0:`...`P15:` (Select user and drive for active panel)
- `HELP`
- `VIEW` (or `TYPE` or `CAT`)
- `DUMP` (or `HEX`)
- `COPY` (or `CP`)
- `MOVE` (or `MV`)
- `DEL` (or `ERA` or `RM`),
- `EXIT` (or `QUIT`).
- `RESET` (reset disk drives, same as CCP's `^C`)
- `SET` (Set or reset the file attributes (only for CP/M3):
  +R/-R (or RO/RW), +S/-S (or SYS/DIR), +A/-A.)
- `SEL <AFN>`, `+ <AFN>` (select files with wildcards, e.g. `SEL *.COM`)
- `DES <AFN>`, `+ <AFN>` (deselect files with wildcards, e.g. `DES X*.COM`)
- `DUP FILENAME.NEW` (copy active file to new file on the same drive)
- `REN FILENAME.NEW` (rename active file)

## TECHNICAL SPECIFICATIONS
- Compiler: z88dk (ZCC) with -O3 optimization using
  - sccz80 assembler (defaults to __smallc linkage)
  - classic library
  - cpm target personality
- `ZMC.COM`requires a Z80 or compatible processor.
- Default terminal: ANSI/VT100 (Full support for real hardware and emulators).
- Memory: Dynamic Heap management to support large directories.
- CP/M3 features:
  - Program adapts the screen size automatically from SCB info.
  - Panels show date/time file stamps
  - Fast file copy using CP/M3 multi sector read/write

### Development and configuration support
Calling the program with command line argument as `ZMC --CONFIG` shows system
information and the value and file position of the screen size constants:

```
V.2.0-rc3 Nov 18 2026 15:57:49
CP/M vers.: 22
ENV 0x7F00
COL 0x7F31: 80
ROW 0x7F32: 24
CP BUFFER:  32
MAX FILES:  585
```

The byte values `_INTCOLUMNS:` at `0x7F31` and `_INTLINES` at `0x7F32` are defined
in `SYSENV.ASM` and can be adjusted to your requirements with a hex editor.

Calling as `ZMC --KEY` supports the function key handling, the program simply
shows each received key byte as hex and ASCII, e.g. with ANSI/VT100 emulation,
pressing `F1 F2 F5 F6 ESC ESC` displays:

```
CP/M version 22: function key test - exit with <ESC><ESC>
0x1B  ESC
0x4F  O
0x50  P
0x1B  ESC
0x4F  O
0x51  Q
0x1B  ESC
0x5B  [
0x31  1
0x35  5
0x7E  ~
0x1B  ESC
0x5B  [
0x31  1
0x37  7
0x7E  ~
0x1B  ESC
0x1B  ESC
```

## INSPIRATION & CREDITS
ZMC is a tribute to the legendary Norton Commander and Peter Norton.  
Some key functions are inspired by the GNU Midnight Commander.

CONTRIBUTORS:
- Volney Torres: Original creator, UI design, and panel logic.
- Martin Homuth-Rosemann: Global refactoring, CP/M Plus support,
  and core algorithm optimization.
- Steven Hirsch: Converting Z3 system libraries to z88dk format
  and implementing the VLIB functions.

(c) 2025-2026 - Open Project for the CP/M Community, [VCFed](https://forum.vcfed.org/index.php?threads/1256243/), and [VzEkC](https://forum.classic-computing.de/forum/index.php?thread/38945).
