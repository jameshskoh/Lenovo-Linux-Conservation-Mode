# Lenovo-Linux-Conservation-Mode

Some Lenovo laptops support Conservation Mode, where the battery stops charging after 60% to reduce charge cycle wear.

While this feature is exposed to Linux users, it is not the easiest thing to configure, especially when you want to toggle it frequently.

`Lenovo-Linux-Conservation-Mode` provides a more convenient way to toggle Conservation Mode in a Linux environment.

**Contributing to the tested device list is welcome! Feel free to create a PR and I will merge it in.**



### Software Requirements

* TLP by `linrunner` is installed
  * Make sure TLP is properly installed and conflicting packages are removed
* Make sure `/etc/tlp.conf` does not have `STOP_CHARGE_THRESH_BAT0` flag
* Make sure `/etc/tlp.d/` does not contain configurations that have `STOP_CHARGE_THRESH_BAT0` flag



### Hardware Requirements

* Lenovo laptops that support Conservation Mode

* To test if your hardware is compatible

  * Install `tlp`

  * Run `tlp-stat -b` with root privilege

  * Look for `conservation_mode`

  * Example output
    ```
    --- TLP 1.5.0 --------------------------------------------
    
    +++ Battery Care
    Plugin: lenovo
    Supported features: charge threshold
    Driver usage:
    * vendor (ideapad_laptop) = active (charge threshold)
    Parameter value range:
    * STOP_CHARGE_THRESH_BAT0: 0(off), 1(on) -- battery conservation mode
    
    /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode = 1 (60%)
    ```



> Note: Lenovo ThinkPad laptop users might have support for `tpacpi` or `tpsmapi`. If you are looking for them, you may want to look elsewhere.



## Instructions

1. `git clone` to a convenient directory
2. `cd Lenovo-Linux-Conservation-Mode`
3. To enable Conservation Mode, execute `./enable-conservation-mode.sh` with root privilege
4. To disable Conservation Mode, execute `./disable-conservation-mode.sh` with root privilege



### Deep Dive

1. Configurations are set in `/etc/tlp.d/99-conservation-mode.conf`
2. Previous configuration will be backed up when the script is run
3. `STOP_CHARGE_THRESH_BAT0="0"` or `STOP_CHARGE_THRESH_BAT0="1"` flag are set in the config file
4. `tlp` is refresh automatically
5. `tlp-stat` is shown for debug purpose



#### Tested Devices

* IdeaPad 5 Pro Gen 6 14' [82L7006CMJ](https://psref.lenovo.com/Detail/IdeaPad/IdeaPad_5_Pro_14ACN6?M=82L7006CMJ)
* IdeaPad 5 Pro Gen 8 14' [83AM001DCK](https://psref.lenovo.com/Detail/IdeaPad/IdeaPad_Pro_5_14APH8?M=83AM001DCK)
* Legion 5 (15ACH6H)
* IdeaPad S145-15IWL
* Yoga C740-14IML [81TC005KAU](https://psref.lenovo.com/Detail/Yoga/Yoga_C740_14IML?M=81TC005KAU)
* IdeaPad Slim 5 14IAH8 [83BF005GFR](https://psref.lenovo.com/Detail/IdeaPad/IdeaPad_Slim_5_14IAH8?M=83BF005GFR)



## References

1. TLP Official Repository https://github.com/linrunner/TLP
2. TLP Official Installation Guide https://linrunner.de/tlp/installation/
3. TLP 1.4 Test: Battery Care for Lenovo Laptops (non-ThinkPad series) https://gist.github.com/linrunner/4a6876648765fac5e141f15d0582a945
