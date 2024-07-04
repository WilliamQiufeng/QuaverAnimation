-- Cache receptor positions
LanePositions = Stage.GetLanePositions()
-- A boolean array where LaneSwapOccupied[i] indicates whether the ith receptor is already in animation
-- This is needed if we want to make animations less 'messy' 
LaneSwapOccupied = {}
for i = 1, 7 do
    table.insert(LaneSwapOccupied, false) -- Pre-initialize with false
end
-- The number of occupied lanes
FreeLaneCount = 7
-- The duration of a lane swap animation
ANIMATION_DURATION = 500

-- Event listener for Events.InputKeyPress event
function onPress(args)
    -- Retrieve information passed from args
    local info = args.hitObject
    local pressTime = args.time
    local judgement = args.judgement
    local lane = info.lane
    -- The lane is already in a swap animation, or there is less than 2 lanes for us to swap
    if LaneSwapOccupied[lane] or FreeLaneCount < 2 then
        return -- skip everything below
    end
    -- Mark the lane as occupied
    LaneSwapOccupied[lane] = true;
    -- Generate a random lane to swap with
    local anotherLane = lane
    while LaneSwapOccupied[anotherLane] do
        anotherLane = math.random(1, Map.KeyCount)
    end
    -- Mark this other lane occupied as well
    LaneSwapOccupied[anotherLane] = true;
    FreeLaneCount = FreeLaneCount - 2

    -- Set tween segments to smoothly swap the X values of the two lanes
    -- local easingWrapper = Easing.InQuint
    local easingWrapper = function(p)
        return p * p * p * p
    end
    Timeline.Add(pressTime, pressTime + ANIMATION_DURATION,
            Stage.LaneContainer(lane).XProp.TweenSwap(Stage.LaneContainer(anotherLane).XProp, easingWrapper))

    -- We want to mark the lanes 'unoccupied' after the animation finishes
    Timeline.Add(pressTime + ANIMATION_DURATION,
            function(_)
                LaneSwapOccupied[lane] = false
                LaneSwapOccupied[anotherLane] = false
                FreeLaneCount = FreeLaneCount + 2
            end)

    -- Swap the positions in cache
    tmp = LanePositions[lane]
    LanePositions[lane] = LanePositions[anotherLane]
    LanePositions[anotherLane] = tmp
end

-- onPress will be called when a key is pressed
Events.Subscribe(EventType.InputKeyPress, onPress)