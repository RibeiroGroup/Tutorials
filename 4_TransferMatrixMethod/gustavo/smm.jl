using Formatting
using LinearAlgebra
import Base: show

struct ScatterMatrix{M}
    S11::M
    S12::M
    S21::M
    S22::M
end

# All quantities are normalized kx = kx/k0, z = k0L
function ScatterMatrix(kx, ky, ϵr, μr, zp)
    
    # W0
    P0 = build_P(kx, ky, 1.0, 1.0)
    Q0 = build_Q(kx, ky, 1.0, 1.0)
    λ02, W0 = eigen(P0*Q0)
    λ0 = diagm([sqrt(Complex(l)) for l in λ02])
    V0 = Q0*W0*inv(λ0)

    # Wi
    Pi = build_P(kx, ky, ϵr, μr)
    Qi = build_Q(kx, ky, ϵr, μr)
    λi2, Wi = eigen(Pi*Qi)
    λi = diagm([sqrt(Complex(l)) for l in λi2])
    Vi = Qi*Wi*inv(λi)
    Xi = diagm([exp(-λ*zp) for λ in diag(λi)])


    Ai = inv(Wi)*W0 + inv(Vi)*V0
    Bi = inv(Wi)*W0 - inv(Vi)*V0

    S11 = inv(Ai - Xi*Bi*inv(Ai)*Xi*Bi) * (Xi*Bi*inv(Ai)*Xi*Ai - Bi)
    S12 = inv(Ai - Xi*Bi*inv(Ai)*Xi*Bi) * Xi * (Ai - Bi*inv(Ai)*Bi)

    return ScatterMatrix(S11, S12, S12, S11)
end

function build_P(kx, ky, ϵr, μr)
    out = zeros(2,2)

    out[1,1] = kx*ky
    out[1,2] = ϵr*μr - kx^2
    out[2,1] = ky^2 - μr*ϵr
    out[2,2] = -kx*ky

    return out ./ ϵr
end

function build_Q(kx, ky, ϵr, μr)

    out = zeros(2,2)
    out[1,1] = kx*kx
    out[1,2] = μr*ϵr - kx^2
    out[2,1] = ky^2 - ϵr*μr
    out[2,2] = -kx*ky

    return out ./ μr
end

function ⊗(A::S, B::S) where S <: ScatterMatrix
    return redheffer(A,B)
end
   
function redheffer(A::S, B::S) where S <: ScatterMatrix

    S11 = A.S11 + A.S12 * inv(I - B.S11*A.S22) * B.S11 * A.S21
    S12 = A.S12 * inv(I - B.S11*A.S22) * B.S12
    S21 = B.S21 * inv(I - A.S22*B.S11) * A.S21
    S22 = B.S22 + B.S21 * inv(I - A.S22*B.S11) * A.S22 * B.S12

    return ScatterMatrix(S11, S12, S21, S22)
end

function compute_RT(S, cinc, kx, ky)

    # We assume that both the reflection region and transmission regions is vaccum
    kz = sqrt(1 - kx^2 + ky^2)

    P0 = build_P(kx, ky, 1.0, 1.0)
    Q0 = build_Q(kx, ky, 1.0, 1.0)
    _, W0 = eigen(P0*Q0)
    
    # Electric field in the reflection region
    Eref = W0 * S.S11 * cinc

    # Electric field in the transmition region
    Etrn = W0 * S.S21 * cinc

    # Electric field incident
    Einc = W0 * cinc

    Ezref = -(kx*Eref[1] + ky*Eref[2])/kz
    Eztrn = -(kx*Etrn[1] + ky*Etrn[2])/kz
    Ezinc = -(kx*Einc[1] + ky*Einc[2])/kz

    Einc2 = abs2(Einc[1]) + abs2(Einc[2]) + abs2(Ezinc)
    R = ( abs2(Eref[1]) + abs2(Eref[2]) + abs2(Ezref) ) / Einc2
    T = ( abs2(Etrn[1]) + abs2(Etrn[2]) + abs2(Eztrn) ) / Einc2

    return R, T
end

function braggs_lengths(n1, n2, λ0)
    l1 = λ0 / (4*n1)
    l2 = λ0 / (4*n2)
    return l1, l2
end

function dbr_normal(n1, n2, N, l1, l2, λ)

    k0 = 2π/λ  

    # Assume all materials are non-magnetic
    μ = 1.0

    # Dielectric constants are obtained from refractive index
    ϵ1 = n1^2
    ϵ2 = n2^2

    # Get scatter matrix for layer 1
    S1 = ScatterMatrix(0.0, 0.0, ϵ1, μ, k0*l1)
    # Get scatter matrix for layer 2
    S2 = ScatterMatrix(0.0, 0.0, ϵ2, μ, k0*l2)
    # Get scatter matrix for a bilayer
    Sbl = S1 ⊗ S2

    # Apply it N times
    Sdevice = Sbl
    for n in 2:N
       Sdevice = Sbl ⊗ Sdevice
    end

    # Assume light is polarized along x
    cinc = [1.0, 0.0]

    return compute_RT(Sdevice, cinc, 0.0, 0.0)
end

function dbr(θ, n1, n2, N, l1, l2, λ; ϕ=0.0)

    k0 = 2π/λ  
    k = [sin(θ)*cos(ϕ), sin(θ)*sin(ϕ), cos(θ)]

    # Assume all materials are non-magnetic
    μ = 1.0

    # Dielectric constants are obtained from refractive index
    ϵ1 = n1^2
    ϵ2 = n2^2

    # Get scatter matrix for layer 1
    S1 = ScatterMatrix(k[1], k[2], ϵ1, μ, k0*l1)
    # Get scatter matrix for layer 2
    S2 = ScatterMatrix(k[1], k[2], ϵ2, μ, k0*l2)
    # Get scatter matrix for a bilayer
    Sbl = S1 ⊗ S2

    # Apply it N times
    Sdevice = Sbl
    for n in 2:N
       Sdevice = Sbl ⊗ Sdevice
    end

    # Assume light is polarized along x
    cinc = [1.0, 0.0]

    return compute_RT(Sdevice, cinc, k[1], k[2])
end

function dbr_cavity(θ, L, nc, n1, n2, N, l1, l2, λ; ϕ=0.0)

    k0 = 2π/λ  
    k = [sin(θ)*cos(ϕ), sin(θ)*sin(ϕ), cos(θ)]

    # Assume all materials are non-magnetic
    μ = 1.0

    # Dielectric constants are obtained from refractive index
    ϵ1 = n1^2
    ϵ2 = n2^2

    # Get scatter matrix for layer 1
    S1 = ScatterMatrix(k[1], k[2], ϵ1, μ, k0*l1)
    # Get scatter matrix for layer 2
    S2 = ScatterMatrix(k[1], k[2], ϵ2, μ, k0*l2)
    # Get scatter matrix for a bilayer
    Sbl = S1 ⊗ S2

    # Apply it N times
    Sdevice = Sbl
    for n in 2:N
       Sdevice = Sbl ⊗ Sdevice
    end

    # We will consider that the inside of the cavity
    ϵ = nc^2
    Scav = ScatterMatrix(k[1], k[2], ϵ, μ, k0*L)

    # Total S matrix
    #Stotal = Sdevice ⊗ Scav ⊗  Sdevice
    Stotal = Sdevice ⊗ Scav ⊗  S2 ⊗  Sdevice

    # Assume light is polarized along x
    cinc = [1.0, 0.0]

    return compute_RT(Stotal, cinc, k[1], k[2])
end
