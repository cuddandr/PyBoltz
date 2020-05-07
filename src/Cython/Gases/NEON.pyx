from libc.math cimport sin, cos, acos, asin, log, sqrt, exp, pow
cimport libc.math
import numpy as np
cimport numpy as np
import sys
from Gas cimport Gas
from cython.parallel import prange
cimport GasUtil
import os

sys.path.append('../hdf5_python')
import cython

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.fast_getattr(True)
cdef void Gas5(Gas* object):
    """
    This function is used to calculate the needed momentum cross sections for Neon gas.
    """
    gd = np.load(os.path.join(os.path.dirname(os.path.realpath(__file__)),"gases.npy"), allow_pickle=True).item()
    cdef double XEN[125], YXSEC[125], XEL[120], YEL[120], XEPS[196], YEPS[196], XION[74], YION[74], YINC[74], YIN1[74]
    cdef double XIN2[49], YIN2[49], XIN3[41], YIN3[41], XKSH[99], YKSH[99], X1S5[111], Y1S5[111], X1S4[137], Y1S4[137], X1S3[117], Y1S3[117]
    cdef double X1S2[119], Y1S2[119], X2P10[73], Y2P10[73], X2P9[70], Y2P9[70], X2P8[72], Y2P8[72], X2P7[65], Y2P7[65], X2P6[59], Y2P6[59]
    cdef double X2P5[63], Y2P5[63], X2P4[66], Y2P4[66], X2P3[62], Y2P3[62], X2P2[62], Y2P2[62], X2P1[59], Y2P1[59], X2S5[19], Y2S5[19]
    cdef double X2S3[19], Y2S3[19], X3D6[12], Y3D6[12], X3D4P[12], Y3D4P[12], X3D4[12], Y3D4[12], X3D3[12], Y3D3[12], X3D1PP[12], Y3D1PP[12]
    cdef double X3D1P[12], Y3D1P[12], X3S1PPPP[12], Y3S1PPPP[12], X3S1PPP[12], Y3S1PPP[12], X3S1PP[12], Y3S1PP[12], X3P106[16]
    cdef double Y3P106[16], X3P52[16], Y3P52[16], X3P1[16], Y3P1[16], Z10T[25], EBRM[25]
    cdef int IOFFN[45], IOFFION[10], i, j, I, J, NL, NBREM
    cdef double CONST, ElectronMass2, API, A0, RY, BBCONST, AM2, C, AUGK
    # BORN BETHE VALUES FOR IONISATION
    CONST = 1.873884e-20
    ElectronMass2 = <float>(1021997.804)
    API = acos(-1)
    A0 = 0.52917720859e-8
    RY = <float>(13.60569193)
    BBCONST = 16.0 * API * A0 * A0 * RY * RY / ElectronMass2
    AM2 = <float>(1.69)
    C = <float>(17.80)
    #AVERAGE AUGER EMISSION FOR EACH SHELL
    AUGK = <float>(1.99)

    object.N_Ionization = 4
    object.N_Attachment = 1
    object.N_Inelastic = 45
    object.N_Null = 0

    NBREM = 25
    XEN = gd['gas5/XEN']
    YXSEC = gd['gas5/YXSEC']
    XEL = gd['gas5/XEL']
    YEL = gd['gas5/YEL']
    XEPS = gd['gas5/XEPS']
    YEPS = gd['gas5/YEPS']
    XION = gd['gas5/XION']
    YION = gd['gas5/YION']
    YINC = gd['gas5/YINC']
    YIN1 = gd['gas5/YIN1']
    XIN2 = gd['gas5/XIN2']
    YIN2 = gd['gas5/YIN2']
    XIN3 = gd['gas5/XIN3']
    YIN3 = gd['gas5/YIN3']
    XKSH = gd['gas5/XKSH']
    YKSH = gd['gas5/YKSH']
    X1S5 = gd['gas5/X1S5']
    Y1S5 = gd['gas5/Y1S5']
    X1S4 = gd['gas5/X1S4']
    Y1S4 = gd['gas5/Y1S4']
    X1S3 = gd['gas5/X1S3']
    Y1S3 = gd['gas5/Y1S3']
    X1S2 = gd['gas5/X1S2']
    Y1S2 = gd['gas5/Y1S2']
    X2P10 = gd['gas5/X2P10']
    Y2P10 = gd['gas5/Y2P10']
    X2P9 = gd['gas5/X2P9']
    Y2P9 = gd['gas5/Y2P9']
    X2P8 = gd['gas5/X2P8']
    Y2P8 = gd['gas5/Y2P8']
    X2P7 = gd['gas5/X2P7']
    Y2P7 = gd['gas5/Y2P7']
    X2P6 = gd['gas5/X2P6']
    Y2P6 = gd['gas5/Y2P6']
    X2P5 = gd['gas5/X2P5']
    Y2P5 = gd['gas5/Y2P5']
    X2P4 = gd['gas5/X2P4']
    Y2P4 = gd['gas5/Y2P4']
    X2P3 = gd['gas5/X2P3']
    Y2P3 = gd['gas5/Y2P3']
    X2P2 = gd['gas5/X2P2']
    Y2P2 = gd['gas5/Y2P2']
    X2P1 = gd['gas5/X2P1']
    Y2P1 = gd['gas5/Y2P1']
    X2S5 = gd['gas5/X2S5']
    Y2S5 = gd['gas5/Y2S5']
    X2S3 = gd['gas5/X2S3']
    Y2S3 = gd['gas5/Y2S3']
    X3D6 = gd['gas5/X3D6']
    Y3D6 = gd['gas5/Y3D6']
    X3D4P = gd['gas5/X3D4P']
    Y3D4P = gd['gas5/Y3D4P']
    X3D4 = gd['gas5/X3D4']
    Y3D4 = gd['gas5/Y3D4']
    X3D3 = gd['gas5/X3D3']
    Y3D3 = gd['gas5/Y3D3']
    X3D1PP = gd['gas5/X3D1PP']
    Y3D1PP = gd['gas5/Y3D1PP']
    X3D1P = gd['gas5/X3D1P']
    Y3D1P = gd['gas5/Y3D1P']
    X3S1PPPP = gd['gas5/X3S1PPPP']
    Y3S1PPPP = gd['gas5/Y3S1PPPP']
    X3S1PPP = gd['gas5/X3S1PPP']
    Y3S1PPP = gd['gas5/Y3S1PPP']
    X3S1PP = gd['gas5/X3S1PP']
    Y3S1PP = gd['gas5/Y3S1PP']
    X3P106 = gd['gas5/X3P106']
    Y3P106 = gd['gas5/Y3P106']
    X3P52 = gd['gas5/X3P52']
    Y3P52 = gd['gas5/Y3P52']
    X3P1 = gd['gas5/X3P1']
    Y3P1 = gd['gas5/Y3P1']
    Z10T = gd['gas5/Z10T']
    EBRM = gd['gas5/EBRM']
    object.EnergyLevels = gd['gas5/EnergyLevels']
    for J in range(6):
        object.AngularModel[J] = object.WhichAngularModel
    for J in range(object.N_Inelastic):
        object.KIN[J] = object.WhichAngularModel
    cdef int NEL, NDATA, NEPSI, N_IonizationD, N_Ionization2, N_Ionization3, NKSH, N1S5, N1S4, N1S3, N1S2, N2P10, N2P9, N2P8, N2P7, N2P6, N2P5, N2P4, N2P3, N2P2
    cdef int N2P1, N2S5, N2S3, N3D6, N3D4P, N3D4, N3D3, N3D1PP, N3D1P, N3S1PPPP, N3S1PPP, N3S1PP, N3P106, N3P52, N3P1

    NEL = 120
    NDATA = 125
    NEPSI = 196
    N_IonizationD = 74
    N_Ionization2 = 49
    N_Ionization3 = 41
    NKSH = 99
    N1S5 = 111
    N1S4 = 137
    N1S3 = 117
    N1S2 = 119
    N2P10 = 73
    N2P9 = 70
    N2P8 = 72
    N2P7 = 65
    N2P6 = 59
    N2P5 = 63
    N2P4 = 66
    N2P3 = 62
    N2P2 = 62
    N2P1 = 59
    N2S5 = 19
    N2S3 = 19
    N3D6 = 12
    N3D4P = 12
    N3D4 = 12
    N3D3 = 12
    N3D1PP = 12
    N3D1P = 12
    N3S1PPPP = 12
    N3S1PPP = 12
    N3S1PP = 12
    N3P106 = 16
    N3P52 = 16
    N3P1 = 16

    cdef double ElectronMass = 9.10938291e-31
    cdef double AMU = 1.660538921e-27, EOBY[5]

    object.E = [0.0, 1.0, <float>(21.56454), 0.0, 0.0, <float>(19.5)]
    object.E[1] = <float>(2.0) * ElectronMass / (<float>(20.1797) * AMU)

    object.EOBY[0:4] = [17.4, 36, 73, 500]
    object.IonizationEnergy[0:4] = [<float>(21.56454), <float>(62.5275), <float>(125.9508), <float>(870.2)]
    object.NC0[0:4] = [0, 1, 2, 2]
    object.EC0[0:4] = [0.0, 5.0, 10.0, <float>(806.6)]
    object.WK[0:4] = [0.0, 0.0, 0.0, 0.015]
    object.EFL[0:4] = [0.0, 0.0, 0.0, 849]
    object.NG1[0:4] = [0, 0, 0, 2]
    object.NG2[0:4] = [0, 0, 0, 1]
    object.EG1[0:4] = [0.0, 0.0, 0.0, 801]
    object.EG2[0:4] = [0.0, 0.0, 0.0, 5.0]

    for j in range(0, object.N_Ionization):
        for i in range(0, 4000):
            if (object.EG[i] > object.IonizationEnergy[j]):
                IOFFION[j] = i
                break
    for NL in range(object.N_Inelastic):
        object.PenningFraction[0][NL] = 0.5
        object.PenningFraction[1][NL] = 1
        object.PenningFraction[2][NL] = 1

    for NL in range(object.N_Inelastic):
        for i in range(4000):
            if object.EG[i] > object.EnergyLevels[NL]:
                IOFFN[NL] = i
                break
    cdef int LMAX
    cdef double APOL, AA, DD, FF, A1, B1, A2, EN, GAMMA1, GAMMA2, BETA, BETA2, AK, AK2, AK3, AK4
    cdef double AK5, AN0, AN1, AN2,  ANHIGH, Sum, SIGEL, ANLOW, SumI, ElasticCrossSectionA, QMOM, PQ[3], QCORR, InelasticCrossSection,
    # PARAMETERS OF PHASE SHIFT ANALYSIS
    APOL = <float>(2.672)
    LMAX = 100
    AA = <float>(0.2135)
    DD = <float>(3.86)
    FF = <float>(-2.656)
    A1 = <float>(1.846)
    B1 = <float>(3.29)
    A2 = <float>(-0.037)
    object.EnergySteps = 4000

    for I in range(object.EnergySteps):
        EN = object.EG[I]
        if EN > object.EnergyLevels[0]:
            GAMMA1 = (ElectronMass2 + 2 * EN) / ElectronMass2
            GAMMA2 = GAMMA1 * GAMMA1
            BETA = sqrt(1.0 - 1.0 / GAMMA2)
            BETA2 = BETA * BETA
        if EN == 0:
            ElasticCrossSectionA = 0.161e-16
            QMOM = 0.161e-16
        elif EN <= 1:
            AK = sqrt(EN / object.RhydbergConst)
            AK2 = AK * AK
            AK3 = AK2 * AK
            AK4 = AK3 * AK
            AK5 = AK4 * AK
            AN0 = -AA * AK * (1.0 + (4.0 * APOL / 3.0) * AK2 * log(AK)) - (API * APOL / 3.0) * AK2 + DD * AK3 + FF * AK4
            AN1 = ((API / 15.0) * APOL * AK2 - A1 * AK3) / (1.0 + B1 * AK2)
            AN2 = API * APOL * AK2 / 105.0 - A2 * AK5
            ANHIGH = AN2
            Sum = (sin(AN0 - AN1)) ** 2
            Sum = Sum + 2.0 * (sin(AN1 - AN2)) ** 2
            SIGEL = (sin(AN0)) ** 2 + 3.0 * (sin(AN1)) ** 2
            for J in range(2, LMAX):
                ANLOW = ANHIGH
                ANHIGH = API * APOL * AK2 / ((2. * J + 5.0) * (2. * J + 3.0) * (2. * J + 1.0))
                SumI = 6.0 / ((2.0 * J + 5.0) * (2.0 * J + 3.0) * (2.0 * J + 1.0) * (2.0 * J - 1.0))
                Sum = Sum + (J + 1.0) * (sin(API * APOL * AK2 * SumI)) ** 2
                SIGEL = SIGEL + (2.0 * J + 1.0) * (sin(ANLOW)) ** 2
            ElasticCrossSectionA = SIGEL * 4.0 * object.PIR2 / AK2
            QMOM = Sum * 4.0 * object.PIR2 / AK2
        else:
            ElasticCrossSectionA = GasUtil.CALIonizationCrossSectionREG(EN, NEL, YEL, XEL)
            QMOM = GasUtil.CALIonizationCrossSectionREG(EN, NDATA, YXSEC, XEN)
        PQ[1] = 0.5 + (ElasticCrossSectionA - QMOM) / ElasticCrossSectionA
        PQ[0] = 0.5
        PQ[2] = GasUtil.CALPQ3(EN, NEPSI, YEPS, XEPS)
        PQ[2] = 1-PQ[2]
        object.PEElasticCrossSection[1][I] = PQ[object.WhichAngularModel]
        object.Q[1][I] = ElasticCrossSectionA
        if object.WhichAngularModel == 0:
            object.Q[1][I] = QMOM

        #IONISATION FOR CHARGE STATE =1
        object.IonizationCrossSection[0][I] = 0.0
        object.PEIonizationCrossSection[0][I] = 0.5
        if object.WhichAngularModel == 2:
            object.PEIonizationCrossSection[0][I] = 0.0
        if EN > object.IonizationEnergy[0]:
            object.IonizationCrossSection[0][I] = GasUtil.CALIonizationCrossSectionX(EN, N_IonizationD, YIN1, XION, BETA2, <float>(0.9594), CONST, object.DEN[I], C, AM2)
        #USE AAnisotropicDetectedTROPIC SCATTERING FOR PRIMARY IONISATION ELECTRON FOR
        #ENERGIES ABOVE 2 * IONISATION ENERGY
        # AAnisotropicDetectedTROPIC ANGULAR DISTRIBUTION SAME AS ELASTIC AT ENERGY OFF SET BY
        # THE IONISATION ENERGY
            if EN > 2 * object.IonizationEnergy[0]:
                object.PEIonizationCrossSection[0][I] = object.PEElasticCrossSection[1][I - IOFFION[0]]

        #IONISATION FOR CHARGE STATE =2
        object.IonizationCrossSection[1][I] = 0.0
        object.PEIonizationCrossSection[1][I] = 0.5
        if object.WhichAngularModel == 2:
            object.PEIonizationCrossSection[1][I] = 0.0
        if EN > object.IonizationEnergy[1]:
            object.IonizationCrossSection[1][I] = GasUtil.CALIonizationCrossSectionX(EN, N_Ionization2, YIN2, XIN2, BETA2, <float>(0.0388), CONST, object.DEN[I], C, AM2)
            if EN > 2 * object.IonizationEnergy[1]:
                object.PEIonizationCrossSection[1][I] = object.PEElasticCrossSection[1][I - IOFFION[1]]

        #IONISATION FOR CHARGE STATE =3
        object.IonizationCrossSection[2][I] = 0.0
        object.PEIonizationCrossSection[2][I] = 0.5
        if object.WhichAngularModel == 2:
            object.PEIonizationCrossSection[2][I] = 0.0
        if EN > object.IonizationEnergy[2]:
            object.IonizationCrossSection[2][I] = GasUtil.CALIonizationCrossSectionX(EN, N_Ionization3, YIN3, XIN3, BETA2, <float>(0.00215), CONST, object.DEN[I], C, AM2)
            if EN > 2 * object.IonizationEnergy[2]:
                object.PEIonizationCrossSection[2][I] = object.PEElasticCrossSection[1][I - IOFFION[2]]

        # K-SHELL IONISATION
        object.IonizationCrossSection[3][I] = 0.0
        object.PEIonizationCrossSection[3][I] = 0.5
        if object.WhichAngularModel == 2:
            object.PEIonizationCrossSection[3][I] = 0.0
        if EN > object.IonizationEnergy[3]:
            object.IonizationCrossSection[3][I] = GasUtil.CALIonizationCrossSectionREG(EN, NKSH, YKSH, XKSH)
            object.PEIonizationCrossSection[3][I] = object.PEElasticCrossSection[1][I - IOFFION[3]]

        # ATTACHMENT
        object.Q[3][I] = 0.0
        object.AttachmentCrossSection[0][I] = 0.0

        #COUNTING IONISATION
        object.Q[4][I] = 0.0
        object.PEElasticCrossSection[4][I] = 0.5
        if object.WhichAngularModel == 2:
            object.PEElasticCrossSection[4][I] = 0.0
            if EN > object.E[2]:
                object.Q[4][I] = GasUtil.CALIonizationCrossSectionX(EN, N_IonizationD, YINC, XION, BETA2, 1, CONST, object.DEN[I], C, AM2)

        # CORRECTION TO CHARGE STATE 1 2 AND 3 X-SECTION FOR K SHELL
        # GIVES TOTAL IONISATION EQUAL TO OSCILLATOR Sum

        if object.Q[4][I] == 0.0:
            QCORR = 1.0
        else:
            QCORR = (object.Q[4][I] - object.IonizationCrossSection[3][I]) / object.Q[4][I]
        object.IonizationCrossSection[0][I] *= QCORR
        object.IonizationCrossSection[1][I] *= QCORR
        object.IonizationCrossSection[2][I] *= QCORR

        object.Q[5][I] = 0.0

        for NL in range(object.N_Inelastic + 1):
            object.InelasticCrossSectionPerGas[NL][I] = 0.0
            object.PEInelasticCrossSectionPerGas[NL][I] = 0.5
            if object.WhichAngularModel == 2:
                object.PEInelasticCrossSectionPerGas[NL][I] = 0.0

        #1S5 METASTABLE LEVEL
        if EN > object.EnergyLevels[0]:
            object.InelasticCrossSectionPerGas[0][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N1S5, Y1S5, X1S5, 3)
            if EN > 2 * object.EnergyLevels[0]:
                object.PEInelasticCrossSectionPerGas[0][I] = object.PEElasticCrossSection[1][I - IOFFN[0]]

        #1S4 RESONANCE LEVEL  F=0.0118
        if EN > object.EnergyLevels[1]:
            object.InelasticCrossSectionPerGas[1][I] = GasUtil.CALInelasticCrossSectionPerGasBEF(EN, EN,N1S4, Y1S4, X1S4, BETA2, GAMMA2, ElectronMass2, object.DEN[I], BBCONST,
                                                 object.EnergyLevels[1], object.E[2], <float>(0.0118))
            object.InelasticCrossSectionPerGas[1][I] = abs(object.InelasticCrossSectionPerGas[1][I])
            if EN > 2 * object.EnergyLevels[1]:
                object.PEInelasticCrossSectionPerGas[1][I] = object.PEElasticCrossSection[1][I - IOFFN[1]]

        #1S3 METASTABLE LEVEL
        if EN > object.EnergyLevels[2]:
            object.InelasticCrossSectionPerGas[2][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N1S3, Y1S3, X1S3, 3)
            if EN > 2 * object.EnergyLevels[2]:
                object.PEInelasticCrossSectionPerGas[2][I] = object.PEElasticCrossSection[1][I - IOFFN[2]]

        #1S2 RESONANCE LEVEL  F=0.159
        if EN > object.EnergyLevels[3]:
            object.InelasticCrossSectionPerGas[3][I] = GasUtil.CALInelasticCrossSectionPerGasBEF(EN, EN,N1S2, Y1S2, X1S2, BETA2, GAMMA2, ElectronMass2, object.DEN[I], BBCONST,
                                                 object.EnergyLevels[3], object.E[2], <float>(0.159))
            object.InelasticCrossSectionPerGas[3][I] = abs(object.InelasticCrossSectionPerGas[3][I])
            if EN > 2 * object.EnergyLevels[3]:
                object.PEInelasticCrossSectionPerGas[3][I] = object.PEElasticCrossSection[1][I - IOFFN[3]]

        #2P10
        if EN > object.EnergyLevels[4]:
            object.InelasticCrossSectionPerGas[4][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P10, Y2P10, X2P10, 2)
            if EN > 2 * object.EnergyLevels[4]:
                object.PEInelasticCrossSectionPerGas[4][I] = object.PEElasticCrossSection[1][I - IOFFN[4]]

        #2P9
        if EN > object.EnergyLevels[5]:
            object.InelasticCrossSectionPerGas[5][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P9, Y2P9, X2P9, 2)
            if EN > 2 * object.EnergyLevels[5]:
                object.PEInelasticCrossSectionPerGas[5][I] = object.PEElasticCrossSection[1][I - IOFFN[5]]

        #2P8
        if EN > object.EnergyLevels[6]:
            object.InelasticCrossSectionPerGas[6][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P8, Y2P8, X2P8, 1)
            if EN > 2 * object.EnergyLevels[6]:
                object.PEInelasticCrossSectionPerGas[6][I] = object.PEElasticCrossSection[1][I - IOFFN[6]]

        #2P7
        if EN > object.EnergyLevels[7]:
            object.InelasticCrossSectionPerGas[7][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P7, Y2P7, X2P7, 2)
            if EN > 2 * object.EnergyLevels[7]:
                object.PEInelasticCrossSectionPerGas[7][I] = object.PEElasticCrossSection[1][I - IOFFN[7]]

        #2P6
        if EN > object.EnergyLevels[8]:
            object.InelasticCrossSectionPerGas[8][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P6, Y2P6, X2P6, 1)
            if EN > 2 * object.EnergyLevels[8]:
                object.PEInelasticCrossSectionPerGas[8][I] = object.PEElasticCrossSection[1][I - IOFFN[8]]

        #2P5
        if EN > object.EnergyLevels[9]:
            object.InelasticCrossSectionPerGas[9][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P5, Y2P5, X2P5, 2)
            if EN > 2 * object.EnergyLevels[9]:
                object.PEInelasticCrossSectionPerGas[9][I] = object.PEElasticCrossSection[1][I - IOFFN[9]]

        #2P4
        if EN > object.EnergyLevels[10]:
            object.InelasticCrossSectionPerGas[10][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P4, Y2P4, X2P4, 1)
            if EN > 2 * object.EnergyLevels[10]:
                object.PEInelasticCrossSectionPerGas[10][I] = object.PEElasticCrossSection[1][I - IOFFN[10]]

        #2P3
        if EN > object.EnergyLevels[11]:
            object.InelasticCrossSectionPerGas[11][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P3, Y2P3, X2P3, 1)
            if EN > 2 * object.EnergyLevels[11]:
                object.PEInelasticCrossSectionPerGas[11][I] = object.PEElasticCrossSection[1][I - IOFFN[11]]

        #2P2
        if EN > object.EnergyLevels[12]:
            object.InelasticCrossSectionPerGas[12][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P2, Y2P2, X2P2, 2)
            if EN > 2 * object.EnergyLevels[12]:
                object.PEInelasticCrossSectionPerGas[12][I] = object.PEElasticCrossSection[1][I - IOFFN[12]]

        #2P1
        if EN > object.EnergyLevels[13]:
            object.InelasticCrossSectionPerGas[13][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2P1, Y2P1, X2P1, 1)
            if EN > 2 * object.EnergyLevels[13]:
                object.PEInelasticCrossSectionPerGas[13][I] = object.PEElasticCrossSection[1][I - IOFFN[13]]

        #2S5
        if EN > object.EnergyLevels[14]:
            object.InelasticCrossSectionPerGas[14][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2S5, Y2S5, X2S5, 2)
            if EN > 2 * object.EnergyLevels[14]:
                object.PEInelasticCrossSectionPerGas[14][I] = object.PEElasticCrossSection[1][I - IOFFN[14]]

        #2S4  BEF SCALING
        if EN > object.EnergyLevels[15]:
            object.InelasticCrossSectionPerGas[15][I] = <float>(0.0128) / (object.EnergyLevels[15] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[15])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[15] + object.E[2])
            object.InelasticCrossSectionPerGas[15][I] = abs(object.InelasticCrossSectionPerGas[15][I])
            if EN > 2 * object.EnergyLevels[15]:
                object.PEInelasticCrossSectionPerGas[15][I] = object.PEElasticCrossSection[1][I - IOFFN[15]]

        #2S3
        if EN > object.EnergyLevels[16]:
            object.InelasticCrossSectionPerGas[16][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N2S3, Y2S3, X2S3, 2)
            if EN > 2 * object.EnergyLevels[16]:
                object.PEInelasticCrossSectionPerGas[16][I] = object.PEElasticCrossSection[1][I - IOFFN[16]]

        #2S2  BEF SCALING
        if EN > object.EnergyLevels[17]:
            object.InelasticCrossSectionPerGas[17][I] = <float>(0.0166) / (object.EnergyLevels[17] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[17])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[17] + object.E[2])
            object.InelasticCrossSectionPerGas[17][I] = abs(object.InelasticCrossSectionPerGas[17][I])
            if EN > 2 * object.EnergyLevels[17]:
                object.PEInelasticCrossSectionPerGas[17][I] = object.PEElasticCrossSection[1][I - IOFFN[17]]

        #3D6
        if EN > object.EnergyLevels[18]:
            object.InelasticCrossSectionPerGas[18][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D6, Y3D6, X3D6, 2)
            if EN > 2 * object.EnergyLevels[18]:
                object.PEInelasticCrossSectionPerGas[18][I] = object.PEElasticCrossSection[1][I - IOFFN[18]]

        #3D5  BEF SCALING
        if EN > object.EnergyLevels[19]:
            object.InelasticCrossSectionPerGas[19][I] = <float>(0.0048) / (object.EnergyLevels[19] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[19])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[19] + object.E[2])
            object.InelasticCrossSectionPerGas[19][I] = abs(object.InelasticCrossSectionPerGas[19][I])
            if EN > 2 * object.EnergyLevels[19]:
                object.PEInelasticCrossSectionPerGas[19][I] = object.PEElasticCrossSection[1][I - IOFFN[19]]

        #3D4!
        if EN > object.EnergyLevels[20]:
            object.InelasticCrossSectionPerGas[20][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D4P, Y3D4P, X3D4P, 2)
            if EN > 2 * object.EnergyLevels[20]:
                object.PEInelasticCrossSectionPerGas[20][I] = object.PEElasticCrossSection[1][I - IOFFN[20]]

        #3D4
        if EN > object.EnergyLevels[21]:
            object.InelasticCrossSectionPerGas[21][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D4, Y3D4, X3D4, 2)
            if EN > 2 * object.EnergyLevels[21]:
                object.PEInelasticCrossSectionPerGas[21][I] = object.PEElasticCrossSection[1][I - IOFFN[21]]

        #3D3
        if EN > object.EnergyLevels[22]:
            object.InelasticCrossSectionPerGas[22][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D3, Y3D3, X3D3, 2)
            if EN > 2 * object.EnergyLevels[22]:
                object.PEInelasticCrossSectionPerGas[22][I] = object.PEElasticCrossSection[1][I - IOFFN[22]]

        #3D2  BEF SCALING
        if EN > object.EnergyLevels[23]:
            object.InelasticCrossSectionPerGas[23][I] = <float>(0.0146) / (object.EnergyLevels[23] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[23])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[23] + object.E[2])
            object.InelasticCrossSectionPerGas[23][I] = abs(object.InelasticCrossSectionPerGas[23][I])
            if EN > 2 * object.EnergyLevels[23]:
                object.PEInelasticCrossSectionPerGas[23][I] = object.PEElasticCrossSection[1][I - IOFFN[23]]

        #3D1!!
        if EN > object.EnergyLevels[24]:
            object.InelasticCrossSectionPerGas[24][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D1PP, Y3D1PP, X3D1PP, 2)
            if EN > 2 * object.EnergyLevels[24]:
                object.PEInelasticCrossSectionPerGas[24][I] = object.PEElasticCrossSection[1][I - IOFFN[24]]

        #3D1!
        if EN > object.EnergyLevels[25]:
            object.InelasticCrossSectionPerGas[25][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3D1P, Y3D1P, X3D1P, 2)
            if EN > 2 * object.EnergyLevels[25]:
                object.PEInelasticCrossSectionPerGas[25][I] = object.PEElasticCrossSection[1][I - IOFFN[25]]

        #3S1!!!!
        if EN > object.EnergyLevels[26]:
            object.InelasticCrossSectionPerGas[26][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3S1PPPP, Y3S1PPPP, X3S1PPPP, 2)
            if EN > 2 * object.EnergyLevels[26]:
                object.PEInelasticCrossSectionPerGas[26][I] = object.PEElasticCrossSection[1][I - IOFFN[26]]

        #3S1!!!
        if EN > object.EnergyLevels[27]:
            object.InelasticCrossSectionPerGas[27][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3S1PPP, Y3S1PPP, X3S1PPP, 2)
            if EN > 2 * object.EnergyLevels[27]:
                object.PEInelasticCrossSectionPerGas[27][I] = object.PEElasticCrossSection[1][I - IOFFN[27]]

        #3S1!!
        if EN > object.EnergyLevels[28]:
            object.InelasticCrossSectionPerGas[28][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3S1PP, Y3S1PP, X3S1PP, 2)
            if EN > 2 * object.EnergyLevels[28]:
                object.PEInelasticCrossSectionPerGas[28][I] = object.PEElasticCrossSection[1][I - IOFFN[28]]

        #3S1!  BEF SCALING
        if EN > object.EnergyLevels[29]:
            object.InelasticCrossSectionPerGas[29][I] = <float>(0.00676) / (object.EnergyLevels[29] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[29])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[29] + object.E[2])
            object.InelasticCrossSectionPerGas[29][I] = abs(object.InelasticCrossSectionPerGas[29][I])
            if EN > 2 * object.EnergyLevels[29]:
                object.PEInelasticCrossSectionPerGas[29][I] = object.PEElasticCrossSection[1][I - IOFFN[29]]

        #Sum 3P10 -- 3P6
        if EN > object.EnergyLevels[30]:
            object.InelasticCrossSectionPerGas[30][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3P106, Y3P106, X3P106, 1.5)
            if EN > 2 * object.EnergyLevels[30]:
                object.PEInelasticCrossSectionPerGas[30][I] = object.PEElasticCrossSection[1][I - IOFFN[30]]

        #Sum 3P5 -- 3P2
        if EN > object.EnergyLevels[31]:
            object.InelasticCrossSectionPerGas[31][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3P52, Y3P52, X3P52, 1.5)
            if EN > 2 * object.EnergyLevels[31]:
                object.PEInelasticCrossSectionPerGas[31][I] = object.PEElasticCrossSection[1][I - IOFFN[31]]

        #3P1
        if EN > object.EnergyLevels[32]:
            object.InelasticCrossSectionPerGas[32][I] = GasUtil.CALInelasticCrossSectionPerGasP(EN, N3P1, Y3P1, X3P1, 1)
            if EN > 2 * object.EnergyLevels[32]:
                object.PEInelasticCrossSectionPerGas[32][I] = object.PEElasticCrossSection[1][I - IOFFN[32]]

        #3S4  BEF SCALING
        if EN > object.EnergyLevels[33]:
            object.InelasticCrossSectionPerGas[33][I] = <float>(0.00635) / (object.EnergyLevels[33] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[33])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[33] + object.E[2])
            object.InelasticCrossSectionPerGas[33][I] = abs(object.InelasticCrossSectionPerGas[33][I])
            if EN > 2 * object.EnergyLevels[33]:
                object.PEInelasticCrossSectionPerGas[33][I] = object.PEElasticCrossSection[1][I - IOFFN[33]]

        #3S2  BEF SCALING
        if EN > object.EnergyLevels[34]:
            object.InelasticCrossSectionPerGas[34][I] = <float>(0.00440) / (object.EnergyLevels[34] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[34])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[34] + object.E[2])
            object.InelasticCrossSectionPerGas[34][I] = abs(object.InelasticCrossSectionPerGas[34][I])
            if EN > 2 * object.EnergyLevels[34]:
                object.PEInelasticCrossSectionPerGas[34][I] = object.PEElasticCrossSection[1][I - IOFFN[34]]

        #4D5  BEF SCALING
        if EN > object.EnergyLevels[35]:
            object.InelasticCrossSectionPerGas[35][I] = <float>(0.00705) / (object.EnergyLevels[35] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[35])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[35] + object.E[2])
            object.InelasticCrossSectionPerGas[35][I] = abs(object.InelasticCrossSectionPerGas[35][I])
            if EN > 2 * object.EnergyLevels[35]:
                object.PEInelasticCrossSectionPerGas[35][I] = object.PEElasticCrossSection[1][I - IOFFN[35]]

        #4D2  BEF SCALING
        if EN > object.EnergyLevels[36]:
            object.InelasticCrossSectionPerGas[36][I] = <float>(0.00235) / (object.EnergyLevels[36] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[36])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[36] + object.E[2])
            object.InelasticCrossSectionPerGas[36][I] = abs(object.InelasticCrossSectionPerGas[36][I])
            if EN > 2 * object.EnergyLevels[36]:
                object.PEInelasticCrossSectionPerGas[36][I] = object.PEElasticCrossSection[1][I - IOFFN[36]]

        #4S1!  BEF SCALING
        if EN > object.EnergyLevels[37]:
            object.InelasticCrossSectionPerGas[37][I] = <float>(0.00435) / (object.EnergyLevels[37] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[37])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[37] + object.E[2])
            object.InelasticCrossSectionPerGas[37][I] = abs(object.InelasticCrossSectionPerGas[37][I])
            if EN > 2 * object.EnergyLevels[37]:
                object.PEInelasticCrossSectionPerGas[37][I] = object.PEElasticCrossSection[1][I - IOFFN[37]]

        #4S4  BEF SCALING
        if EN > object.EnergyLevels[38]:
            object.InelasticCrossSectionPerGas[38][I] = <float>(0.00325) / (object.EnergyLevels[38] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[38])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[38] + object.E[2])
            object.InelasticCrossSectionPerGas[38][I] = abs(object.InelasticCrossSectionPerGas[38][I])
            if EN > 2 * object.EnergyLevels[38]:
                object.PEInelasticCrossSectionPerGas[38][I] = object.PEElasticCrossSection[1][I - IOFFN[38]]

        #5D5 BEF SCALING
        if EN > object.EnergyLevels[39]:
            object.InelasticCrossSectionPerGas[39][I] = <float>(0.00383) / (object.EnergyLevels[39] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[39])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[39] + object.E[2])
            object.InelasticCrossSectionPerGas[39][I] = abs(object.InelasticCrossSectionPerGas[39][I])
            if EN > 2 * object.EnergyLevels[39]:
                object.PEInelasticCrossSectionPerGas[39][I] = object.PEElasticCrossSection[1][I - IOFFN[39]]

        #5D2 BEF SCALING
        if EN > object.EnergyLevels[40]:
            object.InelasticCrossSectionPerGas[40][I] = <float>(0.00127) / (object.EnergyLevels[40] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[40])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[40] + object.E[2])
            object.InelasticCrossSectionPerGas[40][I] = abs(object.InelasticCrossSectionPerGas[40][I])
            if EN > 2 * object.EnergyLevels[40]:
                object.PEInelasticCrossSectionPerGas[40][I] = object.PEElasticCrossSection[1][I - IOFFN[40]]

        #4S2 BEF SCALING
        if EN > object.EnergyLevels[41]:
            object.InelasticCrossSectionPerGas[41][I] = <float>(0.00165) / (object.EnergyLevels[41] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[41])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[41] + object.E[2])
            object.InelasticCrossSectionPerGas[41][I] = abs(object.InelasticCrossSectionPerGas[41][I])
            if EN > 2 * object.EnergyLevels[41]:
                object.PEInelasticCrossSectionPerGas[41][I] = object.PEElasticCrossSection[1][I - IOFFN[41]]

        #5S1! BEF SCALING
        if EN > object.EnergyLevels[42]:
            object.InelasticCrossSectionPerGas[42][I] =<float>(0.00250) / (object.EnergyLevels[42] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[42])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[42] + object.E[2])
            object.InelasticCrossSectionPerGas[42][I] = abs(object.InelasticCrossSectionPerGas[42][I])
            if EN > 2 * object.EnergyLevels[42]:
                object.PEInelasticCrossSectionPerGas[42][I] = object.PEElasticCrossSection[1][I - IOFFN[42]]

        #Sum HIGHER RESONANCE S STATES
        if EN > object.EnergyLevels[43]:
            object.InelasticCrossSectionPerGas[43][I] = <float>(0.00962) / (object.EnergyLevels[43] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[43])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[43] + object.E[2])
            object.InelasticCrossSectionPerGas[43][I] = abs(object.InelasticCrossSectionPerGas[43][I])
            if EN > 2 * object.EnergyLevels[43]:
                object.PEInelasticCrossSectionPerGas[43][I] = object.PEElasticCrossSection[1][I - IOFFN[43]]

        #Sum HIGHER RESONANCE S STATES
        if EN > object.EnergyLevels[44]:
            object.InelasticCrossSectionPerGas[44][I] = <float>(0.01695) / (object.EnergyLevels[44] * BETA2) * (
                    log(BETA2 * GAMMA2 * ElectronMass2 / (4.0 * object.EnergyLevels[44])) - BETA2 - object.DEN[
                I] / 2.0) * BBCONST * EN / (EN + object.EnergyLevels[44] + object.E[2])
            object.InelasticCrossSectionPerGas[44][I] = abs(object.InelasticCrossSectionPerGas[44][I])
            if EN > 2 * object.EnergyLevels[44]:
                object.PEInelasticCrossSectionPerGas[44][I] = object.PEElasticCrossSection[1][I - IOFFN[44]]

        InelasticCrossSection = 0
        for J in range(object.N_Inelastic):
            InelasticCrossSection += object.InelasticCrossSectionPerGas[J][I]

        object.Q[0][I] = ElasticCrossSectionA + object.IonizationCrossSection[0][I] + object.IonizationCrossSection[1][I] + object.IonizationCrossSection[2][I] + object.IonizationCrossSection[3][I] + InelasticCrossSection

    for J in range(object.N_Inelastic):
        if object.FinalEnergy <= object.EnergyLevels[J]:
            object.N_Inelastic = J
            break
    return
