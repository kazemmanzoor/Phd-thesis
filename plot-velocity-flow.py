import numpy as np
import matplotlib.pyplot as plt

#for i in range (0,75,5):

data0 = np.loadtxt('modify-black-flow-5na-300K-0.025x-0y.txt')
plt.plot(data0[:,0]/10, data0[:,1]*100000,label='5na-0.0226')

data = np.loadtxt('modify-black-flow-10na-300K-0.025x-0y.txt')
plt.plot(data[:,0]/10, data[:,1]*100000,label='10na-0.0451')

data1 = np.loadtxt('modify-black-flow-15na-300K-0.025x-0y.txt')
plt.plot(data1[:,0]/10, data1[:,1]*100000,label='15na-0.0677')

data2 = np.loadtxt('modify-black-flow-20na-300K-0.025x-0y.txt')
plt.plot(data2[:,0]/10, data2[:,1]*100000,label='20na-0.0902')

data3 = np.loadtxt('modify-black-flow-25na-300K-0.025x-0y.txt')
plt.plot(data3[:,0]/10, data3[:,1]*100000,label='25na-0.1128')

data4 = np.loadtxt('modify-black-flow-30na-300K-0.025x-0y.txt')
plt.plot(data4[:,0]/10, data4[:,1]*100000,label='30na-0.1353')

data5 = np.loadtxt('modify-black-flow-35na-300K-0.025x-0y.txt')
plt.plot(data5[:,0]/10, data5[:,1]*100000,label='35na-0.1579')

data6 = np.loadtxt('modify-black-flow-40na-300K-0.025x-0y.txt')
plt.plot(data6[:,0]/10, data6[:,1]*100000,label='40na-0.1804')

data7 = np.loadtxt('modify-black-flow-45na-300K-0.025x-0y.txt')
plt.plot(data7[:,0]/10, data7[:,1]*100000,label='45na-0.203')

data8 = np.loadtxt('modify-black-flow-50na-300K-0.025x-0y.txt')
plt.plot(data8[:,0]/10, data8[:,1]*100000,label='50na-0.2255')

data9 = np.loadtxt('modify-black-flow-55na-300K-0.025x-0y.txt')
plt.plot(data9[:,0]/10, data9[:,1]*100000,label='55na-0.2481')

data10 = np.loadtxt('modify-black-flow-60na-300K-0.025x-0y.txt')
plt.plot(data10[:,0]/10, data10[:,1]*100000,label='60na-0.2706')

data11 = np.loadtxt('modify-black-flow-65na-300K-0.025x-0y.txt')
plt.plot(data11[:,0]/10, data11[:,1]*100000,label='65na-0.2706')


#data12 = np.loadtxt('modify-black-flow-70na-300K-0.025x-0y.txt')
#plt.plot(data12[:,0]/10, data12[:,1]*100000,label='65na-0.2706')

plt.xlim([-0.5,5.3])
plt.xlabel('Z(nm)')
plt.ylabel('m/s')
plt.title("EOF")
plt.legend()

print("5na:",np.average(data0[:,1]*100000))
print("10na:",np.average(data[:,1]*100000))
print("15na:",np.average(data1[:,1]*100000))
print("20na:",np.average(data2[:,1]*100000))
print("25na:",np.average(data3[:,1]*100000))
print("10na:",np.average(data4[:,1]*100000))
print("35na:",np.average(data5[:,1]*100000))
print("40na:",np.average(data6[:,1]*100000))
print("45na:",np.average(data7[:,1]*100000))
print("50na:",np.average(data8[:,1]*100000))
print("55na:",np.average(data9[:,1]*100000))
print("60na:",np.average(data10[:,1]*100000))
print("65na:",np.average(data11[:,1]*100000))
#print("70na:",np.average(data12[:,1]*100000))



plt.show()

