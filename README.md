# pi

## Uma alternativa para mobilidade urbana 
O conceito central da aplicação é dar mais conforto a ciclistas fazendo a combinação de rotas, inicialmente divididas em 2 categorias: para ciclistas esportivos e para ciclistas casuais.

### Esportivo 
Neste modo ao escolher o ponto de partida e o de chegada a aplicação irá calcular o caminho mais rápido entre eles.

### Casual
Neste modo o ciclista será conduzido a uma rota mais segura sendo preferencial no calculo da rota: ciclovias e ruas pouco movimentadas que serão feitos com dados próprios da aplicação.

## Tecnologias usadas 
- Flutter 
- Provider 
- MapBox-gl
- MapBox API


## Instalação
Com o [flutter](https://flutter.dev/docs/get-started/install) instalado corretamente basta instalar as dependências com:


```bash
flutter pub get
```

e adicionar uma arquivo chamado keys.dart contendo:
```dart
const String MAPBOX_KEY = 'SUA_CHAVE_DO_MAPBOX';

```

## o que já foi feito?
- [X] Conexão e tratamento da aplicação com as apis mapbox
- [ ] Migrar do provider para o Bloc pattern 

## Contribuição
Qualquer contribuição será bem-vinda basta dar um pull request :)

## Licença
[MIT](https://choosealicense.com/licenses/mit/)
