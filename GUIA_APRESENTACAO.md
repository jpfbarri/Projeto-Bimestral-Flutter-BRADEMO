# Guia de apresentacao - Fluently

Este guia reune respostas curtas para possiveis perguntas sobre o projeto. A ideia
e entender o raciocinio e responder com naturalidade, sem decorar palavra por
palavra.

## Resumo do projeto em 1 minuto

O Fluently e um prototipo de aplicativo educacional feito em Flutter. Ele foi
adaptado visualmente de um UI Kit do Figma e possui fluxo de splash, onboarding,
login, recuperacao de senha, dashboard, menu e telas academicas.

O projeto usa widgets do Material 3, navegacao com `Navigator`, estado local com
`setState`, tema centralizado e componentes reutilizaveis. Os dados sao estaticos:
nao existe backend ou banco de dados nesta versao. A responsividade e obtida pela
combinacao de `LayoutBuilder`, `Expanded`, `SafeArea`, rolagem e restricoes de
tamanho.

## Perguntas sobre Flutter e estrutura

### 1. Por que o grupo escolheu Flutter?

Porque ele permite criar interfaces multiplataforma com uma unica base de codigo.
Tambem oferece muitos widgets prontos, recarregamento rapido durante o
desenvolvimento e boa integracao com o Material Design.

### 2. O que e um widget?

Widget e a unidade basica da interface no Flutter. Textos, botoes, espacamentos,
layouts e ate telas completas sao representados por widgets organizados em uma
arvore.

### 3. Como o projeto esta organizado?

- `lib/views`: telas da aplicacao.
- `lib/widgets`: componentes visuais reutilizaveis.
- `lib/models`: modelos e dados do dominio.
- `lib/theme`: cores e estilos globais.
- `lib/main.dart`: ponto de entrada da aplicacao.

Essa separacao melhora a leitura, a manutencao e o reaproveitamento de codigo.

### 4. O projeto usa MVC?

Nao de forma completa. Ele possui separacao entre modelos, views, widgets e tema,
mas nao tem uma camada propria de controllers ou services. Como os dados sao
estaticos e o estado e simples, a logica ficou local nas telas.

### 5. Qual e a diferenca entre `StatelessWidget` e `StatefulWidget`?

`StatelessWidget` e usado quando a tela nao precisa alterar estado interno.
`StatefulWidget` e usado quando alguma informacao visual muda durante o uso. O
onboarding, por exemplo, precisa guardar a pagina atual; a avaliacao guarda a
questao e a alternativa selecionadas.

### 6. Como o estado e gerenciado?

O estado e local e gerenciado com `setState`. Isso atende ao tamanho atual do
projeto. Em uma versao maior, com dados compartilhados e backend, poderia ser
adotado Provider, Riverpod ou BLoC.

### 7. Por que existem tantos `const` no codigo?

Um widget `const` pode ser reutilizado pelo Flutter quando seus valores nao mudam.
Isso evita reconstrucoes desnecessarias e deixa explicito que aquele trecho e
imutavel.

### 8. O que e null safety?

E o recurso do Dart que diferencia valores que podem ou nao ser nulos. Por
exemplo, `Course?` pode ser nulo, enquanto `Course` exige um objeto valido. Isso
ajuda a prevenir erros de valor nulo em tempo de execucao.

## Perguntas sobre responsividade

### 9. A responsividade e garantida pelo `LayoutBuilder`?

Ele participa, mas nao garante a responsividade sozinho. O `LayoutBuilder` informa
as restricoes de largura e altura disponiveis. O codigo precisa usar essas medidas
para adaptar os widgets.

No projeto, a lista de cursos usa um breakpoint:

```dart
final columns = constraints.maxWidth >= 720 ? 2 : 1;
```

Assim, a grade tem uma coluna em telas estreitas e duas em telas com pelo menos
720 pixels logicos de largura.

### 10. Qual e a diferenca entre `LayoutBuilder` e `MediaQuery`?

`MediaQuery` informa caracteristicas gerais da tela, como tamanho, orientacao e
espacos do sistema. `LayoutBuilder` informa o espaco que o widget pai realmente
disponibilizou. Neste projeto foi usado `LayoutBuilder`, pois a decisao depende do
espaco do componente.

### 11. Para que serve o `Expanded`?

Ele faz um filho de `Row` ou `Column` ocupar o espaco restante. Isso evita depender
de uma largura fixa e permite que o layout se ajuste ao espaco disponivel.

### 12. Para que servem `SingleChildScrollView` e `ConstrainedBox`?

O `SingleChildScrollView` permite rolagem quando o conteudo nao cabe na tela. O
`ConstrainedBox` define limites minimos ou maximos. Juntos, eles fazem o conteudo
preencher telas maiores e continuar acessivel em telas menores.

### 13. Para que serve o `SafeArea`?

Ele impede que o conteudo fique sob a barra de status, notch ou outras areas
reservadas pelo sistema operacional.

### 14. Como o teclado e tratado na tela de login?

O `Scaffold` usa `resizeToAvoidBottomInset: true` e o conteudo possui rolagem.
Quando o teclado aparece, a area util e reduzida e o usuario ainda consegue
acessar os campos e botoes.

### 15. O aplicativo funciona igualmente em qualquer tamanho de tela?

Ele foi preparado principalmente para celulares e possui recursos que evitam
overflow, alem de um breakpoint na grade de cursos. Isso nao significa que todas
as telas tenham layouts exclusivos para tablet, desktop ou web. Uma evolucao seria
criar breakpoints compartilhados e testar mais larguras e orientacoes.

### 16. O que significa `double.infinity`?

Significa que o widget tenta ocupar toda a largura permitida pelo seu pai. Ele nao
cria uma largura infinita real; continua respeitando as restricoes do layout.

## Perguntas sobre navegacao e dados

### 17. Como funciona a navegacao?

O projeto usa navegacao imperativa com `Navigator` e `MaterialPageRoute`:

- `push`: abre uma nova tela mantendo a anterior na pilha.
- `pop`: fecha a tela atual e volta.
- `pushReplacement`: substitui a tela atual.
- `pushAndRemoveUntil`: remove o historico, usado no logout e na redefinicao de
  senha.

### 18. Por que usar `pushReplacement` no splash e no login?

Para impedir que o usuario pressione voltar e retorne ao splash ou a uma etapa de
entrada que ja foi concluida.

### 19. Como um curso e enviado para a tela de detalhes?

O objeto `Course` e passado pelo construtor:

```dart
CourseDetailView(course: course)
```

A tela de detalhes recebe esse objeto em um campo `final`, com `required`, e usa
seus dados para montar o conteudo.

### 20. O que existe no modelo `Course`?

Titulo, professor, categoria, descricao, progresso, icone, cor e lista de modulos.
O modelo concentra os dados de uma materia e evita passar varias informacoes
separadamente.

### 21. De onde vem o conteudo mostrado no aplicativo?

Os dados estao definidos localmente no codigo, em listas e constantes. Nao ha
chamada HTTP, API, autenticacao real ou banco de dados nesta entrega.

## Perguntas sobre formulario e ciclo de vida

### 22. Como o formulario e validado?

O formulario possui uma `GlobalKey<FormState>`. Ao enviar, o codigo chama
`validate()`, que executa o `validator` de cada campo. Se algum valor for invalido,
a funcao retorna antes de concluir o envio.

### 23. Quais validacoes foram implementadas?

- Nome com pelo menos tres caracteres.
- E-mail contendo `@` e ponto.
- Matricula com pelo menos cinco caracteres.
- Selecao obrigatoria de uma materia.

A verificacao de e-mail e intencionalmente simples; em producao poderia ser mais
robusta e tambem validada pelo servidor.

### 24. O formulario envia os dados para algum servidor?

Nao. Depois da validacao, ele registra os valores com `debugPrint` e mostra uma
`SnackBar` de sucesso. A integracao com API e persistencia ficou fora do escopo.

### 25. Para que servem os `TextEditingController`?

Eles permitem ler e controlar o texto dos campos. Sao descartados no metodo
`dispose()` para liberar os recursos quando a tela sai da arvore de widgets.

### 26. Para que servem `initState` e `dispose`?

`initState` executa uma vez quando o estado e criado, sendo usado para iniciar
valores e recursos. `dispose` e chamado ao remover a tela e serve para liberar
controllers, timers e outros recursos.

### 27. Por que o splash verifica `mounted`?

O splash usa um `Timer`. Quando ele termina, a tela pode ja ter sido removida.
`mounted` confirma que o estado ainda esta ligado a arvore antes de usar o
`context` para navegar.

## Perguntas sobre interface e qualidade

### 28. Como o visual e padronizado?

O arquivo `app_theme.dart` centraliza paleta, tipografia, campos, botoes e estilo
da `AppBar`. O `MaterialApp` recebe esse tema, evitando repetir configuracoes em
todas as telas.

### 29. O projeto usa Material Design?

Sim. O tema habilita `useMaterial3: true`, e o aplicativo usa componentes como
`Scaffold`, `AppBar`, `NavigationBar`, `Card`, `SnackBar` e botoes Material.

### 30. Houve reutilizacao de componentes?

Sim. Exemplos sao `StellarBackground`, `StellarLogo`, `CourseCard`,
`HomeworkTile` e o shell compartilhado das telas de recuperacao de senha. Isso
reduz duplicacao e mantem o visual consistente.

### 31. O aplicativo usa imagens externas?

Nao. A interface atual e construida principalmente com widgets, cores e icones do
Material. Por isso o `pubspec.yaml` nao declara arquivos de imagem em `assets`.

### 32. Existem dependencias externas?

Nao em tempo de execucao. O projeto usa o SDK do Flutter e seus componentes. Em
desenvolvimento, usa `flutter_test` para testes e `flutter_lints` para analise de
qualidade.

### 33. Existem testes automatizados?

Sim. Ha um teste de widget que percorre o fluxo principal: abre o aplicativo,
aguarda o splash, avanca pelo onboarding, entra pelo login e verifica elementos do
dashboard. A cobertura ainda pode ser ampliada para formularios, navegacao e
diferentes tamanhos de tela.

### 34. Qual foi a referencia de design?

O projeto foi adaptado do Stellar School Mobile App UI Kit do Figma. A estrutura
visual foi mantida como referencia e o conteudo foi direcionado ao aplicativo de
aprendizagem Fluently.

## Perguntas criticas e respostas honestas

### 35. Quais sao as principais limitacoes atuais?

Nao ha backend, persistencia, login real, consumo de API ou gerenciamento global
de estado. Alguns fluxos sao demonstrativos, como OTP, avaliacao e inscricao. A
responsividade tambem pode ser expandida para tablets, desktop e orientacao
horizontal.

### 36. O que voces fariam em uma proxima versao?

Integrariamos autenticacao e API, persistencia local, tratamento de erros e
carregamento, testes mais amplos, acessibilidade e breakpoints centralizados para
tablet e desktop.

### 37. Por que nao foi usado Provider, BLoC ou outro gerenciador de estado?

Porque o estado atual e pequeno e pertence principalmente a cada tela. Adicionar
uma biblioteca agora aumentaria a complexidade sem necessidade. Ela passaria a
fazer sentido com autenticacao real e dados compartilhados entre varias telas.

### 38. Por que algumas informacoes estao em ingles e outras em portugues?

O design original e de um aplicativo de aprendizagem de ingles e parte do
conteudo visual foi preservada. As telas academicas adicionadas usam portugues.
Em uma versao de producao, o ideal seria centralizar todos os textos e aplicar
internacionalizacao.

### 39. O nome e Fluently ou Stellar School?

O produto apresentado ao usuario e o Fluently. `Stellar School` permanece em
alguns identificadores e textos herdados da referencia visual e da primeira
estrutura do projeto. Uma etapa futura de acabamento deve uniformizar essa
nomenclatura.

### 40. O codigo esta pronto para producao?

Ele atende ao objetivo de prototipo academico de interface e navegacao. Para
producao ainda seriam necessarios backend, seguranca, persistencia, acessibilidade,
testes adicionais, observabilidade e tratamento completo de falhas.

## Mapa rapido para demonstracao

| Assunto | Arquivo principal |
| --- | --- |
| Entrada e tema global | `lib/main.dart` |
| Cores e estilos | `lib/theme/app_theme.dart` |
| Splash e timer | `lib/views/welcome_view.dart` |
| PageView e estado | `lib/views/onboarding_views.dart` |
| Login responsivo | `lib/views/sign_in_view.dart` |
| Dashboard e rolagem | `lib/views/dashboard_view.dart` |
| Menu e navegacao | `lib/views/menu_view.dart` |
| Breakpoint da grade | `lib/views/courses_view.dart` |
| Passagem do objeto | `lib/views/course_detail_view.dart` |
| Formulario e validacao | `lib/views/enrollment_form_view.dart` |
| Modelo e dados estaticos | `lib/models/course.dart` |
| Teste do fluxo principal | `test/widget_test.dart` |

## Dicas para responder durante a apresentacao

- Comece pela resposta direta e depois mostre o exemplo no codigo.
- Nao diga que `LayoutBuilder` resolve tudo: ele fornece as restricoes.
- Nao afirme que existe backend, banco de dados ou autenticacao real.
- Diferencie "evitar overflow" de "ter um layout especifico para cada tela".
- Ao falar de uma limitacao, explique tambem como ela poderia ser evoluida.
- Se nao souber um detalhe, localize o arquivo pelo mapa acima e descreva o que o
  codigo realmente faz.
