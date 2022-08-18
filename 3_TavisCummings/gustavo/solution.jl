using Makie
using WGLMakie
using CairoMakie
using LinearAlgebra

function build_H(N, ωc)
# ωc must be given in cm⁻¹
    
    # Define molecular excitation frequency
    ωM = 1000

    # Define coupling constant
    g = 2
    
    # Initiate H
    H = zeros(ComplexF64, N+1, N+1)
    
    ## Fill diagonal elements

    # Photon mode |1,0⟩
    H[1, 1] = ωc

    # Remaining basis (molecular excitations |0,a⟩, |0,b⟩, ...)
    for i = 1:N
        H[i+1,i+1] = ωM
    end
    
    ## Fill off-diagonal elements. Those are just the row and column of the photon mode |1,0⟩
    for i = 1:N
        H[1, i+1] =  im * g
        H[i+1, 1] = -im * g
    end
    
    return H
end

function solutionA(Nmax; step = 5)

    # Prepare an array of N vals given Nmax and step
    Nvals = collect(1:step:Nmax)

    # Intialize an array to store energy gaps
    Δvals = zeros(length(Nvals))
    
    # Loop through values of N
    for i = eachindex(Nvals)
        N = Nvals[i]

        # Create and diagonalize H
        H = build_H(N, 1000)
        e,_ = eigen(H)

        # Take the energy splliting as the difference between the largest and smallest eigenvalues
        Δvals[i] = (e[end] - e[1])
    end

    # Create figure
    fig = Figure()
    ax = Axis(fig[1,1], xlabel="Number of Molecules", ylabel="Polariton splitting (cm⁻¹)")

    # Plot analytical result: splliting = Ω = 2g√N
    lines!(ax, 1:Nmax, [4*√n for n = 1:Nmax], color=:red, label="Analytical")

    # Plot numerical result
    scatter!(ax, Nvals, Δvals, label="Numerical")

    # Show legend
    axislegend(position = :rb)

    display(fig)

    #save("solA.png", fig, px_per_unit = 2)
end

function solutionB()

    # Get detuning values
    δvals = [-100 + i*10 for i = 0:20]

    # Initiliaze arrays
    up = zeros(length(δvals))    # UP Polariton energy
    lp = zeros(length(δvals))    # LP Polariton energy

    pc_up = zeros(length(δvals)) # Photonic content of the UP polariton (just for coloring)
    pc_lp = zeros(length(δvals)) # Photonic content of the LP polariton (just for coloring)

    # Loop thourgh deturning values
    for i in eachindex(δvals)

        # Construct and diagonalize Hamiltonian
        H = build_H(100, 1000+δvals[i])
        e,c = eigen(H)

        # Fetch polariton energies
        up[i] = e[1]
        lp[i] = e[end]

        # Get photonic component of each polariton
        pc_up[i] = abs2(c[1,1])
        pc_lp[i] = abs2(c[1,end])
    end

    # Create figure
    fig = Figure()
    ax = Axis(fig[1,1], xlabel = "Detuning (cm⁻¹)", ylabel = "Energy (cm⁻¹)")

    # Plot uncoupled energies
    lines!(ax, δvals, [1000 for i = eachindex(δvals)], color=:black, linestyle = :dash)
    lines!(ax, δvals, [1000 + δ for δ in δvals], color=:black, linestyle = :dash)

    # Plot coupled energies
    lines!(ax, δvals, up, color = pc_up, linewidth = 7)
    lines!(ax, δvals, lp, color = pc_lp, linewidth = 7)

    # Add some text for description
    text!(ax, 50, 1040, text = "Pure photon")
    text!(ax, -100, 990, text = "Pure molecule")

    text!(ax, 0, 1050, text="Upper Polariton", align = (:right, :bottom))
    text!(ax, 0, 950, text="Lower Polariton", align = (:left, :top))

    # Colorbar for photonic content
    Colorbar(fig[1,2], limits = (0,1), label = "Polariton photonic content")

    display(fig)
    save("solB.png", fig, px_per_unit = 2)
end