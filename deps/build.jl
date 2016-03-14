# Call Pkg.build("LibOpenCV") to run this script

@linux_only run(`make -f Linux.Makefile`)
@osx_only run(`make -f OSX.Makefile`)
@windows_only begin
    ENV["PATH"] *=  ";" * joinpath(Pkg.dir("LibOpenCV"), "deps", "windows")
    run(`mingw32-make -f Win64.Makefile`)
end
