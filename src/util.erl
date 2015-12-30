


-module(util).
-export([log/1, log/2]).

log(Msg) ->
    {{Year,Month,Day},{Hour,Min,Sec}} = calendar:local_time(),
    {_,_,Micro} = erlang:now(),
    io:format(
        "[~2.10.0B/~2.10.0B/~B ~2.10.0B:~2.10.0B:~2.10.0B.~s] ~p - ~s~n", 
        [Month, Day, Year, Hour, Min, Sec, string:left(integer_to_list(Micro), 4, $0), self(), Msg]
    ).

log(Msg,Pars) -> log(io_lib:format(Msg, Pars)).