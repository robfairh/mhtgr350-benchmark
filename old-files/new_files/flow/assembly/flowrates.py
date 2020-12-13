import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def calc_flowrates(filename):
    file = pd.read_csv(filename)
    ch = []
    for i in range(1, 14):
        ch.append(file['channel'+str(i)+'_fr'].tolist()[0])

    ch = np.array(ch)
    inl = file['flow_in'].tolist()[0]
    oul = file['flow_out'].tolist()[0]

    print('sum chs: ', sum(ch))
    print('in: ', inl)
    print('out: ', oul)


filename = 'ns07F-6.csv'
calc_flowrates(filename)
