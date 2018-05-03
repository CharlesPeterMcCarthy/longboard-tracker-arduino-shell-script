API_URL="{{API_URL}}"   # Put API URL here
API_KEY="{{API_KEY}}"

deviceNameLine=`sed -n '1p' device_info.txt`    # First line of text file
devicePassLine=`sed -n '2p' device_info.txt`    # Second line of text file

deviceName=$(echo $deviceNameLine | cut -d':' -f 2)   # Get device name from line
devicePass=$(echo $devicePassLine | cut -d':' -f 2)   # Get device password from line

count=0
speedString=""
distance=0

for speed in `cat speeds.txt`
do
  if [ $speed != "" ]; then
    speed=$(echo $speed | xargs)    # Remove white space (Causes problems otherwise)

    case $speed in
      d_* ) # Check for total distance log
        distance=$(echo $speed | cut -d'_' -f 2)
        break         # Distance log is the last record - break out of loop
      ;;
    esac

    speedString=$speedString$speed,

    count=$((count+1))
  fi
done

      # Create JSON object containing data and security keys/passwords
      # Send speeds as a string instead of array.
      # The API will turn it into an array
data='{"API_KEY":"'$API_KEY'","deviceName":"'$deviceName'","devicePass":"'$devicePass'","speeds":"'$speedString'","distance":'$distance'}'

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data $data $API_URL
