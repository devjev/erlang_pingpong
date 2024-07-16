-module(pingpong).
-behaviour(gen_server).

%% API declarations
-export([start_link/0, ping/1]).

%% gen_server callbacks declarations
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% API =======================================================================

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

ping(Signal) when Signal == ping; Signal == pong -> 
	gen_server:call(?MODULE, Signal);
ping(_Signal) -> error(invalid_argument).


%% gen_server ================================================================

init([]) -> {ok, #{}}.

% Handle calls ---------------------------------------------------------------

handle_call(ping, _From, State) ->
	log_manager:log({self(), "ping -> pong"}),
	{reply, pong, State};
handle_call(pong, _From, State) ->
	log_manager:log({self(), "pong -> ping"}),
	{reply, ping, State};
handle_call(_Request, _From, State) ->
	{reply, ok, State}.


handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, _State) -> ok.


code_change(_OldVersion, State, _Extra) ->
	{ok, State}.

terminate(_Reason, _State) -> ok.
