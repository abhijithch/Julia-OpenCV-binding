module LibOpenCV

import Base: >>

module cv2

include("consts.jl")
include("config.jl")
include("Mat.jl")
include("highgui.jl")
include("imgproc.jl")
include("videoio.jl")
include("tracking.jl")

end # cv2

export cv2

>>(x, y) = cv2.(>>)(x, y)

end # LibOpenCV
