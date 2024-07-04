pos = Stage.GetLanePositions()[1]
Timeline.Add(10000, 11500,
        Stage.LaneContainer(1).PositionProp.Keyframes(
                {
                    { 0, { pos[1], pos[2] } },
                    { 500, { pos[1] + 100, pos[2] - 100 } },
                    { 1000, { pos[1], pos[2] - 100 } },
                    { 1500, { pos[1] - 100, pos[2] - 50 }, Easing.InCirc },
                    { 2000, { pos[1], pos[2] }, Easing.OutCirc }
                }
        )
)

r2x = Stage.GetLanePositions()[2][1]
Timeline.Add(10000, 11500,
        Stage.LaneContainer(2).XProp.Keyframes(
                {
                    { 0, r2x },
                    { 500, r2x + 100 },
                    { 1000, r2x },
                    { 1500, r2x - 100, Easing.InCirc },
                    { 2000, r2x, Easing.OutCirc }
                }
        )
)
