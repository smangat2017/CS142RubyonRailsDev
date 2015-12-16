function Tagger(photo_id,rect_id,width_id,height_id,x_coord_id,y_coord_id) {
    this.isMouseDown = false;
    this.photo = document.getElementById(photo_id);
    this.rectangle = document.getElementById(rect_id);

    this.width_field = document.getElementById(width_id);
    this.height_field = document.getElementById(height_id);
    this.x_field = document.getElementById(x_coord_id);
    this.y_field = document.getElementById(y_coord_id);

    this.yoffset = this.photo.offsetTop;
    this.xoffset = this.photo.offsetLeft;
    this.widthoffset = this.photo.offsetWidth;
    this.heightoffset = this.photo.offsetHeight;


    console.log(this.yoffset);
    console.log(this.xoffset);
    console.log(this.widthoffset);
    console.log(this.heightoffset);


    var obj = this;
    this.photo.onmousedown = function(event) {
        event.preventDefault();
        obj.mouseDown(event);
    }
}

Tagger.prototype.mouseDown = function(event) {
    var obj = this;
    this.yposition = event.pageY - this.yoffset;
    this.xposition = event.pageX - this.xoffset;

    this.oldMoveHandler = document.body.onmousemove;
    document.body.onmousemove = function(event) {
        obj.mouseMove(event);
    }
    this.oldUpHandler = document.body.onmouseup;
    document.body.onmouseup = function(event) {
        obj.mouseUp(event);
    }
    this.isMouseDown = true;
}

Tagger.prototype.mouseMove = function(event) {
    if (!this.isMouseDown) {
         return;
    }

    var currx = event.pageX - this.xoffset;
    var curry = event.pageY - this.yoffset;

    var width = Math.abs(currx - this.xposition);
    var height = Math.abs(curry - this.yposition);
    var top;
    var left;

    if(currx >= this.xposition && curry >=this.yposition){
        var maxheight = this.heightoffset - this.yposition - 4;
        var maxwidth = this.widthoffset - this.xposition - 4;

        top = this.yposition;
        left = this.xposition;

    }
    else if(currx>=this.xposition && curry < this.yposition){
        var maxheight = this.yposition;
        var maxwidth = this.widthoffset - this.xposition - 4;

        top = Math.max(curry,0);
        left = this.xposition;
    }
    else if(currx < this.xposition && curry>= this.yposition){
        var maxheight = this.heightoffset - this.yposition - 4;
        var maxwidth = this.xposition;

        top = this.yposition
        left = Math.max(currx,0);
    }
    else{
        var maxheight = this.yposition;
        var maxwidth = this.xposition;

        top = Math.max(curry,0);
        left = Math.max(currx,0);
    }

    width = Math.min(maxwidth,width);
    height = Math.min(maxheight,height);

    this.rectangle.style.top = top + 'px';
    this.rectangle.style.left = left + 'px';
    this.rectangle.style.width = width + 'px';
    this.rectangle.style.height = height + 'px';

    this.width_field.value = width;
    this.height_field.value = height;
    this.x_field.value = left;
    this.y_field.value = top;

    console.log(width);

    // var ten = 10;
    // this.rectangle.style.top =  ten + 'px';
    // this.rectangle.style.left = ten + 'px';
    // this.rectangle.style.width = ten + 'px';
    // this.rectangle.style.height = ten + 'px';
}

Tagger.prototype.mouseUp = function(event) {
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
}