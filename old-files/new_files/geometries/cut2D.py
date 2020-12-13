import numpy as np
import math as mt
import sys


def check_upper(x, y, r):
    """
    If the circle intersects the line at 90 degrees, returns TRUE
    """

    xo = x - r
    if xo < 0:
        intersect = True
    else:
        intersect = False
    return intersect


def check_lower(x, y, r, a):
    """
    If the circle intersects the line at angle 'a', returns TRUE
    """

    dx = r * np.sin(a)
    dy = r * np.cos(a)
    xo = x + dx
    yo = y - dy
    ac = mt.atan(yo/xo)
    # print("ac: ", ac/np.pi*180)
    if ac < a:
        intersect = True
    else:
        intersect = False
    return intersect


def plot_circle(f, r, x, y, l, ps, dict_type, lp):
    """
    plots circles
    r: radius of the circle
    x,y: center of the circle
    l: number of lines
    ps: number of surfaces
    dict_type: dictionary that classifies the figures
    """

    f.write("Circle(" + str(l+1) + ") = { " + str(x) + ", " + str(y)
            + ", 0, " + str(r) + ", 0, 2*Pi};\n")
    dict_type['circle'].append(l+1)
    lp.append(ps+1)
    l += 1
    ps += 1
    return l, ps, dict_type, lp


def plot_arc_upper(f, r, x, y, l, ps, dict_type, lp):
    """
    plots arc based on the intersection of the line at 90 degrees and a circle
    r: radius of the circle
    x,y: center of the circle
    l: number of lines
    ps: number of surfaces
    dict_type: dictionary that classifies the figures
    """

    alpha = mt.acos(x/r)
    alpha2 = np.pi - alpha
    f.write("Circle(" + str(l+1) + ") = { " + str(x) + ", " + str(y) + ", 0, "
            + str(r) + ", " + str(-alpha2) + ", " + str(alpha2) + "};\n")
    dict_type['up_arc'].append(l+1)
    points = []
    points.append(ps + 2)
    points.append(ps + 1)
    lp.append(points)
    l += 1
    ps += 2
    return l, ps, dict_type, lp


def plot_arc_lower(f, r, a, x, y, l, ps, dict_type, lp):
    """
    plots arc based on the intersection of the lower line and the circle
    r: radius of the circle
    a: angle of the lower line
    x,y: center of the circle
    l: number of lines
    ps: number of surfaces
    dict_type: dictionary that classifies the figures
    """

    y1 = x * np.tan(a)
    dy = y - y1
    d = dy * np.cos(a)  # center-to-line distance
    alpha = mt.acos(d/r)
    alpha2 = 3./2*np.pi - (alpha - a)
    alpha1 = -1./2*np.pi + (alpha + a)
    f.write("Circle(" + str(l+1) + ") = { " + str(x) + ", " + str(y) + ", 0, "
            + str(r) + ", " + str(alpha1) + ", " + str(alpha2) + "};\n")
    dict_type['low_arc'].append(l+1)
    points = []
    points.append(ps + 1)
    points.append(ps + 2)
    lp.append(points)
    l += 1
    ps += 2
    return l, ps, dict_type, lp


def check_domain(x, y, r, a, dx):
    """
    If the circle is fully or partially inside the domain returns TRUE
    x,y: center of the circle
    r: radius of the circle
    a: angle of the lower line
    """
    beta1 = mt.atan2(y + r * np.cos(a), x - r * np.sin(a))
    # print(beta1)
    beta2 = mt.atan2(y, x + r)
    # print(beta2)
    if beta1 > a and beta2 > 0 and beta2 < np.pi/2 and (y+r) < dx:
        inside = True
    else:
        inside = False
    return inside


def place_channel(f, r, x, a1, dx, l, ps, type, dict_type, lp, phy_type):
    """
    Plots circle if the channel is in the geometry. If the circle intersects
    the line at 90 degrees, it plots an 'upper arc'. If the circle intersects
    the line at angle 'a', it plots a 'lower arc'.
    r: radius of the circle
    d_x:
    """
    xo = x[0, 0]
    for yo in x[:, 1]:
        if check_domain(xo, yo, r, a1, dx):
            if check_lower(xo, yo, r, a1):
                l, ps, dict_type, lp = plot_arc_lower(f, r, a1, xo, yo, l,
                                                      ps, dict_type, lp)
            elif check_upper(xo, yo, r):
                l, ps, dict_type, lp = plot_arc_upper(f, r, xo, yo, l, ps,
                                                      dict_type, lp)
            else:
                l, ps, dict_type, lp = plot_circle(f, r, xo, yo, l, ps,
                                                   dict_type, lp)

        if type == 'fuel' or type == 'coolant' or type == 'moderator':
            phy_type[type].append(l)
        else:
            print('Wrong type')
            sys.exit()
    return l, ps, dict_type, lp, phy_type


def multiple_channels(f, rc, rf, a1, dx, pi, x, l, ps, fuel, dict_type, lp, phy_type):
    """
    The channels are defined from left to right and from the bottom to the top.
    To add the side lines, the channels have to be defined that way. Otherwise
    the lines would be a mess.
    """
    px = pi/2
    py = round(pi*np.cos(np.pi/6), 3)

    x = np.zeros((1, 2))
    x[0, 1] = 2*py
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'coolant', dict_type, lp, phy_type)

    row = np.arange(2, 6)
    x = np.zeros((len(row), 2))
    x[:, 1] = 2*py*row
    l, ps, dict_type, lp, phy_type = place_channel(f, rc, x, a1, dx, l, ps, 'coolant', dict_type, lp, phy_type)

    row = np.arange(1, 6)
    x = np.zeros((len(row), 2))
    x[:, 1] = 2*py*row
    x[:, 0] += px*np.ones(len(row))
    x[:, 1] += py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] -= py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] += py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rc, x, a1, dx, l, ps, 'coolant', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] -= py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] += py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] -= py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rc, x, a1, dx, l, ps, 'coolant', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] += py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] -= py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] += py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rc, x, a1, dx, l, ps, 'coolant', dict_type, lp, phy_type)

    x[:, 0] += px*np.ones(len(row))
    x[:, 1] -= py*np.ones(len(row))
    l, ps, dict_type, lp, phy_type = place_channel(f, rf, x, a1, dx, l, ps, 'fuel', dict_type, lp, phy_type)

    return l, ps, dict_type, lp, phy_type


def place_moderator(f, dx, a, l, ps, dict_type, lp, phy_type):
    """
    plots arc based on the intersection of the upper line and a circle
    r: radius of the circle
    R: radius of the moderator
    x,y: center of the circle
    """
    rc = dx*np.tan(np.pi/6)  # right corner
    f.write("Point(" + str(ps+1) + ") = { 0, " + str(dx) + ", 0, 1};\n")
    f.write("Point(" + str(ps+2) + ") = { " + str(rc) + ", " + str(dx)
            + ", 0, 1};\n")
    f.write("Line(" + str(l+1) + ") = { " + str(ps+1) + ", " + str(ps+2)
            + "};\n")
    dict_type['mod'].append(l+1)

    points = []
    points.append(ps + 1)
    points.append(ps + 2)
    lp.append(points)

    l += 1
    ps += 2
    return l, ps, dict_type, lp, phy_type


def plot_upper_lines(f, l, ps, dict_type, lp):
    cc = 1
    for i in range(len(dict_type['up_arc'][:-1])):
        j0 = dict_type['up_arc'][i]
        j1 = dict_type['up_arc'][i+1]
        f.write("Line(" + str(l+cc) + ") = { " + str(lp[j0][0]) + ", "
                + str(lp[j0][1]) + "};\n")
        cc += 1
        f.write("Line(" + str(l+cc) + ") = { " + str(lp[j0][1]) + ", "
                + str(lp[j1][0]) + "};\n")
        cc += 1

    i = dict_type['up_arc'][-1]
    f.write("Line(" + str(l+cc) + ") = { " + str(lp[i][0]) + ", "
            + str(lp[i][1]) + "};\n")
    cc += 1
    f.write("Line(" + str(l+cc) + ") = { " + str(lp[i][1]) + ", "
            + str(lp[dict_type['mod'][-1]][0]) + "};\n")
    cc += 1
    f.write("Line(" + str(l+cc) + ") = { " + str(dict_type['up_arc'][:-1][1])
            + ", " + str(ps) + "};\n")
    cc += 1
    l += cc
    return l, ps


def plot_lower_lines(f, a, l, ps, dict_type, lp):
    cc = 1
    for i in range(len(dict_type['low_arc'][:-1])):
        j0 = dict_type['low_arc'][i]
        j1 = dict_type['low_arc'][i+1]
        f.write("Line(" + str(l+cc) + ") = { " + str(lp[j0][0]) + ", "
                + str(lp[j0][1]) + "};\n")
        cc += 1
        f.write("Line(" + str(l+cc) + ") = { " + str(lp[j0][1]) + ", "
                + str(lp[j1][0]) + "};\n")
        cc += 1

    i = dict_type['low_arc'][-1]
    f.write("Line(" + str(l+cc) + ") = { " + str(lp[i][0]) + ", "
            + str(lp[i][1]) + "};\n")
    cc += 1
    f.write("Line(" + str(l+cc) + ") = { " + str(lp[i][1]) + ", "
            + str(lp[dict_type['mod'][-1]][1]) + "};\n")
    cc += 1
    f.write("Line(" + str(l+cc) + ") = { " + str(dict_type['low_arc'][:-1][1])
            + ", " + str(ps) + "};\n")
    cc += 1
    l += cc

    return l, ps


def main():
    rc = 0.794
    rf = 0.635
    pi = 1.88  # pitch between channels [cm]

    dx = 36/2
    a1 = np.pi/3  # angle of the plane
    # p = d_x/2/np.tan(np.pi/6)

    l = 0
    ps = 0
    dict_type = {'circle': [], 'up_arc': [], 'low_arc': [],
                 'mod': [], 'central': []}
    lp = [0]  # list of points

    f = open("untitled2.geo", "w+")
    f.write('// Gmsh geometry\n')
    f.write('SetFactory("OpenCASCADE");\n//+\n')

    phy_type = {'fuel': [], 'coolant': [], 'moderator': []}

    x = np.array([0, 0])
    l, ps, dict_type, lp, phy_type = multiple_channels(f, rc, rf, a1, dx, pi, x, l, ps, True, dict_type, lp, phy_type)

    l, ps, dict_type, lp, phy_type = place_moderator(f, dx, a1, l, ps, dict_type, lp, phy_type)
    f.write("Point(" + str(ps+1) + ") = { 0, 0, 0, 1.0};\n")
    ps += 1
    l, ps = plot_lower_lines(f, a1, l, ps, dict_type, lp)
    l, ps = plot_upper_lines(f, l, ps, dict_type, lp)

    f.close()


if __name__ == "__main__":
    main()
