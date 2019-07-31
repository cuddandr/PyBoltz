from Magboltz cimport Magboltz
from libc.math cimport acos, sqrt
cimport numpy as np
import  numpy as np
import cython

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cpdef SETUP(Magboltz object):
    object.API = acos(-1.0)
    TWOPI = 2.0 * object.API
    object.ARY = 13.60569253
    PIR2 = 8.7973554297e-17
    ECHARG = 1.602176565e-19
    EMASS = 9.10938291e-31
    AMU = 1.660538921e-27
    BOLTZ = 8.6173324e-5
    BOLTZJ = 1.3806488e-23
    AWB = 1.758820088e10
    ALOSCH = 2.6867805e19
    EOVM = sqrt(2.0 * ECHARG / EMASS) * 100.0
    ABZERO = 273.15
    ATMOS = 760.0
    object.CONST1 = AWB / 2.0 * 1.0e-19
    object.CONST1 *= 1.0e-02
    object.CONST3 = sqrt(0.2 * AWB) * 1.0e-9
    object.CONST4 = object.CONST3 * ALOSCH * 1.0e-15
    object.CONST5 = object.CONST3 / 2.0
    object.CORR = ABZERO * object.TORR / (ATMOS * (ABZERO + object.TEMPC) * 100.0)
    NANISO = 2
    object.NCOLM = 2000000
    object.NCORLN = 500000
    object.NCORST = 2
    FRACM = 0.0
    MXEKR = 0
    for IH in range(object.NGAS):
        if object.NGASN[IH] != 2 and object.NGASN[IH] != 6 and object.NGASN[IH] == 7 and object.NGASN[IH] != 3 and \
                object.NGASN[IH] != 4 and object.NGASN[IH] != 5:
            FRACM += object.FRAC[IH]
    if object.EFIELD > (10 / object.CORR) or FRACM>3:
            object.NCOLM = 400000
            object.NCORLN = 50000
            object.NCORST = 4
    TOTFRAC = 0.0
    if object.NGAS == 0 or object.NGAS > 6:
        raise ValueError("Error in Gas Input")

    for J in range(object.NGAS):
        if object.NGASN[J] == 0 or object.FRAC[J] == 0:
            raise ValueError("Error in Gas Input")
        TOTFRAC += object.FRAC[J]
    if abs(TOTFRAC - 100) >= 1e-6:
        raise ValueError("Error in Gas Input")
    object.TMAX = 100.0
    NSCALE = 40000000
    object.NMAX = object.NMAX * NSCALE

    if object.NMAX < 0:
        raise ValueError("NMAX value is too large - overflow")
    object.NSTEP = 4000
    object.THETA = 0.785
    object.PHI = 0.1

    object.WX = 0.0
    object.WY = 0.0
    object.WZ = 0.0

    object.ESTART = object.EFINAL / 50.0

    for i in range(6):
        object.ANN[i] = object.FRAC[i] * object.CORR * ALOSCH
    object.AN = 100.0 * object.CORR * ALOSCH
    for i in range(6):
        object.VANN[i] = object.FRAC[i] * object.CORR * object.CONST4 * 1e15
    object.VAN = 100.0 * object.CORR * object.CONST4 * 1.0e15

    object.WB = AWB * object.BMAG * 1e-12

    print(len(object.EFL1))
    if object.BMAG == 0:
        return
    object.EOVB = object.EFIELD * 1e-9 / object.BMAG
    return