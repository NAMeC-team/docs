# Robot firmware
## Dependencies

## Characteristics
- Single core CPU - STM32L4A6RG
- Multitasking & multithreading provided by mbed-os
- Interrupt-based radio handling
- Sends orders to all other components

## Main loop
The robot firmware uses a mBed [EventQueue](https://os.mbed.com/docs/mbed-os/v6.16/apis/eventqueue.html) across the code to perform tasks.
At startup, the robot just initializes necessary objects and runs the EventQueue loop indefinitely.

Two types of events are processed by the EventQueue's `dispatch_forever()` loop : radio packet reception
and periodic motor communication

## Crashes in mBed
Memroy safety is present *to some degree* inside mbed-os, such as dereferencing a null pointer, or accessing invalid memory.
When a crash occurs, information about the crash can be retrieved, thanks to the `swo` library.
Do not turn off the robot, plug a JTag connector the same way you would flash the robot, and run `JLinkSWOViewer` in any terminal.
After syncing with the CPU clock, you'll see what caused the crash inside the terminal.

> ![NOTE]
> Sometimes, you won't be able to sync with the CPU clock inside `JLinkSWOViewer`.
> No one in the team has found the answer for that, the only tip we have is to print a lot of stuff
> to be able to sync correctly.
