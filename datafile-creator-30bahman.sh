#IN THE NAME OF ALLAH


#echo please insert number of water molecule:
#read numberofwater

#echo please insert number of phosphorene in single sheet:
#read numberofphosphorene

numberofwater=3600
numberofphosphorene=520
numberofnanotube=1363

allotrop=black

cat > mixture.in << EOF  
tolerance 2.0
filetype pdb

output configuration.pdb

structure water.pdb 
  number $(($numberofwater))
  inside box 5 5 5 30 30 33  
end structure

structure water.pdb 
  number $(($numberofwater))
  inside box 5 5 105 30 30 133  
end structure
EOF

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" '{print "\t" $1+(3*(numberofwater))+(3*(numberofwater)) "\t" (numberofwater)+(numberofwater)+1 "\t"3"\t"0"\t" $5 "\t"$6"\t"$7 }' > $allotrop-modify-bottom.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+2 "\t"4"\t"0"\t" $5 "\t"$6"\t"$7+50 }' > $allotrop-modify-middle1.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+3 "\t"5"\t"0"\t" $5 "\t"$6"\t"$7+157 }' > $allotrop-modify-middle2.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+4 "\t"6"\t"0"\t" $5 "\t"$6"\t"$7+207 }' > $allotrop-modify-top.txt 

more $allotrop-nanotube.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" -v numberofnanotube="$numberofnanotube" '{print "\t" $1+numberofphosphorene+numberofphosphorene+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+5 "\t"7"\t"0"\t" $5 "\t"$6"\t"$7+51 }' > $allotrop-modify-nanotube.txt 

cat $allotrop-modify-bottom.txt $allotrop-modify-middle1.txt $allotrop-modify-middle2.txt $allotrop-modify-top.txt $allotrop-modify-nanotube.txt > $allotrop-channel.txt

more $allotrop-channel.txt |awk '{print "P" "\t" $5 "\t" $6 "\t" $7}' > all.xyz
