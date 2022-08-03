# Two-level system under a time-dependent potential

Consider a quantum system consisting of two energy levels $|a\rangle$ and $|b\rangle$ with energy gap $\hbar \omega_{ba} = E_b - E_a$. Initially, these energy levels correspond to eigenstates of an unperturbed Hamiltonian $\hat{H}_0$. These states are coupled upon the inclusion of a time dependent perturbation, $\hat{V}(t)$, with a coupling strength of

$V_{ab}(t) = \langle a | \hat{V}(t) | b \rangle$

![img](assets/elevels.png)

The wave function for this system can be written, generically as

$\Large | \psi \rangle = a |a \rangle + b |b\rangle$

for which equations of motion can be derived (as shown in the [appendix A](a_eom.md))

$\Large \dot{a} = -i b e^{-i\omega_{ba}t} V_{ab}(t)$

$\Large \dot{b} = -i a e^{i\omega_{ba}t} V_{ab}(t)$

where we have assumed $V_{ab} = (V_{ba})^*$. If we take our time dependent perturbation to be $V_{ab}(t) = V_{ab}\cos(\omega t)$ these equations become

$\Large \dot{a} = -i b e^{-i\omega_{ba}t} V_{ab}\cos(\omega t) \qquad$ (1a)

$\Large \dot{b} = -i a e^{i\omega_{ba}t} V_{ab}\cos(\omega t) \qquad$ (1b)

Using the complex exponential for for the cosine function, this can also be written as

$\Large \dot{a} = -\frac{i}{2} b  V_{ab} (e^{-i(\omega_{ba}-\omega)t} + e^{-i(\omega_{ba}+\omega)t}) \qquad$ (2a)

$\Large \dot{b} = -\frac{i}{2} a V_{ab} (e^{i(\omega_{ba}-\omega)t} + e^{i(\omega_{ba}+\omega)t})\qquad$ (2b)

From this point, analytical expressions for $a$ and $b$ may be obtained invoking the rotating wave approximation (RWA), see [appendix B](b_rwa_analytical.md).

Under this approximation, the probability of finding the molecule in the state $|b\rangle$ is

$\Large P(b) = |b|^2 = \frac{|V_{ab}|^2}{|V_{ab}|^2 + \hbar^2(\omega_{ba} - \omega)^2} \sin^2(\Omega_R t)$

where the Rabi frequency ($\Omega_R$) is

$\Large \Omega_R = \frac{1}{2\hbar}\sqrt{|V_{ab}|^2 + \hbar^2(\omega_{ba} - \omega)^2}$


# Task 1: Studying the RWA solution

1. Create a function, `get_Pb`, that takes in a value of $\omega$, $\omega_{ba}$, and $V_{ab}$ and return and array with time and $P(b)$ values. By default you can use time values from 0 to 8000 (atomic units) with time steps of 1. For example

```julia
function get_Pb(ω, ωba, Vab; t_final = 8000, δt = 1)

    # Compute tvals and pvals

    return tvals, pvals
end
```

2. Create a second function, `solutionA`, that takes an array of $\omega$ values along with $\omega_{ba}$ and $V_{ab}$ and plots the time evolution of the probability $P(b)$ for different $\omega$ frequency values. Have all the plots in a single figure. A template of the function call is
```julia
function solutionA(ω_vals, ωba, Vab; t_final = 8000, δt = 1)
    # Compute P(b) for each value in `ω_vals` using get_Pb
    # Plot results!
end
```
Produce and save a figure with the following parameters:
- $\omega$ values: $14400$, $14600$, $14800$, and $15000$ cm ${}^{-1}$.
- $\omega_{ba} = 15000$ cm $^{-1}$.
- $V_{ab} = 200$ cm $^{-1}$.

3. Create a third function, `solutionB`, that takes in a range of $\omega$, a $\omega_{ba}$ value and an array of $V_{ab}$ values. For each value of $V_{ab}$ you must

- Compute the probability profile $P(b)$  across the range of $\omega$ values. (Note that this implies a double loop!).
- Determine the maximum of value of the distribution ($P_\text{max}$) and a function of $\omega$.
- Plot $P_\text{max}$ against $\omega$.

A template for this function is shown below

```julia
function solutionB(ωmin, ωmax, ωba, Vab_vals; t_final = 8000, δt = 1)

    # Use 100 steps between maximum e mininum values
    δω = (ωmax - ωmin) / 100

    ωvals = [ωmin + i*δω for i = 1:100]

    # Compute Pmax for each Vab value
    for Vab in Vab_vals

        Pvals = zeros(100)

        for i = 1:100

            # Compute Pmax for each ωvalue

        end
        ...
        # Plot Pmax versus ω for a specific value of Vab
    end

    # Display the final figure
end
```
Using this function prepare and save a figure with the following parameters:

- $\omega$ range: from 1400 to 1600, 100 steps. 
- $\omega_{ba} = 15000$ cm $^{-1}$.
- $V_{ab}$ values: $50$, $100$, $200$, and $300$ cm $^{-1}$.

