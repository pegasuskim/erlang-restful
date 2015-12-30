#!/bin/sh
PA=`pwd`/ebin
ERL=/usr/local/bin/erl

case $1 in

  debug)
    echo $ERL -pa $PA -s console run
    $ERL -pa $PA -s console run
    echo "Done"
    ;;
 
  *)
    echo "Usage: $0 {debug}"
    exit 1
esac
 
exit 0
