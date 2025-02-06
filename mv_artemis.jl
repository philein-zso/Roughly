# Artemis
let bunch="Artemis"
  bry_pit = joinpath(homedir(),bunch)
  hjo_pit = joinpath(homedir(),bunch,"Dailies")
  tickers = readdir(bry_pit,join=false)
  filter!(endswith(".csv"),tickers)
  map!(s -> replace(s,".csv" => ""),tickers,tickers)
  printstyled("Summary\nTickers:$(length(tickers))\nContinue?",color=11)
  readuntil(stdin,"\n")
  stocks = Vector{Stock}(undef,length(tickers))
  for i in 1:length(tickers)
    try
      stocks[i] = Stock(tickers[i])
      setparams!(stocks[i],UnitedStatesEx())
    catch er
      printstyled(er,color=4)
      printstyled(tickers[i],Char(0x2718))
    end
  end
  printstyled("Summary[Observables]\nTickers:$(length(stocks))\nContinue?",color=11)
  readuntil(stdin,"\n")
  # brynhild part
  for i in 1:length(stocks)
    df = read_csv(
                  joinpath(bry_pit,tickers[i] * ".csv"),
                  DataFrame,
                  stringtype=String,
                  truestrings=nothing,
                  falsestrings=nothing
         )
    printstyled(tickers[i]," load from db: ", Char(0x2714),"\n",color=4)
    buildfeatures!(stocks[i],BRYNHILD,df)
    printstyled(tickers[i]," features: ",Char(0x2714),"\n",color=4)
    write(HRAFNHILDUR, stocks[i], df, BRYNHILD)
    printstyled(tickers[i]," written out ",Char(0x2714),color=4)
  end
end
