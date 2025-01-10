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
begin
  const TimePoint = Union{<:Real,<:TimeType}
end


begin
  function simulate(
                    m::BlackScholes,
                    Tuple{A,B},
                    from::D,
                    to::D,
                    dt::Period;
                    n::Int64=1,
                    x0::R=1.0,
                    nsteps::C=0,
                    rn::Bool=false
           ) where {A<:Real,B<:Real,C<:Integer,D<:Union{Date,AbstractDateTime}}
    end
                    
end
