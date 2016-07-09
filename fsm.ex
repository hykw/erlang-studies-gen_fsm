# https://speakerdeck.com/gogogarrett/gen-fsm-meets-elixir

defmodule FSM do
#  @behaviour :gen_fsm

  @name :FSM

  def init(state) do
    disp_select()
    {:ok, :select, state}
  end

  defp disp_select do
    IO.puts("商品を選択してください(decide)")
  end

  defp disp_ignore do
    IO.puts("え？")
  end


  def select(:select, _state) do
    IO.puts("支払いをお願いします(pay)")
    {:next_state, :checking, []}
  end

  def select(_, state) do
    disp_ignore()
    {:next_state, :select, state}
  end

  def checking(:pay, _state) do
    IO.puts("お待たせしました。商品をお取り下さい(got)")
    {:next_state, :serve, []}
  end
  def checking(:cancel, _) do
    IO.puts("キャンセルしました")
    disp_select()
    {:next_state, :select, []}
  end
  def checking(_, state) do
    disp_ignore()
    {:next_state, :checking, state}
  end

  def serve(:got, _) do
    IO.puts("ありがとうございました")
    disp_select()
    {:next_state, :select, []}
  end
  def serve(_, state) do
    disp_ignore()
    {:next_state, :serve, state}
  end

  ### client
  def start do
    :gen_fsm.start_link({:local, @name}, __MODULE__, [], [])
  end
  def decide do
    :gen_fsm.send_event(@name, :select)
  end
  def pay do
    :gen_fsm.send_event(@name, :pay)
  end
  def cancel do
    :gen_fsm.send_event(@name, :cancel)
  end
  def got do
    :gen_fsm.send_event(@name, :got)
  end
end

