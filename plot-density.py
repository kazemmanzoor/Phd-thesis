import numpy as np
import matplotlib.pyplot as plt

data0 = np.loadtxt('ready-H-blue-0na-300K.density')
plt.plot(data0[:,1]/10, data0[:,3],'-',label='H-0.1')


data10 = np.loadtxt('ready-O-blue-0na-300K.density')
plt.plot(data10[:,1]/10, data10[:,3],'-',label='O-0.1')


data20 = np.loadtxt('ready-WATER-blue-0na-300K.density') 
plt.plot(data20[:,1]/10, data20[:,3],'-',label='WATER-0.1')

N_water=input("please insert number of water: ")

plt.xlim([0,5])
plt.xlabel('Channel Height(nm)')
plt.ylabel('gr/cm^3')
plt.title("Density-2700water")
plt.xticks(np.arange(-0.3,5.3,0.25))
plt.axhline(y=1, xmin=0, xmax=5,ls='--',c='r')

plt.axvline(0.455,ls='--',c='r')
plt.axvline(4.55,ls='--',c='r')

plt.axvline(0.10654,ls='--',c='b')
plt.axvline(-0.10654,ls='--',c='b')
plt.axvline(4.89346,ls='--',c='b')
plt.axvline(5.10654,ls='--',c='b')
plt.legend()

x_pos = 0.5
y_pos = 3
#dd=np.average(data20[540:971,3])
#plt.text(x_pos, y_pos, "H2O density",dd)

print("H density",np.average(data0[540:971,3]))
print("O density",np.average(data10[540:971,3]))
print("H2O density",np.average(data20[540:971,3]))

plt.savefig('2700-water.png')

plt.show()

