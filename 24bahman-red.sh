allotrop=red

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do mkdir $i"na"; done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95; do cat > $i"na"/$allotrop-$i"na-Ex.in" << EOF  #cat << 'EOF' > $i"na"/mixture-$i"na".in
#IN THE NAME OF ALLAH
#EOF in $allotrop-phosphorene channel 
echo both 


# settings

variable	q equal $i
variable	area equal 1982.38950000e-20
variable       sigma equal \${q}*1.60217662e-19/(2*\${area})
print          "sigma:  \${sigma} "
variable       T equal 300
variable       Ex equal 0.025
variable       Ey equal 0.00
variable       P_charge equal -\${q}/1040
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


log             log-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.log

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

dump            1 all custom/gz 10000 rerun-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.txt.gz id type x y z vx vy vz  fx fy fz #rerun command
dump_modify     1 sort id
#dump            2 all xyz/gz 25000 DUMP-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.xyz.gz
#dump            3 all atom 25000 solvate-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.lammpstrj

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

fix   	        FChunkO  O   ave/chunk 1 100000 100000 CChunkO  density/mass density/number temp norm sample file O-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkH  H   ave/chunk 1 100000 100000 CChunkH  density/mass density/number temp norm sample file H-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkNA  NA  ave/chunk 1 100000 100000 CChunkNA  density/mass density/number temp norm sample file NA-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkCL  CL  ave/chunk 1 100000 100000 CChunkCL  density/mass density/number temp norm sample file CL-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density
fix             FChunkWater  water  ave/chunk 1 100000 100000 CChunkWATER  density/mass density/number temp norm sample file WATER-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.density

run 10000
run 990000 #2ns


####################### efield #####################################


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



run 		 5000000
run              10000000  # 30 nano secend
#################################################################
#COMPUTE
#################################################################


restart 1000000 red-*-restart\${q}na-\${T}K-\${Ex}x-\${Ey}y.restart

compute	cct1 water chunk/atom molecule
compute	myChunk water dipole/chunk cct1
fix		1aa water ave/time 1000000 1 1000000 c_myChunk[*] file dipole-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.out mode vector


compute cc1 flow chunk/atom bin/1d z 0.0 0.5
compute cc1_813 flow chunk/atom bin/1d z 0.0 0.5

compute cc1CL CL chunk/atom bin/1d z 0.0 0.5
compute cc1CL_6 CL chunk/atom bin/1d z 0.0 0.5

compute cc1NA NA chunk/atom bin/1d z 0.0 0.5
compute cc1NA_6 NA chunk/atom bin/1d z 0.0 0.5

compute cc1Water water chunk/atom bin/1d z 0.0 0.5
compute cc1Water_6 water chunk/atom bin/1d z 0.0 0.5


fix 8 flow ave/chunk 1 1000000 1000000 cc1 vx vy norm sample file vel-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 813 flow ave/chunk 1 6000000 6000000 cc1_813 vx vy norm sample file vel-6milion-red-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile

fix 9 CL   ave/chunk 1 1000000 1000000 cc1CL vx vy norm sample file vel-red-cl-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 91 CL   ave/chunk 1 6000000 6000000 cc1CL_6 vx vy norm sample file vel-6milion-red-cl-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile

fix 10 NA  ave/chunk 1 1000000 1000000 cc1NA vx vy norm sample file vel-red-Na-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 101 NA  ave/chunk 1 6000000 6000000 cc1NA_6 vx vy norm sample file vel-6milion-red-Na-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile

fix 11 water  ave/chunk 1 1000000 1000000 cc1Water vx vy norm sample file vel-red-water-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile
fix 111 water  ave/chunk 1 6000000 6000000 cc1Water_6 vx vy norm sample file vel-6milion-red-water-\${q}na-\${T}K-\${Ex}x-\${Ey}y.profile


run	         15000000 #30ns for statistic
EOF
 
echo "in $i-na-job done!!"

done
