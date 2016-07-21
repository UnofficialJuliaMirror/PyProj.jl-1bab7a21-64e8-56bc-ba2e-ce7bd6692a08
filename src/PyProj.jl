__precompile__()


module PyProj

import PyCall


const pyproj = PyCall.PyNULL()
const Proj = PyCall.PyNULL()
const Geod = PyCall.PyNULL()
const _transform = PyCall.PyNULL()


function __init__()
    copy!(pyproj, PyCall.pyimport_conda("pyproj", "pyproj"))

    copy!(Proj, pyproj[:Proj])
    copy!(Geod, pyproj[:Geod])
    copy!(_transform, pyproj[:transform])
end


function transform(p1, p2, x, y, z, radians=false)
    _transform(p1, p2, x, y, z, radians)
end

end # module
