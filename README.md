# Rede Nacional de Vacinação Blockchain

## Apresentações

A mais recente pandemia, COVID-19, tem demonstrado a importancia da vacinação como uma barreira imunológica da população.  Os casos de coronavirus tem crescido exponencialmente pelo mundo sobrecarregando e levando ao colapso dos Sistemas de Saúde de diversos países.
Entretanto, diversas doenças (Gripe comum, H1N1, entre outras), que se conhece e se fabrica vacinas, estão a competir pelos leitos hospitalares e complicar a identificação da COVID-19 pelo Brasil, complicando a disponibilidade de recursos para combater a dissiminação.
O recente caso de Sarampo, em São Paulo, tem demonstrado a dificuldade de controlar a imunidade da população, até mais que ainda hoje usa-se cardenetas impressas para controlar a vacinação individual de cada cidadão.

O sistema de saude de um Pais depende do trabalho conjunto de diversas organizações. Governo Federal e Estadual, rede publica e privada de saude, secretarias e ministério da saude. São diversas formas de coletar, registrar e compartilhar dados entre os participantes. Possiveis problemas com padronização da informação e disponibilidade de serviços podem gerar atrasos, erros nos dados e falta de confiança das origens das informações. O uso de uma rede blockchain vem para se livrar dos problemas citados.

[![video](https://ml6pvb0mhylj.i.optimole.com/MPs4gQ-xHzU2UWU/w:auto/h:auto/q:auto/https://dudeagency.io/wp-content/uploads/2017/06/video-overlay.png)](https://www.youtube.com/watch?v=Snw2Y8gnv0g)

## Hyperledger

A pasta network é derivada do repositório oficial do [Hyperledger Fabric](https://github.com/hyperledger/fabric-samples). Para o funcionamento é necessário instalar os pré requisitos a partir da [documentação oficial](https://hyperledger-fabric.readthedocs.io/en/latest/install.html).

Nesta rede há (até o momento) duas organizações.
- Governo Federal (brasil-governofederal-msp)
- Sistema Único de Saude (sus-unidadesaude-msp)

Para iniciar a rede, uma vez que tenha instalado os pré requisitos, vá até /network/RNVB-network e execute:
- `./network.sh up`
- `./network.sh createChannel`

Caso queira derrumar a rede:
- `./network.sh down`

## Chaincode

Chaincode está sendo construido em Typescript, para tal é necessário a versão 1.4.x ou posterior do Fabric. A estrutura básica foi gerada com a ajuda da extensão IBM Blockchain Platform para VSCode.

Para fazer o deploy do chaincode (Após ter criado a rede), execute:
- `./network.sh deployCC -l typescript -v 1` onde o argumento de -v é a versão que será instalado o chaincode.

Sempre que for deployar um novo chaincode, lembre de incrementar o numero da versão.

### Contratos

O projeto conta até o momento com os seguintes contratos:

* USContrato -> SmartContract para as organizações dos tipos Unidades de Saude.
    - Responsavel por aplicar a vacina.
* GovernoContrato -> SmartContract para o Governo.
    - Responsavel por cadastrar a Caderneta e a Vacina.
