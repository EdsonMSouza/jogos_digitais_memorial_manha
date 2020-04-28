<?php
header("Access-Control-Allow-Origin: *"); // libera tudo
header("Content-Type: application/json; charset=utf-8");

$json = file_get_contents("php://input");
$obj = json_decode($json);
if ($obj === null && json_last_error() !== JSON_ERROR_NONE) {
    print(json_encode(
        ["Mensagem:" => "Incorrect Request"] # associativo
    ));
    die(); # para o processo 
}
include("class/GameModel.php");

switch ($obj->type) {
    case 'new':
        try {
            $game = new GameModel();
            # {"type":"new", "user_id":1}
            $result = $game->new($obj->user_id);

            if ($result != null) { # sucesso na criação do jogo
                print(json_encode(["ID Game Created" => $result]));
            } else {
                print(json_encode(["Mensagem" => "Game creation failed"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["Mensagem" => $ex->getMessage()]));
        }
        break;

    case 'save':
        try {
            $game = new GameModel();
            # {"type":"save", "game_id":1, "score":50}
            $result = $game->save($obj->game_id, $obj->score);

            if ($result != null) { # sucesso no salvamento do jogo
                print(json_encode(["Game Saved Successfully" => $result]));
            } else {
                print(json_encode(["Mensagem" => "Game save failed"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["Mensagem" => $ex->getMessage()]));
        }
        break;

    case 'ranking_general':
        try {
            $game = new GameModel();
            # {"type":"ranking_general"}
            $result = $game->rankingGeneral();

            if ($result != null) { # mostra o ranking
                print(json_encode($result));
            } else {
                print(json_encode(["Mensagem" => "No ranking to show"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["Mensagem" => $ex->getMessage()]));
        }
        break;
    case 'ranking_player':
        try {
            # cria uma instância do objeto UsuarioModel
            $game = new GameModel();

            # chama o método que verifica o login
            $result = $game->rankingByPlayer($obj->user_id);

            # verifica se foi retornado algum dado, se retornou, devolve um JSON com os dados 
            if ($result != null) {
                echo json_encode($result);
            } else {
                # senão envia uma mensagem de erro
                echo json_encode(["Mensagem" => "Erro ao recuperar o ranking do jogador"]);
            }
        } catch (Exception $ex) {
            # se ocorreu erros com o banco, devolve o erro
            echo json_encode(["Mensagem" => $ex->getMessage()]);
        }
        break;

    default:
        print(json_encode(["Mensagem:" => "Invalid data"]));
        break;
}
