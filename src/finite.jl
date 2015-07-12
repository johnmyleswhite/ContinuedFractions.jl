# rationals have finite continued fractions
immutable FiniteContinuedFraction{T<:Integer} <: ContinuedFraction{T}
    quotients::Vector{T}
end

# continued fraction for the ratio of x and y
function continuedfraction{T<:Integer}(x::Real, y::Real, ::Type{T}=Int)
    qs = T[]
    r = y
    r_p = x

    while r != 0
        q, r_n = divrem(r_p, r)
        push!(qs, q)
        r, r_p = r_n, r
    end
    FiniteContinuedFraction(qs)
end

continuedfraction{T<:Integer}(x::FloatingPoint, ::Type{T}=Int) =
    continuedfraction(x, one(x), T)

continuedfraction{T<:Integer}(x::Rational, ::Type{T}=Int) =
    continuedfraction(x.num, x.den, T)                 

start(cf::FiniteContinuedFraction) = start(cf.quotients)
done(cf::FiniteContinuedFraction) = done(cf.quotients)
next(cf::FiniteContinuedFraction, i) = next(cf.quotients,i)
getindex(cf::FiniteContinuedFraction, i) = getindex(cf.quotients, i)
length(cf::FiniteContinuedFraction) = length(cf.quotients)
