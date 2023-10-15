--[[

This shouldnt be changed :)
But if you really want to then go ahead!

]]--

local NorthDistrict = 
    PolyZone:Create({
    vector2(-2206.52, 4619.05), -- vector3(-2206.52, 4619.05, 1.02)
    vector2(635.76, 4460.03), -- vector3(635.76, 4460.03, 135.84)
    vector2(3790.86, 4900.09), -- vector3(3790.86, 4900.09, 2.0)
    vector2(2606.41, 7760.27), -- vector3(2606.41, 7760.27, 0.17)
    vector2(-81.59, 7904.2), -- vector3(-81.59, 7904.2, 0.47)
    vector2(-2531.53, 5411.89) -- vector3(-2531.53, 5411.89, 41.34)
  }, {
    name=Config.North.Label,
    minZ=1.0,
    maxZ=862.0,
    debugGrid=false,
    gridDivisions=25,
  })


local SouthDistrict = PolyZone:Create({
    vector2(-3745.76, 684.05), -- vector3(-3745.76, 684.05, 48.43)
    vector2(-2641.48, -4422.5), -- vector3(-2641.48, -4422.5, -0.7)
    vector2(3503.32, -4328.06), -- vector3(3503.32, -4328.06, 0.32)
    vector2(4334.31, 148.73), -- vector3(4334.31, 148.73, 163.31)
  }, {
    name=Config.South.Label,
    minZ=1.0,
    maxZ=862.0,
    debugGrid=false,
    gridDivisions=25
  })


local EastDistrict = PolyZone:Create({
    vector2(3865.73, 4853.73), -- vector3(3865.73, 4853.73, 11.23)
    vector2(643.49, 4429.97), -- vector3(643.49, 4429.97, 141.38)
    vector2(624.91, 544.08), -- vector3(624.91, 544.08, 133.44)
    vector2(4356.99, 254.82), -- vector3(4356.99, 254.82, 0.59)
  }, {
    name=Config.East.Label,
    minZ=1.0,
    maxZ=862.0,
    debugGrid=false,
    gridDivisions=25
  })


local WestDistrict = PolyZone:Create({
    vector2(588.73, 553.99), -- vector3(588.73, 553.99, 144.91)
    vector2(-3754.62, 833.88), -- vector3(-3754.62, 833.88, -0.04)
    vector2(-3367.37, 4647.95), -- vector3(-3367.37, 4647.95, 1379.0)
    vector2(593.28, 4419.06), -- vector3(593.28, 4419.06, 586.21)
  }, {
    name=Config.West.Label,
    minZ=1.0,
    maxZ=862.0,
    debugGrid=false,
    gridDivisions=25
  })

    local combo = ComboZone:Create({NorthDistrict, SouthDistrict, EastDistrict, WestDistrict}, {name="comboDistrictZone", debugPoly=false})
      combo:onPlayerInOut(function(isPointInside, point, zone)
          if Config.Framework == "QBCORE" then
            QBZone(zone, isPointInside)
          else if Config.Framework == "ESX" then
            ESXZone(zone, isPointInside)
          end
        end
      end)

