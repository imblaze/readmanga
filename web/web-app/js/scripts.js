var h = {
    preloadImages:function() {
        if(h.preloadIndex >= h.pics.length || h.preloadIndex > h.cur + h.preloadDeep) return;
        if (h.pics[h.preloadIndex].c) { //already loaded
            h.preloadIndex++;
            h.preloadImages();
        } else {
            var pr = jQ("<img class='preloaded'/>").attr("src", h.pics[h.preloadIndex].url);
            h.pics[h.preloadIndex++].c = true;
            pr.load(function () { h.preloadImages(); }).error(function () { h.preloadImages(); });
            jQ("#mangaBox").append(pr);
        }
    },
    findPosY:function (obj) {
        var curtop = 0;
        if (obj.offsetParent)
            while (1) {
                curtop += obj.offsetTop;
                if (!obj.offsetParent)
                    break;
                obj = obj.offsetParent;
            } else if (obj.y)
            curtop += obj.y;
        return curtop;
    },
    wHeight:function () {
        if (h.isExternal)return h.parentH;
        return jQ(window).height();
    },

    wWidth:function () {
        if (h.isExternal)return h.parentW;
        return jQ(window).width();
    },
    setPictureSize:function(jPic, w, heigth) {
        jPic.attr('height', heigth);
        jPic.attr('width', w);
        var divW = w * 1 + h.borderWidth * 2;  //convert to number
        if (divW < h.minWww) {
            divW = h.minWww;
        }
        var divH=heigth*1+h.borderWidth * 2;
        jQ("#mangaBox").css('width', divW + "px");
//        jQ("#imHolder").css('heigth', heigth + "px");
        if (h.isExternal){
            sendExternalSize(divH, divW);
        }
    },
    setDefoultBlockWidth:function() {
        jQ("#mangaBox").css('width', h.minWww+"px");//todo remove attr
    },
    scrollPage:function(byControl) {
        if (!byControl && !h.isFirstPage) {
            if (h.zoom) {
                var img = jQ("#mangaPicture")[0];
                if (img) {
                    var y = h.findPosY(img);
                    window.scroll(0,y);
                }

            } else {
                window.scroll(0, 0);
            }
        }
        h.isFirstPage = false;
    }
    ,
    resizeImg:function () {
        var jPic = jQ("#mangaPicture");

        var curh = jPic.attr("rH");
        var curw = jPic.attr("rW");
        if (!h.zoom) {
            h.setPictureSize(jPic, curw, curh);
            return;
        }

        var availHeight = h.wHeight() - h.borderWidth;
        var availWidth = h.wWidth() - h.borderWidth-10;

        var rh = availHeight / curh;
        var rw = availWidth / curw;
        var mr = Math.min(rh, rw);
        if (mr < 0.5) {
            mr = 0.5;
        }
        h.setPictureSize(jPic, curw * mr, curh * mr);
    },
    updateAds: function() {
//        if (h.adsCount == 0) {
//            h.adsCount = 1;
//        } else {
//            h.adsCount = 0;
//            jQ("#topBaner").html(ads);
//        }
    },
    goNext: function(byControl) {
        h.goPage(h.cur + 1,byControl);
    },
    goPrev: function(byControl) {
        h.goPage(h.cur - 1,byControl);
    },
    goPage: function(num,byControl) {
        num=num*1;//string --> num
        h.isTwitterFocus=false;
        jQ(".mangaProgress").hide();
        if (h.changeControl(num)) return;
        jQ(".mangaProgress").show();
        //show progress   mangaProgress
        var curPic = h.pics[num];
        var src = curPic.url;
        curPic.c = true;
        jQ(".pageSelector").val(num);

        var jCurPic = jQ("#mangaPicture");
        var jNext=jQ("#nextPicture");
        jCurPic.attr("id","nextPicture");
        jNext.attr("id","mangaPicture").attr('src', src).attr('rH', curPic.h).attr('rW', curPic.w);
        h.resizeImg(); //resize next
        jCurPic.hide();
        jNext.show(); //show next
        h.scrollPage(byControl);
        jCurPic.attr('src', '../../images/empty.gif');
        h.updateTwitts(num);
        h.preloadIndex=num+1;
        clearTimeout(h.preloadEvent);
        h.preloadEvent = setTimeout("h.preloadImages();",500);

        h.updateAds();
    },
    updateTwitts:function(num){
        jQ("#twitter .twitt").hide();
        jQ("#twitter .twitt[pagenumber='"+num+"']").show();
        jQ("#twittPageNum").attr("value",h.cur);
    },
    twitterFocus:function(){
       h.isTwitterFocus=true;
    },
    changeControl:function(num) {   //return false if nead change picture
        if (num > h.length || num < -1 || (num >= h.length && !nextLink) || (num < 0 && !prevLink)) {
            return  true;
        }
        h.cur = num;
        jQ("#mangaPicture").show();
        if (num < 0 && prevLink) {
            jQ(".prevChapLink").show();
            jQ("#mangaPicture").hide();
            h.disableButton(".prevButton", true);
            h.setDefoultBlockWidth();
            return true;
        }
        if (num == 0 && !prevLink) {
            h.disableButton(".prevButton", true);
            return false;
        }
        if (num >= h.length && nextLink) {
            h.goToChapter(nextChapterLink);
        }

        if (num == (h.length - 1) && !nextLink) {
            h.disableButton(".nextButton", true);
            return false;
        }
        jQ(".nextChapLink, .prevChapLink").hide();
        h.disableButton(".prevButton, .nextButton", false);
        return false;
    },
    disableButton: function(selector, dis) {
        if (dis) {
            jQ(selector).attr("disabled", "true").removeClass('pretty-hover');
        } else {
            jQ(selector).removeAttr("disabled");
        }
    },
    onResize:function(isChanging) {
        if (isChanging){
           h.zoom=jQ(".resize").toggleClass("zoomSelected").hasClass("zoomSelected");
           setZoomOption(h.zoom);
        }

        if (h.zoom) {
            h.scrollPage(false);
        }

        h.resizeImg();
    },
    goToChapter:function(path) {
        if (h.isExternal){
//            if (jQ.browser.msie){
//                sendURL(path);
//                return false;
//            } else {
                path+="#"+h.parent_url;
//            }
        }
        location.href = path;
        return false;
    },
    showHint:function (){
       var t = getCookie("hideHint");
       if (!t || t=="false"){
         jQ("#helpHint").show();
       }
    },
    closeHint:function (){
        createCookie("hideHint",true,365);
        jQ("#helpHint").hide();
    },
    init: function(p, c, isExternalReader,zoom) {
        h.pics = p;
        h.length = p.length;
        if (isExternalReader){
           h.isExternal=true;
           h.initExternalReader();
        }

        //load bar
        jQ("#mangaPicture, #nextPicture").load(function() {
            if (jQ(this).attr("display") != "none") {
                jQ(".mangaProgress").hide();
            }
        }).error(function () {
            var src = jQ(this).attr("src");
            if (!src || src.length == 0 || src.indexOf("empty.gif")>0) {
              return;
            }
            saveErrorPicture(src);
        });

        h.zoom=zoom;
        if (zoom){
            jQ(".resize").addClass("zoomSelected");
        }
        h.goPage(c);
        jQ(document).keyup(function(e){
            if (h.isTwitterFocus) return false;
            switch (e.keyCode) {
                case 32:
                    h.onResize(true);
                    return false;
                case 37:
                    h.goPrev();
                    return false;
                case 39:
                    h.goNext();
                    return false;
            }
        });
        jQ(window).resize(function() {
            h.onResize(false);
        });
        h.showHint();
    },
    pics:undefined,
    cur:0,
    length:0,
    borderWidth:2,
    minWww:850,
    isFirstPage:true,
    adsCount:0,
    preloadIndex:0,
    preloadDeep:3,
    preloadEvent:null,
    zoom:false,
    isTwitterFocus:false,

    
    //for external reader
    initExternalReader:function () {
        if (!h.isExternal)return;
        try {
            if (parent && parent.document) {
                jQ(parent.document).keyup(function(e) {
                    switch (e.keyCode) {
                        case 32:
                            h.onResize(true);
                            return false;
                        case 37:
                            h.goPrev();
                            return false;
                        case 39:
                            h.goNext();
                            return false;
                    }
                });
            }
        } catch(Ex) {
        }

//        if (jQ.browser.msie) {
//            jQ(".nextButton").focus();
//        }

        var params=document.location.hash.replace( /^#/, '' ).split('??');
        h.parent_url=decodeURIComponent(params[0]);
        if (params[1] && !isNaN(params[1])) { h.parentH = Number(params[1]);}
        if (params[2] && !isNaN(params[2])) { h.parentW = Number(params[2]);}

        jQ.receiveMessage(function(e) {
            var res = h.deserialize(e.data, true, true);
            if (res.hhhh > 0 && res.wwww > 0) {
                h.parentW = res.wwww;
                h.parentH = res.hhhh;
                h.resizeImg();
            }
        } /*, h.parent_url*/);//todo add path like http://localhost:8080

    },
    // Deserialize a params string, optionally preceded by a url? or ?, or followed by an #anchor (or if fragment_mode, optionally preceded by a url#
    // or #) into an object, optionally casting numbers, null, true, false, and undefined values appropriately.
    deserialize:function(params, cast_values, fragment_mode) {
        var p, key, val, obj = {}, cast_types = { 'null': null, 'true': true, 'false': false }, re = fragment_mode ? /^.*[#]/ : /^.*[?]|#.*$/g;

        params = params.replace(re, '').replace(/\+/g, ' ').split('&');

        while (params.length) {
            p = params.shift().split('=');
            key = decodeURIComponent(p[0]);

            if (p.length === 2) {
                val = decodeURIComponent(p[1]);
                if (cast_values) {
                    if (val && !isNaN(val)) { val = Number(val);
                    } else if (val === 'undefined') { val = undefined;
                    } else if (cast_types[val] !== undefined) { val = cast_types[val];
                    }
                }
                obj[key] = val;
//              if ($.isArray(obj[key])) { obj[key].push(val);} else if (obj[key] !== undefined) { obj[key] = [obj[key], val];} else { obj[key] = val;}
            } else if (key) {
                obj[key] = cast_values ? undefined : '';
            }
        }
        return obj;
    },
    parent_url:null,
    isExternal:false,
    parentW:880,
    parentH:900
};


function createCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function deleteCookie(name) {
    document.cookie = name + "=; path=/; expires=Thu, 01-Jan-1970 00:00:01 GMT";
}

function getCookie(search_name) {
    var tab_cookies = document.cookie.split(';');
    for (var i = 0; i < tab_cookies.length; i++) {
        var cookie_tmp = tab_cookies[i].split('=');
        var cookie_name = cookie_tmp[0].replace(/^\s+|\s+$/g, '');
        if (cookie_name == search_name) {
            if (cookie_tmp.length > 1) {
                return unescape(cookie_tmp[1].replace(/^\s+|\s+$/g, ''));
            }
            return null;
        }
    }
    return null;
}
