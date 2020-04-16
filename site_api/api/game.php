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
            
            if($result != null){ # sucesso na criação do jogo
                print(json_encode(["ID Game Created" => $result]));
            }else{
                print(json_encode(["Mensagem" => "Game creation failed"]));
            }
        } catch (Exception $ex) {
            print(json_encode(["Mensagem" => $ex->getMessage()]));
        }
        break;

    case 'save':
        try {
        } catch (Exception $ex) {
            throw $ex;
        }
        break;

    case 'ranking_general':
        try {
        } catch (Exception $ex) {
            throw $ex;
        }
        break;

    default:
        print(json_encode(["Mensagem:" => "Invalid data"]));
        break;
}
