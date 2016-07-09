-module(sample).
-behaviour(gen_fsm).

-export([start/0]).

-export([init/1]).
-export([select/2, checking/2, serve/2]).
-export([decide/0, pay/0, cancel/0, got/0]).


init([]) ->
  disp_select(),
  process_flag(trap_exit, true),
  {ok, select, []}.

disp_select() ->
  io:format("商品を選択してください(decide)~n", []).

disp_ignore() ->
  io:format("え？~n", []).


select({select}, _) ->
  io:format("支払いをお願いします(pay)~n", []),
  {next_state, checking, []};
select(_, LoopData) ->
  disp_ignore(),
  {next_state, select, LoopData}.

checking(pay, _) ->
  io:format("お待たせしました。商品をお取り下さい(got)~n", []),
  {next_state, serve, []};
checking(cancel, _) ->
  io:format("キャンセルしました~n", []),
  disp_select(),
  {next_state, select, []};
checking(_, LoopData) ->
  disp_ignore(),
  {next_state, checking, LoopData}.

serve(got, _) ->
  io:format("ありがとうございました~n", []),
  disp_select(),
  {next_state, select, []};
serve(_, LoopData) ->
  disp_ignore(),
  {next_state, serve, LoopData}.



% client
start() -> gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).

decide() -> gen_fsm:send_event(?MODULE, {select}).
pay() -> gen_fsm:send_event(?MODULE, pay).
cancel() -> gen_fsm:send_event(?MODULE, cancel).
got() -> gen_fsm:send_event(?MODULE, got).
