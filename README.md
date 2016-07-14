# erlang-studies-gen_fsm
Elixir では v0.12.5 で gen_fsm が廃止となっており、https://github.com/elixir-lang/elixir/commit/455eb4c4ace81ce60b347558f9419fe3c33d8bf7 にて `you can also use Erlang's :gen_fsm directly, which GenFSM is a simple wrapper for.` と言われているため、まず Erlang で gen_fsm を書き、それを Elixir に対応してみた。

Elixir からの :gen_fsm 呼び出しは、[light_switch](https://github.com/gogogarrett/light_switch) がかなり参考になった。

## state

- init
  - select へ遷移
- 状態：select
  - decide()で状態：checking へ遷移
  - それ以外は無視
- 状態：checking
  - pay()は状態：serve へ遷移
  - cancel()は状態：select へ遷移
  - それ以外は無視
- 状態：serve
  - got()は状態：select へ遷移
  - それ以外は無視

## Usage(Erlang版)

```
$ erl
> c(fsm).

> fsm:start().

> fsm:decide().
> fsm:pay().
> fsm:get().
```

## Usage(Elixir版)

```
$ iex fsm.exs

> FSM.start

> FSM.decide
> FSM.pay
> FSM.get
```
