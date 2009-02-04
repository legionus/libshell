#!/bin/ash -efu

__libshell_experimental=1

. ./shell-array
. ./shell-sort4

#array_create zzz 111 222 333 444 555

#array_flip zzz 0 1
#set |grep zzz

#array_get zzz first var
#echo "$var"
#array_get zzz last var
#echo "$var"

#set |grep zzz
#for i in 0 1 2 3 4 5 6; do
#	array_get zzz $i var
#	echo "$i: $var"
#done

#array_remove zzz 2 var
#set |grep zzz
#echo "$var"

#array_insert zzz first '777'
#set |grep zzz

#array_push zzz 666 777 888
#set |grep zzz

#while array_foreach zzz var; do
#	echo "$var"
#done

#array_create xxx
#set |grep xxx

#array_create zzz 5 2 1 4 3
#quicksort zzz
#while array_foreach zzz var; do
#	echo "$var"
#done

#seq 1 100 |sort -R > /tmp/xxx
#list=
#while read x; do
#	list="$list $x"
#done < /tmp/xxx
#array_create zzz $list
#quicksort zzz
#while array_foreach zzz var; do
#	echo "$var"
#done
