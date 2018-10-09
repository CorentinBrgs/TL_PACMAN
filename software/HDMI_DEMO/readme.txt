
HDMI-TX Test Note

Objective

  - Test whether the testing VGA pattern can be transmitted to the LCD monitor via the HDMI connector.
  - Test whether the HDMI_TX_INT interrupt signal works or not.
    Currently the test code is programmed to trigger HDMI_TX_INT interrupt only on the hot-plug event.

Test Method 1
  - power on the c5g board with "HDMI cable unplugged"
  - program testing sof and elf image
  - plug-in the HDMI cable
  - if monitor is on and showing the test pattern, then both HDMI-TX and HDMI_TX_INT are PASSED.
    if not ... NG

Test Method 2
  - power on the c5g board with "HDMI cable plugged"
  - program testing sof and elf image
  - if monitor is on and showing the test pattern, then both HDMI-TX and HDMI_TX_INT are PASSED.
    if not, power off the "monitor" and then power on again
  - if monitor is on and showing the test pattern, then both HDMI-TX and HDMI_TX_INT are PASSED.
    if not ... NG

If it went to NG in both method, try to unplug and then re-plug the HDMI cable more than one times.
If there is still not any pattern shown on the LCD monitor, just kick off the board to the NG box
for further examination.
