// http://www.w3.org/2010/05/video/mediaevents.html
function Media(video) {
  this.video = video;

  // the following was extracted from the spec in October 2014
  this.events = new Array();
  this.events["loadstart"] = 0;
  this.events["progress"] = 0;
  this.events["suspend"] = 0;
  this.events["abort"] = 0;
  this.events["error"] = 0;
  this.events["emptied"] = 0;
  this.events["stalled"] = 0;
  this.events["loadedmetadata"] = 0;
  this.events["loadeddata"] = 0;
  this.events["canplay"] = 0;
  this.events["canplaythrough"] = 0;
  this.events["playing"] = 0;
  this.events["waiting"] = 0;
  this.events["seeking"] = 0;
  this.events["seeked"] = 0;
  this.events["ended"] = 0;
  this.events["durationchange"] = 0;
  this.events["timeupdate"] = 0;
  this.events["play"] = 0;
  this.events["pause"] = 0;
  this.events["ratechange"] = 0;
  this.events["resize"] = 0;
  this.events["volumechange"] = 0;

  // capture events
  for (var key in this.events) {
    video.addEventListener(key, this.capture.bind(this), false);
  }

  // seems like this should be rewritten like events, to save space
  this.properties = ["error", "src", "currentSrc", "crossOrigin", "networkState", "preload", "buffered", "readyState", "seeking", "currentTime", "duration",
    "paused", "defaultPlaybackRate", "playbackRate", "played", "seekable", "ended", "autoplay", "loop", "mediaGroup", "controller", "controls", "volume",
    "muted", "defaultMuted", "audioTracks", "videoTracks", "textTracks", "width", "height", "videoWidth", "videoHeight", "poster"];

  this.properties_elts = new Array(this.properties.length);

  // supported video types
  this.videoTypes = ["video/mp4", "video/webm"];

  // fps
  this.fps = 60;
}

Media.prototype.capture = function (event) {
  this.events[event.type]++;
}

Media.prototype.dumpPropertiesToObject = function () {
  var dump = {};

  for (var i = 0; i < this.properties.length; i++) {
    try {
      //var r = eval("this.video." + this.properties[i]);
      var r = this.video[this.properties[i]];
      //if (typeof r !== 'object' && r !== undefined) {
      dump[this.properties[i]] = r;
      //}
    } catch (e) {
      console.log(e);
    }
  }
  return dump;
}

Media.prototype.getPropertyValue = function (property) {
  return this.video[property];
}

Media.prototype.withFps = function (fps) {
  this.fps = fps;
  return this;
}

Media.prototype.hasController = function () {
  return (this.video.controller !== undefined && this.video.controller !== null);
}

Media.prototype.getController = function () {
  return this.video.controller;
}

// returns an object to control video
Media.prototype.instanceController = function () {
  if (this.hasController()) {
    return this.getController();
  } else {
    return this.video;
  }
}

///////////////////////////////////////////////////////////////////////////////
// Controls
///////////////////////////////////////////////////////////////////////////////

Media.prototype.setCurrentTime = function (time) {
  var controller = this.instanceController();
  controller.currentTime = time;
}

Media.prototype.addToCurrentTime = function (time) {
  var controller = this.instanceController();
  var currentTime = controller.currentTime;

  var newTime = (currentTime + time);
  newTime = newTime > 0 ? newTime : 0;

  // make currentTime discrete by making it an interval of fps
  var frames = Math.round(newTime * this.fps);
  var updatedTime = (frames / this.fps).toFixed(6);
  controller.currentTime = updatedTime;
}

Media.prototype.incrementCurrentTime = function (time) {
  this.addToCurrentTime(time);
}

Media.prototype.decrementCurrentTime = function (time) {
  this.addToCurrentTime(-time);
}

Media.prototype.play = function () {
  var controller = this.instanceController();
  controller.play();
}

Media.prototype.adjustPlaybackRate = function (rate) {
  var controller = this.instanceController();
  controller.playbackRate = rate;
}

Media.prototype.load = function () {
  var controller = this.instanceController();
  controller.load();
}

Media.prototype.pause = function () {
  var controller = this.instanceController();
  controller.pause();
}

Media.prototype.fullScreen = function () {
  var controller = this.instanceController();
  controller.webkitEnterFullscreen();
  controller.mozRequestFullScreen();
}

Media.prototype.switch = function (src_poster, src_mp4, src_webm) {
  if (src_poster === undefined || src_poster === null) {
    src_poster = '';
  }

  // cleanup current video w/o messing up listeners, etc
  this.video.textContent = '';

  this.video.setAttribute("poster", src_poster);

  if (src_mp4 !== undefined && src_mp4 !== null) {
    this.addVideoSource(src_mp4, "video/mp4");
  }

  if (src_webm !== undefined && src_webm !== null) {
    this.addVideoSource(src_webm, "video/webm");
  }

  this.load();
}

Media.prototype.addVideoSource = function (url, type) {
  var src = document.createElement("source");
  src.setAttribute("type", type);
  src.setAttribute("src", url);
  this.video.appendChild(src);
}

///////////////////////////////////////////////////////////////////////////////
// Initialize Event Listeners
///////////////////////////////////////////////////////////////////////////////

Media.prototype.initProgress = function (loadingStatus, videoLength) {
  this.loadingStatus = document.getElementById(loadingStatus);
  this.videoLength = document.getElementById(videoLength);
  this.video.addEventListener('progress', this.updateLoadingStatus.bind(this), false);
}

Media.prototype.updateLoadingStatus = function () {
  var percentLoaded = 0;
  var duration = this.getPropertyValue('duration');
  try {
    if (this.video.buffered.length > 0) {
      percentLoaded = parseInt(((this.video.buffered.end(0) / duration) * 100));
    }
  } catch (e) {
    console.log(e);
  }
  this.loadingStatus.innerHTML = percentLoaded + '%';
  if (this.videoLength !== null) {
    this.videoLength.innerHTML = duration;
  }
}

Media.prototype.initPlayThrough = function () {
  this.video.addEventListener('canplaythrough', this.play.bind(this), false);
}

Media.prototype.initTimeUpdate = function (timeUpdate, videoFrame) {
  this.timeUpdate = document.getElementById(timeUpdate);
  this.videoFrame = document.getElementById(videoFrame);
  this.video.addEventListener('timeupdate', this.updateCurrentTime.bind(this), false);
}

Media.prototype.updateCurrentTime = function () {
  var currentTime = this.getPropertyValue('currentTime');
  this.timeUpdate.innerHTML = currentTime;
  if (this.videoFrame !== null) {
    this.videoFrame.innerHTML = Math.round(currentTime * this.fps);
  }
}

Media.prototype.update = function () {
  for (var key in this.events) {
    var e = document.getElementById("e_" + key);
    if (e) {
      e.textContent = this.events[key];
      if (this.events[key] > 0) {
        e.className = "true";
      }
    }
  }

  for (var i = 0; i < this.properties.length; i++) {
    try {
      //var r = eval("this.video." + this.properties[i]);
      var r = this.video[this.properties[i]];
      //printString(r);
      this.properties_elts[i].textContent = r;
    } catch (e) {
      console.log(e);
    }
  }
}

Media.prototype.addEventsToDOM = function (bodyid) {
  var tbody = document.getElementById(bodyid);
  var i = 1;
  var tr = null;
  for (var key in this.events) {
    if (tr === null) {
      tr = document.createElement("tr");
    }

    var th = document.createElement("th");
    th.textContent = key;
    var td = document.createElement("td");
    td.setAttribute("id", "e_" + key);
    td.textContent = "0";
    td.className = "false";
    tr.appendChild(th);
    tr.appendChild(td);

    if ((i++ % 5) === 0) {
      tbody.appendChild(tr);
      tr = null;
    }
  }
  if (tr !== null) {
    tbody.appendChild(tr);
  }
}

Media.prototype.addPropertiesToDOM = function (bodyid) {
  var tbody = document.getElementById(bodyid);
  var tr = null;

  for (var i = 0; i < this.properties.length; i++) {
    if (tr === null) {
      tr = document.createElement("tr");
    }
    var th = document.createElement("th");
    th.textContent = this.properties[i];
    var td = document.createElement("td");
    td.setAttribute("id", "p_" + this.properties[i]);
    // var r = eval("this.video." + this.properties[i]);
    var r = this.video[this.properties[i]];
    td.textContent = r;
    if (typeof (r) !== "undefined") {
      td.className = "true";
    } else {
      td.className = "false";
    }
    tr.appendChild(th);
    tr.appendChild(td);
    this.properties_elts[i] = td;
    if (((i + 1) % 3) === 0) {
      tbody.appendChild(tr);
      tr = null;
    }
  }

  if (tr !== null) {
    tbody.appendChild(tr);
  }
}

Media.prototype.addMediaTypesToDOM = function (bodyid) {
  var tbody = document.getElementById(bodyid);
  var tr = document.createElement("tr");

  for (var i = 0; i < this.videoTypes.length; i++) {
    var td = document.createElement("th");
    td.textContent = this.videoTypes[i];
    tr.appendChild(td);
  }

  tbody.appendChild(tr);

  tr = document.createElement("tr");

  if (this.video.canPlayType) {
    for (var i = 0; i < this.videoTypes.length; i++) {
      var td = document.createElement("td");
      var support = this.video.canPlayType(this.videoTypes[i]);
      td.textContent = '"' + support + '"';
      if (support === "maybe") {
        td.className = "true";
      } else if (support === "") {
        td.className = "false";
      }
      tr.appendChild(td);
    }

    tbody.appendChild(tr);
  }
}

Media.prototype.updateTracks = function (textid, audioid, videoid) {
  if (textid !== null && this.video.textTracks !== undefined) {
    try {
      var td = document.getElementById(textid);
      td.textContent = this.video.textTracks.length;
      td.className = "true";
    } catch (e) {
      console.log(e);
    }
  }

  if (audioid !== null && this.video.audioTracks !== undefined) {
    try {
      var td = document.getElementById(audioid);
      td.textContent = this.video.audioTracks.length;
      td.className = "true";
    } catch (e) {
      console.log(e);
    }
  }

  if (videoid !== null && this.video.videoTracks !== undefined) {
    try {
      var td = document.getElementById(videoid);
      td.textContent = this.video.videoTracks.length;
      td.className = "true";
    } catch (e) {
      console.log(e);
    }
  }
}

function MediaController(controller) {
  this.controller = controller;

  this.events = new Array();
  this.events["emptied"] = 0;
  this.events["loadedmetadata"] = 0;
  this.events["loadeddata"] = 0;
  this.events["canplay"] = 0;
  this.events["canplaythrough"] = 0;
  this.events["playing"] = 0;
  this.events["ended"] = 0;
  this.events["waiting"] = 0;
  this.events["ended"] = 0;
  this.events["durationchange"] = 0;
  this.events["timeupdate"] = 0;
  this.events["play"] = 0;
  this.events["pause"] = 0;
  this.events["ratechange"] = 0;
  this.events["volumechange"] = 0;

  // capture listeners
  for (var key in this.events) {
    controller.addEventListener(key, this.capture.bind(this), false);
  }

  this.properties = ["readyState", "buffered", "seekable", "duration", "currentTime",
    "paused", "playbackState", "played", "defaultPlaybackRate", "playbackRate", "volume", "muted"];

  this.properties_elts = new Array(this.properties.length);
}

MediaController.prototype.capture = function (event) {
  this.events[event.type]++;
}

MediaController.prototype.getPropertyValue = function (property) {
  return this.controller[property];
}

MediaController.prototype.dumpPropertiesToObject = function () {
  var dump = new Array(this.properties.length);

  for (var i = 0; i < this.properties.length; i++) {
    try {
      //var r = eval("this.controller." + this.properties[i]);
      var r = this.controller[this.properties[i]];
      dump[this.properties[i]] = r;
    } catch (e) {
      console.log(e);
    }
  }

  return dump;
}

MediaController.prototype.update = function () {
  for (var key in this.events) {
    var e = document.getElementById("e_mc_" + key);
    if (e) {
      e.textContent = this.events[key];
      if (this.events[key] > 0) {
        e.className = "true";
      }
    }
  }

  for (var i = 0; i < this.properties.length; i++) {
    try {
      // var r = eval("this.controller." + this.properties[i]);
      var r = this.controller[this.properties[i]];
      //printString(r);
      this.properties_elts[i].textContent = r;
    } catch (e) {
      console.log(e);
    }
  }
}

MediaController.prototype.addEventsToDOM = function (bodyid) {
  var tbody = document.getElementById(bodyid);
  var i = 1;
  var tr = null;
  for (key in this.events) {
    if (tr === null) {
      tr = document.createElement("tr");
    }

    var th = document.createElement("th");
    th.textContent = key;
    var td = document.createElement("td");
    td.setAttribute("id", "e_mc_" + key);
    td.textContent = "0";
    td.className = "false";
    tr.appendChild(th);
    tr.appendChild(td);

    if ((i++ % 5) === 0) {
      tbody.appendChild(tr);
      tr = null;
    }
  }
  if (tr !== null) {
    tbody.appendChild(tr);
  }
}

MediaController.prototype.addPropertiesToDOM = function (bodyid) {
  var tbody = document.getElementById(bodyid);
  var tr = null;

  for (var i = 0; i < this.properties.length; i++) {
    if (tr === null) {
      tr = document.createElement("tr");
    }
    var th = document.createElement("th");
    th.textContent = this.properties[i];
    var td = document.createElement("td");
    td.setAttribute("id", "p_mc_" + this.properties[i]);
    // var r = eval("this.controller." + this.properties[i]);
    var r = this.controller[this.properties[i]];
    td.textContent = r;
    if (typeof (r) !== "undefined") {
      td.className = "true";
    } else {
      td.className = "false";
    }
    tr.appendChild(th);
    tr.appendChild(td);
    this.properties_elts[i] = td;
    if (((i + 1) % 3) === 0) {
      tbody.appendChild(tr);
      tr = null;
    }
  }

  if (tr !== null) {
    tbody.appendChild(tr);
  }
}

///////////////////////////////////////////////////////////////////////////////
// Misc Functions
///////////////////////////////////////////////////////////////////////////////

function AddToDOM(bodyid, msg) {
  var tbody = document.getElementById(bodyid);

  var tr = document.createElement("tr");
  var td = document.createElement("td");
  td.textContent = msg;
  tr.appendChild(td);
  tbody.appendChild(tr);
}

function printString(o) {
  if (o === null || !(typeof o === 'object')) {
    return o;
  }

  var out = '';
  for (var p in o) {
    out += p + ': ' + o[p] + '\n';
  }

  console.log(o + ' ' + out);

  return out;
}
