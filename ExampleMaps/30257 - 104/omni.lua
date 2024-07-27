-- FOLLOWING CODE FOR PLACING RECEPTORS TO OMNI DIRECTION
PLAYFIELD_SIZE = Stage.PlayfieldContainer.Size
RECEPTOR_SIZE = Stage.Lanes[1].Size
MID_Y = RECEPTOR_SIZE[1] / 2 - PLAYFIELD_SIZE[2] / 2
RADIUS = 50
POS = { { -RADIUS, MID_Y }, { 0, RADIUS + MID_Y }, { 0, MID_Y - RADIUS }, { RADIUS, MID_Y } }
ANGLES = { -0.5 * math.pi, -math.pi, 0, 0.5 * math.pi }

for i = 1, 4 do
    local r = Stage.Lanes[i]
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

print(beat(1, 0))
print(beat(50, 0))

curTime = START_TIME
curMeasure = 0
for m = 1, 50 do
    for i = 1, 4 do
        receptorIndex = RECEPTOR_INDEX[i]
        nextReceptorIndex = CIRC_INDEX[receptorIndex]

        -- Shift the angles so the next angle is always more than the current
        -- If we don't do this, we will see a receptor rotating through 270 degrees instead of 90
        if ANGLES[nextReceptorIndex] < ANGLES[receptorIndex] then
            ANGLES[nextReceptorIndex] = ANGLES[nextReceptorIndex] + 2 * math.pi
        end

        -- Translate position and rotation, respectively
        
        Timeline.Add({m}, {m, 1}, 
                Stage.Lanes[i].PositionProp.Tween(POS[receptorIndex], POS[nextReceptorIndex])
                .WithVibrateCirc(10)
                .Slerp()
        )
        Timeline.Add(beat(m, 0), beat(m + .25), 
                Stage.Lanes[i].RotationProp.Tween(ANGLES[receptorIndex], ANGLES[nextReceptorIndex])
        )
    end
    -- Next cycle
    for i = 1, 4 do
        RECEPTOR_INDEX[i] = CIRC_INDEX[RECEPTOR_INDEX[i]]
    end
    curMeasure = curMeasure + 1
end

Stage.PlayfieldContainer.CastToRenderTarget()
Stage.PlayfieldContainer.DefaultProjectionSprite.SpriteBatchOptions = New.SpriteBatchOptions(New.MultiEffectShader())
shader = Stage.PlayfieldContainer.DefaultProjectionSprite.SpriteBatchOptions.Shader
Timeline.Add({1}, {5}, shader.MosaicBlockSizeProp.Keyframes({{0, {0, 0}}, {1, {100, 100}}, {1.01, {0, 0}}}))
Timeline.Add({6}, {6, 1}, shader.RedOffsetProp.Tween({0, 0}, {10, 10}))
Timeline.Add({6}, {6, 1, 0.5}, shader.BlueOffsetProp.Tween({0, 0}, {-10, -10}))
Timeline.Add({7}, {10}, shader.GreyscaleProp.Keyframes({{0, 0}, {1, 1}, {2, 0}}))
vibStrength = New.PropertyFloat(0)
Timeline.Add({8}, {14}, Stage.PlayfieldContainer.PositionProp.VibrateCirc(vibStrength))
Timeline.Add({8}, {14}, vibStrength.TweenAdd(100))
