import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt('vel-45na-300K.profile')
for column in data.T:
  plt.plot(data[:,0], column)

plt.show()
