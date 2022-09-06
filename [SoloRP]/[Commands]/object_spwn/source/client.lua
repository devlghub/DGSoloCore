local modelHash = `prop_atm_01`

if not HasModelLoaded(modelHash) then
    -- If the model isnt loaded we request the loading of the model and wait that the model is loaded
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Citizen.Wait(1)
    end
end

-- At this moment the model its loaded, so now we can create the object
local obj = CreateObject(modelHash, vector3(-287.4936, -982.3775, 31.08063), true)

PlaceObjectOnGroundProperly(obj)
SetModelAsNoLongerNeeded(model)
SetEntityAsMissionEntity(obj)