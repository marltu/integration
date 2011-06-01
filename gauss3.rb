f = lambda { |x| Math.sin(3*x) }
a = 0.0
b = Math::PI/3
e = 0.00000001


def gauss3_solve(f, a, b, e, m = 2, sm2 = 1.0/0)
    xi = lambda { |i| a + i * (b - a)/m } 
    sm = 0.upto(m - 1).collect { |i| gauss3(f, xi.call(i), xi.call(i+1)) }.inject {|s, si| s + si}

    diff = (sm2 - sm).abs / (2 ** (2 * 3) - 1)

    print "m = #{m}; Sm = #{sm} diff: #{diff}\n"

    if diff > e
        gauss3_solve(f, a, b, e, m * 2, sm)
    else
        return sm  
    end
end

def gauss3(f, a, b)

    c1 = 5/9.0
    c2 = 8/9.0
    c3 = 5/9.0

    s1 = -Math.sqrt(0.6)
    s2 = 0.0
    s3 = Math.sqrt(0.6)

    g = lambda {|s| (b - a).fdiv(2) * f.call(x_transform(a, b, s)) }

    result = c1 * g.call(s1) + c2 * g.call(s2) + c3 * g.call(s3)
end

def x_transform(a, b, s)
    alpha = (b + a).fdiv(2)
    beta = (b - a).fdiv(2)

    return (b - a).fdiv(2) * s + (a + b).fdiv(2)
end

print gauss3_solve(f, a, b, e)
