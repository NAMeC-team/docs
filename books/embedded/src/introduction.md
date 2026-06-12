# The firmware of NAMeC
This documentation is here to help you have a high-level overview
of the different repositories and custom librairies used throughout
the different firmware.

There are in total 5 different components that require their own firmware, namely :

- the robot firmware
- the base station, that emits commands to all robots
- the dribbler
- each motor card
- the kicker card

Each of those have their own repository inside the NAMeC-Team organization on GitHub. But some librairies have been tailored for usage with our firmware, such as the library handling our radio module. You can find all of the links at a given chapter

## Dev environment
Almost all of our repositories use the mBed RTOS. Briefly, you'll find in an mBed project 

- the source code inside `src/`
- one `.lib` file per library and its associated folder (that appears after running `mbed deploy`)
- a .mbed file describing the project
- a BUILD folder that contains the compiled code

This means you can find out which librairies a project uses by looking at the `.libi` files, which are merely links to Git repositories.

Only the dribbler, which uses STM32CubeIDE, is compiled differently. One day we'll move it to mBed (or something else, idk).

## Protobuf for message transmission
All of the messages that are transmitted, whether via radio or SPI, are Protobuf packets. We use the [nanopb](https://github.com/nanopb/nanopb) library to serialize and deserialize our Protobuf packets.

For those who don't know Protobuf, it's a way of easily transforming structured data into binary. We define the structure of our message in `.proto` files, and the Protobuf compiler's job is to transform those into structures or objects, in the language of our choice (in our case, C++). All Protobuf messages can be found in the [`sensor-data-protocol`](https://github.com/NAMeC-SSL/data-protocol) internal library.

## Flashing
We use a JTag connector to flash the robot, motor, and dribbler firmware. The way you must plug in the cable is (to be described)
