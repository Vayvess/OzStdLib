if [ $1 = "build" ]; then
    ozc -c Main.oz
    ozc -c StdLib.oz
fi

if [ $1 = "run" ]; then
    ozengine Main.ozf
fi
