# Call Pkg.build("LibOpenCV") to run this script

@unix_only run(`make -f Makefile JULIA_HOME=$JULIA_HOME`)
# @windows_only ...
