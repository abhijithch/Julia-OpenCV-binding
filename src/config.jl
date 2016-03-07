function loadlib()
    global cv2_lib
    if !isdefined(:cv2_lib)
        const libdir = joinpath(Pkg.dir("LibOpenCV"), "deps", "usr", "lib")
        @unix_only lib = joinpath(libdir, "libcv2.so")
        @windows_only lib = joinpath(libdir, "libcv2.so")
        try
            Libdl.dlopen(lib)
        catch
            error("Dependent library not found. Please run `Pkg.build(\"LibOpenCV\")`")
        end
        @eval const cv2_lib = $lib
    end
end

loadlib()
