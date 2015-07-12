module ContinuedFractions

import Base: start, done, next, length, eltype, getindex

export ContinuedFraction, FiniteContinuedFraction, IrrationalContinuedFraction,
    ConvergentIterator, continuedfraction, convergents

abstract ContinuedFraction{T<:Integer}
eltype{T}(::ContinuedFraction{T}) = T

include("finite.jl")
include("irrational.jl")
include("convergents.jl")

end # module ContinuedFractions
