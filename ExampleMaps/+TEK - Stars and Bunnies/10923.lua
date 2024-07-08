SCALE_TIME = 500
ids = {}
function setSegments(sprite, lane, offset)
    Timeline.Add(State.SongTime, State.SongTime + SCALE_TIME * 2, sprite.ScaleProp.Keyframes({
        { 0, { 1, 1 } },
        { 1, { 2, 2 } },
        { 2, { 1, 1 } },
    }))
    Timeline.Add(State.SongTime, State.SongTime + SCALE_TIME * 2, sprite.TintProp.TweenRainbow())
end
function onNoteEntry(args)
    local hitObject = args.hitObject
    --print("Note entered at " .. hitObject.StartTime)
    --sprite.rotation = math.random(0, 360)
    setSegments(hitObject.Sprite, hitObject.Lane, 0)
    --setSegments(hitObject.LongNoteBodySprite, hitObject.Lane, 1)
    --setSegments(hitObject.LongNoteEndSprite, hitObject.Lane, 2)
end

Events.Subscribe(EventType.NoteEntry, onNoteEntry)

local text = New.Text("Text that expANDS", 50)
                .WithParent(Stage.PlayfieldContainer)
                .WithLayer("Foreground")
                .Align("MidCenter")

local customFontText = New.Text("CascadiaCode.ttf", "I have custom font", 30)
                          .WithParent(Stage.PlayfieldContainer)
                          .Align("MidCenter")
customFontText.Y = text.Y + 50

-- Test property
local prop = New.Property(function()
    return abc
end, function(v)
    abc = v * 2
end)
prop.Value = 5
print("Before: " .. prop.Value)
prop.Value = 10
print("After: " .. prop.Value)

Timeline.Add(10000, function(v)
    Timeline.Add(v.Time, v.Time + 1000, text.FontSizeProp.TweenAdd(text.FontSize))
    Timeline.Add(v.Time, text.TextProp.TriggerSet("Hello"))
    a = New.AnimatableSprite(Skin.Judgements[Judgement.Marv])
           .WithParent(Stage.PlayfieldContainer)
           .WithLayer("Foreground")
           .Align("MidCenter")
           .Resize({ 200, 200 })
    a.ChangeTo(0)
    a.StartLoop(Direction.Forward, 60)
end)
