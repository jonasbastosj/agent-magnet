# Tower Jump — Dinossauro Simplificado

Um jogo super minimalista: **suba a torre pulando de plataforma em plataforma**, tipo o dinossauro do Google.

## Como abrir

1. Extraia ou clone este repositório
2. Abra o **Godot 4.3+**, clique em **Import**, selecione esta pasta
3. Aperte **F5** pra rodar

## Como jogar

- **A / ← Seta esquerda**: move pra esquerda
- **D / → Seta direita**: move pra direita
- **Espaço**: pula

**Objetivo**: suba pulando nas plataformas verdes até chegar no topo da torre!

Se cair demais pra baixo, reinicia.

## Arquivos

```
.
├── Main.tscn              # Cena principal (gera torre + player)
├── scripts/
│   ├── Main.gd           # Cria plataformas e gerencia câmera/vitória
│   └── Player.gd         # Só pulo e movimento horizontal
└── project.godot         # Config do projeto
```

## Próximos passos

- Adicionar **score** (tempo ou altura)
- **Inimigos** que se movem horizontalmente nas plataformas
- **Power-ups** (pulo duplo, invulnerabilidade, etc.)
- **Sprite real** em vez de quadrado verde
- **Áudio** (música de fundo, som de pulo)
- **Múltiplos níveis** com torres cada vez mais difíceis

---

Tá simplificado ao máximo. Qualquer coisa é só chamar!