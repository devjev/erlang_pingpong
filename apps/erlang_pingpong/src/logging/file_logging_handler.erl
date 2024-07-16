-module(file_logging_handler).
-behaviour(gen_event).

%% gen_event callbacks
-export([init/1,
		handle_event/2,
		handle_call/2,
		handle_info/2,
		terminate/2,
		code_change/3]).

-define(LOG_FILE, "erlang_pingpong.log").

padded_number(Number, Width) ->
	FormatString = "~*..0B",
	FormattedOutput = io_lib:format(FormatString, [Width, Number]),
	lists:flatten(FormattedOutput).

init([]) -> 
	{ok, File} = file:open(?LOG_FILE, [write, append]),
	{ok, #{file => File}}.

handle_event(Event, State) ->
	#{file := File} = State,
	{Sender, Message} = Event,
	{{Year, Month, Day}, {Hour, Minute, Second}} = calendar:universal_time(),
	io:format(File, "~s-~s-~s ~s:~s:~s | ~p | ~p.~n", 
			  [padded_number(Year, 4),
			   padded_number(Month, 2),
			   padded_number(Day, 2),
			   padded_number(Hour, 2),
			   padded_number(Minute, 2),
			   padded_number(Second, 2),
			   Sender, 
			   Message]),
	file:sync(File),
	{ok, State}.

handle_call(_Request, State) -> {ok, ok, State}.

handle_info(_Info, State) -> {ok, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.
