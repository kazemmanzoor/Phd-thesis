import numpy as np
import matplotlib.pyplot as plt


data0 = np.loadtxt('y-direction-5na.dat')
plt.plot(data0[:,0]/10, data0[:,1]*100000,label='$V_y$-5na-$\sigma=0.0226 C/m^2$')

#data01 = np.loadtxt('top-5na.dat')
#plt.plot(data0[:,0]/10, data0[:,1]*100000,label='$V_y$-5na-$\sigma=0.0226 C/m^2$')

data = np.loadtxt('y-direction-10na.dat')
plt.plot(data[:,0]/10, data[:,1]*100000,label='$V_y$-10na-$\sigma=0.0451 C/m^2$')

data1 = np.loadtxt('y-direction-15na.dat')
plt.plot(data1[:,0]/10, data1[:,1]*100000,label='$V_y$-15na-$\sigma=0.0677 C/m^2$')

data2 = np.loadtxt('y-direction-20na.dat')
plt.plot(data2[:,0]/10, data2[:,1]*100000,label='$V_y$-20na-$\sigma=0.0902 C/m^2$')

data3 = np.loadtxt('y-direction-25na.dat')
plt.plot(data3[:,0]/10, data3[:,1]*100000,label='$V_y$-25na-$\sigma=0.1128 C/m^2$')

data4 = np.loadtxt('y-direction-30na.dat')
plt.plot(data4[:,0]/10, data4[:,1]*100000,label='$V_y$-30na-$\sigma=0.1353 C/m^2$')

data5 = np.loadtxt('y-direction-35na.dat')
plt.plot(data5[:,0]/10, data5[:,1]*100000,'x-',label='$V_y$-35na-$\sigma=0.1579 C/m^2$')

data6 = np.loadtxt('y-direction-40na.dat')
plt.plot(data6[:,0]/10, data6[:,1]*100000,'^--',label='$E_y$,$\sigma=-0.1804 C/m^2$')

data61 = np.loadtxt('top-40na.dat')
plt.plot(data61[:,0]/10, data61[:,1]*100000,'o-',label='$E_x$,$\sigma=-0.1804 C/m^2$')

data7 = np.loadtxt('y-direction-45na.dat')
plt.plot(data7[:,0]/10, data7[:,1]*100000,'^-',label='$E_y$,$\sigma=-0.203 C/m^2$')

data71 = np.loadtxt('top-45na.dat')
plt.plot(data71[:,0]/10, data71[:,1]*100000,'o-',label='$E_x$,$\sigma=-0.203 C/m^2$')

data8 = np.loadtxt('y-direction-50na.dat')
plt.plot(data8[:,0]/10, data8[:,1]*100000,label='$V_y$-50na-$\sigma=0.2255C/m^2$')

data9 = np.loadtxt('y-direction-55na.dat')
plt.plot(data9[:,0]/10, data9[:,1]*100000,label='$V_y$-55na-$\sigma=0.2481 C/m^2$')

data10 = np.loadtxt('y-direction-60na.dat')
plt.plot(data10[:,0]/10, data10[:,1]*100000,label='$V_y$-60na-$\sigma=0.2706 C/m^2$')

plt.xlim([0,5])
plt.xlabel('Channel Height(nm)')
plt.xticks(np.arange(0.0,5.0,0.25))#np.around(np.linspace(0,5,20),decimals=1))
plt.ylabel('EOF(m/s)')
plt.title("$V_y$ VS $V_x$")
plt.axhline(2)
plt.axvline(2)

plt.legend()

#print(np.average(data0[100:200,1]*100000))
print(np.average(data[100:200,1]*100000))
print(np.average(data1[100:200,1]*100000))
print(np.average(data2[100:200,1]*100000))
print(np.average(data3[100:200,1]*100000))
print(np.average(data4[100:200,1]*100000))
print(np.average(data5[100:200,1]*100000))
print("velocity-y-direction-40na:",np.average(data6[100:200,1]*100000))
print("velocity-x-direction-40na:",np.average(data61[100:200,1]*100000))
print("velocity-y-direction-45na:",np.average(data7[100:200,1]*100000))
print("velocity-x-direction-45na:",np.average(data71[100:200,1]*100000))
print(np.average(data8[100:200,1]*100000))
print(np.average(data9[100:200,1]*100000))
print(np.average(data10[100:200,1]*100000))

plt.show()

