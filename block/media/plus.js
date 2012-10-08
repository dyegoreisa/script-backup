(function(jwplayer){

  var template = function(player) {
    function setup(evt) {
        $.ajax({
          type: "POST",
          url: "confirmar.php",
        });
    };
    player.onReady(setup);
    this.resize = function(width, height) {};
  };

  jwplayer().registerPlugin('plus', template);

})(jwplayer);


