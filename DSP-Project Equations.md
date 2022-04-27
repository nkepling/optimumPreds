# DSP-Project Notes

## General Notes:

- Benchmark lcp vs 
- For the meeting today outline the presentation 
  - Layout what kind of signals we are trying to predict on
    - Stationary random proceesses
    - Forward and backward linear prerdiction
      - Procedure 
      - AR,ARMA,Ma
      - Lets focus on AR filters
      - 
- https://en.wikipedia.org/wiki/Linear_prediction

## Linear Prediction and Optimum Linear Filters

In this project we are concerened with the design of of optimum filters from the statistical viewpoint. 

- Understanding second-order statistics or a stationary process arere required
- Design of optimum filters for linear prediciton. 
  - Requires solutions to a set of linear equations that have some special symmetry
  - Levinon-Durbin algorithm and Schur algorithm are the two methods to provide a solution through computatitonlly efficient procedurees that exploit symmetry properties

### Random Signals, Correlation Functions, and Power Spectra

A charaterization of random signals in terms of statistical averages in the time and freq domains.

#### 12.1.1 Random Processes

Random fluctuating phenomena like thermal noise voltages are signals usually modeled as infinited-duration infinite-energy signals. 

Suppose that there are a seet of waveforms corresponding to air temperature in different cities around thee world ... the set of all possible waveforms is called an **ensemeble** of times functions or, equivialently a **random process** 

The wave form for a temperature in any particularcity is a **single realization** or a **sample function** of a random process.

Another example is the thermal noise volatage of a single resitor is the sample function of random processes generatted by the set of all resistors. 



The set of all possible noise waveforms of a random process is $X(t,S)$ where $t$ is time and $S$ represents the set (sample space) of all possible sample fucntion. A single waveform in the ensemble is $x(t,s)$. 

Consider all the instances of a process in which have the time instances, $t=t_i,i=1,2,...,n$ the samples

$X_{t_i} = x(t_i)$ are n random variables charactized as the joint probability density function $p(x_{t_1},x_{t_2},...,x_{t_n})$

#### 12.1.2 Stationary Random Processes

A stationary random process is invariant with time. So the statistical properties are the samee as we move forward. Sooo 
$$
p(x_{t_1},x_{t_2},...,x_{t_n}) = p(x_{t_1+\tau},x_{t_2+\tau},...,x_{t_n+\tau})
$$

#### 12.1.3 Statistical (Ensemble) Averages

The $l^{th}$ moment of a random process is teh expectedvalue of $X^l(t_i)$ 
$$
E(X^{l}) = \int_{-\infty}^{\infty}x^l_{t_i}p(x_{t_i})dx_{t_i}
$$
The lth moment is indep of time when the process is stationary. 

 The stistical correlation between r.v $X_{t_1}$adn $X_{t_2}$ is measured by the joint moment
$$
E(X_1,X_2) = \int_{\infty}\int_{\infty}x_{t_1}x_{t_2}P(x_{t_1}x_{t_2})dx_1dx_2
$$
The joint momeent deponds on the two time instances and is denoted as $\gamma_{xx}(t_1t_2)$ The autocorrelation function of a random process. 

For stationary real-valued random process the autocorrrelation function is 
$$
\gamma(\tau) = E[X_{t_1+\tau}X_{t_1}]
$$


---- reffer to book for derivation of moments, autocorrilation and ergodic processes. The upshot in the real world we only have a single realization of a random process. So to deal with time-averages of mean and autocorrilation we nened teh process to be eergodic. in other word the moment of thee single realization are the same as the ensemble.  A [stochastic process](https://en.wikipedia.org/wiki/Stochastic_process) is said to be **ergodic** if its statistical properties can be deduced from a single, sufficiently long, random sample of the process. 

We alo what out system be widesense sationary https://en.wikipedia.org/wiki/Stationary_process#Weak_or_wide-sense_stationarity

WSS random processes only require that 1st [moment](https://en.wikipedia.org/wiki/Moment_(mathematics)) (i.e. the mean) and [autocovariance](https://en.wikipedia.org/wiki/Autocovariance) do not vary with respect to time and that the 2nd moment is finite for all times.







### 12.2 Innovations Representation of a Stationary random process

Wide sense sationary random process can be represented as the output of a cuasal and causally invertable linear system excited by a white noise process. 

#### 12.2.1 Rational Power Spectra



The power spectral density of the sationary random process {x(n)} is a rational function, expressed as+
$$
\Gamma_{xx} = \sigma_w^2\frac{B(z)B(z^{-1})}{A(z)A(z^{-1})}, r_1 < |z| < r_2
$$
Where the polynomials B(z) and A(z) have roots that fall inside the unit circle in the z-plane. 

The filter $H(z)$ for geneerating random process {x(n)} from white noise is 
$$
H(z) = \frac{B(z)}{A(z)} = \frac{\sum_{k=0}^{q}b_kz^{-k}}{1+\sum_{k=0}^{p}a_kz^{-k}},|z|>r_1
$$


Where $b_k$ And $a_k$ are the filter coefficients 

Thus the random process {x(n)} uniqueley reprisnets the statistical properties of the innovations process w(n) and vice versa.



For the linear system with rational system function H(z) teh output x(n) is related to the input w(n) by the difference equation Autoregessivee, moving averagee process (ARMA)
$$
x(n) +\sum_{k=0}^{p}a_kx(n-k) = +\sum_{k=0}^{q}b_kw(n-k)
$$
finte poles and finite zeroes in the real plane. 

#### Relationships Betweeen the Filter Parameters and the Autocorrelation Sequence

$$
\gamma_{xx}(m) =-\sum_k
$$

In general there are relationships betwee the filter parameters {a_k} {b_k} depending on whether we have an AR process, ARMA process, or MA process. 

| Arma     | Ma     | AR     |
| -------- | ------ | ------ |
| nolinear | linear | linear |



### Aside: Lattice structure 

Consider a systeme  with sequence of FIR filters with system functions $H_m(z)=A_m(z)$ where by definition $A_m(z)=1+\sum_{k=1}^{m}\alpha_m(k)z^{-k}$  where $m\ge 1$ and $A_0(z)=1$ The subscipt m denotes the degree of the polynomial. 



If {x(n)} is the input to tehe filter A_m(z) and y(n) is the output, we have


$$
y(n) =x(n)+\sum_{k=1}^{m}\alpha_m(k)x(n-k)
$$
Where $\alpha_m(0)=1$

In linear prerdiction we have 
$$
\hat x(n) = -\sum_{k=1}^{m}\alpha_m(k)x(n-k)
$$
Where we preddict one step forward value $x(n)$ based on m past inputs. 

With FIR direct form implenetations fi we leet m=1 the out put of sucha. filter is 
$$
y(n)=x(n)+\alpha(1)x(n-1)
$$


### Forward and Backward linear Prediction

The problem of linearly prediciton the value of a stationary random process either forward in time or backward in time. --- we get lattice filter structures 

#### Forward Linear Prediction

Prediction future value of stationary random process from observation of past values of the process. 



**The one step forward linear predictor,**

We form the prediciotn of the value x(n) by a weighted linear combination of past values x(n-1),x(n-2),...,x(n-p) the predicted value of x(n) is 
$$
\hat x(n) = -\sum_{k=1}^{p}a_p(k)x(n-k)
$$
where $-a_p(k)$ are the weights

The different between the value x(n) and the predicted value x(n) is the forward prediction error 
$$
f_p(n)=x(n)-\hat x(n)
$$
