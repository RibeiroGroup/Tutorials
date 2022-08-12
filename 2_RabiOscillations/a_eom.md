# Appendix A: Equation of motion for a superposition state

Consider a state in a quantum superposition

$$\Large |\psi\rangle = \sum_k c_k e^{-i E_kt / \hbar}|k\rangle \normalsize \qquad \text{(1)} $$ 

the time-evolution of the coefficients $c_k$ can be obtained by plugging this definition into the Schrödinger equation

$$\Large i\hbar \frac{\partial |\psi\rangle}{\partial t} = \hat{H} |\psi\rangle \normalsize \qquad \text{(2)}$$ 

First, we evaluate the left-hand side of this equation by taking the derivative of (1)

$$\Large i\hbar \frac{\partial |\psi\rangle}{\partial t} = i\hbar\sum_k \dot{c_k}e^{-i E_kt / \hbar}|k\rangle +  \sum_k E_k c_k e^{-i E_kt / \hbar}|k\rangle \normalsize \qquad \text{(3)}$$ 

Next, we partition the Hamiltonian into diagonal and off-diagonal parts

$$\Large \hat{H} = \hat{H}_0 + \hat{V}$$

such that

$$\Large \hat{H}_0 |k\rangle = E_k |k\rangle $$

then, the right-hand side of (2) becomes

$$\Large \hat{H}|\psi\rangle = \sum_k E_k c_k e^{-i E_kt / \hbar}|k\rangle + \sum_k c_k e^{-i E_kt/\hbar}\hat{V}|k \rangle \normalsize \qquad \text{(4)}$$ 

Plugging (3) and (4) back into (2) gives us

$$\Large i\hbar\sum_k \dot{c_k}e^{-i E_kt / \hbar}|k\rangle +  \sum_k E_k c_k e^{-i E_kt / \hbar}|k\rangle = \sum_k E_k c_k e^{-i E_kt / \hbar}|k\rangle + \sum_k c_k e^{-i E_kt/\hbar}\hat{V}|k \rangle$$

we can cancel the common term out to get

$$\Large  i\hbar\sum_k \dot{c_k}e^{-i E_kt / \hbar}|k\rangle = \sum_k c_k e^{-i E_kt/\hbar}\hat{V}|k \rangle $$

Projecting $\Large \frac{-i}{\hbar}\langle n | e^{iE_nt/\hbar}$ from the left side yields

$$\Large \dot{c_n} = -\frac{i}{\hbar}\sum_kc_k e^{-i \omega_{kn} t} V_{nk}$$

where 

$$\Large V_{nk} = \langle n | \hat{V} | k \rangle$$

and 

$$\Large \omega_{kn} = (E_k - En) / \hbar $$

