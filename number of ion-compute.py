x=44.22*10**(-10)
y=40.1760*10**(-10)
charge=1.60217662*10**(-19)
area= x*y

print(area)

#sigma=float(input("insert sigma="))

for sigma in range(0,100,1):
    NAI=sigma*2*area/(100*charge)
    print("sigma",sigma/100,"numbr of ions=",NAI)

