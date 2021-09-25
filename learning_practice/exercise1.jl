# package background 
using Plots
using LinearAlgebra
using ForwardDiff

# Question 1 
function factorial2(n)
    value = 1
    for i in 1:n
        value = value * i 
    end 
    return value 
end 

println(factorial2(10))
factorial(10) == factorial2(10) && println("The function is perfect.")

# Question 2 
function binomial_rv(n, p)
    value = 0 
    for i in 1:n
        rv = rand()
        if rv<p
            value += 1 
        end 
    end 
    return value 
end 


# Question 3 
iteration = 100000000
frequency=0
for i in 1:iteration
    unit = randn(2)
    norm_length = norm(unit - [0.5, 0.5])
    if norm_length <= 0.5 
        frequency += 1 
    end 
end 
π_estimate = frequency/iteration/ 0.5^2 
println("The π is estimated to be $π_estimate in $iteration iterations")

# Question 4 
function award()
    sum = 0
    realization = rand(10)
    for i in eachindex(realization)
        realization[i] > 0.5 ? sum += 1 : sum = 0 
        if sum >2
            println("You get one dollar!!!") 
            break
        end 
    end
    if sum < 3 
        println("You can try one more time.")
    end 
end 

award()

# Question 5, 6  

# define function 
function sample_generating(x0 ,n, α)
    x = zeros(n+1)
    x[1] = x0
    rand_rv = randn(n)
    for i in eachindex(rand_rv)
        x[i+1]= α * x[i] + rand_rv[i]
    end 
    return x[2: end]
end 

x1 = sample_generating(0, 200, 0)
x2 = sample_generating(0, 200, 0.8)
x3 = sample_generating(0, 200, 0.98)
plot(x1, label="α = 0")
plot!(x2, label="α = 0.8")
plot!(x3, label="α = 0.98")


# Question 7 
function sample_generating(x0 , n, α, σ)
    x = zeros(n+1)
    x[1] = x0
    rand_rv = randn(n)
    for i in eachindex(rand_rv)
        x[i+1]= α * x[i] + σ * rand_rv[i]
    end
    x[end]=0 
    return x[2: end]
end 

function cross_time(x0, t_max, α, σ, threshold, iteration)
    T=zeros(iteration)
    for i in 1:iteration
        sample = sample_generating(x0, t_max, α, σ)
        index_sample=0
        while sample[index_sample+1] > threshold && index_sample <= t_max -1 
            index_sample +=1
        end 
        T[i]=index_sample + 1 
    end
    return T  
end

T=cross_time(1, 200, 1.0, 0.2, 0, 100)
histogram(T, bins=20)

# Quesetion 8 a 
function fixedpointmap(f, f_prime; iv=10, tolerance=1E-7, maxiter=1000)
    # setup the algorithm
    x_old = iv
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = x_old - f(x_old)/f_prime(x_old) # use the passed in map
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (value = x_old, normdiff=normdiff, iter=iter) # A named tuple
end

f(x) = (x-1)^3 
f_prime(x) = 3 * (x-1)^2 
sol = fixedpointmap(f, f_prime)

# Quesetion 8 b 
D(f) = x -> ForwardDiff.derivative(f, x)
f(x) = (x-1)^3 
f_prime = D(f)
sol = fixedpointmap(f, f_prime)

# Good job! 