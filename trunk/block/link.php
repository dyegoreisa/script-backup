<?php
session_start();

define('DIR', '/var/www/player/block/videos');

$path_parts = pathinfo($_GET['pathinfo']);
$file = $path_parts['basename'];

list($sessao, $video) = explode("_", $file);

$video = DIR . '/' .  $video;

$player = $_SESSION['confirmar'];
unset($_SESSION['confirmar']);

if ($player == $sessao) {
    unset($player);
    if (file_exists($video)) {
        header("Content-Type: video/x-flv");  
        header("Accept-Ranges: bytes");  
        header("Content-Length: ".filesize($video));  
        header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past  
        readfile($video);
    } else {
        // Vídeo não existe
        header("HTTP/1.0 404 Not Found");
    }
} else {
    // Sessão não existe
    header("HTTP/1.0 404 Not Found");
}
