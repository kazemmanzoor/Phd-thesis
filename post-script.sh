
tail H-blue-0na-300K.density -n 1500 >ready-H-blue-0na-300K.density

tail O-blue-0na-300K.density -n 1500 >ready-O-blue-0na-300K.density

tail WATER-blue-0na-300K.density -n 1500 >ready-WATER-blue-0na-300K.density

python3 plot-density.py
