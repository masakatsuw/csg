set(CSG_DEFAULTS csg_defaults.xml)

file(GLOB_RECURSE VOTCA_XML *.xml)
file(GLOB_RECURSE NOT_VOTCA_XML ${CSG_DEFAULTS})
if(NOT_VOTCA_XML)
  list(REMOVE_ITEM VOTCA_XML ${NOT_VOTCA_XML})
endif()
install(FILES ${VOTCA_XML} DESTINATION ${CMAKE_INSTALL_DATADIR}/votca/xml)

find_program(GMX_EXECUTABLE gmx_d gmx)
find_package_handle_standard_args(GMX REQUIRED_VARS GMX_EXECUTABLE)
if(NOT GMX_FOUND)
  set(GMX_EXECUTABLE "gmx")
endif()
set(MDRUN "${GMX_EXECUTABLE} mdrun")
set(G_ENERGY "${GMX_EXECUTABLE} energy")
set(GROMPP "${GMX_EXECUTABLE} grompp")
set(G_TRJCAT "${GMX_EXECUTABLE} trjcat")

configure_file(${CSG_DEFAULTS}.in ${CMAKE_CURRENT_BINARY_DIR}/${CSG_DEFAULTS} @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${CSG_DEFAULTS} DESTINATION ${CMAKE_INSTALL_DATADIR}/votca/xml)
