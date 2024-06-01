# ApiSshManager

*Uma Api para gerenciamento Ssh, crie seus projetos e mantenha a segurança !*

### Tabela de Conteúdos

- [Instalação](#instalação)
- [Scripts Testados e Suportados](#scripts-suportados)
- [Uso](#uso)
- [Créditos](#créditos)

## Instalação

Para fazer a instalação rode o seguinte comando:
```bash <(wget -qO- https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/install.sh)```


## Scripts Testados e Suportados
- DragonCoreSsh
- Kirito (SshPlus)

## Uso

#### Criar Usuario
- Requisição para usar **POST**
- Tipo do PostDATA a enviar **JSON**
- Exemplo:
    ```cgo
    POST -> http://localhost:8080/add_user
    PostData -> {
        "user": "usuario"
        "pass": "senha"  
        "limit": "limite"  
        "validity": "dias"  
    }
    Em "user" será o usuario a ser criado
    Em "pass" será a senha para o usuario a ser criado
    Em "limit" será o limite de conexões para o usuario a ser criado
    Em "validity" será a validade em dias para o  usuario a ser criado
  
    ``` 
#### Deletar Usuario
- Requisição para usar **GET**
- Tipo do dados a enviar **Query Parameters**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/del_user?user=usuario 
    Em "usuario" será o usuario a ser removido    ^
  
    ``` 
  
#### Gerar Teste
- Requisição para usar **GET**
- Tipo do dados a enviar **Query Parameters**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/gen_test?minutes=validade 
    Em "validade" será a validade do teste a ser criado ^
    (a validade tem que ser em minutos)
    ``` 


#### Alterar senha do Usuario
- Requisição para usar **POST**
- Tipo do PostDATA a enviar **JSON**
- Exemplo:
    ```cgo
    POST -> http://localhost:8080/chg_pass
    PostData -> {
        "user": "usuario"
        "pass": "novaSenha"
    }
    Em "user" será o usuario que deseja fazer a alteração da senha
    Em "pass" será a nova senha para o usuario
    ``` 

#### Alterar limite de conexões do Usuario
- Requisição para usar **POST**
- Tipo do PostDATA a enviar **JSON**
- Exemplo:
    ```cgo
    POST -> http://localhost:8080/chg_limit
    PostData -> {
        "user": "usuario"
        "limit": "novoLimite"
    }
    Em "user" será o usuario que deseja fazer a alteração da senha
    Em "limit" será o novo limite de conexões para o usuario
    ``` 
  
#### Alterar validade do Usuario
- Requisição para usar **POST**
- Tipo do PostDATA a enviar **JSON**
- Exemplo:
    ```cgo
    POST -> http://localhost:8080/chg_val
    PostData -> {
        "user": "usuario"
        "validity": "novaValidade"
    }
    Em "user" será o usuario que deseja fazer a alteração da senha
    Em "validity" será a nova validade em dias para o usuario
    ``` 

#### Verificar limite do Usuario
- Requisição para usar **GET**
- Tipo do dados a enviar **Query Parameters**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/chk_limit?user=usuario 
    Em "usuario" o usuario a ser consultado
    ``` 

#### Verificar usuarios criados
- Requisição para usar **GET**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/created_users
    ``` 


#### Verificar usuarios online
- Requisição para usar **GET**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/online_users
    ``` 



#### Remover usuarios expirados
- Requisição para usar **GET**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/del_expired
    ``` 

#### Relatorio de usuarios
- Requisição para usar **GET**
- Exemplo:
    ```cgo
    GET -> http://localhost:8080/users_report
    ``` 


## Créditos
- `@UlekBR` -> *SshManager Developer* 