if [ "$#" -ne 1 ]; then 
    echo "Expected flavor: sh $0 <flavor>" 
    exit 1 
fi

flavor=$1

cp "./web/$flavor/favicon.png" "./web/favicon.png" 
echo "Successfully copied favicon"
cp "./web/$flavor/Icon-192.png" "./web/icons/Icon-192.png" 
cp "./web/$flavor/Icon-512.png" "./web/icons/Icon-512.png" 
echo "Successfully copied icons"
cp "./web/$flavor/manifest.json" "./web/manifest.json" 
echo "Successfully copied manifest.json"
cp "./web/$flavor/index.html" "./web/index.html" 
echo "Successfully copied index.html"
