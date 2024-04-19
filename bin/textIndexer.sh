#!/bin/bash

BASEBINDIR=$( (cd -P $(dirname $0) && pwd) )

HOMEDIR=$(dirname $BASEBINDIR)

CLASSPATH="$HOMEDIR/WEB-INF/classes:$HOMEDIR/WEB-INF/lib/*"

JAVAARGS="-Xms256m -Xmx1000m -Dxtf.home=$HOMEDIR -DentityExpansionLimit=128000 -enableassertions"

MAINCLASS="org.cdlib.xtf.textIndexer.TextIndexer"

java -classpath $CLASSPATH $JAVAARGS $MAINCLASS $*
