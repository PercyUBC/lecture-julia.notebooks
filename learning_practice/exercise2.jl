# I set the background here 
using Statistics 
using Plots
using LinearAlgebra

# Question 1 
# part 1
x_vals = rand(3)
y_vals = rand(3)
sum = 0
for (x, y) in zip(x_vals, y_vals)
    sum += x*y 
end 
println("x = $x_vals", "y = $y_vals")
println("The inner product of two vector is $sum .")

# part 2 
sum([i % 2 == 0 ? 1 : 0 for i in 1:99])

# part 3 
pair = ((2, 5), (4, 2), (9, 8), (12, 10))

sum([iseven(a) && iseven(b) ? 1 : 0 for (a,b) in pair])

# Question 2
p(x, coff) = sum([x^(i-1)*coff[i] for i in eachindex(coff)])

function p2(x, coff)
    sum=0
    for (i,co_value) in enumerate(coff)
        sum += x^(i-1) * co_value 
    end 
    return sum 
end 

coff = [1,2,3]
x = 2 
println(p(x, coff) == p2(x, coff) && "Two functions both works")

#Question 3 
count_uppercase(string) = sum([i == uppercase(i) ? 1 : 0 for i in string])

#Questin 4 
function check_same(seq_a, seq_b)
    check = true 
    for i in seq_a
        check = check && (i in seq_b)
    end
    return check  
end 

seq1= ["ubc", "mit", "harvard", "queens"]
seq2= ["ubc", "mit", "harvard", "toronto", "sfu"]
check_same(seq1, seq2)
# Question 5
function linapprox(f, a, b, n, x)
    v=NaN64
    for i in range(a, stop=b, length=n)
        left = i
        right =  i + (b-a)/(n-1)
        if x>left && x<= right 
            v = f(left) + (x - left) * (f(right) - f(left)) / (right - left)
            break 
        end
    end
    return v
end

f(x) = x^3 

plot(linapprox.(f, 1, 20, 5,(1:20)))

# Question 6 
open("us_cities.txt", "w") do f
    write(f,
  "new york: 8244910
  los angeles: 3819702
  chicago: 2707120
  houston: 2145146
  philadelphia: 1536471
  phoenix: 1469471
  san antonio: 1359758
  san diego: 1326179
  dallas: 1223229")
  end
file = open("us_cities.txt", "r")
summ = 0 
for i in eachline(file)
    text_number = split(strip(i), ":")[end]
    summ += parse(Int, text_number)
end
println("The total population is $summ.") 

# Question 7 
function linapprox(x; f, nodes = -1.0:0.5:1.0)
    left = div(x, step(nodes), RoundDown) * step(nodes)
    right = (div(x, step(nodes), RoundDown)+1) * step(nodes)
    v = f(left) + (x - left) * (f(right) - f(left)) / (right - left)
    return v 
end 

f_ex5(x) = x^2
g_ex5(x) = linapprox(x, f=f_ex5)
x_grid = range(-1.0, 1.0, length = 100)
y_vals = f_ex5.(x_grid)
y = g_ex5.(x_grid)
plot(x_grid, y_vals, label = "true")
plot!(x_grid, y, label = "approximation")

