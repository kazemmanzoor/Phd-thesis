# this script compute velocity from lammps's output'#
#average / write to file , ...#
#writen by S.M.KAZEM.MANZOOROLAJDAD#
##
#later must add tail command

echo "check line number for slice"
echo "check line number for average -> eliminate zero in velocity "
line_number=105
element=flow
temp=300
for i in 23 28 65 70 75 ; do

echo "#############"
split vel-blue-$i"na"-$temp"K"-0.025x-0y.profile -l $line_number $element-$i$"na"-blue-

more $element-$i$"na"-blue-aa |awk '{print $2}' > first.txt 

more $element-$i$"na"-blue-aa |awk '{print $4}' > 1.txt #34ns
more $element-$i$"na"-blue-ab |awk '{print $4}' > 2.txt #36ns
more $element-$i$"na"-blue-ac |awk '{print $4}' > 3.txt #38ns
more $element-$i$"na"-blue-ad |awk '{print $4}' > 4.txt #40ns
more $element-$i$"na"-blue-ae |awk '{print $4}' > 5.txt #42ns
more $element-$i$"na"-blue-af |awk '{print $4}' > 6.txt #44ns
more $element-$i$"na"-blue-ag |awk '{print $4}' > 7.txt #46ns
more $element-$i$"na"-blue-ah |awk '{print $4}' > 8.txt #48ns
more $element-$i$"na"-blue-ai |awk '{print $4}' > 9.txt #50ns
more $element-$i$"na"-blue-aj |awk '{print $4}' > 10.txt #52ns
more $element-$i$"na"-blue-ak |awk '{print $4}' > 11.txt #54ns
more $element-$i$"na"-blue-al |awk '{print $4}' > 12.txt #56ns
more $element-$i$"na"-blue-am |awk '{print $4}' > 13.txt #58ns
more $element-$i$"na"-blue-an |awk '{print $4}' > 14.txt #60ns
more $element-$i$"na"-blue-ao |awk '{print $4}' > 15.txt #62ns
 
#compute mean value
paste first.txt 1.txt 2.txt 3.txt 4.txt 5.txt 6.txt 7.txt 8.txt 9.txt 10.txt 11.txt 12.txt 13.txt 14.txt 15.txt > all.txt

#30ns
paste first.txt 1.txt 2.txt 3.txt 4.txt 5.txt 6.txt 7.txt 8.txt 9.txt 10.txt 11.txt 12.txt 13.txt 14.txt 15.txt|awk '{print $1 "\t" ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16)/15}' > 30ns-$element-$i"na".txt

echo "30na-$element-$i"na":"
more 30ns-$element-$i"na".txt|awk '{ total += $2 } END { print total*100000/(NR-11) }' # >> 30ns.txt

#20ns
paste first.txt 6.txt 7.txt 8.txt 9.txt 10.txt 11.txt 12.txt 13.txt 14.txt 15.txt|awk '{print $1 "\t" ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)/10}' > 20ns-$element-$i"na".txt

echo "20na-$element-$i"na":"
more 20ns-$element-$i"na".txt|awk '{ total += $2 } END { print total*100000/(NR-11) }' # >> 20ns.txt

#10ns
paste first.txt 11.txt 12.txt 13.txt 14.txt 15.txt|awk '{print $1 "\t" ($2+$3+$4+$5+$6)/5}' > 10ns-$element-$i"na".txt

echo "10na-$element-$i"na":"
more 10ns-$element-$i"na".txt|awk '{ total += $2 } END { print total*100000/(NR-11) }'>> 10ns-$temp"K".txt

#clean scrach file
rm $element-$i$"na"-blue-a*

rm first.txt 1.txt 2.txt 3.txt 4.txt 5.txt 6.txt 7.txt 8.txt 9.txt 10.txt 11.txt 12.txt 13.txt 14.txt 15.txt

echo "Job Done sir!!!" 

done
