$(function() {

  $('#lawyer-index a').on('click', function(e) {
    var $that = $(this);
    // Enable console logs for debugging
    // TB.setLogLevel(TB.DEBUG);

    // Initialize session, set up event listeners, and connect
    var sessionId = $that.data('opentok-session-id');
    var apiKey = $that.data('opentok-api-key');
    var token;
    $.post("/sessions/generate_token", { opentok_session_id: sessionId }, function(data) {
      token = data.token_id;
      var session = TB.initSession(sessionId);
      session.addEventListener('sessionConnected', sessionConnectedHandler);
      session.addEventListener('streamCreated', streamCreatedHandler);
      session.addEventListener("sessionDisconnected", sessionDisconnectHandler);
      session.connect(apiKey, token);
      function sessionConnectedHandler(event) {
        var publisherProperties = {width: 200, height:150};
        var publisher = TB.initPublisher(apiKey, 'self-video', publisherProperties);
        session.publish(publisher);
        // Subscribe to streams that were in the session when we connected
        subscribeToStreams(event.streams);
      }

      function sessionDisconnectHandler(event) {
        session.cleanup();
      }

      function streamCreatedHandler(event) {
        // Subscribe to any new streams that are created
        subscribeToStreams(event.streams);
      }

      function subscribeToStreams(streams) {
        for (var i = 0; i < streams.length; i++) {
          // Make sure we don't subscribe to ourself
          if (streams[i].connection.connectionId == session.connection.connectionId) {
            return;
          }
          // Create the div to put the subscriber element in to
          var div = document.createElement('div');
          div.setAttribute('id', 'stream' + streams[i].streamId);
          $('#lawyer-video-container').append(div);
          // Subscribe to the stream
          session.subscribe(streams[i], div.id, { width: 750, height: 500});
        }
      }

      $('#video-modal').modal({
        keyboard: false,
        backdrop: "static",
      });

      $('#video-modal').on('hide', function() {
        session.disconnect();
      });
      $('#video-modal').modal('show');
    });
  });

  if($('#lawyer-show').length > 0) {

    console.log("found lawyer-show");
     var $that = $("#lawyer-show");
     // Enable console logs for debugging
     // TB.setLogLevel(TB.DEBUG);

     // Initialize session, set up event listeners, and connect
     var sessionId = $that.data('opentok-session-id');
     var apiKey = $that.data('opentok-api-key');
     var token = $that.data('opentok-token-id');

     var session = TB.initSession(sessionId);
     session.addEventListener('sessionConnected', sessionConnectedHandler);
     session.addEventListener('streamCreated', streamCreatedHandler);
     session.connect(apiKey, token);
     function sessionConnectedHandler(event) {
       var publisherProperties = {width: 200, height:150};
       var publisher = TB.initPublisher(apiKey, 'self-video', publisherProperties);
       session.publish(publisher);
       // Subscribe to streams that were in the session when we connected
       subscribeToStreams(event.streams);
     }

     function streamCreatedHandler(event) {
       // Subscribe to any new streams that are created
       subscribeToStreams(event.streams);
     }

     function subscribeToStreams(streams) {
       for (var i = 0; i < streams.length; i++) {
         // Make sure we don't subscribe to ourself
         if (streams[i].connection.connectionId == session.connection.connectionId) {
           return;
         }
         // Create the div to put the subscriber element in to
         var div = document.createElement('div');
         div.setAttribute('class', "subscriber")
         div.setAttribute('id', 'stream' + streams[i].streamId);
         $('#customer-video-container').append(div);
         // Subscribe to the stream
         session.subscribe(streams[i], div.id, { width: 750, height: 500});
       }
     }
   };
});