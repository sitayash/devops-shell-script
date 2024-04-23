#!/bin/bash
COURSE="devops from current script"
echo "befor callin other script, course : $course"
echo "process instand id of  current shell script: $$"
./11-otherscript.share
echo "after calling other script, course: $COURSE"