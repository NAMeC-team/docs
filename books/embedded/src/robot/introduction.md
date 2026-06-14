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
