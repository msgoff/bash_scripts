#for ((i=0;i<${#X[@]};i++));do clear;delete_lines $i;echo ${X[$i]};cat ${X[$i]}|head;sleep 5;done
#readarray  X < <(grep -nm 1 { x*|tr -d "{"|awk -F: '$2 >1'|cut -d ":" -f1)
#readarray  Y < <(grep -nm 1 { x*|tr -d "{"|awk -F: '$2 >1'|cut -d ":" -f2)
delete_lines(){
sed  -i "1,$(echo $((${Y[$1]}-1)))d" ${X[$1]}
}
