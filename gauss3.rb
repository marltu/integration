f = lambda { |x| Math.sin(3*x) }
a = 0.0
b = Math::PI/3
e = 0.00000001

def gauss3(f, a, b, e = 0.001, sn2 = 1.0/0)

    c1 = 5/9.0
    c2 = 8/9.0
    c3 = 5/9.0

    s1 = -Math.sqrt(0.6)
    s2 = 0.0
    s3 = Math.sqrt(0.6)

    g = lambda {|s| f.call(x_transform(a, b, s)) }

    result = c1 * g.call(s1) + c2 * g.call(s2) + c3 * g.call(s3)
end

def x_transform(a, b, s)
    alpha = (b + a).fdiv(2)
    beta = (b - a).fdiv(2)

    return alpha + beta * s
end

print gauss3(f, a, b, e).inspect
