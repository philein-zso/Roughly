# this might the a script
# this algo is to be refined
#
begin
  """
      LongstaffSchwartz <: EquityModels
  """
  struct LongstaffSchwartz{U} <: EquityModels
    m::U where U<:AbstractModel
    LongstaffSchwartz(m::U) where U<:AbstractModel = new{U}(m)
  end

  function evaluate(op::AmericanOption, ...)
    nothing
  end
end
