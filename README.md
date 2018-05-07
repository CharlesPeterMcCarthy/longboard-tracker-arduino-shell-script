# longboard_shell_script
Shell Script to be placed in the Linux file system on an Arduino Yún

*Do not place these files on a mounted SD card because the Shell Script will not be executable.*

*The shell script (`send_speeds.sh`) follows Ash standards (not Bash) due to the Arduino Yún having Ash built in by default.*

## How To Set Up
  - Before you continue, you should have followed some of the steps from the [Arduino GitHub Repo](https://github.com/CharlesPeterMcCarthy/longboard_arduino) up until this point
  - Change the values listed below under [To Use](https://github.com/CharlesPeterMcCarthy/longboard_shell_script#to-use)
  - The values you enter in `device_info.txt` should match the device details you enter into the MySQL Table [here](https://github.com/CharlesPeterMcCarthy/longboard_db)
  - In order to place these files on the Arduino, you will need a micro SD card
  - First you must format the SD card. This can be done by running the [ExpandingYunDiskSpace Arduino Sketch](https://www.arduino.cc/en/Tutorial/ExpandingYunDiskSpace)
  - When this has finished, remove the micro SD card from the Arduino
  - Insert the micro SD card into an SD card adapter
  - Insert the adapter into your PC / Laptop
  - Move these files from your PC / Laptop to the micro SD card
  - Remove the micro SD card adapter from your PC / Laptop
  - Remove the micro SD card from the adapter
  - Insert the micro SD card into the Arduino
  - Open the Terminal (Ctrl + Alt + T):
  - Get the local IP Address of the Arduino from the Arduino IDE
  - SSH into the Arduino using the local IP
  ```
  ssh root@192.168.XXX.XXX
  ```
  - Enter the password for root - Default values are `arduino` (Arduino) or `doghunter` (Linino)
  - Move into the SD card directory
  ```
  cd /mnt/sd
  ```
  - Copy these files to the folder relative to the Arduino program
  ```
  cp device_info.txt /usr/lib/python2.7/bridge
  cp speeds.txt /usr/lib/python2.7/bridge
  cp send_speeds.sh /usr/lib/python2.7/bridge
  ```
  - Move to the same directory and make the Shell Script executable
  ```
  cd /usr/lib/python2.7/bridge
  chmod +x send_speeds.sh
  ```

### To Use
  - **send_speeds.sh**
    - Change `{{API_URL}}` to the URL of your API
    - Change `{{API_KEY}}` to the API key
  - **device_info.txt**
    - Change `{{DEVICE_NAME}}` to the device's registered name
    - Change `{{DEVICE_PASSWORD}}` to the device's registered password

## How It Works
  - This script is called by the program running on an Arduino Yún ([Arduino GitHub Repo](https://github.com/CharlesPeterMcCarthy/longboard_arduino))
  - The script reads in the device name ans password from `device_info.txt`
  - The speed logs from the skate session are read in from `speeds.txt`
  - These values are stored in a comma-separated string (which will be turned into an array in the API)
  - Every log is checked if it has been prepended with `d_` which signals that this log represents the total distance of the skate
  - A JSON object is created, containing:
    - The API key
    - The device name
    - The device password
    - The speed logs
    - The total distance
  - The script sends the JSON object to the API via cURL/POST and awaits the response
