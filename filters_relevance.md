# Correction Filter

The following document tends to answer these questions:
- Is any correction filter relevant for these robots?
- If it is, how could it?
    - What are the different methods for correcting a signal?
    - Which data could it process?
    - How could it be embeded in the code?

## Relevance

Signal theory is really large, and covers 3 great domains:
1. **Smooting** | Re-estimate a value of the past thanks to further data from the future.
2. **Filtering** | Cleaning data of the present.
3. **Predincting** | Using data from the past to predict the next value.

Cf. My signal theory classes. I don't have any other justification but my knowledge I'm sorry onegaishimasu gomennasai sumimasen shitsureishimasu hontoni gomen Wanchaï sama 🙏.

### Generalities

For NaMEC, we will certainly only use **filtering** and **predicting**.

For filtering, a simple filter can usually help. It can be pretty **simple** and still delete some noise for the system to get better. This is my knowledge of the domain who talks, please believe me blindly.

**Example** of simple but useful filters: [lowpass filters](https://github.com/jimmyberg/LowPassFilter/blob/1.x.x/LowPassFilter.cpp). Used in many domains, such as imagery to reduce Gaussian noise, sound to attenuate high frequencies, or any type of signal.

It can also be more complex. For instance, some **Kalman filters** can be used for sensor fusion, or for the **predicting** step. They can predict the next value according to given points of a signal. It's like Yoda. Can Yoda [read the future](https://www.reddit.com/r/MawInstallation/comments/ml1o3k/on_yodas_lesson_on_seeing_the_future/)? Anyway.

### Tests

To be sure it will help NaMEC team, some tests can be done on robots.

1. **Implement a simple filtering process** | By simple I hear low-pass, to see if suppressing basic noise on IR data will enhance guidance. I did code one in Python once, though I know nothing about C++ so if I had to do it, I might use a lib. Please forgive me Wanchaï. At least it won't be AI.
2. **Try a Kalman filter** | You can try [SimpleKalmanFilter](https://github.com/denyssene/SimpleKalmanFilter/blob/master/examples/BasicKalmanFilterExample/BasicKalmanFilterExample.ino) library and use it on the IR signal, to try **prediction**. Make a test with the robots by using the `updateEstimate()` method, and compare it with the recieved signal. If there is a difference, then a Kalman filter is a great idea to start filtering.
3. **Start correcting the position** | As my eyes travel through [the code](src/main.cpp), I see no instance of a potential command law. How is it possible? Do you really trust your robots? Or I missed something and the radio command does have an invisible command law?

### On command law
The principle of a command law is very simple:
1. Compute the position $p_m$ according to odometry
2. Get sensors values 
3. Clean sensor signal (via a **filter**)
4. Translate sensor signal values into an estimation of position $p_s$
5. Compute the error on $x$ and $y$: $e=|p_s-p_m|$
6. Translate the error into a position vector to rattraper the lack
7. Translate the position vector into rotational speed for each wheel thanks to a mixer

Then, the robot is supposed to correct its position to reach its objective.

**Note :** Tests cannot be done if there is no basic command law implemented. Maybe this should be the start. Just a suggestion.

## Means

### Filtering
- **Windowing** | Some signals can be cleaned by a simple algorithm which allows only a certain range of values. For instance, it could be used with IR signals. This would avoid counting a robot as the wall.
    - Barlett
    - Hamming 
    - Blackman
    - Yule-Walker (que des maths pour estimer le PSD (Power Spectral Density))
- **Lowpass, bypass, highpass** | Classing filters to decide if we want to keep certain types of frequency. Generally we want to avoid noise, so we will use a lowpass filter. Then data will be readable.
- **Weiner Filters** | Generally we use the FIR causal one because it's more stable than the others. It estimates the present of a hidden signal with a noisy signal in
input. Honestly it's just a bunch of mathematics, I don't want to spend hours translating this in C++.

### Prediction 

The general method of prediction process is to minimize the MSE (Mean Square Error), to find the most probable next value. It's all bayesian stuff.

Most popular method for prediction are the following ones:
- **Kalman filter** | Basic, cool, vrey nice.
- **EKF** | Cool, is ok.
- **EnKF** | Cool, is ok.
- **UKF** | Not so basic, uses first-order Taylor expansion, NOT NICE.
- **Particle Filter** | BEST EVEEERRRR ♥ But so heavy... :c

### Data processed

Filtering and prediction could be made thanks to IR data, camera data and any sensor you want actually. To begin, we will just start by implementing a simple command law which corrects the position of the robot given the position according to its motors and  the camera.

### Code embeding

The command law will take place... I forgot where, but Wanchaï told me