# Motor communication
## Periodic transmission
We start a periodic communication with each motor card on the SPI bus. Access to the SPI bus is mutex-protected and is automatically handled by the EventQueue. The mutex is important because physically, all motors are connected to the same SPI bus.

The messages passed are `MainBoardToBrushless` and `BrushlessToMainboard`, stored in `brushless.proto` inside the `sensor-data-protocol` repository.

Motors return an error count, which represents the number of times the motor card decoded the message sent from the mainboard and computed a CRC that did not match the passed CRC.

## SPI Watchdog
A watchdog is in place inside the motor code, such that if the motor does not receive any SPI message after a fixed amount of time, the motor reboots entirely. This stems from the fact that F1 chips on the motor cards had a bug that blocked the SPI bus (or at least that was what I was told), so this measure has been put in place.

## Orders sent
The motors are speed-controlled and obey to the commands they're told to perform by the robot card.
Once we receive a speed order from the decision software, through the base station, we transform this robot-frame speed order into 4 separate target speeds to transmit to each motor. This is performed in the `compute_motor_speed()` function.
The mathematics are based on formulas that were tailored for our robot, which is uneven because two wheels are at a 30 degree angle, and the other two wheels at a 45 degree angle. You can search up one of the TDPs of NAMeC that should explain these formulas more in detail.

On their side, the code of the motors have their own PID to ensure the ordered target speed is respected. Tuning of the PID coefficients has been performed some years ago, but never tuned again.
