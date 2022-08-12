# Appendix B: Rotating Wave Approximation

This derivation follows closely the notes found [here](https://chem.libretexts.org/Bookshelves/Physical_and_Theoretical_Chemistry_Textbook_Maps/Time_Dependent_Quantum_Mechanics_and_Spectroscopy_(Tokmakoff)/03%3A__Time-Evolution_Operator/3.04%3A_Resonant_Driving_of_a_Two-Level_System) (*Tokmakoff, 2020*).

Starting from equation 2 from the [instructions](instructions.md)

$$\Large \dot{a} = -\frac{i}{2\hbar} b  V_{ab} (e^{-i(\omega_{ba}-\omega)t} + e^{-i(\omega_{ba}+\omega)t}) \qquad$$ 

$$\Large \dot{b} = -\frac{i}{2\hbar} a V_{ab} (e^{i(\omega_{ba}-\omega)t} + e^{i(\omega_{ba}+\omega)t})\qquad$$ 

We discard the terms containing exponentials of $\pm i(\omega_{ba} + \omega)$ under the justification that these oscillations are very rapid and get averaged out. [Task 3](instructions.md#task-3-comparing-numerical-integration-to-the-rwa-result), will address this approximating in more detail. Dropping these nonresonant terms we get

$$\Large \dot{a} = -\frac{i}{2\hbar} b  V_{ab} e^{-i(\omega_{ba}-\omega)t} \qquad \normalsize \text{(1a)}$$

$$\Large \dot{b} = -\frac{i}{2\hbar} a V_{ab} e^{i(\omega_{ba}-\omega)t} \qquad \normalsize \text{(1b)}$$

Differentiating equation for 1b yields

$$\Large \ddot{b} = -\frac{iV_{ab}}{2\hbar} [\dot{a} e^{i(\omega_{ba}-\omega)t} + i(\omega_{ba}-\omega) a e^{i(\omega_{ba}-\omega)t}] \qquad \normalsize \text{(2)}$$

Equation 1b can be rearranged as

$$\Large a = \frac{2i\hbar}{V_{ab}} e^{-i(\omega_{ba}-\omega)t} \dot{b} \qquad \normalsize \text{(3)}$$

Plugging (3) and (1a) into (2), we obtain

$$\Large \ddot{b} = - \frac{V_{ab}^2}{4\hbar^2}b + i(\omega_{ba}-\omega)\dot{b}$$

$$\Large \ddot{b} - i(\omega_{ba}-\omega)\dot{b} + \frac{V_{ab}^2}{4\hbar^2}b = 0 \qquad \normalsize \text{(4)}$$

The second-order differential equation (4) is well-known as the damped harmonic oscillator

$$\Large \alpha \ddot{b} + \beta \dot{b} + \gamma b = 0$$

for which solutions can be written as

$$\Large b = e^{-(\beta/2\alpha)t}[A\cos{\Omega_R t} + B\sin{\Omega_R t}]\qquad \normalsize \text{(5)}$$

where

$$\Large \Omega_R = \frac{1}{2a}\sqrt{4\alpha \gamma + |\beta|^2}$$ 

In order to find constants $A$ and $B$ suitable to our problem, we employ our initial conditions. First, using $b(t=0) = 0.0$ equation (5) becomes

$$\Large b(t = 0) = A \Rightarrow  A = 0$$ 

Thus, 

$$\Large b = Be^{-(\beta/2\alpha)t}\sin{\Omega_R t}\qquad \normalsize \text{(5)}$$

Note that, from equation (1b), and using $a(t=0) = 1$ we have 

$$\Large \dot{b}(t=0) = -\frac{i}{2\hbar} V_{ab} \qquad \normalsize \text{(6)}$$

Differentiating (5) and setting it equal (6) at $t = 0$ leads to

$$\Large B = \frac{-i V_{ba}}{2\hbar \Omega_R}$$

which solves the problem. Now we only need to plug in our values for $\alpha$, $\beta$, and $\gamma$. 

$$\Large \Omega_R = \frac{1}{2}\sqrt{\frac{|V_{ab}|^2}{\hbar^2} + (\omega_{ba}-\omega)^2}$$ 

or

$$\Large \Omega_R = \frac{1}{2\hbar}\sqrt{|V_{ab}|^2 + \hbar^2(\omega_{ba}-\omega)^2}$$ 

Finally,

$$\Large b = \frac{-i V_{ba}}{2\hbar \Omega_R} e^{-\frac{i}{2}(\omega_{ba}-\omega)t}\sin{\Omega_R t}$$

The probability of finding the system in the state $|b\rangle$ is

$$\Large P(b) = |b|^2 = \frac{|V_{ab}|^2}{4\hbar^2 \Omega_R^2}\sin^2{\Omega_R t}$$

$$\Large P(b) = |b|^2 = \frac{|V_{ab}|^2}{|V_{ab}|^2 + \hbar^2(\omega_{ba} - \omega)^2} \sin^2(\Omega_R t)$$

The frequency at which this probability oscillates $(\Large \Omega_R)$ is known as Rabi frequency.
