

-module(random_number_server).
-behaviour(gen_server).

% interface
-export([start/0, 
         stop/0, 
         do_something_synchronously/1, 
         do_something_asynchronously/1]).
    
% callbacks
-export([init/1,
         handle_call/3, 
         handle_cast/2,
         handle_info/2, 
         terminate/2, 
         code_change/3]).

-define(TIME, 2).

%%====================================================================
%% Server interface
%%====================================================================
%% Booting server (and linking to it)
start() -> 
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% Stopping server asynchronously
stop() ->
    gen_server:cast(?MODULE, shutdown).

do_something_asynchronously(Parameter) -> 
    gen_server:cast(?MODULE, {generate_random_number, Parameter}).	

do_something_synchronously(Parameter) -> 
    gen_server:call(?MODULE, {generate_random_number, Parameter}).	

%%====================================================================
%% gen_server callbacks
%%====================================================================
% Init with trap exit
init([]) ->
    random:seed(now()),    
    util:log("SERVER: Initializing"),
    {ok, initialized}.

%% Synchronous calls
handle_call({generate_random_number, Max}, _, State) -> 
    Time = generate_random(Max),
    {reply, Time, State};   
handle_call(_, _, State) -> {reply, error, State}.

%% Asynchronous calls
handle_cast({generate_random_number, Max}, State) -> 
    generate_random(Max),
    {noreply, State};
handle_cast(shutdown, State) -> 
    util:log("SERVER: stopped"),
    {stop, normal, State}.

%% Informative calls
handle_info(_Message, _Server) -> {noreply, _Server}.

%% Server termination
terminate(_Reason, _Server) -> ok.

%% Code change
code_change(_OldVersion, _Server, _Extra) -> {ok, _Server}.   


%%====================================================================
%% Private functions
%%====================================================================
generate_random(Max) ->
    Rand = random:uniform(Max),
    util:log("SERVER: Generating random up to '~p', will take me ~p seconds ",[Max, ?TIME]),
    timer:sleep(?TIME * 1000),
    util:log("SERVER: Done!, generated number was ~p", [Rand]),
    Rand.
 
