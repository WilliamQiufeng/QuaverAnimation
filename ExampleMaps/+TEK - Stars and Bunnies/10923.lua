SCALE_TIME = 500
ids = {}
function setSegments(sprite, lane, offset)
    Timeline.Add(
            Segment(State.SongTime, State.SongTime + SCALE_TIME,
                    Timeline.Tween(Tween.Width(sprite)), sprite.Width, sprite.Width * 4, 
                    true)
    )
    Timeline.Add(
            Segment(State.SongTime, State.SongTime + SCALE_TIME,
                    Timeline.Tween(Tween.Height(sprite)), sprite.Height, sprite.Height * 4, 
                    true)
    )
    Timeline.Add(
            Segment(State.SongTime + SCALE_TIME, State.SongTime + SCALE_TIME * 2,
                    Timeline.Tween(Tween.Width(sprite)), sprite.Width * 4, sprite.Width, 
                    true)
    )
    Timeline.Add(
            Segment(State.SongTime + SCALE_TIME, State.SongTime + SCALE_TIME * 2,
                    Timeline.Tween(Tween.Height(sprite)), sprite.Height * 4, sprite.Height, 
                    true)
    )
end
function onNoteEntry(args)
    local hitObject = args.hitObject
    --print("Note entered at " .. hitObject.StartTime)
    --sprite.rotation = math.random(0, 360)
    setSegments(hitObject.Sprite, hitObject.Lane, 0)
    setSegments(hitObject.LongNoteBodySprite, hitObject.Lane, 1)
    setSegments(hitObject.LongNoteEndSprite, hitObject.Lane, 2)
end

Events.Subscribe(EventType.NoteEntry, onNoteEntry)

local text = Stage.CreateText("Text that expANDS", 50)
                  .WithParent(Stage.PlayfieldContainer)
                  .Align(Alignment.MidCenter)

local customFontText = Stage.CreateText("CascadiaCode.ttf", "I have custom font", 30)
                            .WithParent(Stage.PlayfieldContainer)
                            .Align(Alignment.MidCenter)
customFontText.Y = text.Y + 50

Timeline.Add(
        Trigger(10000, function(v)
            Timeline.Add(Segment(v.Time, v.Time + 1000,
                    Timeline.Tween(Tween.FontSize(text), text.FontSize, text.FontSize * 2)))
            --Timeline.SetTweenSegment(-1, State.songTime, State.songTime + 1000, text.width, text.width * 2, Tweens.width(text))
            a = Stage.CreateAnimatableSprite(Skin.Judgements[Judgement.Marv]).WithParent(Stage.PlayfieldContainer).Align(Alignment.MidCenter).Resize({ 200, 200 })
            a.ChangeTo(0)
            a.StartLoop(Direction.Forward, 60)
        end))
