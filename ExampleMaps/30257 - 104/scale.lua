TIMING_POINT = State.CurrentTimingPoint
START_TIME = TIMING_POINT.StartTime
BPM = TIMING_POINT.Bpm
MS_PER_BEAT = 60000 / BPM * 20

POP_DURATION = 10000

curTime = START_TIME
curBeat = 0
while curTime + curBeat * MS_PER_BEAT < Map.Length do
    popStartTime = curTime + curBeat * MS_PER_BEAT
    Timeline.Add(Segment(popStartTime, popStartTime + POP_DURATION, Timeline.Keyframes(
            Tween.Scale(Stage.PlayfieldContainer),
            {
                { 0, { 1, 1 } },
                { 1, { -1, -1 } },
                { 2, { 1, 1 } }
            }
    )))
    curBeat = curBeat + 1
end 