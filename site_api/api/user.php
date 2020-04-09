<?php

# cabeçalho da página para receber requisições do tipo JSON
# Especificação CORS (AUTH0)
header("Access-Control-Allow-Origin: *"); // libera tudo

# tipo do cabeçalho
header("Content-Type: application/json; charse=utf-8");

# recupera as informações enviadas via serviço
$json = file_get_contents("php://input");

# decodifica os dados enviados no formato JSON para um objeto PHP
$obj = json_decode($json);

# tratar algum erro de requisição
# O nome do operador "=>" é: arrow
if ($obj === null && json_last_error() !== JSON_ERROR_NONE) {
    print(json_encode(
        ["Mensagem:" => "Incorrect Request"] # associativo
    ));
    die(); # para o processo 
}

# Incluindo/importando o arquivo do Modelo do Usuário
include("class/UserModel.php");

# criar um novo usuário - objeto UserModel()
# formato do payload:
# {"type":"new", "name":"Edson Melo de Souza", "user":"edson.melo", "password":"edson123"}
try {
    $user = new UserModel();

    # verificar se os dados foram enviados corretamente
    if (empty($obj->name) == true || empty($obj->user) == true || empty($obj->password) == true) {
        print(json_encode(["Mensagem:" => "Invalid data"]));
        die();
    }

    # chama o método que insere no banco
    $result = $user->new($obj->name, $obj->user, $obj->password);

    # verifica o retorno do método
    if ($result != null) {
        print(json_encode(["Mensagem:" => $result]));
    } else {
        print(json_encode(["Mensagem:" => "User creation failed"]));
    }
} catch (Exception $ex) {
    print(json_encode(["Mensagem:" => $ex->getMessage()]));
}