%%%-------------------------------------------------------------------
%% @doc erlang_pingpong top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(erlang_pingpong_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 1,
                 period => 5},

    ChildSpecs = [#{id => pingpong,
				    start => {pingpong, start_link, []},
				    restart => permanent,
				    shutdown => 5000,
				    type => worker,
				    modules => [pingpong]},

				  #{id => log_manager,
				    start => {log_manager, start_link, [[terminal_handler, file_logging_handler]]},
					restart => permanent,
					shutdown => 5000,
					type => worker,
					modules => [log]}],

    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
