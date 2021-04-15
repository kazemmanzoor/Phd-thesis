import numpy as np
import matplotlib.pyplot as plt

data0 = np.loadtxt('top-5na.dat')
plt.plot(data0[:,0]/10, data0[:,1]*100000,label='5na-0.0226')

data = np.loadtxt('top-10na.dat')
plt.plot(data[:,0]/10, data[:,1]*100000,label='10na-0.0451')

data1 = np.loadtxt('top-15na.dat')
plt.plot(data1[:,0]/10, data1[:,1]*100000,label='15na-0.0677')

data2 = np.loadtxt('top-20na.dat')
plt.plot(data2[:,0]/10, data2[:,1]*100000,label='20na-0.0902')

data3 = np.loadtxt('top-25na.dat')
plt.plot(data3[:,0]/10, data3[:,1]*100000,label='25na-0.1128')

data4 = np.loadtxt('top-30na.dat')
plt.plot(data4[:,0]/10, data4[:,1]*100000,label='30na-0.1353')

data5 = np.loadtxt('top-35na.dat')
plt.plot(data5[:,0]/10, data5[:,1]*100000,label='35na-0.1579')

data6 = np.loadtxt('top-40na.dat')
plt.plot(data6[:,0]/10, data6[:,1]*100000,label='40na-0.1804')

data7 = np.loadtxt('top-45na.dat')
plt.plot(data7[:,0]/10, data7[:,1]*100000,label='45na-0.203')

data8 = np.loadtxt('top-50na.dat')
plt.plot(data8[:,0]/10, data8[:,1]*100000,label='50na-0.2255')

data9 = np.loadtxt('top-55na.dat')
plt.plot(data9[:,0]/10, data9[:,1]*100000,label='55na-0.2481')

data10 = np.loadtxt('top-60na.dat')
plt.plot(data10[:,0]/10, data10[:,1]*100000,label='60na-0.2706')

plt.xlim([0,5])
plt.xlabel('Z(nm)')
plt.ylabel('m/s')
plt.title("Simple Plot")
plt.legend()

print(np.average(data0[100:200,1]*100000))
print(np.average(data[100:200,1]*100000))
print(np.average(data1[100:200,1]*100000))
print(np.average(data2[100:200,1]*100000))
print(np.average(data3[100:200,1]*100000))
print(np.average(data4[100:200,1]*100000))
print(np.average(data5[100:200,1]*100000))
print(np.average(data6[100:200,1]*100000))
print(np.average(data7[100:200,1]*100000))
print(np.average(data8[100:200,1]*100000))
print(np.average(data9[100:200,1]*100000))
print(np.average(data10[100:200,1]*100000))

plt.show()

