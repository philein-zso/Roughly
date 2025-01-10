# some facilities to add:
# 1. introduce the 'evaluate' foo for fi evals (associate to the u-t-h facility)
#    _model_value(m::AbstractModel)
# 2. bs sim
# 3. cir sim
# 4. parisian option
# 5. bootstrap facility

begin
  """
      evaluate(m::AbstractModel, der::Derivatives, t::TimePoint, <kwargs>)

  Return the value of `der` under the model assumption `m`.
  """
  function evaluate(m::BlackScholes, op::U, t::TimePoint) where U<:EuropeanOption
    nothing
  end
  
  evaluate(m::AbstractModel, obs::U, t::TimePoint) where U<:Real = obs

  evaluate(obs::U, t::TimePoint) where U<:Real = obs

  evluate(obs::U) where U<:Real = obs
end

# change the TimePoint type into
# something more robust and concize
# here's a proposal
# begin
#    const TimePoint = Union{<:Real,<:TimeType}
# end


begin
  function simulate(
                    m::BlackScholes, par::Tuple{A,B},
                    from::T, to::T, dt::Period;
                    n::Integer=1, nsteps::Integer=0,
                    x0::R=1.0, rn::Bool=false,
                    dcc::DayCountConventions=ActAct()
           ) where {A<:Real,B<:Real,T<:TimeType,R<:Real}
    t  = collect(StepRange(from, dt, to))
    in(to, t) ? nothing : push!(t, to)
    _t = vcat(0.0, diff(dcc, t))
    _n = max(nsteps, ceil(Int64, /(size(_t,1),max(_t)))) - 1
    wi = WienerProcess(n, sum(_t), nsteps=_n, dimension=1)
    simulate!(wi)
    β  = ifelse(rn, S(m.riskfreerate)(from), par[1]-0.5par[2]^2)
    (t, x0 * exp.(.+(β * cumsum(_t), par[2] * wi.paths)))
  end

  function simulate(
                    m::BlackScholes, par::Tuple{A,B},
                    from::T1, to::T2, dt::T3;
                    n::Integer=1, nsteps::Integer=0,
                    x0::R=1.0, rn::Bool=false,
                    dcc::DayCountConventions=ActAct()
           ) where {A<:Real,B<:Real,T1<:Real,T2<:Real,T3<:Real,R<:Real}
    @assert isless(0.0, dt)
    t  = collect(LinRange(from, to, ceil(Int64, /(to - from, dt))))
    wi = WienerProcess(n, last(t), nsteps=max(size(t,1)-1, nsteps), dimension=1)
    simulate!(wi)
    β  = ifelse(rn, S(m.riskfreerate)(from), par[1]-0.5par[2]^2)
    (t, x0 * exp.(.+(β * t, par[2] * wi.paths)))
  end

  function simulate(
                    m::BlackScholes, obs::Observables,
                    from::T, to::T, dt::Union{Period,<:Real};
                    n::Integer=1, nsteps::Integer=0,
                    x0::R=1.0, rn::Bool=false,
                    dcc::DayCountConventions=ActAct()
           ) where {T<:TimePoint,R<:Real}
    for k in m.required
      @assert hasparam(obs, k)
    end
    simulate(
             m, (getparams(obs, "μ"), getparams(obs, "σ")),
             from, to, dt, n=n, nsteps=nsteps, x0=x0,
             rn=rn, dcc=dcc
    )
  end
end
