# JogoVelha-Godot-4.1.1
 Um simples jogo da velha para explorar o potencial dos componentes de UI da Godot 4

![Screen 1](.readme/screen.gif)

## Game Download

Confira as versões compiladas em [Releases](https://github.com/diogorbg/JogoVelha-Godot-4.1.1/releases).

* [jogoVelha_win_v0.2.zip](https://github.com/diogorbg/JogoVelha-Godot-4.1.1/releases/download/v0.2/jogoVelha_win.zip)

## Inteligência Artificial

Agora você pode jogar contra uma IA. Ela é feita para ser balanceada. Ela não deixa de ganhar/defender se estiver por uma única jogada, mas ela também não é capaz de criar estratégias para vencer. Em vez disso a IA joga aleatoriamente. Ela segue as seguintes prioridades:
1. Verifica se existe uma jogada vitoriosa, onde se vence o jogo.
2. Verifica se existe uma jogada de defesa, onde se impede o oponente.
3. Não restando opção a IA é forçada jogar aleatoriamente.
