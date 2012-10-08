<?php
    session_start();
    $_SESSION['player'] = rand(1483,9304);
?>
<script type='text/javascript' src='media/jwplayer.js'></script>
<script type='text/javascript' src='media/jquery-1.8.2.min.js'></script>

<div id='mediaspace'>This text will be replaced</div>

<script type='text/javascript'>
    jwplayer('mediaspace').setup({
        'flashplayer': 'player.swf',
        'file': '<?php echo $_SESSION['player']; ?>_video.mp4',
        'controlbar': 'bottom',
        'width': '470',
        'height': '320',
        'plugins': './media/plus.js'
    });
</script>
