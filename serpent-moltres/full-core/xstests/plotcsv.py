import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import serpentTools as st


def plotcsv_fromparaview_temp(file, save):
    '''
        Moltres output is an exodus file.
        Paraview reads exodus file.
        Paraview exports values to csv.
        This function plots those values.
    '''
    file = pd.read_csv(file)

    x = file['Points:1'].tolist()
    temp = file['temp'].tolist()

    plt.figure()
    plt.plot(x, temp)
    plt.ylabel('Temperature')
    plt.xlabel('z [cm]')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plotcsv_frommoose_temp(file, save):
    '''
        Moltres output is a csv file.
        This function plots those values.
    '''
    file = pd.read_csv(file)

    x = file['y'].tolist()
    temp = file['group1'].tolist()

    plt.figure()
    plt.plot(x, temp)
    plt.ylabel('Temperature')
    plt.xlabel('z [cm]')
    # plt.title('Steady-state flux')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plotcsv_fromparaview_groups(file, save, G=2, dire='z'):
    '''
        Moltres output is an exodus file.
        Paraview reads exodus file.
        Paraview exports values to csv.
        This function plots those values.
    '''
    file = pd.read_csv(file)
    plt.figure()

    group1 = file['group1'].tolist()
    N = len(group1)
    group = np.zeros((G, N))

    for i in range(G):
        group[i] = np.array(file['group'+str(i+1)].tolist())

    if dire == 'r':
        x1 = np.array(file['Points:0'].tolist())
        y1 = np.array(file['Points:1'].tolist())
        r = np.sqrt(x1**2 + y1**2)
        x = r
    else:
        # z direction
        x = file['Points:2'].tolist()

    for i in range(G):
        plt.plot(x, group[i], label='g='+str(i+1))

    if G < 20:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.), fancybox=True)
    else:
        # 1.1 or 1.2
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.1), fancybox=True)

    plt.xlabel(dire+' [cm]')
    plt.ylabel(r'$\phi \left[\frac{n}{cm^2s}\right]$')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plotcsv_frommoose_groups(file, save, G=2, dire='z'):
    '''
        Moltres output is a csv file.
        This function plots those values.
    '''
    file = pd.read_csv(file)
    plt.figure()

    if dire == 'r':
        x1 = np.array(file['x'].tolist())
        y1 = np.array(file['y'].tolist())
        r = np.sqrt(x1**2 + y1**2)
        x = r

    else:
        x = file[dire].tolist()

    group1 = file['group1'].tolist()
    N = len(group1)
    group = np.zeros((G, N))

    for i in range(G):
        group[i] = np.array(file['group'+str(i+1)].tolist())

    # If values are unsorted
    for i in range(G):
        group[i] = [X for _, X in sorted(zip(x, group[i]))]
    x.sort()

    # To normalize to the max value of group 1 flux
    # M = max(group1)
    # group /= M

    for i in range(G):
        plt.plot(x, group[i], label='g='+str(i+1))

    if G < 20:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.), fancybox=True)
    else:
        # 1.1 or 1.2
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.1), fancybox=True)

    plt.xlabel(dire+' [cm]')
    plt.ylabel(r'$\phi \left[\frac{n}{cm^2s}\right]$')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plot_power_distribution(file, save):
    '''
        The way of doing this is not ideal, but it works.
    '''
    df = pd.read_csv(file)

    tot = 0
    for i in range(1, 14):
        P = df['F' + str(i) + '_fission_heat'].tolist()[-1]
        P = np.array(P)/1e6
        print('P', i, ' = ', np.round(P, 3), 'MW')
        tot += P

    print('Total Power = ', tot*6, 'MW')

    grid = st.read('serpent_det0.m', reader='det')
    det = grid.detectors['power']

    det.tallies = np.zeros((5, 5))
    det.tallies[0, 3] = 2*df['F1_fission_heat'].tolist()[-1]
    det.tallies[0, 4] = 2*df['F2_fission_heat'].tolist()[-1]

    det.tallies[1, 2] = df['F3_fission_heat'].tolist()[-1]
    det.tallies[1, 3] = df['F4_fission_heat'].tolist()[-1]
    det.tallies[1, 4] = df['F5_fission_heat'].tolist()[-1]

    det.tallies[2, 1] = df['F6_fission_heat'].tolist()[-1]
    det.tallies[2, 2] = df['F7_fission_heat'].tolist()[-1]
    det.tallies[2, 3] = df['F8_fission_heat'].tolist()[-1]

    det.tallies[3, 0] = 2*df['F9_fission_heat'].tolist()[-1]
    det.tallies[3, 1] = df['F10_fission_heat'].tolist()[-1]
    det.tallies[3, 2] = df['F11_fission_heat'].tolist()[-1]

    det.tallies[4, 0] = 2*df['F12_fission_heat'].tolist()[-1]
    det.tallies[4, 1] = df['F13_fission_heat'].tolist()[-1]

    det.tallies /= 1e6  # Values are in MW now
    det.pitch = 36
    det.hexType = 3
    ax = det.hexPlot(cbarLabel='Power [MW]')
    ax.set_aspect('equal')
    plt.savefig(save, dpi=300, bbox_inches="tight")


def plot_fullcore_3D_A():
    file = 'fullcore12GA_axial1_0002.csv'
    save = 'fullcore12GA_axial1'
    plotcsv_frommoose_groups(file, save, dire='z')

    file = 'fullcore12GA_axial3_0002.csv'
    save = 'fullcore12GA_axial3'
    plotcsv_frommoose_groups(file, save, dire='z')

    file = 'fullcore12GA_radial1_0002.csv'
    save = 'fullcore12GA_radial1'
    plotcsv_frommoose_groups(file, save, dire='r')


def plot_fullcore_3D_B():
    file = 'fullcore12GB_axial1_0002.csv'
    save = 'fullcore12GB_axial1'
    plotcsv_frommoose_groups(file, save, dire='z')

    file = 'fullcore12GB_axial3_0002.csv'
    save = 'fullcore12GB_axial3'
    plotcsv_frommoose_groups(file, save, dire='z')

    file = 'fullcore12GB_radial1_0002.csv'
    save = 'fullcore12GB_radial1'
    plotcsv_frommoose_groups(file, save, dire='r')


plot_fullcore_3D_A()
plot_fullcore_3D_B()
