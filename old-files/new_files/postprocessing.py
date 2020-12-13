import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import serpentTools as st
import os
import matplotlib.patches as mpatches
from matplotlib.cbook import get_sample_data
from matplotlib.patches import RegularPolygon
from matplotlib.collections import PatchCollection
from matplotlib.pyplot import gca
from matplotlib.axes import Axes


def plot_radial_flux_distribution(filename, save):
    '''
    This function plots the radial flux distribution in the active core.

    '''
    file = pd.read_csv(filename)

    # fast flux
    flux = np.zeros((3, 22))
    for r in range(22):
        flux[0, r] = float(file['axially_averaged_radial_fast_flux_R'
                           + str(r+1)].tolist()[-1])
        flux[1, r] = float(file['axially_averaged_radial_epithermal_flux_R'
                           + str(r+1)].tolist()[-1])
        flux[2, r] = float(file['axially_averaged_radial_thermal_flux_R'
                           + str(r+1)].tolist()[-1])

    P = 36  # pitch
    F = P / np.sqrt(3)

    coord = []
    # 1 - 6
    for i in range(4):
        coord.append(np.array([i*(F+F/2), 3*P-i*P/2]))
    for i in range(1, 3):
        coord.append(np.array([3*(F+F/2), 3*P-3*P/2-i*P]))

    # 7 - 14
    for i in range(5):
        coord.append(np.array([i*(F+F/2), 4*P-i*P/2]))
    for i in range(1, 4):
        coord.append(np.array([4*(F+F/2), 4*P-4*P/2-i*P]))

    # 15 - 22
    for i in range(1, 5):
        coord.append(np.array([i*(F+F/2), 5*P-i*P/2]))
    for i in range(1, 5):
        coord.append(np.array([5*(F+F/2), 5*P-5*P/2-i*P]))

    coord = np.array(coord)

    patches = []
    xmax, ymax = [-np.inf, ] * 2
    xmin, ymin = [np.inf, ] * 2
    for i in range(len(coord)):
        h = RegularPolygon(coord[i], 6, F, np.pi/2)
        patches.append(h)
        verts = h.get_verts()
        vmins = verts.min(0)
        vmaxs = verts.max(0)
        xmax = max(xmax, vmaxs[0])
        xmin = min(xmin, vmins[0])
        ymax = max(ymax, vmaxs[1])
        ymin = min(ymin, vmins[1])

    patches = np.array(patches, dtype=object)
    pc = PatchCollection(patches)

    g = 2
    ax = gca()
    pc.set_array(flux[g])
    ax.add_collection(pc)
    ax.set_xlim(xmin, xmax)
    ax.set_ylim(ymin, ymax)

    cbar = plt.colorbar(pc)
    cbar.ax.set_ylabel(r'$\phi \left[\frac{n}{cm^2s}\right]$')

    for i in range(22):
        val = "{:.2e}".format(flux[g, i])
        plt.text(x=coord[i][0]-F, y=coord[i][1]-P/15, s=val, fontsize=8)

    plt.axis('equal')
    plt.xlabel('X [cm]')
    plt.ylabel('Y [cm]')
    plt.savefig(save+'-'+str(g)+'G', dpi=300, bbox_inches="tight")


if __name__ == "__main__":
    # Plots the radially averaged axial flux distribution
    # We won't get these plots
    # Doing so with Moltres is quiet time consuming

    # Plots the axially averaged (over active core only)
    # radial flux distribution
    # We won't get these plots for 26G
    filename = '3D-fullcore6G-koutb.csv'
    save = '3D-fullcore6G-radialflux'
    plot_radial_flux_distribution(filename, save)
