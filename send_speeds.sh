count=0
speedString=""

for speed in `cat speeds.txt`
do
  if [ $speed != "" ]; then
    if [ $count -gt 0 ]; then
      speedString=$speedString","
    fi

    speedString=$speedString$speed

    (( count++ ))
  fi
done

response=$(curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data '{"API_KEY":"d581128856e29d64ea3878923a9ea95c","speeds":['$speedString']}' https://dingdongdelivery.ie/receive_speeds.php)

echo $response
