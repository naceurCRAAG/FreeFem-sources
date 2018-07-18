INCLUDE(FREEFEM_FIND_PACKAGE)


FIND_PACKAGE(FLEX REQUIRED)


FIND_PACKAGE(CBLAS)
FIND_PACKAGE(HDF5)

FIND_PACKAGE(ARPACK)


FIND_PACKAGE(UMFPACK)
#FIND_PACKAGE(GLUT)
FIND_PACKAGE(GSL)
FIND_PACKAGE(LAPACK)
FIND_PACKAGE(MPI)
#FIND_PACKAGE(OpenGL)
FIND_PACKAGE(Threads)

IF(WITH_PETSC)
  INCLUDE(FFInstallPackage)
  FF_INSTALL_PACKAGE(PETSC)
ENDIF(WITH_PETSC)


LIST(APPEND MODULE_LIST FFTW
                        #GMM
                        IPOPT
                        METIS
                        MUMPS
                        NLOPT
                        SCOTCH
                        SUITESPARSE
                        SUPERLU
                        TETGEN
)


FOREACH(MODULE ${MODULE_LIST})
  FREEFEM_FIND_PACKAGE(${MODULE})
  IF(NOT FREEFEM_${MODULE}_INSTALLED)
    LIST(APPEND DOWNLOAD_LIST ${MODULE})
  ENDIF(NOT FREEFEM_${MODULE}_INSTALLED)

ENDFOREACH(MODULE)

IF(ENABLE_DOWNLOAD)
  MESSAGE(STATUS "The following modules will be downloaded: ${DOWNLOAD_LIST}")
  INCLUDE(FFInstallPackage)
  FOREACH(MODULE ${DOWNLOAD_LIST})
    FF_INSTALL_PACKAGE(${MODULE}) 
  ENDFOREACH(MODULE)
ELSE()
  IF(${DOWNLOAD_LIST})
    MESSAGE(STATUS "The following modules are missing: ${DOWNLOAD_LIST}")
  ENDIF()
ENDIF(ENABLE_DOWNLOAD)



