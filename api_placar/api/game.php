<?php
header("Access-Control-Allow-Origin: *"); // libera tudo
header("Content-Type: application/json; charset=utf-8");

$json = file_get_contents("php://input");
$obj = json_decode($json);

if ($obj === null && json_last_error() !== JSON_ERROR_NONE) {
    print(json_encode(["data" => "err", "value" => "incorrect_request"]));
    die(); # para o processo 
}
include("class/GameModel.php");

switch ($obj->type) {
    case 'new':
        try {
            $game = new GameModel();
            # {"type":"new", "user_id":1}
            $result = $game->new($obj->user_id);

            if ($result != null) { # sucesso na criação do jogo -> retorna o ID do jogo criado
                print(json_encode(["data" => "game_created", "value" => $result]));
            } else {
                print(json_encode(["data" => "err", "value" => "game_create_failed"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["data" => "err", "value" => $ex->getMessage()]));
        }
        break;

    case 'save':
        try {
            $game = new GameModel();
            # {"type":"save", "game_id":1, "score":50}
            $result = $game->save($obj->game_id, $obj->score);

            if ($result != null) { # sucesso no salvamento do jogo
                print(json_encode(["data" => "ok", "value" => "game_saved"]));
            } else {
                print(json_encode(["data" => "err", "value" => "game_save_failed"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["data" => "err", "value" => $ex->getMessage()]));
        }
        break;

    case 'ranking_general':
        try {
            $game = new GameModel();
            # {"type":"ranking_general"}
            $result = $game->rankingGeneral();

            if ($result != null) { # retorna o ranking
                #$result["data"] = "ok";
                print(json_encode($result));
            } else {
                print(json_encode(["data" => "err", "value" => "no_ranking_to_show"]));
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
                print(json_encode($result));
            } else {
                # senão envia uma mensagem de erro
                print(json_encode(["data" => "err", "value" => "ranking_recover_error"]));
            }
        } catch (Exception $ex) {
            # se ocorreu erros com o banco, devolve o erro
            print(json_encode(["data" => "err", "value" => $ex->getMessage()]));
        }
        break;

    default:
        print(json_encode(["data" => "err", "value" => "invalid_data"]));
        break;
}
