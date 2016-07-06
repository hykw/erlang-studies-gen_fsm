# erlang-studies-gen_fsm
Erlang の gen_fsm の練習

## Usage

```
$ erl
> c(sample).

> sample:start_link().

> sample:decide().
> sample:pay().
> sample:get().
```

## state

- init
  - select へ遷移
- 状態：select
  - decide()で状態：checking へ遷移
  - cancel()は無視
  - pay()は無視
- 状態：checking
  - cancel()は状態：select へ遷移
  - select()は無視
  - pay()は状態：serve へ遷移
- 状態：serve
  - cancel()は無視
  - select()は無視
  - pay()は無視
  - got()は状態：select へ遷移
