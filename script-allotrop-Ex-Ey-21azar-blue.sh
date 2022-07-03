echo please insert number of water molecule:
read numberofwater
echo please insert number of ions for 1molar:
read numberofions
echo please insert number of phosphorene in single sheet:
read numberofphosphorene
#echo "which allotrop?(black-blue-green-red)"
#read allotrop

allotrop=blue

mkdir $allotrop/
cd $allotrop/
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do mkdir $i"na"; done
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do mkdir $i"na"/$i"na-Ex"; done
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do mkdir $i"na"/$i"na-Ey"; done
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do mkdir $i"na"/source; done
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cp ../../SOURCE-FILE-BLUE/*.* $i"na"/source/. ; done
for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cat > $i"na"/source/mixture-$i"na".in << EOF  
tolerance 2.0
filetype pdb
output configuration.pdb

structure water.pdb 
  number $(($numberofwater-$i))
  inside box 5 5 5 38 43 45  
end structure

structure SOD.pdb 
  number $(($numberofions+$i))
  inside box 5 5 5 38 43 45  
end structure


structure CLA.pdb 
  number $numberofions
  inside box 5 5 5 38 43 45  
end structure

EOF
 
done


#for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cd $i"na"/source;echo "packmol for $i-na job start"; ~/packmol/packmol <mixture-$i"na".in > log-$i"na" ;echo "$i-na job done"; cp configuration.pdb ../.;cd ../.. ; done

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cd $i"na"/source; more $allotrop-bottom.txt | awk -v i="$i" -v numberofwater="$numberofwater" -v numberofions="$numberofions"  '{print "\t" $1+(3*(numberofwater-i))+numberofions+(numberofions+i)"\t" (numberofwater-i)+numberofions+(numberofions+i)+1 "\t"5"\t"0"\t" $5 "\t"$6"\t"$7 }' > $allotrop-modify-bottom.txt  ; cd ../.. ; done

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cd $i"na"/source; more $allotrop-top.txt | awk -v i="$i" -v numberofwater="$numberofwater" -v numberofions="$numberofions" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+ 3*(numberofwater-i)+numberofions+(numberofions+i)"\t" (numberofwater-i)+numberofions+(numberofions+i)+2 "\t"6"\t"0"\t" $5 "\t"$6"\t"$7 }' > $allotrop-modify-top.txt  ; cd ../.. ; done

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cd $i"na"/source ;cat $allotrop-modify-bottom.txt $allotrop-modify-top.txt > ../$allotrop-channel.txt; cd ../.. ; done

echo "#############################EEEEEEXXXX#####################"

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cat > $i"na"/$i"na"-Ex/$allotrop-$i"na-Ex.in" << EOF  #cat << 'EOF' > $i"na"/mixture-$i"na".in

#IN THE NAME OF ALLAH
#EOF in $allotrop-phosphorene channel 
echo both 


# settings

variable	q equal $i
variable	area equal 1992.684145841e-20
variable       sigma equal \${q}*1.60217662e-19/(2*\${area})
print          "sigma:  \${sigma} "
variable       T equal 300
variable       Ex equal 0.025
variable       Ey equal 0.00
variable       P_charge equal -\${q}/832
#variable       allotrope equal $allotrop


boundary     p  p  f
units           real
neigh_modify    delay 0 every 1




atom_style      full
bond_style      harmonic
angle_style     charmm

read_data       $allotrop-EOF-\${q}na.data

pair_style      lj/charmm/coul/long 8 11
pair_coeff      1 1	0.0      0.000 #H
pair_coeff      2 2 	0.1553   3.165 #O
pair_coeff      1 2 	0.0      0.000 # H-O
pair_coeff      3 3 	0.0148   2.575 #SOD
pair_coeff      4 4 	0.106    4.448 #CLA
pair_coeff      5 5 	0.400    3.330 #P
pair_coeff      6 6 	0.400    3.330 #P


pair_modify     mix arithmetic
kspace_style    pppm 1e-4
kspace_modify slab 3.0


log             log-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.log

group           water type 1 2
group           channel type 5 6
group           flow type 1 2 3 4
group           H  type  1
group           O  type  2
group           NA type  3
group           CL type  4


set group channel charge \${P_charge}

velocity        flow create \$T 12345678 dist uniform
delete_atoms    overlap 1 flow channel mol yes


compute Temp flow temp
compute Press all pressure Temp  ke pair bond virial
compute Press1 all pressure Temp  virial
compute Press2 all pressure Temp  ke 


thermo          10000
thermo_style  multi

velocity        channel set 0 0 0 units box
fix             setforce1 channel setforce 0 0 0
fix             Spring channel spring/self  200


dump            2 all atom 100 solvate-minimize.dump
thermo 100
minimize 0.0 0.0 10000 10000
undump 2

fix             2 water shake 1e-6 500 0 m 1.0 a 1



dump            1 all custom/gz 10000 rerun-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.txt.gz id type x y z vx vy vz fx fy fz #rerun command
dump_modify     1 sort id
#dump            2 all xyz/gz 25000 DUMP-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.xyz.gz
#dump            3 all atom 25000 solvate-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.lammpstrj

fix       FixNVT1 flow nvt temp \$T \$T 100

thermo_style custom step temp  c_Temp press density

############################################################## equilibrium #####################################
reset_timestep 0

thermo   100000

timestep  2

compute		CChunkO  O   chunk/atom bin/1d z 0 0.1
compute		CChunkH  H   chunk/atom bin/1d z 0 0.1
compute		CChunkNA  NA  chunk/atom bin/1d z 0 0.1
compute		CChunkCL  CL  chunk/atom bin/1d z 0 0.1
compute		CChunkWATER  water   chunk/atom bin/1d z 0 0.1

fix   	        FChunkO  O   ave/chunk 1 100000 100000 CChunkO  density/mass density/number temp norm sample file O-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkH  H   ave/chunk 1 100000 100000 CChunkH  density/mass density/number temp norm sample file H-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkNA  NA  ave/chunk 1 100000 100000 CChunkNA  density/mass density/number temp norm sample file NA-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkCL  CL  ave/chunk 1 100000 100000 CChunkCL  density/mass density/number temp norm sample file CL-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkWater  water  ave/chunk 1 100000 100000 CChunkWATER  density/mass density/number temp norm sample file WATER-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density


run 500000 #1ns


############################################################## efield #####################################


#dump            33 all  xyz  100000  all-$allotrop-efield-\${q}na-${T}K-${Ex}x-${Ey}y.xyz             #5000 all-efield.xyz
#dump            4 flow xyz  100000  NoWater-$allotrop-efield-\${q}na-${T}K-${Ex}x-${Ey}y.xyz          #5000 NoWater-efield.xyz

compute cc1 flow chunk/atom bin/1d z 0.0 0.5
compute cc1f flow chunk/atom bin/1d z 0.0 1
compute cc1CL CL chunk/atom bin/1d z 0.0 0.5
compute cc1NA NA chunk/atom bin/1d z 0.0 0.5
compute cc1Water water chunk/atom bin/1d z 0.0 0.5

#fix 8 flow ave/chunk 500000 1 500000 cc1 vx vy file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile #
fix 8 flow ave/chunk 1 2000000 2000000 cc1 vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 80 flow ave/chunk 1 2000000 2000000 cc1f vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y-1bin.profile
fix 9 CL   ave/chunk 1 2000000 2000000 cc1CL vx vy norm sample file vel-$allotrop-cl-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 10 NA  ave/chunk 1 2000000 2000000 cc1NA vx vy norm sample file vel-$allotrop-Na-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 11 water  ave/chunk 1 2000000 2000000 cc1Water vx vy norm sample file vel-$allotrop-water-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile

compute  cc12d flow chunk/atom bin/2d x 0.0 0.5 z 0.0 0.5
fix  12 flow ave/chunk 1 2000000 2000000 cc12d vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y-2d-bin.profile

#restart         500000 restarting1-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y restarting2-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y

##########################
#electric field = volts/Angstrom
##########################

fix              Electic all efield  \${Ex} \${Ey} 0.0

thermo           500000

unfix FixNVT1

fix       FixNVT2 flow nvt temp \$T \$T 100

if "\${Ex} != 0.0" then  "compute  Temp5 flow temp/partial 0 1 1" &
else  "compute  Temp5 flow temp/partial 1 0 1 "

fix_modify FixNVT2 temp Temp5

thermo_style	custom step temp c_Temp c_Temp5 press vol

#################################################################
#COMPUTE
#################################################################

compute	cct1 water chunk/atom molecule
compute	myChunk water dipole/chunk cct1
fix		1aa water ave/time 100000 1 100000 c_myChunk[*] file dipole-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.out mode vector


run              4000000  # 8 nano secend

run	         20000000 #40ns for equilibrium

EOF
 
echo "in $i-na-job done!!"

done

echo "#############################EEEEEEEEEEEYYYYY#####################"

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cat > $i"na"/$i"na"-Ey/$allotrop-$i"na-Ey.in" << EOF  #cat << 'EOF' > $i"na"/mixture-$i"na".in

#IN THE NAME OF ALLAH
#EOF in $allotrop-phosphorene channel 
echo both 


# settings

variable	q equal $i
variable	area equal 1992.684145841e-20
variable       sigma equal \${q}*1.60217662e-19/(2*\${area})
print          "sigma:  \${sigma} "
variable       T equal 300
variable       Ex equal 0.0
variable       Ey equal 0.025
variable       P_charge equal -\${q}/832
#variable       allotrope equal $allotrop


boundary     p  p  f
units           real
neigh_modify    delay 0 every 1




atom_style      full
bond_style      harmonic
angle_style     charmm

read_data       $allotrop-EOF-\${q}na.data

pair_style      lj/charmm/coul/long 8 11
pair_coeff      1 1	0.0      0.000 #H
pair_coeff      2 2 	0.1553   3.165 #O
pair_coeff      1 2 	0.0      0.000 # H-O
pair_coeff      3 3 	0.0148   2.575 #SOD
pair_coeff      4 4 	0.106    4.448 #CLA
pair_coeff      5 5 	0.400    3.330 #P
pair_coeff      6 6 	0.400    3.330 #P


pair_modify     mix arithmetic
kspace_style    pppm 1e-4
kspace_modify slab 3.0


log             log-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.log

special_bonds   charmm

group           water type 1 2
group           channel type 5 6
group           flow type 1 2 3 4
group           H  type  1
group           O  type  2
group           NA type  3
group           CL type  4


set group channel charge \${P_charge}

velocity        flow create \$T 12345678 dist uniform
delete_atoms    overlap 1 flow channel mol yes


compute Temp flow temp
compute Press all pressure Temp  ke pair bond virial
compute Press1 all pressure Temp  virial
compute Press2 all pressure Temp  ke 


thermo          10000
thermo_style  multi


velocity        channel set 0 0 0 units box
fix             setforce1 channel setforce 0 0 0
fix             Spring channel spring/self  200

dump            2 all atom 100 solvate-minimize.dump
thermo 100
minimize 0.0 0.0 10000 10000
undump 2

fix             2 water shake 1e-6 500 0 m 1.0 a 1


dump            1 all custom/gz 10000 rerun-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.txt.gz id type x y z vx vy vz fx fy fz #rerun command
dump_modify     1 sort id
#dump            2 all xyz/gz 25000 DUMP-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.xyz.gz
#dump            3 all atom 25000 solvate-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.lammpstrj


fix       FixNVT1 flow nvt temp \$T \$T 100

thermo_style custom step temp  c_Temp press density



############################################################## equilibrium #####################################
reset_timestep 0

thermo   100000
timestep  2

compute		CChunkO  O   chunk/atom bin/1d z 0 0.1
compute		CChunkH  H   chunk/atom bin/1d z 0 0.1
compute		CChunkNA  NA  chunk/atom bin/1d z 0 0.1
compute		CChunkCL  CL  chunk/atom bin/1d z 0 0.1
compute		CChunkWATER  water   chunk/atom bin/1d z 0 0.1

fix   	        FChunkO  O   ave/chunk 1 100000 100000 CChunkO  density/mass density/number temp norm sample file O-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkH  H   ave/chunk 1 100000 100000 CChunkH  density/mass density/number temp norm sample file H-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkNA  NA  ave/chunk 1 100000 100000 CChunkNA  density/mass density/number temp norm sample file NA-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkCL  CL  ave/chunk 1 100000 100000 CChunkCL  density/mass density/number temp norm sample file CL-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkWater  water  ave/chunk 1 100000 100000 CChunkWATER  density/mass density/number temp norm sample file WATER-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density


run 500000 #1ns


############################################################## efield #####################################


#dump            33 all  xyz  100000  all-$allotrop-efield-\${q}na-${T}K-${Ex}x-${Ey}y.xyz             #5000 all-efield.xyz
#dump            4 flow xyz  100000  NoWater-$allotrop-efield-\${q}na-${T}K-${Ex}x-${Ey}y.xyz          #5000 NoWater-efield.xyz

compute cc1 flow chunk/atom bin/1d z 0.0 0.5
compute cc1f flow chunk/atom bin/1d z 0.0 0.25
compute cc1CL CL chunk/atom bin/1d z 0.0 0.5
compute cc1NA NA chunk/atom bin/1d z 0.0 0.5
compute cc1Water water chunk/atom bin/1d z 0.0 0.5

#fix 8 flow ave/chunk 500000 1 500000 cc1 vx vy file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile #
fix 8 flow ave/chunk 1 2000000 2000000 cc1 vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 80 flow ave/chunk 1 2000000 2000000 cc1f vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y-0.25bin.profile
fix 9 CL   ave/chunk 1 2000000 2000000 cc1CL vx vy norm sample file vel-$allotrop-cl-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 10 NA  ave/chunk 1 2000000 2000000 cc1NA vx vy norm sample file vel-$allotrop-Na-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 11 water  ave/chunk 1 2000000 2000000 cc1Water vx vy norm sample file vel-$allotrop-water-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile

compute  cc12d flow chunk/atom bin/2d x 0.0 0.5 z 0.0 0.5
fix  12 flow ave/chunk 1 2000000 2000000 cc12d vx vy norm sample file vel-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y-2d-bin.profile

#restart         500000 restarting1-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y restarting2-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y

##########################
#electric field = volts/Angstrom
##########################

fix              Electic all efield  \${Ex} \${Ey} 0.0

thermo           500000

unfix FixNVT1

fix       FixNVT2 flow nvt temp \$T \$T 100

if "\${Ex} != 0.0" then  "compute  Temp5 flow temp/partial 0 1 1" &
else  "compute  Temp5 flow temp/partial 1 0 1 "

fix_modify FixNVT2 temp Temp5

thermo_style	custom step temp c_Temp c_Temp5 press vol

#################################################################
#COMPUTE
#################################################################

compute	cct1 water chunk/atom molecule
compute	myChunk water dipole/chunk cct1
fix		1aa water ave/time 100000 1 100000 c_myChunk[*] file dipole-$allotrop-\${q}na-\${T}K-\${Ex}x-\${Ey}y.out mode vector


run              4000000  # 8 nano secend

run	         20000000 #40ns for equilibrium

EOF
 
echo "in $i-na-job done!!"

done


for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do na="na"; cat > $i"na"/$i"na"-Ex/run-mix-2021.sh << EOF 
time mpirun -np 2 ~/lammps-29Sep2021/src/lmp_intel_cpu_intelmpi -sf gpu -pk gpu 1 <$allotrop-$i$na-Ex.in

EOF

chmod +x $i"na"/$i"na"-Ex/run-mix-2021.sh

done

for i in 5 7 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do  na="na"; cat > $i"na"/$i"na"-Ey/run-mix-2021.sh << EOF 
time mpirun -np 2 ~/lammps-29Sep2021/src/lmp_intel_cpu_intelmpi -sf gpu -pk gpu 1 <$allotrop-$i$na-Ey.in

EOF

chmod +x $i"na"/$i"na"-Ey/run-mix-2021.sh
 
done
