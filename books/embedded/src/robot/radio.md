# Receiving commands over radio
Robot ID is hardcoded inside the robot. The nRF24L01+ radio module we use can have a physical address that can be assigned at startup. Our code does not make use of this feature (yet). Instead, we broadcast the radio command to all robots (they all have the same physical address), making it go through the radio module, that forwards it to our code.

Inside our code, we deserialize the Protobuf packet, and check if this packet is meant for us (there is a robot id field in the packet). If this packet wasn't meant for us, we ignore it.

Time consumptino of this operation was not benchmarked, but it is pretty clear that it is very inefficient (why would robot 5 have to process 6 packets where it could've only processed 1 instead ?).
