import numpy as np
import matplotlib.pyplot as plt

data1 = np.loadtxt('sigma-Ex-Ey.txt')
plt.plot(data1[:,0], data1[:,2],'bo--',label='EOF-Ey')

#plt.xlim([0,5])
plt.xlabel('Surface Charge ($C/m^2$)')
plt.ylabel('EOF(m/s)')
plt.title("EOF va charge density")
plt.legend()

plt.show()

