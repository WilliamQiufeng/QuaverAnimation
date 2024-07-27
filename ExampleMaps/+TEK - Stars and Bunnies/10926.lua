pos = Stage.GetLanePositions()[1]
Timeline.Add(10000, 11500,
        Stage.Lanes[1].PositionProp.Keyframes(
                {
                    { 0, { pos[1], pos[2] } },
                    { 500, { pos[1] + 100, pos[2] - 100 } },
                    { 1000, { pos[1], pos[2] - 100 } },
                    { 1500, { pos[1] - 100, pos[2] - 50 }, "InCirc" },
                    { 2000, { pos[1], pos[2] }, "OutCirc" }
                }
        )
)

r2x = Stage.GetLanePositions()[2][1]
Timeline.Add(10000, 11500,
        Stage.Lanes[2].XProp.Keyframes(
                {
                    { 0, r2x },
                    { 500, r2x + 100 },
                    { 1000, r2x },
                    { 1500, r2x - 100, "InCirc" },
                    { 2000, r2x, "OutCirc" }
                }
        )
)
