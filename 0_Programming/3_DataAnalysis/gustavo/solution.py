import numpy as np
import matplotlib.pyplot as plt

def read_data(fname):

    # Open file
    with open(fname, "r") as f:

        # Read the file as an array of Strings (each line is one element in the array)
        lines = f.readlines()

        # Get number of lines (equals the number of data points)
        N = len(lines)
        xvals = np.zeros(N) 
        yvals = np.zeros(N) 

    ## Loop through lines
    for l in range(N):
        # Split line into two blocks (`split` uses whitespace as the breaking point)
        xstr,ystr = lines[l].split()
        xvals[l] = float(xstr)
        yvals[l] = float(ystr)
    
    return xvals, yvals


def linear_regression(xvals, yvals):

    # Compute coefficients A,B of the line
    # y = Ax + B
    n = len(xvals)
    Σy  = np.sum(yvals)
    Σx  = np.sum(xvals)
    Σx2 = np.sum(xvals * xvals)
    Σxy = np.sum(xvals * yvals)

    A = (n * Σxy - Σx * Σy) / (n * Σx2 - Σx**2)

    B = (Σy * Σx2 - Σx * Σxy) / (n * Σx2 - Σx**2)

    return A, B

def plot_data(xvals, yvals, A, B):
    # Compute values for the straight line model
    yline = [A*x + B for x in xvals]

    # Create plots and label
    plt.plot(xvals, yvals, 'bo', label="Raw")
    plt.plot(xvals, yline, 'r', label="Model")
    plt.ylabel("Y values")
    plt.xlabel("X values")
    plt.title("Linear Regression")
    plt.legend(loc="lower right")

    # Show figure
    plt.show()



if __name__ == "__main__":
    ## Parse data
    x,y = read_data("../data.txt")
    ## Process data
    A,B = linear_regression(x,y)
    ## Plot data
    plot_data(x,y, A, B)