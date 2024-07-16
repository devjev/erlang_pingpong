-module(log_manager).
-behaviour(gen_event).

%% API
-export([start_link/1,
		 add_handler/1,
		 log/1]).

%% gen_event callbacks
-export([init/1,
		 handle_event/2,
		 handle_call/2,
		 handle_info/2,
		 terminate/2,
		 code_change/3]).

-record(log_state, {}).


%% API Functions
start_link(Handlers) when is_list(Handlers) -> 
	{ok, Pid} = gen_event:start_link({local, ?MODULE}),
	lists:foreach(fun(Handler) -> add_handler(Handler) end, Handlers),
	{ok, Pid};
start_link(_Handlers) -> {error, badarg}.

add_handler(Handler) -> gen_event:add_handler(?MODULE, Handler, []).

log(Event) -> gen_event:notify(?MODULE, Event).

%% gen_event callbacks
init([]) -> {ok, #log_state{}}.

handle_event(Event, State) ->
	io:format("Handle event: ~p.~n", [Event]),
	{ok, State}.

handle_call(_Request, State) -> {ok, ok, State}.

handle_info(_Info, State) -> {ok, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.
