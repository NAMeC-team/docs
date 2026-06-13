# Kalman Filters

These entities are gifts of god. Blessed shall be those who live with them.

I know 5 types of Kalman filters.
1. **Kalman filter** | Basic, cool, very nice.
2. **EKF** | Cool, is ok.
3. **EnKF** | Cool, is ok.
4. **UKF** | Not so basic, uses first-order Taylor expansion, NOT NICE (in my opinion).
5. **Particle Filter** | BEST EVEEERRRR ♥ But so heavy... :c

So let's start without tergiverging more.

What actually *is* a Kalman filter? The answer is not simple. It's not just one thing, it is a set of mathematical equations that provides an efficient computational (recursive) solution of the least-squares method [[Wekch et. al.](http://www.ceri.memphis.edu/people/rsmalley/ESCI7355/welch%20and%20bishop%20-%20kalman.pdf)]. In simple words, it can estimate past, present and future. It has been formulated by R. E. Kalman, in 1960, in an article named *[A New Approach to Linear Filtering and Prediction Problems](https://www.cs.unc.edu/~welch/kalman/media/pdf/Kalman1960.pdf)*. It is very cool, yet unreadable for my small brain.

Let $x$ be a state of a discrete-time controlled process, and $u$ a control input, which **we know**. $x$ is governed by this equation:

$$x_{k+1} = A_k x_k + B u_k + w_k$$

In parallel, we also get the measurement of the signal processed according to the law given by $x$. This measurement is described as $z$:

$$z_k = H_k x_k + v_k$$

With:
- $w_k$ and $v_k$ random independant noises,
- $A$ an $n \times n$ matrix for linking the timesteps $k$ and $k+1$,
- $B$ an $n \times 1$ matrix linking the input $u$ to the state $x$ (optionnal according to my professor),
- $H$ the observation matrix, which maps the true state space into the observed space [[Stack Overflow](https://stackoverflow.com/questions/62734219/what-is-the-h-matrix-in-a-kalman-filter)].

All of the matrices are supposed to be known.

Then, all the story is about predicting and correcting. 

Omg [this article](https://www.bzarg.com/p/how-a-kalman-filter-works-in-pictures/) is so great. It actually explains everything that we need to know for basic Kalman filters, so I guess I stop here for this part?






