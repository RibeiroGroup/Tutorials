using Makie
using WGLMakie
using CairoMakie


# Step 1: RWA Solutions
# Arguments must be in Hartrees
function get_Pb(ω, ωab, Vab; t_final = 8000, δt = 1)
    tvals = collect(0:δt:t_final)
    N = length(tvals)
    pvals = zeros(N)

    # Get Rabi Frequency
    Ω = 0.5 * √(Vab^2 + (ωab - ω)^2)

    # Common prefactor
    prefac = Vab^2 / (Vab^2 + (ωab - ω)^2)

    # Compute value for each time step
    for i = 1:N
        t = tvals[i]
        pvals[i] = prefac * sin(Ω*t)^2
    end

    return tvals, pvals
end

# Arguments must be in cm⁻¹
function solutionA(ω_vals, ωab, Vab; t_final = 8000, δt = 1)

    # Conversion factor from wavenumber to Hartrees
    conv = 4.5564e-6

    # Prepare empty figure
    fig = Figure()
    ax = Axis(fig[1,1], xlabel="Time", ylabel="P(b)")

    # Compute P(b) for each ω value
    for ω in ω_vals
        t, P = get_Pb(ω*conv, ωab*conv, Vab*conv; t_final = t_final, δt = δt)
        lines!(ax, t, P, label = "ωab - ω = $(ωab - ω) cm⁻¹")
    end

    axislegend(position = :lt)
    save("solA.png", fig, px_per_unit = 2)
    display(fig)
end

# Arguments must be in cm⁻¹
function solutionB(ωmin, ωmax, ωab, Vab_vals; t_final = 8000, δt = 1)

    # Prepare empty figure
    fig = Figure()
    ax = Axis(fig[1,1], xlabel="ω(cm⁻¹)", ylabel="Pmax")

    # Conversion factor from wavenumber to Hartrees
    conv = 4.5564e-6

    δω = (ωmax - ωmin) / 100

    ωvals = [ωmin + i*δω for i = 1:100]

    # Compute Pmax for each Vab value
    for Vab in Vab_vals
        Pvals = zeros(100)
        # Compute Pmax for each ωvalue
        for i = 1:100
            ω = ωvals[i]
            _, P = get_Pb(ω*conv, ωab*conv, Vab*conv; t_final = t_final, δt = δt)

            Pvals[i] = maximum(P)
        end

        # Plot Pmax versus ω for a specific value of Vab
        lines!(ax, ωvals, Pvals, linewidth = 2, label = "Vab = $Vab cm⁻¹")
    end

    axislegend(position = :lt)
    save("solB.png", fig, px_per_unit = 2)
    display(fig)
end

# Arguments in wavenumbers, ω assumed to be resonant
function solutionC(ω_vals, Vab_vals)
    # Conversion factor from wavenumber to Hartrees
    conv = 4.5564e-6

    # Create an empty figure
    fig = Figure()

    # Loop through values of ω and Vab
    for i = 1:length(ω_vals)
        ω   = ω_vals[i]   * conv
        for j = 1:length(ω_vals)
            Vab = Vab_vals[j] * conv

            # Get RWA result
            tvals, rwa = get_Pb(ω, ω, Vab)

            # Plot RWA result
            ax = Axis(fig[i,j], xlabel="Time", ylabel="P(b)", title = "ω = $(ω_vals[i]) Vab = $(Vab_vals[j])")
            lines!(ax, tvals, rwa, label = "RWA")

            # Compute numerical result
            a = zeros(ComplexF64, length(tvals))
            b = zeros(ComplexF64, length(tvals))
            a .= 0
            b .= 0
            δt = tvals[2] - tvals[1]

            # Starting values k = 1
            a[1] = 1.0
            b[1] = 0.0

            # First step k = 2
            expp = exp(im*ω*δt)
            expm = exp(-im*ω*δt)
            epac = expp
            emac = expm

            for k = 2:length(tvals)
                epac *= expp
                emac *= expm

                V = Vab*cos(ω*tvals[k-1])

                ∂b = -im * (a[k-1] * epac * V)
                b[k] = b[k-1] + ∂b * δt

                ∂a = - im * (b[k-1] * emac * V)
                a[k] = a[k-1] + ∂a * δt
            end

            Pb = real(b .* conj.(b))

            # Plot numerical Pb
            lines!(ax, tvals, Pb, label = "Numerical")
        end
    end

    save("solC.png", fig, px_per_unit = 2)
    display(fig)
end