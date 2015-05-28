function DoVideo(video) {
  this.media = new Media(video);
  this.media_controller = null;

  // init video
  this.media.addEventsToDOM("events");
  this.media.addPropertiesToDOM("properties");
  this.media.initProgress("loadingStatus", "videoDuration");
  this.media.initTimeUpdate('videoCurrentTime', 'videoFrame');
  //media.initPlayThrough();

  // properties are updated even if no event was triggered
  setInterval(this.update.bind(this), 250);
}

DoVideo.prototype.update = function () {
  if (this.media !== null) {
    this.media.update();
  }
  if (this.media_controller !== null) {
    this.media_controller.update();
  }
}

function uploadMarkedObjects(url, s) {
  var dump = s.dumpShapeRanges();
  if (dump.length === 0) {
    alert("Nothing to upload.  Create mark and bind time.")
  } else {
    var payload = JSON.stringify(dump);
    var c = confirm('Confirm upload of ' + payload);
    if (c) {
      // do upload
      try {
        $.ajax({
          url: url,
          type: "POST",
          data: {'data': payload},
          //contentType: "application/json; charset=utf-8",
          contentType: "application/x-www-form-urlencoded; charset=utf-8",
          dataType: "json",
          success: function (html) {
            console.log("Upload successful!" + JSON.stringify(html));
          },
          error: function (request, status, error) {
            console.log("Upload error!" + JSON.stringify(status) + ' ' + error);
          },
          complete: function () {
            console.log("Upload complete!");
          }
        });
      } catch (e) {
        console.log(e);
      }

    }
  }
}
