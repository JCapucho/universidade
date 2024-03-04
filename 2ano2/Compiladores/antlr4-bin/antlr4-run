#!/bin/bash
#
# Miguel Oliveira e Silva (mos@ua.pt), 2017-2020

IFS=$'\n'

scriptName="$0"
target="java"
ext=".class"

function help()
{
   echo "Usage: $scriptName [-h | -help | -cpp | -python | -java]"
   echo ""
   echo "   Runs the compiler present in current directory or in a subdirectory (fails if none exists,"
   echo "    or if there are more than one)."
   echo "   Accepts program files as arguments (uses stdin if no argument is passed)."
   echo ""
   echo "   target language:"
   echo "       -java:   java (default)"
   echo "       -cpp:    c++"
   echo "       -python: python3"
   exit 1
}

case $1 in
   "")
      ;;
   -h | -help)
      help
      ;;
   -java)
      shift
      ;;
   -cpp | -c++)
      shift
      target="cpp"
      ext=""
      ;;
   -python | -python3)
      shift
      target="python"
      ext=".py"
      ;;
esac

count=`find . -name \*Main$ext | wc -l`

if ((count == 0)); then
   echo "Main file not found!"
   exit 1
elif ((count > 1)); then
   echo "Too many main files!"
   find . -name \*Main$ext -printf "   %p\n"
   exit 1
fi

case $target in
   java)
      main=`find . -name \*Main.class | sed 's/.class//g' | sed 's/^.\///1'`
      cat $* | java -ea $main
      ;;
   cpp)
      main=`find . -name \*Main`
      cat $* | exec $main
      ;;
   python)
      main=`find . -name \*Main.py`
      cat $* | python3 $main
      ;;
esac

