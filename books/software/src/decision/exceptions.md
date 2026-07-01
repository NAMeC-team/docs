## Exceptions
When running the decision pipeline, there are moments where we may want to force certain behaviour from robots. This includes but is not limited to yellow cards. In such cases, a manager may use exceptions to fill in a list of robots whose behaviour must be "locked" and has been already fixed.

The manager needs to provide to the exceptions a list that will be modified, and from which the result of the exceptions may be read from. Such a list may be empty in the beginning. 
Managers are not inherently tied to exceptions, meaning a manager is free to use part, or none of the implemented exceptions.

To implement a new exception, a struct must implement the exception trait.
