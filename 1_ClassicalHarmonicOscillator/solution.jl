using Makie
using WGLMakie

function simulate(δ, ω = 5.0, y0 = 2.0, N = 5000, duration = 15.0, E0 = 20.0, ton = 5.0, toff = 10.0; return_field = false)

    y = zeros(N)
    Energy = zeros(N)

    ωE = ω*δ

    # Start at rest
    y[1] = y0
    y[2] = y0 
    Energy[1] = 0.5*(ω * y0)^2
    Energy[2] = 0.5*(ω * y0)^2
    δt = duration/(N-1)
    t = [i*δt for i = 0:(N-1)]

    for i = 3:N

        # Get accelation
        a = - ω^2 * y[i-1]
        # Get electrict force
        if ton < t[i] < toff 
            a += E0 * sin(-ωE*t[i])
        end

        # Update position
        y[i] = 2*y[i-1] - y[i-2] + a*δt^2

        # Compute energy
        Energy[i] = 0.5*(ω * y[i])^2 + 0.5*((y[i] - y[i-2])/(2*δt))^2
    end


    if return_field
        Evals = [ton < ti < toff ? E0*sin(-ωE*ti) : 0.0 for ti = t]
        return t, y, Evals, Energy
    else
        return t, y, Energy
    end
end

function position_plot(δ, ω = 5.0, y0 = 2.0, N = 5000, duration = 15.0, E0 = 20.0, ton = 5.0, toff = 10.0)

    t, y, Ef, E = simulate(δ, ω, y0, N, duration, E0, ton, toff, return_field = true)
    fig = Figure()
    ax = Axis(fig[1,1])
    lines!(ax, t, y)
    lines!(ax, t, Ef, color=:yellow)
    display(fig)
end

### Compute energy transfered
function energy_transferred(δvals; ω = 5.0, y0 = 2.0, N = 5000, duration = 15.0, E0 = 20.0, ton = 5.0, toff = 10.0)

    Nδ = length(δvals)
    ΔE = zeros(Nδ)

    for i = 1:Nδ
        print("Computing δ = $(δvals[i])...")
        t, _, E = simulate(δvals[i], ω, y0, N, duration, E0, ton, toff)

        # Number of time points before electrict field is turned on
        Nbefore = count(x -> x < ton, t)
        Ebefore = sum(E[1:Nbefore]) / Nbefore

        # Number of time point after electrict field is turned off
        Nafter = count(x -> x > toff, t)
        Eafter = sum(E[(N-Nafter + 1):N]) / Nafter

        ΔE[i] = Eafter - Ebefore
        print("Done.\n")
    end

    println(ΔE)

    fig = Figure()
    ax = Axis(fig[1,1])
    lines!(ax, δvals, ΔE)
    display(fig)
end

