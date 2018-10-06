infoFile="info.txt"

deviceNameLine=`sed -n '1p' $infoFile`    # First line of text file
devicePassLine=`sed -n '2p' $infoFile`    # Second line of text file
apiURLLine=`sed -n '3p' $infoFile`    # Third line of text file
apiKeyLine=`sed -n '4p' $infoFile`    # Fourth line of text file

deviceName=$(echo $deviceNameLine | cut -d'=' -f 2)   # Get device name from line
devicePass=$(echo $devicePassLine | cut -d'=' -f 2)   # Get device password from line
API_URL=$(echo $apiURLLine | cut -d'=' -f 2)   # Get API URL from line
API_KEY=$(echo $apiKeyLine | cut -d'=' -f 2)   # Get API Key from line

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

echo $data

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data $data $API_URL
