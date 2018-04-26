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
    if [[ $speed == d_* ]]; then
      distance=$(echo $speed | cut -d'_' -f 2)      # Get distance number from line prepended with "d_"
    else
      if [ $count -gt 0 ]; then
        speedString=$speedString","
      fi

      speedString=$speedString$speed
    fi

    (( count++ ))
  fi
done

        # Create JSON object containing data and security keys/passwords
response=$(curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data '{"API_KEY":"'$API_KEY'","deviceName":"'$deviceName'","devicePass":"'$devicePass'","speeds":['$speedString'],"distance":'$distance'}' $API_URL)

echo $response    # Return response back to Arduino
