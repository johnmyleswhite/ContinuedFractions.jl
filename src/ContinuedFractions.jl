module ContinuedFractions

import Base: start, done, next, length, eltype, collect

export ContinuedFraction, quotients, convergents, ConvergentIterator

immutable ContinuedFraction{T<:Integer}
	quotients::Vector{T}
end

quotients(cf::ContinuedFraction) = cf.quotients

immutable ConvergentIterator{T<:Integer}
    qs::Vector{T}
end

start(::ConvergentIterator) = 1
done(it::ConvergentIterator, state::Int) = state > length(it.qs)
length(it::ConvergentIterator) = length(it.qs)

function next(it::ConvergentIterator, state::Int)
    convergent = Rational(ContinuedFraction(it.qs[1:state]))
    convergent, state + 1
end

eltype(it::ConvergentIterator) = Rational{eltype(it.qs)}
collect(it::ConvergentIterator) = collect(eltype(it), it)

convergents(cf::ContinuedFraction) = convergents(quotients(cf))
convergents{T<:Integer}(qs::Vector{T}) = ConvergentIterator(qs)

function Base.Rational(cf::ContinuedFraction)
    qs = quotients(cf)
    isempty(qs) && return 0 // 1
    length(qs) == 1 && return qs[1] // 1

    remainder = qs[2:end]
    rat = Rational(ContinuedFraction(remainder))
    (qs[1] * rat.num + rat.den) // rat.num
end

function ContinuedFraction{T<:Integer}(rat::Rational{T})
    a = div(rat.num, rat.den)
    a * rat.den == rat.num && return ContinuedFraction(T[a])  # Exact!

    cf = ContinuedFraction(rat.den//(rat.num - a*rat.den))
    unshift!(quotients(cf), a) # insert at index 1
    cf
end

# let rationalize handle conversion from floating point
ContinuedFraction(x::BigFloat) = ContinuedFraction(rationalize(BigInt, x))
ContinuedFraction(x::AbstractFloat) = ContinuedFraction(rationalize(x))

ContinuedFraction(x::Integer) = ContinuedFraction([x])

end # module ContinuedFractions
