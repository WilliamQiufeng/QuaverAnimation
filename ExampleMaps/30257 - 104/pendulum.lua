TIMING_POINT = State.CurrentTimingPoint
START_TIME = TIMING_POINT.StartTime
BPM = TIMING_POINT.Bpm
MS_PER_BEAT = 60000 / BPM
MS_PER_MEASURE = MS_PER_BEAT * TIMING_POINT.Signature

ANGLE_CYCLE = {0, math.pi / 6, 0, -math.pi / 6}

ROTATION_DURATION = 300

Stage.PlayfieldContainer.Pivot = {0.5, 0}

curTime = START_TIME
curBeat = 0
while curTime + curBeat * MS_PER_BEAT < Map.Length do
    rotateStartTime = curTime + curBeat * MS_PER_BEAT
    Timeline.Add(rotateStartTime, rotateStartTime + ROTATION_DURATION, Stage.PlayfieldContainer.RotationProp.Tween(
            ANGLE_CYCLE[curBeat % 4 + 1],
            ANGLE_CYCLE[(curBeat + 1) % 4 + 1],
            Easing.OutCirc
    ))
    curBeat = curBeat + 1
end 