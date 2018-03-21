count=0
speedString=""
distance=0

for speed in `cat speeds.txt`
do
  if [ $speed != "" ]; then
    if [[ $speed == d_* ]]; then
      distance=$(echo $speed | cut -d'_' -f 2)
    else
      if [ $count -gt 0 ]; then
        speedString=$speedString","
      fi

      speedString=$speedString$speed
    fi

    (( count++ ))
  fi
done

response=$(curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data '{"API_KEY":"d581128856e29d64ea3878923a9ea95c","speeds":['$speedString'],"distance":'$distance'}' https://dingdongdelivery.ie/receive_speeds.php)

echo $response
