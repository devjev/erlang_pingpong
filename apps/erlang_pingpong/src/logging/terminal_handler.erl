-module(terminal_handler).
-behaviour(gen_event).

%% gen_event callbacks
-export([init/1,
		 handle_event/2,
		 handle_call/2,
		 handle_info/2,
		 terminate/2,
		 code_change/3]).

init([]) -> {ok, {}}.

handle_event(Event, State) ->
	io:format("~p.~n", [Event]),
	{ok, State}.

handle_call(_Request, State) -> {ok, ok, State}.

handle_info(_Info, State) -> {ok, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.
