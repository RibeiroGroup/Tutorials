# Transfer Matrix Method using Scattering matrices

> This tutorial is based on Dr. Raymond Rumpf's lecture available [here](https://www.youtube.com/watch?v=mOy5jyZe7_Y&t=3957s).

## Goal

We want to implement the transfer matrix method and use it to compute reflectance and transmitance spectra of a layered material, in this case a Distributed Braggs Reflector (DBR). 

## Incident Wave

The first step in the implementation is to consider the incident wave that will be reflected/transmitted across our structure. The wave will be defined by its wavelength ($\lambda$) and its orientation ($\theta$, $\phi$). For simplicity we can take $\phi=0$. Hence, we have

$k_0 = 2\pi/\lambda$,

$k_x = k_0\sin(\theta)$,

$k_y = 0.0$,

$k_x = k_0\cos(\theta)$.

For our implementation, we will use the dimensionless quantities 

$\tilde{k}_x = k_x/k_0 = \sin(\theta)$,

$\tilde{k}_y = k_y/k_0 = 0.0$,

$\tilde{k}_x = k_x/k_0 = \cos(\theta)$.

The incident field will be polarized along $x$, we can write

$$\mathbf{c}_\text{inc} = \left[\begin{array}{c}
1.0 \\
0.0
\end{array}\right]
$$

## Scatter Matrix

The full scatter matrix for a given layer $i$ is a 4x4 matrix, however we will work with it using four 2x2 submatrices:

$$ \mathbf{S}^{(i)} = \left[\begin{array}{c c}
\mathbf{S}^{(i)}_{11} &  \mathbf{S}^{(i)}_{12} \\[2mm]
\mathbf{S}^{(i)}_{21} &  \mathbf{S}^{(i)}_{22}
\end{array}\right]
$$

We will never have to construct the full 4x4 structure. 
Each submatrix is constructed as

$\mathbf{S}^{(i)}_{11} = (\mathbf{A}_i - \mathbf{X}_i  \mathbf{B}_i  \mathbf{A}_i^{-1} \mathbf{X}_i  \mathbf{B}_i)^{-1} (\mathbf{X}_i  \mathbf{B}_i  \mathbf{A}_i^{-1}\mathbf{X}_i  \mathbf{A}_i^{-1} - \mathbf{B}_i)$

$\mathbf{S}^{(i)}_{12} = (\mathbf{A}_i - \mathbf{X}_i  \mathbf{B}_i  \mathbf{A}_i^{-1} \mathbf{X}_i  \mathbf{B}_i)^{-1}  \mathbf{X}_i  ( \mathbf{A}_i - \mathbf{B}_i  \mathbf{A}_i^{-1}\mathbf{B}_i)$

$\mathbf{S}^{(i)}_{21} = \mathbf{S}^{(i)}_{12}$

$\mathbf{S}^{(i)}_{22} = \mathbf{S}^{(i)}_{11}$

where we define the auxiliary matrices

$\mathbf{A}_i = \mathbf{W}_i^{-1}\mathbf{W}_0 + \mathbf{V}^{-1}_i\mathbf{V}_0$

$\mathbf{B}_i = \mathbf{W}_i^{-1}\mathbf{W}_0 - \mathbf{V}^{-1}_i\mathbf{V}_0$

$\mathbf{X}_i = \exp({-\lambda_i k_0 L_i})$

where the subscript $0$ indicates vacuum ($\epsilon_r = \mu_r = 0.0$). $\mathbf{W}_i$ is matrix containing the eigenvector of the $\mathbf{PQ}$ matrix. The $\mathbf{P}$ matrix is constructure using the normalized (dimensionaless) $\mathbf{k}$ components of the incident wave and the relative permitivity/permeability of that medium (layer): 

$$\mathbf{P} = \frac{1}{\epsilon_r}\left[
\begin{array}{cc}
\tilde{k}_x\tilde{k}_y & \epsilon_r\mu_r-\tilde{k}_x^2 \\
\tilde{k}_y^2 - \epsilon_r\mu_r & -\tilde{k}_x\tilde{k}_y 
\end{array}
\right].$$
Similarly, for $\mathbf{Q}$:
$$\mathbf{Q} = \frac{1}{\mu_r}\left[
\begin{array}{cc}
\tilde{k}_x\tilde{k}_y & \epsilon_r\mu_r-\tilde{k}_x^2 \\
\tilde{k}_y^2 - \epsilon_r\mu_r & -\tilde{k}_x\tilde{k}_y 
\end{array}
\right].$$

We define $\mathbf{\Omega}^2 = \mathbf{PQ}$, such that $\mathbf{W}$, as mentioned above, is the eigenvector matrix of $\mathbf{\Omega}$ and $\mathbf{\lambda}$ is a diagonal matrix containing its eigenvalues.

**Attention:** Note that $\mathbf{\lambda}$ is built from the eigenvalues of $\mathbf{\Omega}$, but the eigenvalues of $\mathbf{PQ}$ are $\lambda^2$. Hence, the matrix $\mathbf{\lambda}$ must be constructed as

$$\mathbf{\lambda} = \left[
\begin{array}{cc}
\sqrt{\lambda^2_1} & 0 \\
0 & \sqrt{\lambda^2_2} 
\end{array}
\right],$$
where $\lambda^2_1$ and $\lambda^2_2$ are the eigenvalues of $\mathbf{PQ}$. In turn, $\mathbf{X}$ is computed by multiplying this matrix by $k_0L_i$, where $L_i$ is the thickness of the layer, and taking the [matrix exponential](https://en.wikipedia.org/wiki/Matrix_exponential) of it.

Finally, the $\mathbf{V}$ matrices can be obtained from previous intermediate ones:

$$\mathbf{V}_i = \mathbf{Q}_i\mathbf{W}_i \mathbf{\lambda}_i^{-1}$$

This procedure will allow us to construct the scatter matrix for a particular layer. Next, we will consider how to combine two matrices for two adjacent layers.

## Redheffer Star Product

Two scatter matrices can be combined using a special operation called Redheffer star product, which we represent here with the symbol $\otimes$:

$$ \mathbf{S}^{(AB)} = \mathbf{S}^{(A)} \otimes \mathbf{S}^{(B)} $$

Having this tool available will allow us to construct the total scatter matrix for the whole system by repeatedly applying the star product:

$$ \mathbf{S}^{(\text{total})} = \mathbf{S}^{(A)} \otimes \mathbf{S}^{(B)} \otimes \mathbf{S}^{(C)} \otimes ...  \mathbf{S}^{(Z)}  $$

$\mathbf{S}^{(AB)}_{11} = \mathbf{S}^{(A)}_{11} + \mathbf{S}^{(A)}_{12} \left(\mathbf{I} - \mathbf{S}^{(B)}_{11} \mathbf{S}^{(A)}_{22}\right)^{-1} \mathbf{S}^{(B)}_{11} \mathbf{S}^{(A)}_{21}$

$\mathbf{S}^{(AB)}_{12} = \mathbf{S}^{(A)}_{12} \left(\mathbf{I} - \mathbf{S}^{(B)}_{11} \mathbf{S}^{(A)}_{22}\right)^{-1} \mathbf{S}^{(B)}_{12}$ 

$\mathbf{S}^{(AB)}_{21} = \mathbf{S}^{(B)}_{21} \left(\mathbf{I} - \mathbf{S}^{(A)}_{22} \mathbf{S}^{(B)}_{11}\right)^{-1} \mathbf{S}^{(A)}_{21}$

$\mathbf{S}^{(AB)}_{22} = \mathbf{S}^{(B)}_{22} + \mathbf{S}^{(B)}_{21} \left(\mathbf{I} - \mathbf{S}^{(A)}_{22} \mathbf{S}^{(B)}_{11}\right)^{-1} \mathbf{S}^{(A)}_{22} \mathbf{S}^{(B)}_{12}$


## Reflectance and Transmittance

Since our reflection and transmitted regions are just vacuum, the reflectance ($R$) and transmittance ($T$) can be computed as

$$ R = \frac{|\mathbf{E}_\text{ref}|^2}{|\mathbf{E}_\text{inc}|^2} $$

$$ T = \frac{|\mathbf{E}_\text{trn}|^2}{|\mathbf{E}_\text{inc}|^2} $$

where

$$|\mathbf{E}|^2 = |E_x|^2 + |E_y|^2 + |E_z|^2 $$

For the incident wave we have

$$
\left[
\begin{array}{c}
E_x \\
E_y
\end{array}
\right]_\text{inc} = \mathbf{W}_0 \mathbf{c}_\text{inc}
$$

Once the global scatter matrix is constructed, we can compute reflected (ref) and transmitted (trn) fields from some incident wave
$$
\left[
\begin{array}{c}
\mathbf{c}_\text{ref} \\
\mathbf{c}_\text{trn}
\end{array}
\right] = \mathbf{S}^{(\text{global})} 
\left[
\begin{array}{c}
\mathbf{c}_\text{inc} \\
0.0
\end{array}
\right] 
$$
From the scatter matrix structure we get that
$$
\mathbf{c}_\text{ref} = \mathbf{S}^{(\text{global})}_{11} \mathbf{c}_\text{inc} \\[2mm]
\mathbf{c}_\text{trn} = \mathbf{S}^{(\text{global})}_{21}  \mathbf{c}_\text{inc}
$$
and therefore, the fields are
$$
\left[
\begin{array}{c}
E_x \\
E_y
\end{array}
\right]_\text{ref} = \mathbf{W}_0 \mathbf{c}_\text{ref}
\qquad
\left[
\begin{array}{c}
E_x \\
E_y
\end{array}
\right]_\text{trn} = \mathbf{W}_0 \mathbf{c}_\text{trn}
$$

Finally, teh $E_z$ components are obtained from the divergence law ($\nabla\cdot\mathbf{E}=0$):
$$
E_z = - \frac{k_xE_x + k_yE_y}{k_z}
$$

> Note that if you decide to use a different medium for the reflection or transmission region you need to use the appropriate $\mathbf{W}$ matrix to convert modes $\mathbf{c}$ to fields.


## Distributed Braggs Reflector (DBR)

A [DBR](https://en.wikipedia.org/wiki/Distributed_Bragg_reflector) is a layered structure that acts as a high-quality mirror due to the destructive interaction of waves reflection off each layer. It is constructed by alternating layers of two materials with different refractive index. The length of each layer is given by

$$ l = \frac{\lambda}{4n}$$

where $\lambda$ is the central wavelength of the reflector and $n$ is the index of refraction of the medium. Note that $n^2 = \epsilon_r$ for non-magnetic materials, i.e. $\mu_r = 1.0$. 

In this tutorial, we will construct a DBR centered at 630 nm with layers made of $\text{SiO}_2$ ($n = 1.5$) and $\text{TiO}_2$ ($n = 2.5$). 

The scatter matrix for a bilayer is computed using the Redheffer star product $S^{(\text{bl})} = S^{(1)} \otimes S^{(2)}$. The scatter matrix of the whole DBR is obtained by using the Redheffer operation $N-1$ times, where $N$ is the number of layers

$$S^{(DBR)} = S^{(\text{bl})} \otimes S^{(\text{bl})} \otimes ... \otimes S^{(\text{bl})} $$

> Note that there are more efficient ways to compute the final scatter matrix, as described in the video lecture, however since we are not too concerned with efficiency at this point we will stick to the naive implementation. Feel free to optimize it!

Having the $S^{(DBR)}$ constructed, we can compute reflectance and transmitance for a range of incoming wavelengths and angles.

## Challenges  

1. Start by constructing a single DBR with 5 bilayers. Use the parameters given above and assume all materials are non magnetic.

2. Compute a reflectance spectrum for the DBR mirror, from $\lambda$ = 400 to 1000 nm using steps of 1 nm. Plot the reflectance versus wavelength at normal incidence ($\theta = 0$).

3. Change the number of layers, what happens?

4. Increase the index of refraction of $\text{TiO}_2$ to [3.0, 4.0, 5.0], what happens in the spectrum? Do not forget to update the layer thickness when you change the index of refraction.

5. For a range of angles, $\theta = [0, \pi/3]$, and using the same range of wavelengths, create a 2D reflectance spectrum (such as a heatmap) with angle on the x-axis and wavelength on the y-axis. 

6. Construct an optical microcavity by "sandwiching" a layer of thickness $L_c = 315$ nm and $n = 1.0$ with one DBR mirror on each side. Be careful to construct this structure such that the layer touching the cavity on both sides is the same. 

7. Analyze the reflectance spectrum for the microcavity, what has changed? 






