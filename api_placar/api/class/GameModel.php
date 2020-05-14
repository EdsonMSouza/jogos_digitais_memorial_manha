<?php
include('PDOConnection.php');

class GameModel
{
    private static $pdo;

    function __construct()
    {
        self::$pdo = \PDOConnection::connection();
    }

    function new($userId)
    {
        try {
            $sql = "INSERT INTO games (user_id) VALUES (:userId)";
            $stmt = self::$pdo->prepare($sql);
            $stmt->bindValue(":userId", $userId, \PDO::PARAM_INT);

            $stmt->execute();

            # retorna o último ID criado na tabela
            # ID do jogo (game)
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
        try {
            $sql = "UPDATE games SET score = :score WHERE id = :idGame";
            $stmt = self::$pdo->prepare($sql);
            $stmt->bindValue(":score", $score, \PDO::PARAM_INT);
            $stmt->bindValue(":idGame", $idGame, \PDO::PARAM_INT);
            $stmt->execute();

            # verificar se foi realmente atualizado
            if ($stmt->rowCount() == 1) { # então atualizou algo
                return true;
            } else {
                return false;
            }
        } catch (PDOException $ex) {
            throw $ex;
        }
    }

    /**
     * Retorna o ranking de todos os jogadores
     * Ou, se for apenas um usuário (mono), o seu ranking
     */
    function rankingGeneral()
    {
        try {
            $sql = 'SELECT users.user AS User, max(games.score) AS Score
                    FROM games 
                    INNER JOIN users 
                    ON games.user_id = users.id 
                    GROUP BY users.name 
                    HAVING Score > 0 
                    ORDER BY Score DESC';

            $stmt = self::$pdo->prepare($sql);
            $stmt->execute();

            return $stmt->fetchAll(\PDO::FETCH_OBJ);
        } catch (PDOException $ex) {
            throw $ex;
        }
    }

    /**
     * Ranking por jogador 
     */
    public function rankingByPlayer($userId)
    {
        try {
            $sql = "SELECT users.user AS User, games.id AS IDGame, games.score AS Score
                    FROM games 
                    INNER JOIN users 
                    ON games.user_id = users.id 
                    WHERE games.user_id = :userId 
                    HAVING Score > 0 
                    ORDER BY Score DESC";

            $stmt = self::$pdo->prepare($sql);
            $stmt->bindValue(":userId", $userId, \PDO::PARAM_INT);
            $stmt->execute();

            return $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } catch (PDOException $ex) {
            throw $ex;
        }
    }
}
