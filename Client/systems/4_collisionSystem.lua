-- TrafficConeGod

return function(Sunshine, entity)
    local collider = entity.collider
    local model = entity.model
    if collider and model then
        Sunshine:addConnection(model.model.PrimaryPart.Touched, function(part)
            if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntityById(part.Parent.Name)
                if hitEntity and hitEntity.collider and not hitEntity.collider.anchored then
                    collider.hitEntities[#collider.hitEntities + 1] = hitEntity
                    -- this is so the metatable registers the change
                    collider.hitEntities = collider.hitEntities
                end
            end
        end, entity)
        Sunshine:addConnection(model.model.PrimaryPart.TouchEnded, function(part)
            if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntityById(part.Parent.Name)
                if hitEntity and hitEntity.collider and not hitEntity.collider.anchored then
                    for index, otherEntity in pairs(collider.hitEntities) do
                        if otherEntity == hitEntity then
                            collider.hitEntities[index] = nil
                            -- this is so the metatable registers the change
                            collider.hitEntities = collider.hitEntities
                        end
                    end
                end
            end
        end, entity)
        Sunshine:update(function()
            local parts = model.model.PrimaryPart:GetTouchingParts()
            local foundHitEntities = {}
            for _, part in pairs(parts) do
                if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part
                then
                    local hitEntity = Sunshine:getEntityById(part.Parent.Name)
                    if hitEntity and hitEntity.collider and hitEntity.collider.anchored then
                        collider.hitEntities[#collider.hitEntities + 1] = hitEntity
                        -- this is so the metatable registers the change
                        collider.hitEntities = collider.hitEntities
                        foundHitEntities[#foundHitEntities + 1] = hitEntity
                    end
                end
            end
            for index, hitEntity in pairs(collider.hitEntities) do
                if hitEntity.collider.anchored then
                    local found = false
                    for _, foundHitEntity in pairs(foundHitEntities) do
                        if foundHitEntity == hitEntity then
                            found = true
                        end
                    end
                    if not found then
                        collider.hitEntities[index] = nil
                        -- this is so the metatable registers the change
                        collider.hitEntities = collider.hitEntities
                    end
                end
            end
            if not collider.trigger then
                collider.hitEntities = {}
            end
        end, entity)
    end
end