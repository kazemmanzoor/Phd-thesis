echo please insert number of water molecule:
read numberofwater
echo please insert number of ions for 1molar:
read numberofions
echo please insert number of phosphorene in single sheet:
read numberofphosphorene
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do mkdir $i"na"; done
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cp ../SOURCE-FILE/*.* $i"na"/.; done
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cat > $i"na"/mixture-$i"na".in << EOF  #cat << 'EOF' > $i"na"/mixture-$i"na".in
tolerance 2.0
filetype pdb
output configuration.pdb

structure water.pdb 
  number $(($numberofwater-$i))
  inside box 5 5 5 37 37 43 
end structure

structure SOD.pdb 
  number $(($numberofions+$i))
  inside box 5 5 5 37 37 43 
end structure


structure CLA.pdb 
  number $numberofions
  inside box 5 5 5 37 37 43 
end structure



EOF
 
pwd

done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cd $i"na"; ~/Downloads/packmol/packmol <mixture-$i"na".in ; cd .. ; done


for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cd $i"na"; more bottom.txt | awk -v i="$i" -v numberofwater="$numberofwater" -v numberofions="$numberofions"  '{print "\t" $1-9460+1+(3*(numberofwater-i))+numberofions+(numberofions+i)"\t" numberofwater-i+numberofions+numberofions+i "\t"5"\t"0"\t" $5 "\t"$6"\t"$7 }' > modify-bottom.txt  ; cd .. ; done
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cd $i"na"; more top.txt | awk -v i="$i" -v numberofwater="$numberofwater" -v numberofions="$numberofions" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1-9980+1+numberofphosphorene+ 3*(numberofwater-i)+numberofions+(numberofions+i)"\t" (numberofwater-i)+numberofions+(numberofions+i)+1 "\t"6"\t"0"\t" $5 "\t"$6"\t"$7 }' > modify-top.txt  ; cd .. ; done
