__precompile__()


module PyProj

import PyCall


const pyproj = PyCall.PyNULL()
const Proj = PyCall.PyNULL()
const Geod = PyCall.PyNULL()
const _transform = PyCall.PyNULL()


function __init__()
    try
        copy!(pyproj, PyCall.pyimport("pyproj"))
    catch e
        if PyCall.conda
            info("Installing pyproj by conda")
            Conda.add("pyproj")
            copy!(pyproj, PyCall.pyimport("pyproj"))
        else
            error("Failed to import pyproj Python package: ", e)
        end
    end

    copy!(Proj, pyproj[:Proj])
    copy!(Geod, pyproj[:Geod])
    copy!(_transform, pyproj[:transform])
end


function transform(p1, p2, x, y, z, radians=false)
    _transform(p1, p2, x, y, z, radians)
end

end # module
