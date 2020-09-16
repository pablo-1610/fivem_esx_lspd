local isLSPD = false

function createMarkerThread(initialAccess)
    if initialAccess then print("[PZ] Police markers access: true") else print("[PZ] Police markers access: false") end
    isLSPD = initialAccess
    Citizen.CreateThread(function()
        local wait = 2
        local closeRange = false
        while true do
            local playerPos = GetEntityCoords(PlayerPedId())
            for index,marker in pairs(Zones.Markers) do
                local dist = GetDistanceBetweenCoords(playerPos,marker.location, false)
                if marker.isRestricted then
                    if isLSPD then
                        if dist <= Zones.drawDistance then
                            closeRange = true
                            DrawMarker(22, marker.location.x, marker.location.y,marker.location.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.scale, marker.scale, marker.scale, marker.color.r, marker.color.g, marker.color.b, 255, 55555, false, true, 2, false, false, false, false)
                            if dist <= marker.interactionDistance then
                                marker.action()
                            end
                        else
                            if closeRange ~= true then closeRange = false end
                        end
                    end
                else
                    if dist <= Zones.drawDistance then
                        closeRange = true
                        DrawMarker(22, marker.location.x, marker.location.y,marker.location.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, marker.color.r, marker.color.g, marker.color.b, 255, 55555, false, true, 2, false, false, false, false)
                        if dist <= marker.interactionDistance then
                            marker.action()
                        end
                    else
                        if closeRange ~= true then closeRange = false end
                    end
                end
            end
            if closeRange then wait = 1 else wait = 1000 end
            Citizen.Wait(wait)
        end
    end)
end

function updateMarkerAccess(access)
    if access then print("[PZ] Police markers access updated to: true") else print("[PZ] Police markers access updated to: false") end
    isLSPD = access
end