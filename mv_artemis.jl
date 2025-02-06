# Artemis
let bunch="Artemis"
  bry_pit = joinpath(homedir(), bunch)
  hjo_pit = joinpath(homedir(), bunch, "Dailies")
  tickers = readdir(brypit, join=false)
  filter!(endswith(".csv"), tickers)
  map!(s -> replace(s,".csv" => ""), tickers, tickers)
  printstyled("Summary\nTickers:$(length(tickers))\nContinue?",color=11)
  readuntil(stdin,"\n")
  stocks = Vector{Stock}(undef,length(tickers))
  for i in 1:length(tickers)
    try
      stocks[i] = Stock(tickers[i])
      setparams!(stocks[i], UnitedStatesEx())
    catch er
      printstyled(er,color=4)
      printstyled(tickers[i],Char(0x2718))
    end
  end
  printstyled("Summary[Observables]\nTickers:$(length(stocks))\nContinue?",color=11)
  readuntil(stdin,"\n")
  
end
