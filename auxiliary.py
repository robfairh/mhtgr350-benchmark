import os
import numpy as np
from matplotlib.cbook import get_sample_data
import matplotlib.patches as mpatches
import matplotlib.pyplot as plt
import serpentTools as st


def compact():
    '''
    Adds legend to compact geometry image: 'compact_geom1.png'.
    '''

    uco = mpatches.Patch(color=(1., 1., 0.), label='UCO')
    buffer = mpatches.Patch(color=(1., 0.5, 0.), label='Porous Carbon')
    pyc = mpatches.Patch(color=(1., 0., 0.), label='PyC')
    sic = mpatches.Patch(color=(0.6, 0.3, 0.), label='SiC')
    matrix = mpatches.Patch(color=(0.63, 0.63, 0.63),
                            label='Graphite Compact Matrix')
    block = mpatches.Patch(color=(0.61, 1., 0.91), label='Graphite Fuel Block')
    helium = mpatches.Patch(color=(0.59, 0.41, 1.), label='He')

    cwd = os.getcwd()
    fname = get_sample_data('%s/compact_geom1.png' % (cwd))
    im = plt.imread(fname)
    plt.imshow(im)
    plt.legend(handles=[uco, buffer, pyc, sic, matrix, block, helium],
               loc="upper left", bbox_to_anchor=(1.0, 1.0), fancybox=True)

    plt.axis('off')
    plt.savefig("compact", dpi=300, bbox_inches="tight")


def standard():
    '''
    Adds legend to standard fuel assembly geometry image:
    'standard-fuel_geom1.png'.
    '''

    matrix = mpatches.Patch(color=(0.63, 0.63, 0.63),
                            label='Graphite Compact Matrix')
    block = mpatches.Patch(color=(0.61, 1., 0.91), label='Graphite Fuel Block')
    helium = mpatches.Patch(color=(0.59, 0.41, 1.), label='He')

    cwd = os.getcwd()
    fname = get_sample_data('%s/standard-fuel_geom1.png' % (cwd))
    im = plt.imread(fname)
    plt.imshow(im)
    plt.legend(handles=[matrix, block, helium],
               loc="upper right", bbox_to_anchor=(1., 0.0), fancybox=True)

    plt.axis('off')
    plt.savefig("standard", dpi=300, bbox_inches="tight")


def fullcore():
    '''
    Adds legend to fuel core geometry image:
    'fullcore_geom1.png'.
    '''

    matrix = mpatches.Patch(color=(0.63, 0.63, 0.63),
                            label='Graphite Fuel Block')
    block = mpatches.Patch(color=(0.61, 1., 0.91), label='Graphite Reflector')

    cwd = os.getcwd()
    fname = get_sample_data('%s/fullcore_geom1.png' % (cwd))
    im = plt.imread(fname)
    plt.imshow(im)
    plt.legend(handles=[matrix, block])

    plt.axis('off')
    plt.savefig("fullcore", dpi=300, bbox_inches="tight")


def plot_spectrum(data, name):
    """
    Plots spectrum normalized. The integral of the flux is 1.

    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
    name of the detector
    """

    det = data.detectors[name]
    val = det.tallies

    E = [line[0] for line in det.grids['E']]
    Emax = det.grids['E'][-1][1]

    dE = np.roll(E, -1) - E
    dE[-1] = Emax - E[-1]
    inte = sum(val*dE)
    val = val/inte

    plt.figure()
    plt.loglog(E, val)
    plt.xlabel('E [MeV]')
    plt.ylabel('Normalized flux')
    plt.grid(True)
    plt.savefig(name, dpi=300, bbox_inches="tight")


def plot_axial(data, vb, vc, vt):
    """
    Plots axial flux in bottom reflector, core, and top reflector.

    Parameters:
    -----------
    data: [serpenttools format]
    vb: [float]
    volume of the bottom reflector detector
    vc: [float]
    volume of the core reflector detector
    vt: [float]
    volume of the top reflector detector
    """

    name = 'AxialBot'
    det = data.detectors[name]
    zb = [line[0] for line in det.grids['Z']]
    valb = det.tallies
    vd1 = vb/len(zb)
    valb /= vd1

    name = 'AxialFuel'
    det = data.detectors[name]
    zf = [line[0] for line in det.grids['Z']]
    valf = det.tallies
    vd2 = vc/len(zf)
    valf /= vd2

    name = 'AxialTop'
    det = data.detectors[name]
    zt = [line[0] for line in det.grids['Z']]
    valt = det.tallies
    vd3 = vt/len(zt)
    valt /= vd3

    ther = np.concatenate([valb[0], valf[0], valt[0]])
    fast = np.concatenate([valb[1], valf[1], valt[1]])
    ztot = np.concatenate([zb, zf, zt])

    plt.figure()
    plt.step(ztot, ther, where='post', label='thermal')
    plt.step(ztot, fast, where='post', label='fast')
    plt.xlabel('z [cm]')
    plt.ylabel(r'$\phi$')
    plt.legend(loc="upper right")
    plt.title('Axial flux.')
    plt.savefig('axial1', dpi=300, bbox_inches="tight")


def plot_detector(data, name, V=1):
    """
    Plots flux in the axial direction 'Z'.

    Parameters:
    -----------
    data: [serpenttools format]
    name: [string]
    name of the detector
    V: [float]
    total volume where the detector is applied [cm3]
    """

    det = data.detectors[name]
    z = [line[0] for line in det.grids['Z']]
    val = det.tallies
    vdetector = V/len(z)
    val = val/vdetector

    plt.figure()
    plt.step(z, val[0], where='post', label='thermal')
    plt.step(z, val[1], where='post', label='fast')
    plt.xlabel('z [cm]')
    plt.ylabel(r'$\phi$')
    plt.legend(loc="upper right")
    plt.savefig(name, dpi=300, bbox_inches="tight")


def plots_standardcolumn():
    """
    Plots standard-column flux detector
    """

    data = st.read('standard-column_det0.m', reader='det')
    A = 18/np.cos(np.pi/6)  # cm length of face of the hexagon
    Ah = 6. * (A * 18./2)  # Area of the hexagon
    V = Ah * (160 + 793 + 120)
    plot_detector(data, 'Axial', V)


def fullcore_detectors():
    '''
    '''

    cwd = os.getcwd()
    fname = get_sample_data('%s/oecd-fullcore_geom1.png' % (cwd))
    im = plt.imread(fname)

    # crop the image
    height, width, color = np.shape(im)
    y1 = int(height*0.15)
    y2 = int(height*0.6)
    x1 = int(width*0.45)
    x2 = int(width)
    plt.imshow(im[y1:y2,x1:x2,:])
    plt.axis('off')

    # Axial 1
    x = 158
    y = 291
    P = 55
    s = P/2/np.cos(np.pi/6)
    plt.plot([s+x, 2*s+x], [0+y, 0+y], 'r-', lw=1.5, label='1- Axial1')
    plt.plot([s+x, 2*s+x], [P+y, P+y], 'r-', lw=1.5)
    plt.plot([s+x, s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([s/2+x, s+x], [P/2+y, P+y], 'r-', lw=1.5)
    plt.plot([2*s+x, 2*s+s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([2*s+s/2+x, 2*s+x], [P/2+y, P+y], 'r-', lw=1.5)

    plt.text(x=x+37, y=y+40, s='1', fontsize=20, color='w')

    # Axial 2
    x = 210
    y = 321
    P = 55
    s = P/2/np.cos(np.pi/6)
    plt.plot([s+x, 2*s+x], [0+y, 0+y], 'r-', lw=1.5, label='2- Axial2')
    plt.plot([s+x, 2*s+x], [P+y, P+y], 'r-', lw=1.5)
    plt.plot([s+x, s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([s/2+x, s+x], [P/2+y, P+y], 'r-', lw=1.5)
    plt.plot([2*s+x, 2*s+s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([2*s+s/2+x, 2*s+x], [P/2+y, P+y], 'r-', lw=1.5)
    plt.text(x=x+37, y=y+40, s='2', fontsize=20, color='w')

    # Axial 3
    x = 262
    y = 291
    P = 55
    s = P/2/np.cos(np.pi/6)
    plt.plot([s+x, 2*s+x], [0+y, 0+y], 'r-', lw=1.5, label='3- Axial3')
    plt.plot([s+x, 2*s+x], [P+y, P+y], 'r-', lw=1.5)
    plt.plot([s+x, s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([s/2+x, s+x], [P/2+y, P+y], 'r-', lw=1.5)
    plt.plot([2*s+x, 2*s+s/2+x], [0+y, P/2+y], 'r-', lw=1.5)
    plt.plot([2*s+s/2+x, 2*s+x], [P/2+y, P+y], 'r-', lw=1.5)

    plt.text(x=x+37, y=y+40, s='3', fontsize=20, color='w')

    # Radial 1
    x = 52
    y = 349
    plt.plot([x, 495+x], [y, y], 'r-', lw=1.5, label='4- Radial1')
    plt.plot([x, 495+x], [y, y], 'r-', lw=1.5, label='5- Radial2')
    plt.text(x=x+380, y=y-10, s='4, 5', fontsize=20, color='black')

    # Radial 2
    x = 52
    y = 349
    L = 495
    plt.plot([x, L*np.cos(np.pi/6)+x], [y, -L/2+y], 'r-', lw=1.5, label='6- Radial3')
    plt.text(x=350, y=y-200, s='6', rotation=30, fontsize=20, color='black')
    plt.legend(loc='best')

    plt.savefig("oecd-fullcore-detectors", dpi=300, bbox_inches="tight")


def plots_fullcore():
    '''
    Plots full-core flux detectors:
    * Spectrum
    * Axial1, Axial2, Axial3,
    * Radial1, Radial2, Radial3
    '''

    # Plot spectrum
    data = st.read('bw/fullcore_det1b1.m', reader='det')
    name = 'EnergyDetector'
    plot_spectrum(data, name)

    A = 18/np.cos(np.pi/6)  # cm length of face of the hexagon
    Ah = 6. * (A * 18./2)  # Area of the hexagon
    V = Ah * (160 + 793 + 120)
    plot_detector(data, 'Axial1', V)
    plot_detector(data, 'Axial2', V)
    plot_detector(data, 'Axial3', V)

    H = 793
    p = 2*np.pi  # = 360 deg
    plot_radial(data, 'Radial1', p*H)

    H = 79.3
    p = np.pi/90  # = 2 deg
    plot_radial(data, 'Radial2', p*H)

    H = 79.3
    p = np.pi/90  # = 2 deg
    plot_radial(data, 'Radial3', p*H)


def main():
    # Add legends
    # compact()
    # standard()
    # fullcore()

    # plots location of the detectors
    fullcore_detectors()

    # Gets full-core flux plots 
    # plots_fullcore()


if __name__ == "__main__":
    main()
