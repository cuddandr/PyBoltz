from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import os
import  numpy
ext_modules=[
    Extension("*",["Gases/*.pyx"],include_dirs=[numpy.get_include(),'.']),
    Extension("*", ["Townsend/CollisionFrequencyCalc/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/PulsedTownsend/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/TimeOfFlight/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/SteadyStateTownsend/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/Friedland/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*", ["Townsend/Monte/*.pyx"], include_dirs=[numpy.get_include(), '.']),
    Extension("*",["Monte/*.pyx"],include_dirs=[numpy.get_include(),'.']),
Extension("*",["*.pyx"],include_dirs=[numpy.get_include(),'.',os.path.join(os.path.dirname(os.path.abspath(__file__)), "Townsend/TimeOfFlight")])
]
setup(ext_modules=cythonize(ext_modules))
