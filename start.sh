cd network/RNVB-network
echo "oi"
. network.sh down
. network.sh up
. network.sh createChannel

. network.sh deployCC -l typescript -v $0