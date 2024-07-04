function printer(args)
    caller = args.Arguments[1]
    print("from " .. caller.Name .. ": " .. SM.RootMachine.GenerateDotGraph())
end
PRINTER_EVENT = EventType.Custom .. 100
Events.Subscribe(PRINTER_EVENT, printer)
machine1 = New.StateMachine("Machine 1", nil, SM.RootMachine)
state1 = New.State("State 1", nil, PRINTER_EVENT, nil, machine1)
state2 = New.State("State 2", nil, PRINTER_EVENT, nil, machine1)
state1.AddTransition(state2, EventType.Custom .. 1)
machine2 = New.StateMachine("Machine 2", nil, SM.RootMachine)
state3 = New.State("State 3", nil, PRINTER_EVENT, nil, machine2)
state4 = New.State("State 4", nil, PRINTER_EVENT, nil, machine2)
state3.AddTransition(state4, EventType.Custom .. 2)
state4.AddTransition(machine1, EventType.Custom .. 3)
state2.AddTransition(machine2, EventType.Custom .. 4)
state1.AddTransition(state3, EventType.Custom .. 5)
state1.AddTransition(state4, EventType.Custom .. 6)
state4.AddTransition(state2, EventType.Custom .. 7)
SM.Start()
Events.Enqueue(EventType.Custom .. 2)
-- Events.Enqueue(EventType.Custom .. 1)
-- This line is expected to error because of invalid transition
-- Events.Enqueue(EventType.Custom .. 4)

