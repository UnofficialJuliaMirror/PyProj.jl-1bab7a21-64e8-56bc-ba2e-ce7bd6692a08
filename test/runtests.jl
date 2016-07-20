using PyProj
using Base.Test


let
    p1 = PyProj.Proj("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
    p2 = PyProj.Proj("+proj=geocent +datum=WGS84 +no_defs")

    let
        lon, lat, height = 0, 0, 0
        x, y, z = PyProj.transform(p1, p2, lon, lat, height)
        @test isapprox(x, 6.378137e6)
        @test isapprox(y, 0)
        @test isapprox(z, 0)
    end

    let
        lon, lat, height = pi/2, 0, 0
        x, y, z = PyProj.transform(p1, p2, lon, lat, height, true)
        @test isapprox(x, 0, atol=1e-3)
        @test isapprox(y, 6.378137e6)
        @test isapprox(z, 0)
    end

    let
        lon, lat, height = 0, -90, -1000000
        x, y, z = PyProj.transform(p1, p2, lon, lat, height)
        @test isapprox(x, 0, atol=1e-3)
        @test isapprox(y, 0, atol=1e-3)
        @test isapprox(z, -5.356752314245179e6)
    end

    let
        lon, lat, height = 10, 20, 30000
        x, y, z = PyProj.transform(p1, p2, lon, lat, height)
        lon_, lat_, height_ = PyProj.transform(p2, p1, x, y, z)
        @test isapprox(lon_, lon)
        @test isapprox(lat_, lat)
        @test isapprox(height_, height)
    end
end
