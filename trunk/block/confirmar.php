<?php
    session_start();
    $_SESSION['confirmar'] = $_SESSION['player'];
    unset($_SESSION['player']);
?>
