New.Layer("Custom")
Layers.RequireOrder({
    "HitObjects",
    "Custom",
    "PlayfieldBackground"
})

sprite = New.Sprite("pixel art.jpg")
        .Resize({200, 200})
        .WithParent(Stage.PlayfieldContainer)
        .Align("MidCenter")
        .WithLayer("Custom")
sprite.Layer = "Custom"
Timeline.Add(1000, 10000, sprite.XProp.Tween(-500, 500))

Layers.Dump()