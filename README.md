# longboard_shell_script
Shell Script to be placed in the Linux file system on an Arduino Yún

*Do not place these files on a mounted SD card because the Shell Script will not be executable.*

*The shell script (`send_speeds.sh`) follows Ash standards (not Bash) due to the Arduino Yún having Ash built in by default.*

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

### To Use
- **send_speeds.sh**
  - Change `{{API_URL}}` to the URL of your API
  - Change `{{API_KEY}}` to the API key
- **device_info.txt**
  - Change `{{DEVICE_NAME}}` to the device's registered name
  - Change `{{DEVICE_PASSWORD}}` to the device's registered password
