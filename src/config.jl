function loadlib()
    global cv2_lib
    if !isdefined(:cv2_lib)
        const libdir = joinpath(Pkg.dir("LibOpenCV"), "deps")
        @unix_only lib = joinpath(libdir, "usr", "lib", "libcv2.so")
        @windows_only lib = joinpath(libdir, "windows", "libcv2.dll")
        try
            Libdl.dlopen(lib)
        catch
            error("Dependent library not found. Please run `Pkg.build(\"LibOpenCV\")`")
        end
        @eval const cv2_lib = $lib
    end
end

loadlib()
