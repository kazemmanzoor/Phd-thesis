#IN THE NAME OF ALLAH

numberofwater=3600
numberofphosphorene=520
numberofnanotube=1364

allotrop=black

for ((i=0;i<400;i=i+60))
do
mkdir $i
cd $i
cp -r ../source .

cd source 
#echo $i
atomsk BlackPZ.cfg -torsion x $i test1-$i.xyz test1-$i.pdb
atomsk test1-$i.xyz -rotate y 90 test-$i.xyz test-$i.pdb
tail -n $numberofnanotube test-$i.xyz |awk  '{print $2 "\t" $3 "\t" $4 }' >nanotube-$i.txt

nl nanotube-$i.txt >1.txt

more 1.txt |awk '{print $1 "\t" 1 "\t" 1 "\t" 0 "\t" $2 "\t" $3 "\t" $4}' > $allotrop-nanotube-$i.txt
rm 1.txt

cat > mixture.in << EOF  
tolerance 2.0
filetype pdb

output configuration.pdb

structure water.pdb 
  number $(($numberofwater))
  inside box 5 5 -15 38 35 44  
end structure

structure water.pdb 
  number $(($numberofwater))
  inside box 5 5 160 38 35 210  
end structure
EOF

# ~/packmol-20.3.5/packmol <mixture.in
 
more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" '{print "\t" $1+(3*(numberofwater))+(3*(numberofwater)) "\t" (numberofwater)+(numberofwater)+1 "\t"3"\t"0"\t" $5 "\t"$6"\t"$7-20 }' > $allotrop-modify-bottom.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+2 "\t"3"\t"0"\t" $5 "\t"$6"\t"$7+50 }' > $allotrop-modify-middle1.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+3 "\t"3"\t"0"\t" $5 "\t"$6"\t"$7+157 }' > $allotrop-modify-middle2.txt

more $allotrop-bottom.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" '{print "\t" $1+numberofphosphorene+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+4 "\t"3"\t"0"\t" $5 "\t"$6"\t"$7+207+20 }' > $allotrop-modify-top.txt 

more $allotrop-nanotube-$i.txt | awk -v numberofwater="$numberofwater" -v numberofphosphorene="$numberofphosphorene" -v numberofnanotube="$numberofnanotube" '{print "\t" $1+numberofphosphorene+numberofphosphorene+numberofphosphorene+numberofphosphorene+3*(numberofwater)+3*(numberofwater) "\t" (numberofwater)+(numberofwater)+5 "\t"3 "\t" 0 "\t" $5-30 "\t"$6-55.6  "\t" $7+51+105 }' > $allotrop-modify-nanotube.txt 

cat $allotrop-modify-bottom.txt $allotrop-modify-middle1.txt $allotrop-modify-middle2.txt $allotrop-modify-top.txt $allotrop-modify-nanotube.txt > $allotrop-channel-$i.txt

more $allotrop-channel-$i.txt |awk '{print "P" "\t" $5 "\t" $6 "\t" $7}' > all-$i.xyz

cd ..

cat > torsion-$i.in << EOF 
 
units           real
neigh_modify    delay 0 every 1 check yes one 3000 page 200000

atom_style      full
bond_style      harmonic
angle_style     charmm
boundary        p p f

read_data       BlackPZ.data

pair_style      lj/charmm/coul/long 8 12                              
pair_coeff  1   1            0.0               0.0                              #HT
pair_coeff  2   2            0.1553            3.166                            #OT
pair_coeff  1   2            0.0               0.0	                          #H-O
#pair_coeff  3  3            0.3670929         3.438                            #P
pair_coeff  3  3             0.1               0.1                              #P
pair_coeff  1  3             0.0               1.719                            #H-P
pair_coeff  2  3             0.238766680       3.3020                           #O-P

kspace_style    pppm 1e-4
kspace_modify   slab 3.0

thermo          10
thermo_style    multi
timestep        1.0



############## GROUP #####################

group           WATER         type 1 2
group           Hydrogen      type 1
group           Oxygen        type 2

set group Hydrogen charge 0.4238

set group Oxygen charge -0.8476

group           pistonup      id 23161:23680

group           waterup       id 1:10800
group           Hwaterup      subtract waterup Oxygen
group           Owaterup      subtract waterup Hydrogen

group           upsheet       id 22641:23160

group           PNT           id 23681:25044

group           downsheet       id 22121:22640

group           channel    union upsheet PNT downsheet

group 		waterdown      id 10801:21600
group           Hwaterdown     subtract waterdown Oxygen
group           Owaterdown      subtract waterdown Hydrogen

group           pistondown    id 21601:22120


region       reserviorup block EDGE EDGE  EDGE EDGE 107.227 240 units box
region       reserviordown block EDGE EDGE  EDGE EDGE -82 0.486 units box
region       nanotube   block EDGE EDGE  EDGE EDGE 4.44 103.206 units box

####------------------Definition fix property/atoms to clarify atoms--------------####
fix                   ID all property/atom i_id
run                   0
set                   group pistonup   			             i_id 1
set                   group Hwaterup 	 		             i_id 2
set                   group Owaterup 			             i_id 3
set                   group upsheet 			             i_id 4
set                   group PNT 			             i_id 5
set                   group downsheet 			             i_id 6
set                   group Hwaterdown 			             i_id 7
set                   group Owaterdown                               i_id 8
set                   group pistondown   			     i_id 9


thermo_modify   lost ignore

delete_atoms    overlap 1.1 waterup channel mol yes
delete_atoms    overlap 1.1 waterdown channel mol yes
delete_atoms    overlap 1.1 waterup pistonup mol yes
delete_atoms    overlap 1.1 waterdown pistondown mol yes

delete_atoms    overlap 1.1 PNT upsheet mol yes

delete_atoms    overlap 1.1 PNT downsheet mol yes

velocity 	channel set 0 0 0
fix 		setforce1 channel setforce 0 0 0 


thermo      5

fix          SHAKE WATER shake 0.001 100 0 b 1 a 1

#-----------------------------------------------#
#---------Minimization protocol-----------------#            
#-----------------------------------------------#
dump                  min all custom/gz 1000 min.custom.gz  mass id type xs ys zs i_id
timestep               0.5
fix                    fxnvt WATER nvt temp 1.0 1.0 100
thermo                 100
run                    1000 #
unfix                  fxnvt
undump                 min
reset_timestep       0

###-------------------Define velocity in 300 K Temperature------------###
velocity              WATER create 300 2869
run                   0
velocity              WATER scale 300


################# EQULIBRIUM STATE #############################

fix             1 WATER nvt temp 300 300 100


restart         1000000 restart.*

dump                  equ all custom/gz 5000 equlibrium.custom.gz  mass id type x y z i_id

write_data       all.data

################## flow rate-EQ #####################

variable     WCountRup  equal count(WATER,reserviorup)

variable     WCountRdown  equal count(WATER,reserviordown)

variable     WCountNT  equal count(WATER,nanotube)

variable     WDown  equal count(waterdown,reserviorup)

variable     WUp  equal count(waterup,reserviordown)

variable     WDRD  equal count(waterdown,reserviordown)

variable     WURU  equal count(waterup,reserviorup)

################ collecting data-EQ #################### 

thermo          100

thermo_style 	custom step temp   v_WCountRdown  v_WCountRup  v_WCountNT  v_WDown  v_WUp   v_WDRD  v_WURU

timestep        1

compute 	c1 WATER chunk/atom bin/1d z 0.0 0.25
fix 		cf1 WATER ave/chunk 1 2000000 2000000 c1 vx vy vz density/number density/mass norm sample file water_density_1.txt


run		5000
run            1995000 #2ns


unfix   1
unfix   cf1


undump  equ

################## ADD FORCE ############################ 
#------------------------------------------------------------#
#----------- Appling pressure to Piston ------------#
#------------------------------------------------------------#


fix                    WALL_FIXd   pistondown setforce 0.0 0.0  NULL
fix                    PISTONd     pistondown aveforce 0.0 0.0  13.81720415          #P=60MPa
fix                    NVEd        pistondown nve


fix                    WALL_FIXu   pistonup setforce 0.0 0.0  NULL
fix                    PISTONu     pistonup aveforce 0.0 0.0 -2.302867360          #P=10MPa
fix                    NVEu        pistonup nve


fix             6 WATER nvt temp 300 300 100

compute 	Temp1 WATER temp/partial 1 1 0

fix_modify 	6 temp Temp1


dump                  result all custom/gz 20000 result.custom.gz  mass id type x y z i_id


################ FLOW RATE ##############################
 
variable     WCountRup  equal count(WATER,reserviorup)

variable     WCountRdown  equal count(WATER,reserviordown)

variable     WCountNT  equal count(WATER,nanotube)

variable     WDown  equal count(waterdown,reserviorup)

variable     WUp  equal count(waterup,reserviordown)

variable     WDRD  equal count(waterdown,reserviordown)

variable     WURU  equal count(waterup,reserviorup)


####################### DIFFUSION COEFFICENT ##################

compute      msdw  WATER  msd com yes
variable     Dw    equal  c_msdw[4]/2/(step*dt+1.0e-6)


####################### COLLECTING DATA ##########################

thermo  100
thermo_style 	custom step temp c_Temp1 v_WCountRdown v_WCountRup  v_WCountNT v_WDown  v_WUp  v_WDRD  v_WURU  v_Dw  c_msdw[4] 


timestep     1 

compute 	c2 WATER chunk/atom bin/1d z 0.0 0.25
fix 		cf2 WATER ave/chunk 1 2000000 4000000 c2 vx vy vz density/number density/mass norm sample file water_density_2.txt


run          4000000 #4ns

EOF
 

cd ..
done

#atomsk CNT.cfg -shift 0.5*box 0.5*box 0 -torsion z 30 test.cfg
