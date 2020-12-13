
def plotcsv_fromparaview_temp(file, save):
    '''
    Moltres output is an exodus file.
    Paraview reads exodus file.
    Paraview exports values to csv.
    This function plots those values.

    Parameters:
    -----------
    file: [string]
        name of the .csv file
    save: [string]
        name of the figure to produce
    '''

    file = pd.read_csv(file)

    x = file['Points:1'].tolist()
    temp = file['temp'].tolist()

    plt.figure()
    plt.plot(x, temp)
    plt.ylabel('Temperature')
    plt.xlabel('z [cm]')
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


def plotcsv_fromparaview_groups(file, save, G=2, dire='z'):
    '''
    Moltres output is an exodus file.
    Paraview reads exodus file.
    Paraview exports values to csv.
    This function plots those values.

    Parameters:
    -----------
    file: [string]
        name of the .csv file
    save: [string]
        name of the figure to produce
    G: [int]
        number of energy groups
    dire: [char]
        direction on which the detector is applied
        values: 'x', 'y', 'z', 'r'
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
    if dire == 'x':
        x = file['Points:0'].tolist()
    if dire == 'y':
        x = file['Points:1'].tolist()
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

    Parameters:
    -----------
    file: [string]
        name of the .csv file
    save: [string]
        name of the figure to produce
    G: [int]
        number of energy groups
    dire: [char]
        direction on which the detector is applied
        values: 'x', 'y', 'z', 'r'
    '''

    file = pd.read_csv(file)
    plt.figure()

    if dire == 'r':
        x1 = np.array(file['x'].tolist())
        y1 = np.array(file['y'].tolist())
        r = np.sqrt(x1**2 + y1**2)
        x = r
    else:
        # x, y, z direction
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


def plotconvergence(file, save):
    '''
        This function plots eigenvalues vs power iteraions
    '''
    file = pd.read_csv(file)

    x = file['iteration'].tolist()
    eig = file['eigenvalue'].tolist()
    sold = file['solution_difference'].tolist()

    fig, ax1 = plt.subplots()
    ax1.plot(x[1:], eig[1:], marker='o', color='black')
    ax1.set_ylabel("Eigenvalue", color='black')
    ax1.set_xlabel("Iteration")
    ax1.tick_params(axis='y', labelcolor='black')
    ax2 = ax1.twinx()
    ax2.plot(x[1:], sold[1:], color='red', marker='o')
    ax2.set_ylabel(r'$\phi_1-\phi_{1,prev}$', color='red')
    ax2.tick_params(axis='y', labelcolor='red')
    fig.tight_layout()
    plt.savefig(save, dpi=300, bbox_inches="tight")


def reagroup(E, val, E0):
    '''
    This function converts a fine energy grid spectrum into a
    coarser one.

    Parameters:
    -----------
    E: [array]
        contains energy group limits
    val: [array]
        contains fluxes for each energy bins
    E0: [array]
        contains new enegy group limist
    '''

    e = 1e-13
    new_val = np.zeros(len(E0))
    j = 0
    for i in range(len(E)-1):
        if j < len(E0)-2:
            if E[i] >= E0[j]-e and E[i] < E0[j+1]+e:
                new_val[j] += val[i]
                # new_val[j] += val[i]*(E[i+1]-E[i])/(E0[j+1]-E0[j])
            else:
                j += 1
                continue
        else:
            if E[i] >= E0[j]-e:
                new_val[j] += val[i]
                # new_val[j] += val[i]*(E[i+1]-E[i])/(E0[j+1]-E0[j])

    # this adds an additional point in the very beginning
    new_val = np.roll(new_val, 1)
    new_val[0] = new_val[1]
    E = E0
    val = new_val
    return E, val


def plot_serpent_coarse_spectrum():
    '''
    This function
    '''

    data = st.read('oecd-fullcore26G-1200_det1b1.m', reader='det')
    save = 'serpent-fullcore-1200-coarse-spectrum'
    det = data.detectors['EnergyDetector']
    val = det.tallies

    E = [line[0] for line in det.grids['E']]
    Emax = det.grids['E'][-1][1]

    dE = np.roll(E, -1) - E
    dE[-1] = Emax - E[-1]

    # Integral is normalized to 1
    # inte = sum(val*dE)
    # val = val/inte
    val /= sum(val)

    plt.figure()
    # plt.step(E, val)

    # 15 groups
    E15d = [1.49e+7, 3.68e+6, 1.11e+5, 7.485e+2, 1.301e+2,
            2.9e+1, 8.32e0, 2.38e0, 6.5e-1, 3.5e-1,
            2.0e-1, 8.0e-2, 5.0e-2, 2.0e-2, 1.0e-2,
            1.0e-5]

    E15d.reverse()
    E15d = np.array(E15d)/1e6  # eV to MeV
    E1, val1 = reagroup(E, val, E15d)

    plt.step(E1, val1)
    plt.xscale('log')
    plt.xlabel('E [MeV]')
    plt.ylabel(r'Energy integrated flux [$\frac{n}{cm^2s}$]')
    plt.grid(True)
    plt.savefig(save, dpi=300, bbox_inches="tight")
    plt.close()


def plot_serpent_axial(data, name, save, V=1, dire='Z'):
    """
    Plots axial flux from serpent detector.

    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
        name of the detector
    fig: [string]
        root name of the figure
    V: [float]
        total volume where the detector is applied [cm3]
    dire: [float]
        direction that the detector faces: 'X', 'Y', 'Z'
    """
    det = data.detectors[name]
    z = [line[0] for line in det.grids[dire]]
    val = det.tallies
    vdetector = V/len(z)
    val = val/vdetector
    # M = max(val[1])
    # val /= M
    G = len(val)  # number of energy groups

    plt.figure()
    for i in range(G):
        plt.step(z, val[G-1-i], where='post', label='g={0}'.format(i+1))

    plt.xlabel(dire.lower()+' [cm]')
    plt.ylabel(r'$\phi \left[\frac{n}{cm^2s}\right]$')
    if G < 20:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.), fancybox=True)
    else:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.2), fancybox=True)
    plt.savefig(fig + '-' + name, dpi=300, bbox_inches="tight")


def plot_radial(data, name, fig, piH=1):
    """
    Plots flux from curvilinear detector.

    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
        name of the detector
    fig: [string]
        root name of the figure
    piH: [float]
        angle * total height of the detector [cm]
    """
    det = data.detectors[name]
    r = np.array([line[0] for line in det.grids['R']])
    vdetector = np.roll(r, -1)**2-r**2
    vdetector[-1] = det.grids['R'][-1][1]**2 - det.grids['R'][-1][0]**2
    vdetector *= piH/2

    val = det.tallies
    val = val/vdetector
    G = len(val)  # number of energy groups

    plt.figure()
    for i in range(G):
        plt.step(r, val[G-1-i], where='post', label='g={0}'.format(i+1))

    plt.xlabel('r [cm]')
    plt.ylabel(r'$\phi$')
    if G < 20:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.), fancybox=True)
    else:
        plt.legend(loc="upper left", bbox_to_anchor=(1., 1.2), fancybox=True)
    plt.savefig(fig + '-' + name, dpi=300, bbox_inches="tight")


def plot_hexagonal(data, name, fig, p, x0, y0, ff):
    """
    Plots flux from curvilinear detector.
    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
        name of the detector
    fig: [string]
        root name of the figure
    p: [float]
        pitch. Distance between hexagon centers.
    x0: [float]
        center coordinate
    y0: [float]
        center coordinate
    ff: [float]
        assembly flat-to-flat distance
    """
    det = data.detectors[name]
    plt.figure()
    det.tallies /= 1e6  # Values are in MW now
    det.pitch = p
    det.hexType = 3
    ax = det.hexPlot(cbarLabel='Power [MW]')
    ax.set_aspect('equal')
    plt.savefig(fig + '-' + name, dpi=300, bbox_inches="tight")


def int_flux(data, name):
    """
    Integrates flux in a domain.

    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
        name of the detector
    """
    det = data.detectors[name]
    val = det.tallies
    val0 = val[0]  # thermal flux
    val1 = val[1]  # fast flux
    # If I want to integrate between to values of R:
    # r = det.grids['R'][:, 0]
    # val0 = np.where(det.grids['R'][:, 0] > 80, val[0], 0)
    # val0 = np.where(det.grids['R'][:, 0] < 180, val0, 0)
    # val1 = np.where(det.grids['R'][:, 0] > 80, val[1], 0)
    # val1 = np.where(det.grids['R'][:, 0] < 180, val1, 0)
    print('Int_G1: ', sum(val1))
    print('Int_G2: ', sum(val0))


def plot_old_fullcore():
    '''
    Plots the output of the detectors of the full core model.
    - Spectrum
    - 3 axial flux detectors
    - 3 radial flux detector
    - Pin power distribution
    '''
    data = st.read('oecd-fullcore26G_det1b1.m', reader='det')
    fig = 'fullcore26G'

    # Plots energy spectrum
    plot_spectrum(data, 'EnergyDetector', fig)

    # Plots axial fluxes
    A = 18/np.cos(np.pi/6)  # cm length of face of the hexagon
    Ah = 6. * (A * 18./2)   # Area of the hexagon
    V = Ah * (160 + 793 + 120)
    plot_axial(data, 'Axial1', fig, V)
    plot_axial(data, 'Axial2', fig, V)
    plot_axial(data, 'Axial3', fig, V)

    # Plots radial flux
    H = 793
    p = np.pi/180 * 360  # = 360 deg
    plot_radial(data, 'Radial1', fig, p*H)
    H = 79.3
    p = np.pi/180 * 2  # = 2 deg
    plot_radial(data, 'Radial2', fig, p*H)
    H = 79.3
    p = np.pi/180 * 2  # = 2 deg
    plot_radial(data, 'Radial3', fig, p*H)

    # Plots pin power distribution
    plot_hexagonal(data, 'power', fig, 36, 36*np.cos(np.pi/6), 62.35383, 108)


def plot_column():
    '''
    Plots the output of the detectors of the standard column model:
    - 1 axial flux detector
    '''
    A = 18/np.cos(np.pi/6)  # cm length of face of the hexagon
    Ah = 6. * (A * 18./2)   # Area of the hexagon
    V = Ah * (160 + 793 + 120)

    G = 26
    data = st.read('standard-column2-' + str(G) + 'G_det1b1.m', reader='det')
    plot_axial(data, 'Axial', 'column-noLBP-' + str(G) + 'G-600', V)
    data = st.read('standard-column2-' + str(G) + 'G_det1b2.m', reader='det')
    plot_axial(data, 'Axial', 'column-noLBP-' + str(G) + 'G-1200', V)
    data = st.read('standard-column7-' + str(G) + 'G_det1b1.m', reader='det')
    plot_axial(data, 'Axial', 'column-LBP-' + str(G) + 'G-600', V)
    data = st.read('standard-column7-' + str(G) + 'G_det1b2.m', reader='det')
    plot_axial(data, 'Axial', 'column-LBP-' + str(G) + 'G-1200', V)


def plot_moltres_spectrum():
    '''
    This function

    '''

    # filename = '3D-fullcore-600-15Gd.csv'
    # save = 'moltres-fullcore-600-spectrum'
    filename = '3D-fullcore-1200-15Gc.csv'
    save = 'moltres-fullcore-1200-spectrum'
    file = pd.read_csv(filename)

    group = []
    for i in range(1, 16):
        group.append(file['integral_group' + str(i)].tolist()[-1])
    group.append(file['integral_group' + str(i)].tolist()[-1])
    group.reverse()
    group = np.array(group)
    group /= sum(group)

    # 15 groups
    E15d = [1.49e+7, 3.68e+6, 1.11e+5, 7.485e+2, 1.301e+2,
            2.9e+1, 8.32e0, 2.38e0, 6.5e-1, 3.5e-1,
            2.0e-1, 8.0e-2, 5.0e-2, 2.0e-2, 1.0e-2,
            1.0e-5]
    E15d.reverse()
    E15d = np.array(E15d)/1e6  # eV to MeV

    # # divides the flux by the energy bins
    # group = []
    # for i in range(1, 16):
    #     group.append(file['integral_group' + str(i)].tolist()[-1])

    # # 15 groups
    # E15d = [1.49e+7, 3.68e+6, 1.11e+5, 7.485e+2, 1.301e+2,
    #         2.9e+1, 8.32e0, 2.38e0, 6.5e-1, 3.5e-1,
    #         2.0e-1, 8.0e-2, 5.0e-2, 2.0e-2, 1.0e-2,
    #         1.0e-5]
    # E15d = np.array(E15d)/1e6  # eV to MeV
    # group = np.array(group)/(E15d - np.roll(E15d, -1))[:-1]
    # group = group[::-1]
    # E15d = E15d[::-1]
    # new_group = np.zeros(len(group)+1)
    # new_group[1:] = group
    # new_group[0] = new_group[1]

    plt.figure()
    plt.step(E15d, group)
    plt.xscale('log')
    plt.xlabel('E [MeV]')
    plt.ylabel(r'Normalized flux [$\frac{n}{cm^2s}$]')
    plt.grid(True)
    plt.savefig(save, dpi=300, bbox_inches="tight")
    plt.close()


def serpent_moltres_spectrum():
    '''
    '''

    # data = st.read('oecd-fullcore26G-600_det1b1.m', reader='det')
    # save = 'fullcore-600-coarse-spectrum'
    # filename = '3D-fullcore-600-15Gd.csv'
    
    data = st.read('oecd-fullcore26G-1200_det1b1.m', reader='det')
    filename = '3D-fullcore-1200-15Gc.csv'
    save = 'fullcore-1200-coarse-spectrum'

    det = data.detectors['EnergyDetector']
    val = det.tallies

    E = [line[0] for line in det.grids['E']]
    Emax = det.grids['E'][-1][1]

    dE = np.roll(E, -1) - E
    dE[-1] = Emax - E[-1]
    val /= sum(val)

    # 15 groups
    E15d = [1.49e+7, 3.68e+6, 1.11e+5, 7.485e+2, 1.301e+2,
            2.9e+1, 8.32e0, 2.38e0, 6.5e-1, 3.5e-1,
            2.0e-1, 8.0e-2, 5.0e-2, 2.0e-2, 1.0e-2,
            1.0e-5]
    E15d.reverse()
    E15d = np.array(E15d)/1e6  # eV to MeV
    E1, val1 = reagroup(E, val, E15d)

    plt.figure()
    plt.step(E1, val1, label='serpent')

    file = pd.read_csv(filename)

    group = []
    for i in range(1, 16):
        group.append(file['integral_group' + str(i)].tolist()[-1])
    group.append(file['integral_group' + str(i)].tolist()[-1])
    group.reverse()
    group = np.array(group)
    group /= sum(group)

    plt.step(E15d, group, label='moltres')

    plt.xscale('log')
    plt.xlabel('E [MeV]')
    plt.ylabel(r'Energy integrated flux [$\frac{n}{cm^2s}$]')
    plt.grid(True)
    plt.legend(loc='upper right')
    plt.savefig(save, dpi=300, bbox_inches="tight")
    plt.close()


# def calc_error(dire='z'):
#     '''
#        This function calculates the error between two plots (for different groups).
#        This should be used carefully, as the solutions on the reflector present a
#        much larger error than in the active core region, making the error quite 
#        high.
#        It would be better to only consider the active core.
#     '''
    
#     file1 = '3D-assembly-noLBP-600-26G_axial_0002.csv'
#     file2 = '3D-assembly-noLBP-600-21G_axial_0002.csv'

#     save = '21G-er'

#     file1 = pd.read_csv(file1)
#     file2 = pd.read_csv(file2)
#     plt.figure()

#     if dire == 'r':
#         x1 = np.array(file1['x'].tolist())
#         y1 = np.array(file1['y'].tolist())
#         r = np.sqrt(x1**2 + y1**2)
#         x = r

#     else:
#         x = file1[dire].tolist()

#     group11 = file1['group1'].tolist()
#     N = len(group11)
#     G = len(file1.keys())-4  # this might cause issues

#     lim = [4, 16, 26]  # from 26 to 3
#     Gp = len(lim)
#     group1 = np.zeros((Gp, N))

#     for gp in range(Gp):
#         if gp == 0:
#             for g in range(lim[0]):
#                 group1[gp] += np.array(file1['group'+str(g+1)].tolist())
#         else:
#             for g in range(lim[gp-1], lim[gp]):
#                 group1[gp] += np.array(file1['group'+str(g+1)].tolist())

#     group21 = file2['group1'].tolist()
#     N = len(group21)
#     G = len(file2.keys())-4  # this might cause issues

#     lim = [2, 12, 21]  # from 21 to 3
#     Gp = len(lim)
#     group2 = np.zeros((Gp, N))

#     for gp in range(Gp):
#         if gp == 0:
#             for g in range(lim[0]):
#                 group2[gp] += np.array(file2['group'+str(g+1)].tolist())
#         else:
#             for g in range(lim[gp-1], lim[gp]):
#                 group2[gp] += np.array(file2['group'+str(g+1)].tolist())

    
#     e = np.zeros(3)
#     for gp in range(Gp):
#         x = ((group1[gp]-group2[gp])/group1[gp])**2
#         e[gp] = np.sqrt(sum(x))

#     print(e)


def calc_error(file1, file2, limB, l1, l2, dire='z'):
    '''
    This function calculates the error between two plots (for different groups).
    This should be used carefully, as the solutions on the reflector present a
    much larger error than in the active core region, making the error quite 
    high.
    It would be better to only consider the active core.

    Parameters:
    -----------
    '''
    
    file1 = pd.read_csv(file1)
    file2 = pd.read_csv(file2)
    plt.figure()

    if dire == 'r':
        x1 = np.array(file1['x'].tolist())
        y1 = np.array(file1['y'].tolist())
        r = np.sqrt(x1**2 + y1**2)
        x = r

    else:
        x = file1[dire].tolist()

    x = np.array(x)
    group11 = file1['group1'].tolist()
    N = len(group11)
    G = len(file1.keys())-4  # this might cause issues

    lim = choose_lim(G)
    Gp = len(lim)
    group1 = np.zeros((Gp, N))

    for gp in range(Gp):
        if gp == 0:
            for g in range(lim[0]):
                group1[gp] += np.array(file1['group'+str(g+1)].tolist())
        else:
            for g in range(lim[gp-1], lim[gp]):
                group1[gp] += np.array(file1['group'+str(g+1)].tolist())

    group21 = file2['group1'].tolist()
    N = len(group21)
    G = len(file2.keys())-4  # this might cause issues

    Gp = len(limB)
    group2 = np.zeros((Gp, N))

    for gp in range(Gp):
        if gp == 0:
            for g in range(limB[0]):
                group2[gp] += np.array(file2['group'+str(g+1)].tolist())
        else:
            for g in range(limB[gp-1], limB[gp]):
                group2[gp] += np.array(file2['group'+str(g+1)].tolist())

    e = np.zeros(3)
    for gp in range(Gp):
        aux = ((group1[gp]-group2[gp])/group1[gp])**2
        e[gp] = np.sqrt(sum(aux))

    # active core error
    group1 = np.where(x >= l1, group1, 0)
    group1 = np.where(x <= l2, group1, 0)
    group2 = np.where(x >= l1, group2, 0)
    group2 = np.where(x <= l2, group2, 0)

    # plt.figure()
    # plt.plot(x, group1[2], label='15G')
    # plt.plot(x, group2[2], label='9G')
    # plt.legend(loc='best')
    # plt.show()

    e2 = np.zeros(3)
    for gp in range(Gp):
        aux = ((group1[gp][group1[gp] != 0]-group2[gp][group2[gp] != 0])/group1[gp][group1[gp] != 0])**2
        e2[gp] = np.sqrt(sum(aux))

    return e, e2
