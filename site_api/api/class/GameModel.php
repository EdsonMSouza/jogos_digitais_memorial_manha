<?php
include('PDOConnection.php');

class GameModel
{
    private static $pdo;

    function __construct()
    {
        self::$pdo = \PDOConnection::connection();
    }

    # estrutura da nossa classe
    /**
     * Cria um novo jogo
     */
    function new($userId)
    {
        try {
            $sql = "INSERT INTO games (user_id) VALUES (:userId)";
            $stmt = self::$pdo->prepare($sql);
            $stmt->bindValue(":userId", $userId, \PDO::PARAM_STR);

            $stmt->execute();

            # retorna o último ID criado na tabela
            return self::$pdo->lastInsertId();
        } catch (PDOException $ex) {
            throw $ex;
        }
    }

    /**
     * Salva/Atualiza um jogo criado anteriormente
     */
    function save($idGame, $score)
    {
    }

    /**
     * Retorna o ranking de todos os jogadores
     * Ou, se for apenas um usuário (mono), o seu ranking
     */
    function rankingGeneral()
    {
    }

    /**
     * Ranking por jogador
     */
    function rankingByUser($idUser)
    {
    }
}
