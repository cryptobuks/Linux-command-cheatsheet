Here is the best setup (I think so :D) for Keychron + Linux

https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444

### Make Fn + F-keys work

Keychron Keyboards on Linux use the `hid_apple` driver (even in Windows/Android mode), both in Bluetooth and Wired modes.
By default, this driver uses the F-keys as multimedia shortcuts and you have to press `Fn` \+ the key to get the usual F1 through F12 keys.

In order to change this, you need to change the `fnmode` parameter for the `hid_apple` kernel module.
Here's some [documentation](https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior) on it, but a quick summary can be found below:

> - 0 = `disabled`: Disable the 'fn' key. Pressing 'fn'+'F8' will behave like you only press 'F8'
> - 1 = `fkeyslast`: Function keys are used as last key. Pressing 'F8' key will act as a special key. Pressing 'fn'+'F8' will behave like a F8.
> - 2 = `fkeysfirst`: Function keys are used as first key. Pressing 'F8' key will behave like a F8. Pressing 'fn'+'F8' will act as special key (play/pause).

You can temporarily set the value (for testing, for example) by doing:

```sh
# replace <value> below with 0, 1 or 2
# example: echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo <value> | sudo tee /sys/module/hid_apple/parameters/fnmode
```

Test how the keyboard behaves after each value. Pick the one the works for you.
Once you have found the value that works for you, you can make the change permanent:

1.  Create the file `/etc/modprobe.d/hid_apple.conf`
2.  Add this line to the file: `options hid_apple fnmode=<value>`, replacing `<value>` with the one that worked for you in the previous step (0, 1 or 2)
3.  Save the file
4.  Run `sudo update-initramfs -u`
5.  Reboot

Here's a script, for convenience:

```sh
# replace <value> below with the one that worked for you in the previous step (0, 1 or 2)
# example: echo "options hid_apple fnmode=2 | sudo tee /etc/modprobe.d/hid_apple.conf"
# this will erase any pre-existing contents from /etc/modprobe.d/hid_apple.conf
echo "options hid_apple fnmode=<value>" | sudo tee /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u
sudo systemctl reboot
```

Other source says:

```
You can set this persistently by creating a module options file like /etc/modprobe.d/hid_apple.conf:

options hid_apple fnmode=0
```

### Enable Bluetooth fast connect config:

If your keyboard takes too long to connect to your computer over Bluetooth (for example, when you press a key and wakes it up), you can enable the Bluetooth fast connect. This usually makes the keyboard connect in less than 1 second.

Some users have reported issues with Bluetooth headphones such as popping audio and general instability, but I haven't experienced anything like that.

1.  Edit the file /etc/bluetooth/main.conf
2.  Uncomment FastConnectable config and set it to true: `FastConnectable = true`
3.  Uncomment `ReconnectAttempts=7` (set the value to whatever number that you want)
4.  Uncomment `ReconnectIntervals=1, 2, 3`

### Disable Autosuspend for USB Bluetooth dongles:

If your keyboard just won't reconnect after sleep, it might be because your Bluetooth card or dongle was automatically suspended by the operating system.
You can disable the auto suspend feature for USB Bluetooth dongles by changing the settings for the `btusb` module.

Note: you might need to target a different module if your Bluetooth controller is somehow using some other module. The options and values themselves might change as well. You need to check the documentation for the module your Bluetooth controller uses. Most USB Bluetooth dongles (and sometimes internal cards that are wired to the USB bus) use `btusb`. Please check if the `btusb` module is used by your controller first.

```sh
# Disable autosuspend for btusb to make the bluetooth keyboard work again
# this will erase any pre-existing contents from /etc/modprobe.d/btusb_disable_autosuspend.conf
echo "options btusb enable_autosuspend=n" | sudo tee /etc/modprobe.d/btusb_disable_autosuspend.conf
sudo update-initramfs -u
```

Now reboot your computer, or run:

```sh
sudo modprobe -r btusb
sudo systemctl restart bluetooth
sudo modprobe btusb
```

### Enable Bluetooth after waking up from sleep:

When your computer wakes up from sleep mode, the Bluetooth controller might not turn on automatically.
In order to force it to do so, we can create a script that will be executed every time the computer comes back from sleep mode.

Note: just like in the previous step, this script assumes your Bluetooth controller uses the `btusb` module.

```sh
# Unload the btusb module, restart the bluetooth service and reload the module again
# post = after the computer wakes up
sudo tee /lib/systemd/system-sleep/bt << EOT
#!/bin/sh
case $1 in
  post)
    modprobe -r btusb
    sleep 1
    service bluetooth restart
    sleep 1
    modprobe btusb
    ;;
esac
EOT
# Now let's make the script executable
sudo chmod +x /lib/systemd/system-sleep/bt
```
