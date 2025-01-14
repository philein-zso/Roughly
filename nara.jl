# This script is part of Zsofia. Soel Philippe © 2025

begin
  """
      CIR <: RatesModels
  
  The **Cox-Ingersoll-Ross** model, aka CIR model.
  
  ## Model dynamic
  
  ``dr_t = θ(μ - r_t)dt + σ * \\sqrt{r_t} dW_t``

  Where ``(W_t)_{t>=0}`` is the **Wiener Process**.
  
  See also  [`WienerProcess`](@ref).
  
  # Fields
  - `required::NTuple{3,String}`: required parameters' names, "θ", "μ" and "σ".
  
  # Constructors
      CIR()
      
  # Arguments
  No args.
  
  # Notes
  The model holds required (and optional) parameters which will/would/should
  eventually be retrieved from the underlying object/`Observables`. The implementation
  requires those parameters to be stored into `params`' property/fields container.
  """
  struct CIR <: RatesModels
    required::NTuple{3,AbstractString}
    CIR() = new(("θ", "μ", "σ"))
  end

  function Base.show(io::IO, ::MIME"text/plain", cir::CIR)
    print(io, "CIR", cir.required)
  end

  Base.string(cir::CIR) = "CIR"

  """
      fit(m::CIR, prices, times; <kwargs>)
      fit(m::CIR, obs, from::TimePoint, to::TimePoint; <kwargs>)
      fit(m::CIR, obs, from::TimePoint; <kwargs>)
      fit(m::CIR, obs; <kwargs>)

  Return an `NTuple{2,Real}` representing the result of fitting
  the Black-Scholes model `m` to `prices` observed at `times`.
  
  # Arguments
  - `m::CIR`: a CIR model intance.
  - `prices::Vector{Real}`: prices to fit from.
  - `times::Vector{TimePoint}`: `prices` observed at `times`.
  - `obs::Observables`: the observable to get prices from.
  - `from::TimePoint`: use `obs`' prices from `from` to `to`.
  - `to::TimePoint`: use `obs` prices from `from` to `to`.
  - `dcc::DayCountConventions=ActAct()`: kwarg, day count convention.
  
  # Notes
  The current implementation does not restrict the `Observables`
  to any its (sub)types. Even if the CIR model is mostly intended
  for rates, the implementation does not restrict the `obs` argument.

  When `obs` is procided, the implementation requires model's
  `required` parameters to be stored into `params` field. Use
  the `setparams!` facility for that goal.
  """
  function StatsBase.fit(
                         m::CIR, prices::Vector{R}, times::Vector{T};
                         dcc::DayCountConventions=ActAct()
                     ) where {R<:Real,T<:TimePoint}
    nothing
  end

  function StatsBase.fit(
                         m::CIR, obs::U, from::T, to::T;
                         dcc::DayCountConventions=ActAct()
                     ) where {U<:Observables,T<:TimePoint}
    nothing
  end

  function StatsBase.fit(
                         m::CIR, obs::U, from::T;
                         dcc::DayCountConventions=ActAct()
                     ) where {U<:Observables,T<:TimePoint}
    nothing
  end

  function StatsBase.fit(
                         m::CIR, obs::U;
                         dcc::DayCountConventions=ActAct()
                     ) where {U<:Observables}
    nothing
  end

  """
      fit!(m::CIR, obs, prices, times; <kwargs>)
      fit!(m::CIR, obs, from::TimePoint, to::TimePoint; <kwargs>)
      fit!(m::CIR, obs, from::TimePoint; <kwargs>)
      fit!(m::CIR, obs; <kwargs>)

  `fit` `obs` in-place, then return the `NTuple{2,Real}` of parameters.
  
  # Arguments
  - `m::CIR`: a CIR model intance.
  - `prices::Vector{Real}`: prices to fit from.
  - `times::Vector{TimePoint}`: `prices` observed at `times`.
  - `obs::Observables`: the observable to get prices from.
  - `from::TimePoint`: use `obs`' prices from `from` to `to`.
  - `to::TimePoint`: use `obs` prices from `from` to `to`.
  - `dcc::DayCountConventions=ActAct()`: day count convention.
  
  # Notes
  The current implementation does not restrict the `Observables`
  to any its (sub)types. Even if the CIR model is mostly intended
  for rates, the implementation does not restrict the `obs` argument.

  When `obs` is procided, the implementation requires model's
  `required` parameters to be stored into `params` field. Use
  the `setparams!` facility for that goal.
  """
  function StatsBase.fit!(
                          m::CIR,
                          obs::Observables,
                          prices::Vector{R},
                          times::Vector{T};
                          dcc::DayCountConventions=ActAct()
           ) where {R<:Real,T<:TimePoint}
    nothing
  end
  
  function StatsBase.fit!(
                          m::CIR,
                          obs::Observables,
                          from::T,
                          to::T;
                          dcc::DayCountConventions=ActAct()
           ) where {T<:TimePoint}
    nothing
  end
  
  function StatsBase.fit!(
                          m::CIR,
                          obs::Observables,
                          from::T;
                          dcc::DayCountConventions=ActAct()
           ) where T<:TimePoint
    nothing
  end
  
  function StatsBase.fit!(
                          m::CIR,
                          obs::Observables;
                          dcc::DayCountConventions=ActAct()
           )
    nothing
  end
end
