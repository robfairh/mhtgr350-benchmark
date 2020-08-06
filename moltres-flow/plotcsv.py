import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def plotcsv_fromparaview_temp(file, save):
    '''
        Moltres output is an exodus file.
        Paraview reads exodus file.
        Paraview exports values to csv.
        This function plots those values.
    '''
    file = pd.read_csv(file)

    # x = file['Points:0'].tolist()
    x = np.array(file['Points:0'].tolist())
    y = np.array(file['Points:1'].tolist())
    r = np.sqrt(x**2+y**2)
    temp = file['temp'].tolist()

    plt.figure()
    plt.plot(r, temp)
    plt.ylabel(r'Temperature [$^{\circ}$C]')
    plt.xlabel('r [cm]')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plotcsv_frommoose_temp(file, save, dire='x'):
    '''
        Moltres output is a csv file.
        This function plots those values.
        The output is a figure.
    Parameters:
    -----------
    file: [string]
        name of the .csv file
    save: [string]
        name of the figure
    dire: ['x', 'y', 'z']
        direction of the detector
    '''
    file = pd.read_csv(file)

    if dire == 'r':
        x = np.array(file['x'].tolist())
        y = np.array(file['y'].tolist())
        d = np.sqrt(x**2 + y**2)
    else:
        d = file[dire].tolist()
    
    temp = file['temp'].tolist()

    plt.figure()
    plt.plot(d, temp)
    plt.ylabel(r'Temperature [$^{\circ}$C]')
    # plt.ylim(bottom = 800, top=1200)
    plt.xlabel(dire + ' [cm]')
    plt.savefig(save, dpi=300, bbox_inches="tight")

name = 'cg-advec1-ss'
t = '0002'
file = name + '_center_' + t + '.csv'
save = name + 'A'
plotcsv_frommoose_temp(file, save, 'y')

file = name + '_outer_' + t + '.csv'
save = name + 'B'
plotcsv_frommoose_temp(file, save, 'y')

file = name + '_across_' + t + '.csv'
save = name + 'C'
plotcsv_frommoose_temp(file, save, 'x')