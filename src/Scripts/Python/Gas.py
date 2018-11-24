class Gas:
    def __init__(self):
        # First Setup
        self.NGS =0
        self.Q = [[0 for x in range(4000)] for y in range(6)]
        self.QIN = [[0 for x in range(4000)] for y in range(250)]
        self.NIN =0
        self.E = [0 for g in range(6)]
        self.EI = [0 for g in range(250)]
        self.KIN = [0 for g in range(250)]
        self.QION = [[0 for x in range(4000)] for y in range(30)]
        self.PEQION = [[0 for x in range(4000)] for y in range(30)]
        self.EION = [0 for x in range(30)]
        self.EB = [0 for x in range(30)]
        self.PEQEL = [[0 for x in range(4000)] for y in range(6)]
        self.PEQIN = [[0 for x in range(4000)] for y in range(250)]
        self.KEL = [0 for x in range(6)]
        self.PENFRA = [[0 for x in range(250)] for y in range(30)]
        self.NC0 = [0 for x in range(30)]
        self.EC0 = [0 for x in range(30)]
        self.WK = [0 for x in range(30)]
        self.EFL = [0 for x in range(30)]
        self.NG1 = [0 for x in range(30)]
        self.EG1 = [0 for x in range(30)]
        self.NG2 = [0 for x in range(30)]
        self.EG2 = [0 for x in range(30)]
        self.QATT = [[0 for x in range(4000)] for y in range(8)]
        self.QNULL = [[0 for x in range(4000)] for y in range(10)]
        self.SCLN = [0 for x in range(10)]
        self.EG = [0 for x in range(4000)]
        self.EROOT = [0 for x in range(4000)]
        self.QT1 = [0 for x in range(4000)]
        self.QT2 = [0 for x in range(4000)]
        self.QT3 = [0 for x in range(4000)]
        self.QT4 = [0 for x in range(4000)]
        self.DEN = [0 for x in range(4000)]
        self.DENS = 0
        self.NGAS = 0
        self.NSTEP = 0
        self.NANISO = 0
        self.EFINAL = 0
        self.AKT = 0
        self.ESTEP = 0
        self.ARY = 0
        self.TEMPC = 0
        self.TORR = 0
        self.IPEN = 0
