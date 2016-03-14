module LibOpenCV

import Base: >>, size

module cv2

include("consts.jl")
include("config.jl")
include("Mat.jl")
include("highgui.jl")
include("imgproc.jl")
include("videoio.jl")
include("tracking.jl")
include("core.jl")
include("objdetect.jl")

end # cv2

export cv2

>>(x, y) = cv2.(>>)(x, y)
size(m) = cv2.size(m)

end # LibOpenCV
