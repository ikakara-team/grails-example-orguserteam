// Based on
//   https://github.com/simonsarris/Canvas-tutorials/blob/master/shapes.js

function CollectionShapeRanges() {
  this.shapeRanges = []; // array of shapeRanges
}

function ShapeRanges(id) {
  this.id = id || -1;
  this.shapes = [];
}

ShapeRanges.prototype.size = function () {
  return this.shapes.length;
}

ShapeRanges.prototype.clone = function (shape) {
  var clone = shape.clone();
  this.withPush(clone);
  return clone;
}

ShapeRanges.prototype.copy = function (shape) {
  var copy = shape.copy();
  this.withPush(copy);
  return copy;
}

ShapeRanges.prototype.getDefaultShape = function () {
  if (this.size()) {
    // the first one is the default
    return this.shapes[0];
  }
  return null;
}

ShapeRanges.prototype.haveShape = function (time) {
  if (time !== null) {
    var list = this.findByTime(time);
    if (list.length > 0) {
      return true;
    }
  }

  return false;
}

ShapeRanges.prototype.getShape = function (time) {
  var shape = null;
  if (time !== null) {
    var list = this.findByTime(time);
    if (list.length > 0) {
      // return the first item
      shape = list[0];
    }
  }

  if (shape === null) {
    shape = this.getDefaultShape();
  }

  return shape;
}

ShapeRanges.prototype.withPush = function (shape) {
  var count = this.shapes.push(shape);
  return this;
}

ShapeRanges.prototype.findBy = function (key, value) {
  return this.shapes.filter(function (x) {
    return x[key] === value;
  })
}

ShapeRanges.prototype.findByTime = function (value) {
  return this.findBy('time', value);
}

ShapeRanges.prototype.sort = function () {
  this.shapes.sort(this.compare);
}

ShapeRanges.prototype.compare = function (a, b) {
  if (a.time < b.time) {
    return -1;
  } else if (a.time > b.time) {
    return 1;
  } else {
    return 0;
  }
}

// Draws this shape to a given context
ShapeRanges.prototype.draw = function (time, ctx, width, height) {
  var shape = this.getShape(time);
  if (shape !== null) {
    shape.safeDraw(ctx, width, height);
  } else {
    console.log('Shape not found for time: ' + time)
  }
}

// Constructor for Shape objects to hold data for all drawn objects.
// For now they will just be defined as rectangles.
function Shape(x, y, w, h, fill) {
  // This is a very simple and unsafe constructor. All we're doing is checking if the values exist.
  // "x || 0" just means "if there is a value for x, use that. Otherwise use 0."
  // But we aren't checking anything else! We could put "Lalala" for the value of x
  this.x = x || 0;
  this.y = y || 0;
  this.w = w || 1;
  this.h = h || 1;
  this.fill = fill || '#AAAAAA';
  this.time = -1.0;

  this.normalizeSize();
  this.normalizePosition();
}

// clone isn't an exact copy
Shape.prototype.clone = function () {
  var clone = new Shape(this.x, this.y, this.w, this.h, this.fill);
  // we don't copy time
  return clone;
}

// copy
Shape.prototype.copy = function () {
  var copy = this.clone();
  // we don't copy time
  copy.time = this.time;
  return copy;
}

// adjust x/y to insure that widths/heights are positive values
Shape.prototype.normalizeSize = function () {
  var b = false;
  // normalize width
  if (this.w < 0) {
    var newx = this.x + this.w;
    this.x = newx > 0 ? newx : 0;
    this.w = Math.abs(this.w);
    b = true;
  } else if (this.w === 0) {
    this.w = 1;
  }
  // normalize height
  if (this.h < 0) {
    var newy = this.y + this.h;
    this.y = newy > 0 ? newy : 0;
    this.h = Math.abs(this.h);
    b = true;
  } else if (this.h === 0) {
    this.h = 1;
  }
  return b;
}

// adjust x/y to insure that widths/heights are positive values
Shape.prototype.normalizePosition = function () {
  var b = false;
  // insure x is positive
  if (this.x < 0) {
    this.x = 0;
    b = true;
  }
  // insure y is positive
  if (this.y < 0) {
    this.y = 0;
    b = true;
  }
  return b;
}

// Draws this shape to a given context
Shape.prototype.safeDraw = function (ctx, width, height) {
  // We can skip the drawing of elements that have moved off the screen:
  if (this.x > width || this.y > height || this.x + this.w < 0 || this.y + this.h < 0) {
    return;
  }

  this.draw(ctx);
}

// Draws this shape to a given context
Shape.prototype.draw = function (ctx) {
  ctx.fillStyle = this.fill;
  ctx.fillRect(this.x, this.y, this.w, this.h);
}

// Determine if a point is inside the shape's bounds
Shape.prototype.contains = function (mx, my) {
  // All we have to do is make sure the Mouse X,Y fall in the area between
  // the shape's X and (X + Width) and its Y and (Y + Height)
  return  (this.x <= mx) && (this.x + this.w >= mx) &&
          (this.y <= my) && (this.y + this.h >= my);
}

function CanvasState(canvas) {
  // create (hidden) video elements by js (presumably faster) and append to DOM
  this.videoElement = document.createElement("video");
  this.videoElement.setAttribute("preload", "metadata"); // get the video metadata asap
  this.videoDiv = document.createElement('div');
  document.body.appendChild(this.videoDiv);
  this.videoDiv.appendChild(this.videoElement);
  this.videoDiv.setAttribute("style", "display:none;");

  // setup canvas state
  this.canvas = canvas;
  this.width = canvas.width;
  this.height = canvas.height;
  this.ctx = canvas.getContext('2d');
  // This complicates things a little but but fixes mouse co-ordinate problems
  // when there's a border or padding. See getMouse for more detail
  var stylePaddingLeft, stylePaddingTop, styleBorderLeft, styleBorderTop;
  if (document.defaultView && document.defaultView.getComputedStyle) {
    this.stylePaddingLeft = parseInt(document.defaultView.getComputedStyle(canvas, null)['paddingLeft'], 10) || 0;
    this.stylePaddingTop = parseInt(document.defaultView.getComputedStyle(canvas, null)['paddingTop'], 10) || 0;
    this.styleBorderLeft = parseInt(document.defaultView.getComputedStyle(canvas, null)['borderLeftWidth'], 10) || 0;
    this.styleBorderTop = parseInt(document.defaultView.getComputedStyle(canvas, null)['borderTopWidth'], 10) || 0;
  }
  // Some pages have fixed-position bars (like the stumbleupon bar) at the top or left of the page
  // They will mess up mouse coordinates and this fixes that
  var html = document.body.parentNode;
  this.htmlTop = html.offsetTop;
  this.htmlLeft = html.offsetLeft;

  // **** Keep track of state! ****
  this.chooseColor = 'rgba(0,255,0,.6)';
  this.valid = false;    // when set to false, the canvas will redraw everything
  this.collectionShapeRanges = []; // the collection of things to be drawn
  this.dragging = false; // Keep track of when we are dragging
  this.resizeDragging = false;
  this.resizeSelectionHandle = -1; // New, will save the # of the selection handle if the mouse is over one.

  // the current selected object. In the future we could turn this into an array for multiple selection
  this.selection = null;
  this.dragoffx = 0; // See mousedown and mousemove events for explanation
  this.dragoffy = 0;

  // **** Then events! ****

  // This is an example of a closure!
  // Right here "this" means the CanvasState. But we are making events on the Canvas itself,
  // and when the events are fired on the canvas the variable "this" is going to mean the canvas!
  // Since we still want to use this particular CanvasState in the events we have to save a reference to it.
  // This is our reference!
  var myState = this;

  /////////////////////////////////////////////////////////////////////////////
  //fixes a problem where double clicking causes text to get selected on the canvas
  /////////////////////////////////////////////////////////////////////////////
  canvas.addEventListener('selectstart', function (e) {
    e.preventDefault();
    return false;
  }, false);
  /////////////////////////////////////////////////////////////////////////////
  // Up, down, and move are for dragging
  /////////////////////////////////////////////////////////////////////////////
  canvas.addEventListener('mousedown', function (e) {
    //we are over a selection box
    if (myState.resizeSelectionHandle !== -1) {
      myState.resizeDragging = true;
      return;
    }

    var currentTime = myState.getCurrentTime();

    ///////////////////////////////////////////////////////////////////////////
    // handle right click
    ///////////////////////////////////////////////////////////////////////////
    if (e.button === 2) {
      // check for selection
      if (myState.selection !== null) {
        var m = confirm("Want to delete selected???");
        if (m) {
          myState.removeShapeRanges(myState.selection, currentTime);
          myState.selection = null;
          myState.valid = false;
        }
      }
      return;
    }

    ///////////////////////////////////////////////////////////////////////////
    // Handle other clicks
    ///////////////////////////////////////////////////////////////////////////
    var mouse = myState.getMouse(e);
    var mx = mouse.x;
    var my = mouse.y;
    var ranges = myState.collectionShapeRanges;
    var l = ranges.length;
    for (var i = l - 1; i >= 0; i--) {
      var mySel = ranges[i].getShape(currentTime);
      if (mySel.contains(mx, my)) {
        // Keep track of where in the object we clicked
        // so we can move it smoothly (see mousemove)
        myState.dragoffx = mx - mySel.x;
        myState.dragoffy = my - mySel.y;
        myState.dragging = true;
        myState.selection = ranges[i];
        myState.valid = false;
        return;
      }
    }
    // havent returned means we have failed to select anything.
    // If there was an object selected, we deselect it
    if (myState.selection) {
      myState.nullSelection();
      myState.valid = false; // Need to clear the old selection border
    }
  }, true);
  /////////////////////////////////////////////////////////////////////////////
  //
  /////////////////////////////////////////////////////////////////////////////
  canvas.addEventListener('mousemove', function (e) {
    var currentTime = myState.getCurrentTime();
    var selectionShape = myState.getSelectionShape(currentTime);

    if (myState.dragging) {
      var mouse = myState.getMouse(e);
      // We don't want to drag the object by its top-left corner, we want to drag it
      // from where we clicked. Thats why we saved the offset and use it here
      selectionShape.x = mouse.x - myState.dragoffx;
      selectionShape.y = mouse.y - myState.dragoffy;
      myState.valid = false; // Something's dragging so we must redraw
    } else if (myState.resizeDragging) {
      var mouse = myState.getMouse(e);

      // time ro resize!
      var oldx = selectionShape.x;
      var oldy = selectionShape.y;

      // 0  1  2
      // 3     4
      // 5  6  7
      switch (myState.resizeSelectionHandle) {
        case 0:
          selectionShape.x = mouse.x;
          selectionShape.y = mouse.y;
          selectionShape.w += oldx - mouse.x;
          selectionShape.h += oldy - mouse.y;
          break;
        case 1:
          selectionShape.y = mouse.y;
          selectionShape.h += oldy - mouse.y;
          break;
        case 2:
          selectionShape.y = mouse.y;
          selectionShape.w = mouse.x - oldx;
          selectionShape.h += oldy - mouse.y;
          break;
        case 3:
          selectionShape.x = mouse.x;
          selectionShape.w += oldx - mouse.x;
          break;
        case 4:
          selectionShape.w = mouse.x - oldx;
          break;
        case 5:
          selectionShape.x = mouse.x;
          selectionShape.w += oldx - mouse.x;
          selectionShape.h = mouse.y - oldy;
          break;
        case 6:
          selectionShape.h = mouse.y - oldy;
          break;
        case 7:
          selectionShape.w = mouse.x - oldx;
          selectionShape.h = mouse.y - oldy;
          break;
      }
      myState.valid = false; // Something's resizing so we must redraw
    } else if (myState.selection !== null) {
      // resizing
      var mouse = myState.getMouse(e);

      for (var i = 0; i < 8; i++) {
        // 0  1  2
        // 3     4
        // 5  6  7

        var cur = myState.selectionHandles[i];

        // we dont need to use the ghost context because
        // selection handles will always be rectangles
        if (mouse.x >= cur.x && mouse.x <= cur.x + myState.selectionHandlesBoxSize &&
                mouse.y >= cur.y && mouse.y <= cur.y + myState.selectionHandlesBoxSize) {
          // we found one!
          myState.resizeSelectionHandle = i;
          myState.valid = false; // Something's resizing so we must redraw

          switch (i) {
            case 0:
              this.style.cursor = 'nw-resize';
              break;
            case 1:
              this.style.cursor = 'n-resize';
              break;
            case 2:
              this.style.cursor = 'ne-resize';
              break;
            case 3:
              this.style.cursor = 'w-resize';
              break;
            case 4:
              this.style.cursor = 'e-resize';
              break;
            case 5:
              this.style.cursor = 'sw-resize';
              break;
            case 6:
              this.style.cursor = 's-resize';
              break;
            case 7:
              this.style.cursor = 'se-resize';
              break;
          }
          return;
        }
      }

      // not over a selection box, return to normal
      myState.resizeDragging = false;
      myState.resizeSelectionHandle = -1;
      this.style.cursor = 'auto';
    }
  }, true);
  /////////////////////////////////////////////////////////////////////////////
  //
  /////////////////////////////////////////////////////////////////////////////
  canvas.addEventListener('mouseup', function (e) {
    var shape = myState.getSelectionShape();
    if (shape !== null) {
      var b = shape.normalizeSize();
      if (b) {
        myState.updateShapesOnDOM();
      }
    }
    myState.dragging = false;
    myState.resizeDragging = false;
    myState.resizeSelectionHandle = -1;
  }, true);
  /////////////////////////////////////////////////////////////////////////////
  // double click for making new shapes or marking time
  /////////////////////////////////////////////////////////////////////////////
  canvas.addEventListener('dblclick', function (e) {
    if (myState.selection !== null) {
      var m = confirm("Want to bind object to this time/frame???");
      if (m) {
        // mark time
        myState.recordSelectionShape();
      }
    } else {
      // Create a new shape
      var mouse = myState.getMouse(e);
      myState.addShape(-1, new Shape(mouse.x - 10, mouse.y - 10, 40, 40, myState.chooseColor));
    }
  }, true);

  /////////////////////////////////////////////////////////////////////////////
  // New, holds the 8 tiny boxes that will be our selection handles
  // the selection handles will be in this order:
  // 0  1  2
  // 3     4
  // 5  6  7
  /////////////////////////////////////////////////////////////////////////////
  this.selectionHandles = [];

  // set up the selection handle shapes
  for (var i = 0; i < 8; i++) {
    var rect = new Shape;
    this.selectionHandles.push(rect);
  }

  /////////////////////////////////////////////////////////////////////////////
  // **** Options! ****
  /////////////////////////////////////////////////////////////////////////////
  this.selectionColor = 'darkred';
  this.selectionWidth = 2;
  // resizing: selected shape will by outlined w/ selectionHandles
  this.selectionHandlesBoxSize = 6;

  /////////////////////////////////////////////////////////////////////////////
  // canvas refresh interval
  /////////////////////////////////////////////////////////////////////////////
  this.interval = 30;
  setInterval(function () {
    myState.draw();
  }, myState.interval);
}

CanvasState.prototype.withUpdateSeeked = function () {
  this.videoElement.addEventListener('seeked', this.updateSeeked.bind(this), false);
  return this;
}

CanvasState.prototype.updateSeeked = function () {
  this.valid = false;
}

CanvasState.prototype.createShape = function (x, y, w, h, fill) {
  return this.addShape(-1, new Shape(x, y, w, h, fill));
}

CanvasState.prototype.addShape = function (id, shape) {
  var shaperange = null;

  if (id === -1) {
    // create a new shaperanges
    var newid = this.collectionShapeRanges.length + 1;
    shaperange = new ShapeRanges(newid).withPush(shape);
    this.collectionShapeRanges.push(shaperange);
  }

  this.valid = false;

  return shaperange;
}

CanvasState.prototype.removeShapeRanges = function (shapeRanges, time) {
  var removed = false;
  var shapes = shapeRanges.shapes;
  var l = shapes.length;
  for (var i = l - 1; i >= 0; i--) {
    if (time !== undefined || shapes[i].time === time) {
      shapes.splice(i, 1);
      removed = true;
      break;
    }
  }
  if (!removed && shapes.length > 0) {
    shapes.splice(0, 1);
  }

  // remove shaperanges w/ no shapes
  if (shapeRanges.size() === 0) {
    var list = this.collectionShapeRanges;
    l = list.length;
    for (var i = l - 1; i >= 0; i--) {
      if (list[i].id === shapeRanges.id) {
        list.splice(i, 1);
        return;
      }
    }
  }
}

CanvasState.prototype.recordSelectionShape = function () {
  if (this.selection === null) {
    console.log('No object selected');
    return;
  }

  var shape = null;
  var currentTime = this.getCurrentTime();

  var shapeRanges = this.selection;
  var list = shapeRanges.findByTime(currentTime);
  if (list.length > 0) {
    // return the first item
    shape = list[0];
  }

  if (shape !== null) {
    shape.time = currentTime;
  } else {
    shape = shapeRanges.getDefaultShape();
    var newshape = shapeRanges.clone(shape);
    newshape.time = currentTime;
  }

  shapeRanges.sort(); // let's sort the shapes by time

  this.valid = false; // redraw
}

CanvasState.prototype.getSelectionShape = function (time) {
  var shape = null;
  if (this.selection !== null) {
    shape = this.selection.getShape(time);
  }
  return shape;
}

CanvasState.prototype.nullSelection = function () {
  if (this.selection !== null) {
    var shape = this.selection.getShape();
    if (shape !== null) {
      shape.normalizeSize();
    }
    this.selection = null;
  }
}

CanvasState.prototype.clear = function () {
  this.ctx.clearRect(0, 0, this.width, this.height);
}

CanvasState.prototype.clearAll = function (canvasimg) {
  var m = confirm("Want to clear all???");
  if (m) {
    this.clear();
    this.collectionShapeRanges = [];
    this.valid = false; // redraw
    if (canvasimg !== undefined) {
      document.getElementById(canvasimg).style.display = "none";
    }
  }
}

CanvasState.prototype.color = function (color) {
  this.chooseColor = color;
}

CanvasState.prototype.withCustomVideoDraw = function (methodDraw) {
  this.customVideoDraw = methodDraw;
  return this;
}

CanvasState.prototype.save = function (canvasimg) {
  document.getElementById(canvasimg).style.border = "2px solid";
  var dataURL = this.canvas.toDataURL();
  document.getElementById(canvasimg).src = dataURL;
  document.getElementById(canvasimg).style.display = "inline";
}

// video controls
CanvasState.prototype.seek = function (rangeIdx, time) {
  this.selection = this.collectionShapeRanges[rangeIdx];
  this.videoElement.currentTime = time;
  this.valid = false;
}

CanvasState.prototype.getCurrentTime = function () {
  return this.videoElement.currentTime;
}

// video controls
CanvasState.prototype.switch = function (video) {
  this.videoElement.setAttribute("src", video);
  // delay
  setTimeout(function () {
    this.valid = false;
  }.bind(this), 1000); // delay required depends on how long it takes to load video
}

CanvasState.prototype.drawVideo = function () {
  var ctx = this.ctx;

  /////////////////////////////////////////////////////////////////////////////
  // custom video draw
  /////////////////////////////////////////////////////////////////////////////
  if (this.customVideoDraw !== undefined) {
    try {
      this.customVideoDraw.call(this.customVideoDraw, this.canvas, ctx, this.videoElement);
      return;
    } catch (e) {
      console.log(e);
    }
  }

  /////////////////////////////////////////////////////////////////////////////
  // default video draw
  /////////////////////////////////////////////////////////////////////////////

  //Background
  ctx.fillStyle = '#ffffaa';
  ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
  // video
  ctx.drawImage(this.videoElement, 0, 0);
}

// While draw is called as often as the INTERVAL variable demands,
// It only ever does something if the canvas gets invalidated by our code
CanvasState.prototype.draw = function () {
  // if our state is invalid, redraw and validate!
  if (!this.valid || !this.videoElement.paused) {
    var ctx = this.ctx;
    var shapeRanges = this.collectionShapeRanges;
    this.clear(); // we don't need this if canvas.size == video.size

    // ** Add stuff you want drawn in the background all the time here **
    this.drawVideo();

    var currentTime = this.getCurrentTime();

    // draw all shapeRanges
    var l = shapeRanges.length;
    for (var i = 0; i < l; i++) {
      shapeRanges[i].draw(currentTime, ctx, this.width, this.height);
    }

    // draw selection
    // right now this is just a stroke along the edge of the selected Shape
    var mySel = this.getSelectionShape(currentTime);
    if (mySel !== null) {
      ctx.strokeStyle = this.selectionColor;
      ctx.lineWidth = this.selectionWidth;
      ctx.strokeRect(mySel.x, mySel.y, mySel.w, mySel.h);

      var half = this.selectionHandlesBoxSize / 2;

      // 0  1  2
      // 3     4
      // 5  6  7
      // top left, middle, right
      this.selectionHandles[0].x = mySel.x - half;
      this.selectionHandles[0].y = mySel.y - half;

      this.selectionHandles[1].x = mySel.x + mySel.w / 2 - half;
      this.selectionHandles[1].y = mySel.y - half;

      this.selectionHandles[2].x = mySel.x + mySel.w - half;
      this.selectionHandles[2].y = mySel.y - half;

      //middle left
      this.selectionHandles[3].x = mySel.x - half;
      this.selectionHandles[3].y = mySel.y + mySel.h / 2 - half;

      //middle right
      this.selectionHandles[4].x = mySel.x + mySel.w - half;
      this.selectionHandles[4].y = mySel.y + mySel.h / 2 - half;

      //bottom left, middle, right
      this.selectionHandles[6].x = mySel.x + mySel.w / 2 - half;
      this.selectionHandles[6].y = mySel.y + mySel.h - half;

      this.selectionHandles[5].x = mySel.x - half;
      this.selectionHandles[5].y = mySel.y + mySel.h - half;

      this.selectionHandles[7].x = mySel.x + mySel.w - half;
      this.selectionHandles[7].y = mySel.y + mySel.h - half;

      ctx.fillStyle = this.selectionColor;
      for (var i = 0; i < 8; i++) {
        var cur = this.selectionHandles[i];
        ctx.fillRect(cur.x, cur.y, this.selectionHandlesBoxSize, this.selectionHandlesBoxSize);
      }
    }

    // ** Add stuff you want drawn on top all the time here **
    this.updateShapesOnDOM();

    this.valid = true;
  }
}

// Creates an object with x and y defined, set to the mouse position relative to the state's canvas
// If you wanna be super-correct this can be tricky, we have to worry about padding and borders
CanvasState.prototype.getMouse = function (e) {
  var element = this.canvas, offsetX = 0, offsetY = 0, mx, my;

  // Compute the total offset
  if (element.offsetParent !== undefined) {
    do {
      offsetX += element.offsetLeft;
      offsetY += element.offsetTop;
      element = element.offsetParent;
    } while (element);
  }

  // Add padding and border style widths to offset
  // Also add the <html> offsets in case there's a position:fixed bar
  offsetX += this.stylePaddingLeft + this.styleBorderLeft + this.htmlLeft;
  offsetY += this.stylePaddingTop + this.styleBorderTop + this.htmlTop;

  mx = e.pageX - offsetX;
  my = e.pageY - offsetY;

  // We return a simple javascript object (a hash) with x and y defined
  return {x: mx, y: my};
}

CanvasState.prototype.initShapesUpdate = function (bodyid, countid, onclickObjectStr) {
  this.domidShapesUpdate = document.getElementById(bodyid);
  this.domidShapesCount = document.getElementById(countid);
  this.shapesUpdateOnclickObjectStr = onclickObjectStr;
}

CanvasState.prototype.updateShapesOnDOM = function () {
  var tbody = this.domidShapesUpdate;
  var countid = this.domidShapesCount;
  var count = 0;

  if (tbody !== undefined) {
    var currentTime = this.getCurrentTime();

    // clear table
    this.domidShapesUpdate.textContent = '';

    // build the DOM w/ the ShapeRanges
    var l = this.collectionShapeRanges.length;
    for (var i = l - 1; i >= 0; i--) {
      var found = this.collectionShapeRanges[i].haveShape(currentTime);

      var tr = document.createElement("tr");
      if (this.selection === this.collectionShapeRanges[i]) {
        tr.style.border = '2px solid ' + this.selectionColor;
      }

      var th = document.createElement("th");
      th.textContent = i;
      var td = document.createElement("td");
      //td.className = "true";

      var ol = document.createElement("ol");

      // iterate through all the shapes
      var shapes = this.collectionShapeRanges[i].shapes;
      for (var j = 0; j < shapes.length; j++) {
        if (shapes[j].time !== -1) {
          count++;
        }

        var li = document.createElement("li");
        if (shapes[j].time === currentTime || (!found && shapes[j].time === -1)) {
          li.className = "highlight";
        }
        var a = document.createElement("a");
        a.setAttribute("onclick", this.shapesUpdateOnclickObjectStr + ".seek(" + i + ", " + shapes[j].time + ")");
        a.textContent = JSON.stringify(shapes[j]);
        li.appendChild(a);
        ol.appendChild(li);
      }
      td.appendChild(ol);
      tr.appendChild(th);
      tr.appendChild(td);
      tbody.appendChild(tr);
    }
    // update count of objects
    countid.textContent = count;
  }

}

CanvasState.prototype.dumpShapeRanges = function () {
  var list = [];

  // build the DOM w/ the ShapeRanges
  var l = this.collectionShapeRanges.length;
  for (var i = l - 1; i >= 0; i--) {
    var shapeRanges = new ShapeRanges(this.collectionShapeRanges[i].id);

    // iterate through all the shapes
    var shapes = this.collectionShapeRanges[i].shapes;
    for (var j = 0; j < shapes.length; j++) {
      if (shapes[j].time !== -1) {
        shapeRanges.copy(shapes[j]);
      }
    }

    if (shapeRanges.size() > 0) {
      list.push(shapeRanges);
    }
  }
  return list;
}