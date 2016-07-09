# erlang-studies-gen_fsm
Erlang の gen_fsm の練習

## Usage

```
$ erl
> c(sample).

> sample:start().

> sample:decide().
> sample:pay().
> sample:get().
```

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
