var readmanga_r_serverLocation="http://readmanga.ru";
var readmanga_r_serverApp="";
try {
    if (readmanga_r_serverLocation_s && readmanga_r_serverLocation_s.length > 10) {
        readmanga_r_serverLocation = readmanga_r_serverLocation_s;
        readmanga_r_serverApp = readmanga_r_serverApp_s;
    }
} catch(Ex) {
}

/*
 * postMessage - v0.4 - 8/23/2009
 * http://benalman.com/
 *
 * Copyright (c) 2009 "Cowboy" Ben Alman
 * Licensed under the MIT license
 * http://benalman.com/about/license/
 */
(function($){var g,d,j=1,a,b=this,f=!1,h="postMessage",e="addEventListener",c,i=b[h]&&!$.browser.opera;$[h]=function(k,l,m){if(!l){return}k=typeof k==="string"?k:$.param(k);m=m||parent;if(i){m[h](k,l.replace(/([^:]+:\/\/[^\/]+).*/,"$1"))}else{if(l){m.location=l.replace(/#.*$/,"")+"#"+(j++)+"&"+k}}};$.receiveMessage=c=function(l,m,k){if(i){if(l){a&&c();a=function(n){if((typeof m==="string"&&n.origin!==m)||($.isFunction(m)&&m(n.origin)===f)){return f}l(n)}}if(b[e]){b[l?e:"removeEventListener"]("message",a,f)}else{b[l?"attachEvent":"detachEvent"]("onmessage",a)}}else{g&&clearInterval(g);g=null;if(l){k=typeof m==="number"?m:typeof k==="number"?k:100;g=setInterval(function(){var o=document.location.hash,n=/^#?\d+&/;if(o!==d&&n.test(o)){d=o;l({data:o.replace(n,"")})}},k)}}}})(jQuery);
var readmanga_r={
    createLink:function (m,v,c){
        readmanga_r.wH =$(window).height();
        readmanga_r.wW =$(window).width();

        readmanga_r.readerSrc=readmanga_r_serverLocation+readmanga_r_serverApp+"/reader/"+m+"/vol"+v+"/"+c;
        return readmanga_r.readerSrc+"#"+encodeURIComponent( document.location.href )+"??"+readmanga_r.wH+"??"+readmanga_r.wW;
    },
    generateIFrame:function(l) {
        var ww = 880;
        var hh = 900;
        if (window.readmanga_ru_width) ww = window.readmanga_ru_width;
        if (window.readmanga_ru_height) hh = window.readmanga_ru_height;

        return "<iframe class='cpFrame' id='" + readmanga_r.frameId + "' frameborder='0' border='0' cellspacing='0' height='" + hh + "' width='" + ww + "' src='" + l + "' scrolling='no'></iframe>";
    },
    processBlock:function(){
        var l = readmanga_r.createLink(readmanga_ru_manga, readmanga_ru_vol, readmanga_ru_c);
        var readmanga_ru_ss=readmanga_r.generateIFrame(l);
        document.write(readmanga_ru_ss);
        readmanga_r.appendMessageRessiver();
    },
    appendMessageRessiver:function() {
        $.receiveMessage(function(e) { //"if_height=1273&if_width=683"
            var res=readmanga_r.deserialize(e.data,true,true);
            var h = res.if_height;
            if ( h && h > 0 && h !== readmanga_r.height) {
                $('#' + readmanga_r.frameId).height(readmanga_r.height = h + 25);
            }
            var w = res.if_width;
            if (w && w > 0 && w !== readmanga_r.wigth) {
                $('#' + readmanga_r.frameId).width(readmanga_r.wigth = w + 25);
                return;
            }
            var url = res.if_url;    //todo remove
            if (url && url.length > 10) {
                readmanga_r.refrashIFrame(url);    //todo 
            }
        }, readmanga_r_serverLocation);
        $(window).resize(function() {
            if ($.browser.msie) {
                return;
            }
            var tH=$(window).height();
            var tW=$(window).width();
            if ((readmanga_r.wH - tH > 5 || readmanga_r.wH - tH < -5) || (readmanga_r.wW - tW > 5 || readmanga_r.wW - tW < -5)) {
                readmanga_r.wH = tH;
                readmanga_r.wW = tW;
                $.postMessage({ hhhh: tH, wwww: tW }, readmanga_r.readerSrc, $('#' + readmanga_r.frameId).get(0).contentWindow);
            }
        });

    },
    refrashIFrame:function(url) { //todo remove
        url = readmanga_r_serverLocation + decodeURIComponent(url) + "#" + encodeURIComponent(document.location.href);
        $('#' + readmanga_r.frameId).attr("src",url);
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

    frameId:"readMangaExternalReader",
    height:0,
    wigth:0,
    wH:0,
    wW:0
};
readmanga_r.processBlock();





