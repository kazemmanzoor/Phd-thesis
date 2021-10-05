
tail H-blue-0na-300K-0x-0y.density -n 1500 >ready-H-blue-0na-300K-0x-0y.density

tail O-blue-0na-300K-0x-0y.density -n 1500 >ready-O-blue-0na-300K-0x-0y.density

tail WATER-blue-0na-300K-0x-0y.density -n 1500 >ready-WATER-blue-0na-300K-0x-0y.density

tail NA-blue-0na-300K-0x-0y.density -n 1500 >ready-NA-blue-0na-300K-0x-0y.density

tail CL-blue-0na-300K-0x-0y.density -n 1500 >ready-CL-blue-0na-300K-0x-0y.density

python3 plot-density.py
