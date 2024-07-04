-- FOLLOWING CODE FOR PLACING RECEPTORS TO OMNI DIRECTION

PLAYFIELD_SIZE = Stage.PlayfieldContainer.Size
RECEPTOR_SIZE = Stage.LaneContainer(1).Size
MID_Y = RECEPTOR_SIZE[1] / 2 - PLAYFIELD_SIZE[2] / 2
RADIUS = 50
POS = { { -RADIUS, MID_Y }, { 0, RADIUS + MID_Y }, { 0, MID_Y - RADIUS }, { RADIUS, MID_Y } }
ANGLES = { -0.5 * math.pi, -math.pi, 0, 0.5 * math.pi }

for i = 1, 4 do
    local r = Stage.LaneContainer(i)
    r.Align(Alignment.MidCenter)
    -- Rotate the lane about the mid-bottom point
    r.Pivot = { 0.5, 1 }
    r.MoveTo(POS[i])
    r.Rotation = ANGLES[i]
    -- IndependentRotation makes it so the rotation of the sprite will not be dependent on its parent
    r.Receptor.IndependentRotation = true
end

-- Since we are using arrow skin, the note head must not rotate with the lane, as it would bring confusion otherwise.
function onNoteEntry(args)
    h = args.HitObject
    h.Sprite.IndependentRotation = true
end

Events.Subscribe(EventType.NoteEntry, onNoteEntry)

-- FOLLOWING CODE FOR ROTATION OF RECEPTORS EVERY MEASURE
-- IF YOU WANT OMNI DIRECTION ONLY, YOU CAN COMMENT THIS SECTION OUT

-- CIRC_INDEX maps a receptor index to another such that the output receptor is 90 degrees clockwise to the input
CIRC_INDEX = { 3, 1, 4, 2 }
RECEPTOR_INDEX = { 1, 2, 3, 4 }

TIMING_POINT = State.CurrentTimingPoint
START_TIME = TIMING_POINT.StartTime
BPM = TIMING_POINT.Bpm
MS_PER_BEAT = 60000 / BPM
MS_PER_MEASURE = MS_PER_BEAT * TIMING_POINT.Signature

TRANSITION_DURATION = 500

curTime = START_TIME
curMeasure = 0
while curTime + curMeasure * MS_PER_MEASURE < Map.Length do
    rotateStartTime = curTime + curMeasure * MS_PER_MEASURE
    for i = 1, 4 do
        receptorIndex = RECEPTOR_INDEX[i]
        nextReceptorIndex = CIRC_INDEX[receptorIndex]

        -- Shift the angles so the next angle is always more than the current
        -- If we don't do this, we will see a receptor rotating through 270 degrees instead of 90
        if ANGLES[nextReceptorIndex] < ANGLES[receptorIndex] then
            ANGLES[nextReceptorIndex] = ANGLES[nextReceptorIndex] + 2 * math.pi
        end

        -- Translate position and rotation, respectively
        
        
        
        Timeline.Add(rotateStartTime, rotateStartTime + TRANSITION_DURATION, 
                Stage.LaneContainer(i).PositionProp.Tween(POS[receptorIndex], POS[nextReceptorIndex])
        )
        Timeline.Add(rotateStartTime, rotateStartTime + TRANSITION_DURATION, 
                Stage.LaneContainer(i).RotationProp.Tween(ANGLES[receptorIndex], ANGLES[nextReceptorIndex])
        )
    end
    -- Next cycle
    for i = 1, 4 do
        RECEPTOR_INDEX[i] = CIRC_INDEX[RECEPTOR_INDEX[i]]
    end
    curMeasure = curMeasure + 1
end

-- Stage.PlayfieldContainer.CastToRenderTarget()
-- Stage.PlayfieldContainer.DefaultProjectionSprite.SpriteBatchOptions = New.SpriteBatchOptions(New.MultiEffectShader())
-- Stage.PlayfieldContainer.DefaultProjectionSprite.SpriteBatchOptions.Shader.SetParameter("p_greyscale_strength", 0.5)