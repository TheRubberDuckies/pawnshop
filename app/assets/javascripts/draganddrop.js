// added drop piece code back to this file
$(".pieces.show").ready(function(){
  var whitePieces = $("#piece[data-color='white']");
  var blackPieces = $("#piece[data-color='black']");
  var pieceHTML;
  var pieceId;
  var pieceMovedType;
  var startX;
  var startY;
  var gameId = $("div#gameId").attr("data-game-id");
  var gameState = $("div#gameState").attr("data-game-state");

  whitePieces.draggable({
    containment: "#chessboard tbody",
    cursor: "move",
  });
  blackPieces.draggable({
    containment: "#chessboard tbody",
    cursor: "move",
  });

  var currentUserId = $("#currentUser").attr("data-current-user-id");
  var whitePlayerId = $("#whitePlayer").attr("data-white-player-id");
  var blackPlayerId = $("#blackPlayer").attr("data-black-player-id");

  var setPlayerTurn = function(whitePlayerTurn){
    if (whitePlayerTurn == undefined){
      whitePieces.draggable().draggable("destroy");
      blackPieces.draggable().draggable("destroy");
    }
    if (whitePlayerTurn == true && currentUserId == whitePlayerId){
      whitePieces.draggable().draggable("enable");
      blackPieces.draggable().draggable("disable");
    }
    if (whitePlayerTurn == true && currentUserId != whitePlayerId){
      whitePieces.draggable().draggable("disable");
      blackPieces.draggable().draggable("disable");
    }
    if (whitePlayerTurn == false && currentUserId == blackPlayerId){
      whitePieces.draggable().draggable("disable");
      blackPieces.draggable().draggable("enable");
    }
    if (whitePlayerTurn == false && currentUserId != blackPlayerId){
      whitePieces.draggable().draggable("disable");
      blackPieces.draggable().draggable("disable");
    }
  }

  gon.watch("white_player_turn", setPlayerTurn)

  whitePieces.mousedown(function(e){
    pieceHTML = $(e.target);
    pieceId = $(e.target).attr('data-id');
    pieceColor = $(e.target).attr('data-color');
    pieceMovedType = $(e.target).attr('data-type');
    startX = $(e.target).attr('data-x');
    startY = $(e.target).attr('data-y');
  });

  blackPieces.mousedown(function(e){
    pieceHTML = $(e.target);
    pieceId = $(e.target).attr('data-id');
    pieceColor = $(e.target).attr('data-color');
    pieceMovedType = $(e.target).attr('data-type');
    startX = $(e.target).attr('data-x');
    startY = $(e.target).attr('data-y');
  });

  $('td').droppable(
    // { accept: pieces },
    // { accept: whitePieces },
    // { accept: blackPieces },
    {drop: function(e){
      var destSqIdNum = parseInt(e.target.id);
      var destSqX = Math.trunc(destSqIdNum / 10);
      var destSqY = destSqIdNum % 10;
      var isEnPassantCapture = $(e.target).children().length == 0 && Math.abs(destSqX - startX) == 1 && Math.abs(destSqY - startY) == 1 && pieceMovedType == "Pawn";
      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: {
          piece: { id: pieceId, x_position: destSqX, y_position: destSqY } 
        },
        
          // Called when there's incoming data on the websocket for this channel
          // data represents the updated game, including all its pieces. (todo: make sure that game includes all pieces)
          // loop through all pieces in the DOM, and update position/remove based on game.pieces.
          // check game.status and end the game and display game over message as appropriate

        error: function(jqXHR){
          alert(jqXHR.responseJSON.error);
          $(pieceHTML).css({"top":"initial", "left":"initial"});
          $(pieceHTML).addClass('ui-draggable ui-draggable-handle')
        },
      })
    }}
  )
  
});
