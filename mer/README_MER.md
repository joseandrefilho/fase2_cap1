
# FIAP - Faculdade de Informática e Administração Paulista

<p align="center">
<a href= "https://www.fiap.com.br/"><img src="assets/logo-fiap.png" alt="FIAP - Faculdade de Informática e Admnistração Paulista" border="0" width=40% height=40%></a>
</p>

<br>

# Modelo Entidade-Relacionamento (MER) e Diagrama Entidade-Relacionamento (DER)

## Descrição

Esta pasta contém os arquivos do **Modelo Entidade Relacionamento (MER)** e o **Diagrama Entidade Relacionamento (DER)** do sistema de sensoriamento agrícola **FarmTech Solutions**. O MER e DER foram gerados utilizando a ferramenta **SQLModeler** e refletem a estrutura e os relacionamentos das entidades que compõem o banco de dados.

O objetivo do MER/DER é modelar de forma clara as entidades envolvidas no processo de coleta de dados de sensores agrícolas e a gestão das culturas, assim como os relacionamentos entre essas entidades.

### Entidades e Atributos:

#### 1. **T_CULTURA**
   - **Descrição**: Armazena informações sobre as culturas plantadas.
   - **Campos**:
     - `cd_cultura` (INT, Primary Key) — Código único da cultura.
     - `nm_cultura` (VARCHAR(100)) — Nome da cultura.
     - `dt_plantio` (DATETIME) — Data de plantio da cultura.
     - `vl_area_cultivo` (DECIMAL(10,2)) — Área de cultivo.

#### 2. **T_SENSOR**
   - **Descrição**: Armazena informações sobre os sensores utilizados para monitoramento das condições do solo.
   - **Campos**:
     - `cd_sensor` (INT, Primary Key) — Código único do sensor.
     - `ds_tipo_sensor` (VARCHAR(50)) — Tipo do sensor (umidade, pH, nutrientes).
     - `vl_latitude_sensor` (DECIMAL(9,6)) — Latitude da localização do sensor.
     - `vl_longitude_sensor` (DECIMAL(9,6)) — Longitude da localização do sensor.
     - `cd_cultura` (INT, Foreign Key) — Referencia a cultura monitorada pelo sensor.

#### 3. **T_LEITURA**
   - **Descrição**: Armazena as leituras realizadas pelos sensores.
   - **Campos**:
     - `cd_leitura` (INT, Primary Key) — Código único da leitura.
     - `dt_leitura` (DATETIME) — Data e hora da leitura.
     - `vl_valor_leitura` (DECIMAL(10,2)) — Valor da leitura (umidade, pH, nutrientes).
     - `cd_sensor` (INT, Foreign Key) — Referencia o sensor que realizou a leitura.

#### 4. **T_ALERTAS**
   - **Descrição**: Armazena os alertas gerados com base nas leituras dos sensores.
   - **Campos**:
     - `cd_alerta` (INT, Primary Key) — Código único do alerta.
     - `ds_tipo_alerta` (VARCHAR(100)) — Tipo de alerta (umidade baixa, pH fora do normal).
     - `dt_alerta` (DATETIME) — Data e hora do alerta.
     - `cd_sensor` (INT, Foreign Key) — Referencia o sensor que gerou o alerta.

#### 5. **T_TIPO_PRODUTO**
   - **Descrição**: Armazena os tipos de produtos aplicados nas culturas, como fertilizantes, pesticidas e água.
   - **Campos**:
     - `cd_tipo_produto` (INT, Primary Key) — Código único do tipo de produto.
     - `ds_tipo_produto` (VARCHAR(100)) — Descrição do tipo de produto.
     - `ds_unidade_medida` (VARCHAR(20)) — Unidade de medida padrão (litros, quilos, etc.).

#### 6. **T_APLICACAO**
   - **Descrição**: Armazena informações sobre as aplicações de produtos nas culturas.
   - **Campos**:
     - `cd_aplicacao` (INT, Primary Key) — Código único da aplicação.
     - `dt_aplicacao` (DATETIME) — Data e hora da aplicação.
     - `vl_quantidade_aplicada` (DECIMAL(10,2)) — Quantidade aplicada.
     - `cd_cultura` (INT, Foreign Key) — Referencia a cultura que recebeu a aplicação.
     - `cd_tipo_produto` (INT, Foreign Key) — Referencia o tipo de produto aplicado.

#### 7. **T_IRRIGACAO**
   - **Descrição**: Armazena os eventos de irrigação das culturas.
   - **Campos**:
     - `cd_irrigacao` (INT, Primary Key) — Código único da irrigação.
     - `dt_irrigacao` (DATETIME) — Data e hora da irrigação.
     - `vl_quantidade_agua_aplicada` (DECIMAL(10,2)) — Quantidade de água aplicada.
     - `cd_cultura` (INT, Foreign Key) — Referencia a cultura irrigada.

### Relacionamentos:

- **T_CULTURA** 1:N com **T_SENSOR**: Uma cultura pode ter vários sensores monitorando suas condições.
- **T_SENSOR** 1:N com **T_LEITURA**: Um sensor pode realizar várias leituras ao longo do tempo.
- **T_SENSOR** 1:N com **T_ALERTAS**: Um sensor pode gerar vários alertas ao longo do tempo.
- **T_CULTURA** 1:N com **T_APLICACAO**: Uma cultura pode receber várias aplicações de produtos ao longo do tempo.
- **T_CULTURA** 1:N com **T_IRRIGACAO**: Uma cultura pode ser irrigada várias vezes.
- **T_TIPO_PRODUTO** 1:N com **T_APLICACAO**: Um tipo de produto pode ser aplicado em várias culturas.

---

# Observações Importantes do Modelo

### 1. **Sobre a Obrigatoriedade de Campos**
   - Todos os campos marcados com um asterisco (*) são obrigatórios. Esses campos não podem aceitar valores nulos (NOT NULL) para garantir que informações essenciais, como datas de aplicação, quantidade de produto e coordenadas de localização de sensores, sejam sempre preenchidas.
   - A obrigatoriedade foi aplicada com o objetivo de assegurar a consistência e integridade dos dados críticos no sistema.

### 2. **Sobre a Localização dos Sensores**
   - A localização dos sensores (`vl_latitude_sensor`, `vl_longitude_sensor`) é obrigatória para cada sensor. Isso garante que todos os dados coletados possam ser georreferenciados, o que é crucial para análises de produtividade e condições do solo baseadas em geolocalização.
   - A presença de dados georreferenciados facilita a geração de mapas de calor e análises espaciais de dados agrícolas.

### 3. **Sobre as Relações 1:N**
   - As relações **1:N** entre as tabelas (ex: entre **T_CULTURA** e **T_IRRIGACAO**, ou **T_APLICACAO**) permitem o registro de múltiplos eventos de irrigação ou aplicação de produtos para a mesma cultura ao longo do tempo, refletindo a natureza repetitiva e cíclica dessas atividades no contexto de gestão agrícola.
   - Isso assegura que o sistema possa lidar com os diferentes ciclos de manejo da cultura sem a necessidade de redundância de dados.

### 4. **Sobre a Tabela de Produtos**
   - A tabela **T_TIPO_PRODUTO** permite adicionar novos tipos de produtos (ex: fertilizantes, pesticidas) de maneira modular, sem a necessidade de modificar a estrutura do modelo. Isso facilita a manutenção do sistema conforme novos insumos forem introduzidos ou adotados na agricultura.
   - A tabela também permite associar a unidade de medida correta para cada tipo de produto, promovendo a padronização e a consistência nos registros de quantidade aplicada.

### 5. **Sobre a Possibilidade de Campos Opcionais**
   - Alguns campos, como a `dt_plantio` na tabela **T_CULTURA**, são opcionais. Isso permite o registro de culturas ainda não plantadas, facilitando a inserção de dados em planejamentos antecipados ou em situações onde a data de plantio não é imediata.
   - A flexibilidade de campos opcionais permite um registro gradual e dinâmico dos dados agrícolas, acomodando a variabilidade do processo de plantio.

### 6. **Sobre a Unidade de Medida nos Produtos**
   - A unidade de medida associada aos produtos na tabela **T_TIPO_PRODUTO** garante a padronização dos valores aplicados. Isso assegura que as quantidades de insumos como fertilizantes, pesticidas e água sejam registradas de forma consistente e correta, facilitando a análise posterior.
   - A presença de unidades de medida específicas para cada produto facilita a compatibilidade dos dados com relatórios e ferramentas de análise externas.

---

## Constraints Definidas no Sistema

### 1. **Unique Constraint no Nome da Cultura**
   - **Tabela**: `T_CULTURA`
   - **Campo**: `nm_cultura`
   - **Regra**: O nome da cultura deve ser único, garantindo que não existam duas culturas com o mesmo nome.
   
### 2. **Check Constraint para Quantidade Aplicada**
   - **Tabela**: `T_APLICACAO`
   - **Campo**: `vl_quantidade_aplicada`
   - **Regra**: A quantidade aplicada deve ser maior que 0.

### 3. **Check Constraint para Latitude e Longitude dos Sensores**
   - **Tabela**: `T_SENSOR`
   - **Campos**: `vl_latitude_sensor`, `vl_longitude_sensor`
   - **Regras**:
     - A latitude deve estar no intervalo entre -90 e 90.
     - A longitude deve estar no intervalo entre -180 e 180.

### 4. **Default Constraint para Definir Data Atual como Valor Padrão**
   - **Tabela**: `T_LEITURA`
   - **Campo**: `dt_leitura`
   - **Regra**: A data de leitura será definida como a data e hora atuais (`CURRENT_TIMESTAMP`) por padrão.

---

## Estrutura de Arquivos

Nesta pasta, você encontrará os seguintes arquivos:
- **MER.sql**: Script SQL contendo a estrutura do banco de dados com as entidades e seus relacionamentos.
- **DER.png**: Imagem representando o Diagrama Entidade Relacionamento (DER) gerado pelo **SQLModeler**.
- **MER.pdf**: Documento PDF gerado pelo SQLModeler com o diagrama detalhado do MER.
  
## Instruções para Uso

1. O arquivo **MER.sql** pode ser utilizado para criar as tabelas no banco de dados. Basta executá-lo no sistema de gerenciamento de banco de dados que você estiver utilizando (MySQL, Oracle, etc.).
   
2. A imagem **DER.png** fornece uma visualização gráfica dos relacionamentos entre as entidades, sendo uma representação visual do modelo implementado no banco de dados.

3. O arquivo **MER.pdf** é uma versão detalhada do modelo de entidade-relacionamento, que pode ser usado para consulta durante o desenvolvimento do sistema.

## Ferramenta Utilizada

- **SQLModeler**: Ferramenta utilizada para a criação do MER e DER. Você pode acessar mais informações sobre o SQLModeler em [SQLModeler GitHub](https://github.com/ondras/wwwsqldesigner).

