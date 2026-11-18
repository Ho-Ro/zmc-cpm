SOURCE = main.c panel.c operations.c cpsrcdst.asm keys.c internal_env.asm vlib.asm
ENVSRC = sysenv.asm vt100.asm
CRT = z3_crt0.asm
HEADER = zmc.h internal_env.h vlib.h
ZMC = zmc.com
TCAP = vt100.z3t vt100_ul.z3t adm-3a.z3t heath19.z3t
ENV = vt100.env vt100_ul.env adm-3a.env heath19.env

KEYTEST = keytest.com bioskeyt.com

ZCC = zcc
ZASM = zasm

# force a build when the default stack size is overruled via environment
ifdef ZMC_STACK_SIZE
	FORCE_ZMC := FORCE_BUILD
else
	ZMC_STACK_SIZE := 256
endif

# force a build when the default copy buffer size is overruled via environment
ifdef ZMC_NUMBUF
	DEFINE_NUMBUF := -DNUMBUF=$(ZMC_NUMBUF)
	FORCE_ZMC := FORCE_BUILD
endif

.PHONY: all
all: $(ZMC) $(KEYTEST) $(TCAP) $(ENV)

# ZMC build is using:
#  The sccz80 assembler (defaults to __smallc linkage)
#  The classic library
#  The 'cpm' target personality


# the complete build is more compact (~ -500 byte) than the modular build
$(ZMC): $(SOURCE) $(HEADER) $(ENVSRC) $(CRT) Makefile $(FORCE_ZMC)
	$(ZCC) +cpm -O3 -crt0=z3_crt0.asm -vn -Wall $(DEFINE_NUMBUF) \
	-pragma-output:noprotectmsdos \
	-pragma-output:noredir -DAMALLOC \
	-pragma-define:CRT_STACK_SIZE=$(ZMC_STACK_SIZE) \
	$(SOURCE) \
	-lvlib -lsyslib \
	-m --list \
	-o $@

# helper to force a new build
.PHONY: FORCE_BUILD
FORCE_BUILD:

# unconditional rebuild (fakes a stack size overrule)
.PHONY: rebuild
rebuild:
	$(MAKE) ZMC_STACK_SIZE=$(ZMC_STACK_SIZE)


# the TCAP files
adm-3a.z3t: adm-3a.asm
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@ -m --list

heath19.z3t: heath19.asm
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@ -m --list

vt100.z3t: vt100.asm
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@ -m --list

vt100_ul.z3t: vt100_ul.asm
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@ -m --list


# the environment file
sysenv.bin: sysenv.asm
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@ -m --list


# the environment and TCAP files
adm-3a.env: sysenv.bin adm-3a.z3t
	cat $^ > $@

heath19.env: sysenv.bin heath19.z3t
	cat $^ > $@

vt100.env: sysenv.bin vt100.z3t
	cat $^ > $@

vt100_ul.env: sysenv.bin vt100_ul.z3t
	cat $^ > $@


# keyboard test files
# keytest using BDOS call
keytest.com: keytest.c Makefile
	$(ZCC) +cpm -O3 -vn -DAMALLOC -pragma-define:CRT_STACK_SIZE=$(STACK_SIZE) -Wall \
	$< -o $@ -create-app

# keytest uing BIOS call
bioskeyt.com: bioskeyt.asm Makefile
	$(ZCC) +z80 -O3 --no-crt -vn -Wall $< -o $@


.PHONY: clean
clean:
	rm -f zmc*.com $(ENV) $(TCAP) $(KEYTEST) *.map *.lis
