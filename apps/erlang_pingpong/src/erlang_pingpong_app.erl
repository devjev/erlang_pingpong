%%%-------------------------------------------------------------------
%% @doc erlang_pingpong public API
%% @end
%%%-------------------------------------------------------------------

-module(erlang_pingpong_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    erlang_pingpong_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
