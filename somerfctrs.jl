#> bonds_pricers, under specific models

#> refactoring of OU simulation

# The following function can be defined in [utils.jl]
begin
  function Base.muladd(ξ::R) where R<:Real
    _f(x::A,y::B) where {A<:Real,B<:Real} = muladd(x,ξ,y)
  end
end

begin
  function simulate(ou::OrnsteinUhlenbeckProcess; x0::R=one(Real)) where R<:Real
    τ = vcat(0, diff(ou.times))
    ω = exp.(-θ * τ)
    x = rand(Normal(0.0, 1.0), getfield(ou, :kinda))
    x .= .*(ou.σ * sqrt.(/(1 .- ω .* ω, 2θ)), x)
    accumulate!(muladd(ω), x, x, dims=1, init=x0)
    (ou.times, x)
  end
end


##> Vasicek Model
