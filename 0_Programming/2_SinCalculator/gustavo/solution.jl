function get_sin(x, precision = 10^-5)

    max_iter = 100

    out = x

    xsqr = x^2 

    iter = 1
    n = 3

    x0 = x
    x1 = 1.0
    while abs(x1) > precision
        if iter > max_iter
            println("Does not converge")
            break
        end
        x1 = -x0 * xsqr / (n * (n-1))
        out += x1

        x0 = x1
        n += 2
        iter += 1
    end
    
    return out
end