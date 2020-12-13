"""
This script produces the 3D geometry of a standard-fuel assembly.
"""

import numpy as np
import math as mt
import random as rd

def add_lines(f, ftf, lc):
    """
    Adds boundary lines of the geometry.
    Parameters
    ----------
    f: file object
    Returns
    -------
    c = number of lines added.
    l = number of lines added.
    ns = number of surfaces added.
    ls = ??
    """

    side = ftf * np.tan(np.pi/6) # Side length of the hexagonal assembly.

    f.write("//+\n")
    f.write("SetFactory('OpenCASCADE');\n")
    f.write("// Define Points of the assembly boundaries \n")
    f.write("Point(1) = { "+ str(side/2) +", "+ str(ftf/2) +", 0, "+ str(lc) +"};\n")
    f.write("Point(2) = { "+ str(side) +", 0, 0, "+ str(lc) +"};\n")
    f.write("Point(3) = { "+ str(side/2) +", "+ str(-ftf/2) +", 0, "+ str(lc) +"};\n")
    f.write("Point(4) = { "+ str(-side/2) +", "+ str(-ftf/2) +", 0, "+ str(lc) +"};\n")
    f.write("Point(5) = { "+ str(-side) +", 0, 0, "+ str(lc) +"};\n")
    f.write("Point(6) = { "+ str(-side/2) +", "+ str(ftf/2) +", 0, "+ str(lc) +"};\n")
    f.write("// Define Lines in the boundary \n")
    f.write("Line(1) = {1, 2};\n")
    f.write("Line(2) = {2, 3};\n")
    f.write("Line(3) = {3, 4};\n")
    f.write("Line(4) = {4, 5};\n")
    f.write("Line(5) = {5, 6};\n")
    f.write("Line(6) = {6, 1};\n")
    f.write("// Boundary of the assembly \n")
    f.write("Curve Loop(1) = {1, 2, 3, 4, 5, 6};\n")
    f.write("// Defines fuel channel Assembly\n")
    c = 7
    l = 2
    ns = 1
    ls = [1]
    
    return c, l, ns, ls

def place_circles(f, r, d_x, d_y, col, row, c, l, ns, ls, type, dict_type):
    for j in col:
        cc = 0
        for i in row:
            f.write("Circle("+ str(cc + c) +") = { "+ str(i*d_x) +", "+ str(j*d_y) +", 0, "+ str(r) +", 0, 2*Pi};\n")
            f.write("Curve Loop("+ str(l) +") = {"+ str(cc + c) +"};\n")
            f.write("Plane Surface("+ str(ns) +") = {"+ str(l) +"};\n")
            ls.append(l)
            
            if type == 'fuel' or type == 'coolant' or type == 'moderator':
                dict_type[type].append(ns)
            else:
                print('Wrong type')
                sys.exit()
            cc += 1
            l += 1
            ns += 1
        c += cc
    
    return c, l, ns, ls, dict_type

def cooling_channels(f, d_x, rc, p_c, c, l, ns, ls, dict_type):
    s = 2 * p_c/2 * np.tan(np.pi/6)
    p = round(3*s, 4)
    p2 = round(3*s/2, 4)

    col = [-3]
    row = [-1]
    #c, l, ns, ls, dict_type = place_circles(f, rc, p, p_c, col, row, c, l, ns, ls, 'coolant', dict_type)

    col = [-3, 3]
    row = [-1, 0, 1]
    c, l, ns, ls, dict_type = place_circles(f, rc, p, p_c, col, row, c, l, ns, ls, 'coolant', dict_type)

    col = [-3/2, 3/2]
    row = [-3, -1, 1, 3]
    c, l, ns, ls, dict_type = place_circles(f, rc, p2, p_c, col, row, c, l, ns, ls, 'coolant', dict_type)

    col = [0]
    row = [-2, -1, 0, 1, 2]
    c, l, ns, ls, dict_type = place_circles(f, rc, p, p_c, col, row, c, l, ns, ls, 'coolant', dict_type)
    
    return c, l, ns, ls, dict_type

def fuel_channels(f, d_x, rf, p_c, c, l, ns, ls, dict_type):
    s = 2 * p_c/2 * np.tan(np.pi/6)
    p = round(3*s, 4)
    p2 = round(3*s/2, 4)

    col = [-1/2]
    row = [-5]
    #c, l, ns, ls, dict_type = place_circles(f, rf, p2, p_c, col, row, c, l, ns, ls, 'fuel', dict_type)

    col = [-1/2, 1/2]
    row = [-5, -3, -1, 1, 3, 5]
    c, l, ns, ls, dict_type = place_circles(f, rf, p2, p_c, col, row, c, l, ns, ls, 'fuel', dict_type)

    col = [-7/2, -5/2, 5/2, 7/2]
    row = [-3, -1, 1, 3]
    c, l, ns, ls, dict_type = place_circles(f, rf, p2, p_c, col, row, c, l, ns, ls, 'fuel', dict_type)

    col = [-2, -1, 1, 2]
    row = [-2, -1, 0, 1, 2]
    c, l, ns, ls, dict_type = place_circles(f, rf, p, p_c, col, row, c, l, ns, ls, 'fuel', dict_type)

    col = [-4, 4]
    row = [-1, 0, 1]
    c, l, ns, ls, dict_type = place_circles(f, rf, p, p_c, col, row, c, l, ns, ls, 'fuel', dict_type)

    return c, l, ns, ls, dict_type

def define_moderator(f, H, ns, ls, dict_type):
    f.write("Plane Surface("+str(ns)+") = {")
    for i in ls:
        if i == ls[-1]:
            f.write(str(i))
        else:
           f.write(str(i)+", ")
    f.write("};\n")

    f.write("//+\nExtrude {0, 0, "+ str(H) +"} {\n  ")
    f.write("Surface{"+ str(ns) +"}; ")
    for i in range(1, ns):
        f.write(" Surface{"+ str(i) +"};")
    f.write(" Layers{10}; Recombine;\n}\n")

    f.write('//+\nPhysical Surface("moderator_bottom") = {'+ str(ns) +'};\n')  

    f.write('//+\nPhysical Surface("coolant_bottom") = {')
    for i in dict_type['coolant'][:-1]:
        f.write(str(i)+', ')
    f.write(str(dict_type['coolant'][-1])+'};\n')

    f.write('//+\nPhysical Surface("fuel_bottom") = {')
    for i in dict_type['fuel'][:-1]:
        f.write(str(i)+', ')
    f.write(str(dict_type['fuel'][-1])+'};\n')

    f.write('//+\nPhysical Surface("moderator_top") = {'+ str(2*ns+6) +'};\n')

    f.write('//+\nPhysical Surface("coolant_top") = {')
    for i in dict_type['coolant'][:-1]:
        f.write(str(2*ns+6+i)+', ')
    f.write(str(2*ns+6+dict_type['coolant'][-1])+'};\n')

    f.write('//+\nPhysical Surface("fuel_top") = {')
    for i in dict_type['fuel'][:-1]:
        f.write(str(2*ns+6+i)+', ')
    f.write(str(2*ns+6+dict_type['fuel'][-1])+'};\n')

    f.write('//+\nPhysical Volume("moderator") = {1};\n')

    f.write('//+\nPhysical Volume("coolant") = {')
    for i in dict_type['coolant'][:-1]:
        f.write(str(1+i)+', ')
    f.write(str(1+dict_type['coolant'][-1])+'};\n')

    f.write('//+\nPhysical Volume("fuel") = {')
    for i in dict_type['fuel'][:-1]:
        f.write(str(1+i)+', ')
    f.write(str(1+dict_type['fuel'][-1])+'};\n')

    return ns, ls, dict_type

def main():    
    f = open("standard-fuel.geo","w+")
    # Parameter definitions
    ftf = 36  # Flat to flat distance
    rc = 0.5  # Radius of cooling channel
    rf = 1.5  # Radius of cooling channel
    p_c = 5.6 # pitch between channels
    H = 10    # Fuel assembly height
    
    dict_type = {'fuel': [], 'coolant': [], 'moderator': []}

    c, l, ns, ls = add_lines(f, ftf, 1)
    c, l, ns, ls, dict_type = cooling_channels(f, d_x, rc, p_c, c, l, ns, ls, dict_type)
    c, l, ns, ls, dict_type = fuel_channels(f, d_x, rf, p_c, c, l, ns, ls, dict_type)
    ns, ls, dict_type = define_moderator(f, H, ns, ls, dict_type)

    f.close()

if __name__ == "__main__":
    main()