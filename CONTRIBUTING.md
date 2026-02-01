# Contributing to ZMC (Z80 Management Commander)

First of all, thank you for your interest in improving ZMC! [cite: 2026-02-01] To maintain the stability and quality of the official release, please follow these guidelines [cite: 2026-01-31, 2026-02-01].

## How to Contribute
1. **Report Bugs**: If you find a bug (especially keyboard or UI issues), please open an "Issue" in this repository with details about your hardware/emulator setup [cite: 2026-02-01].
2. **Suggest Enhancements**: We welcome ideas to make ZMC better for the CP/M community [cite: 2026-02-01].
3. **Submit a Pull Request (PR)**:
   - Ensure your code follows the existing style [cite: 2026-01-28].
   - **Do not** use hardware-specific calls if a BDOS alternative exists (to maintain compatibility).
   - Test your changes on real hardware if possible before submitting [cite: 2026-01-31].

## Guidelines for Pull Requests
- **Respect Logic**: Improvements should be additive and respect previous logic [cite: 2026-01-28].
- **No Hardcoded Values**: Use the macros defined in `zmc.h` for screen dimensions and rows.
- **Official Version**: This is the official repository. Any unmerged forks are considered "unofficial" and may contain bugs not present here.

## Code of Conduct
Please be respectful to other contributors. [cite: 2026-02-01] This project belongs to the CP/M and VCFed community [cite: 2026-01-31].

---
*Maintained by Volney Torres*
