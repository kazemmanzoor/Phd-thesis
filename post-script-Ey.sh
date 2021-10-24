#more vel-5na-300K.profile | awk '{print $2 ,"\t" $4}' > top-5na.dat
#more vel-10na-300K.profile | awk '{print $2 ,"\t" $4}' > top-10na.dat
#more vel-15na-300K.profile | awk '{print $2 ,"\t" $4}' > top-15na.dat
#more vel-20na-300K.profile | awk '{print $2 ,"\t" $4}' > top-20na.dat
#more vel-25na-300K.profile | awk '{print $2 ,"\t" $4}' > top-25na.dat
#more vel-30na-300K.profile | awk '{print $2 ,"\t" $4}' > top-30na.dat
#more vel-35na-300K.profile | awk '{print $2 ,"\t" $4}' > top-35na.dat
#more vel-40na-300K.profile | awk '{print $2 ,"\t" $4}' > top-40na.dat
#more vel-45na-300K.profile | awk '{print $2 ,"\t" $4}' > top-45na.dat
#more vel-50na-300K.profile | awk '{print $2 ,"\t" $4}' > top-50na.dat
#more vel-55na-300K.profile | awk '{print $2 ,"\t" $4}' > top-55na.dat
#more vel-60na-300K.profile | awk '{print $2 ,"\t" $4}' > top-60na.dat


for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do  tail vel-black-$i'na'-300K-0x-0.025y.profile -n 106 |awk '{print $2 ,"\t" $5}' > modify-black-flow-$i'na'-300K-0x-0.025y.txt ; done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do  tail vel-black-cl-$i'na'-300K-0x-0.025y.profile -n 106 |awk '{print $2 ,"\t" $5}' > modify-black-cl-$i'na'-300K-0x-0.025y.txt ; done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do  tail vel-black-Na-$i'na'-300K-0x-0.025y.profile -n 106 |awk '{print $2 ,"\t" $5}' > modify-black-Na-$i'na'-300K-0x-0.025y.txt ; done

for i in 5 10 15 20 25 30 35 40 45 50 55 60 65 70; do  tail vel-black-water-$i'na'-300K-0x-0.025y.profile -n 106 |awk '{print $2 ,"\t" $5}' > modify-black-water-$i'na'-300K-0x-0.025y.txt ; done


