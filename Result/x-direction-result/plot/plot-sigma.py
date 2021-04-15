import numpy as np
import matplotlib.pyplot as plt

data0 = np.loadtxt('sigma.txt')
plt.plot(data0[:,0], data0[:,1],'ro--',label='EOF')

#plt.xlim([0,5])
plt.xlabel('Surface Charge ($C/m^2$)')
plt.ylabel('EOF(m/s)')
plt.title("EOF va charge density")
plt.legend()

plt.show()

