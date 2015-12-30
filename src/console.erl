

-module(console).
-export([run/0]).

%% run the tests, far from functional but it shows the example running
run() -> 

    timer:sleep(2000),
    util:log("CLIENT: Starting server"),
    random_number_server:start(), 
    
    util:log("CLIENT: sync request"),
    
    util:log(
        "CLIENT: Received from random_number_server ~p",
        [random_number_server:do_something_synchronously(1000)]
    ), 
    
    util:log("CLIENT: do_something_synchronously done"),
    
    util:log("CLIENT: async request"),
    
    
    util:log(
        "CLIENT: Received from random_number_server ~p",
        [random_number_server:do_something_asynchronously(1000)]
    ),
    
    util:log("CLIENT: stopping server"),
    
    random_number_server:stop().
        
