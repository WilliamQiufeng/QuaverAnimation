TIMING_POINT = State.CurrentTimingPoint
START_TIME = TIMING_POINT.StartTime
BPM = TIMING_POINT.Bpm
MS_PER_BEAT = 60000 / BPM * 20

POP_DURATION = MS_PER_BEAT

curTime = START_TIME
curBeat = 0
while curTime + curBeat * MS_PER_BEAT < Map.Length do
    popStartTime = curTime + curBeat * MS_PER_BEAT
    Timeline.Add(popStartTime, popStartTime + POP_DURATION, Stage.PlayfieldContainer.ScaleProp.Keyframes(
            {
                { 0, { 1, 1 } },
                { 1, { -1, -1 } },
                { 2, { 1, 1 } }
            }
    ))
    curBeat = curBeat + 1
end 