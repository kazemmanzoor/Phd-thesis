echo please insert number of water molecule:
read numerofwater
echo please insert number of ions for 1molar:
read numberofions
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do mkdir $i"na"; done
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cp ../SOURCE-FILE/*.* $i"na"/.; done
for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cat > $i"na"/mixture-$i"na".in << EOF  #cat << 'EOF' > $i"na"/mixture-$i"na".in
tolerance 2.0
filetype pdb
output configuration.pdb

structure SOD.pdb 
  number $(($numberofions+$i))
  inside box 5 5 5 37 37 43 
end structure


structure CLA.pdb 
  number $numberofions
  inside box 5 5 5 37 37 43 
end structure

structure water.pdb 
  number $(($numerofwater-$i))
  inside box 5 5 5 37 37 43 
end structure

EOF
 
pwd

done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do cd $i"na"; ~/Downloads/packmol/packmol <mixture-$i"na".in ; cd .. ; done

