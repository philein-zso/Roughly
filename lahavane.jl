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
