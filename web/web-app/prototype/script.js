function ge(id) {
	return document.getElementById(id);
}

function show(id, display) {
	ge(id).style.display = display ? 'inline' : 'none';
}

function windowHeight() {
	var de = document.documentElement;
	return window.innerHeight || (de && de.clientHeight) || document.body.clientHeight;
}

function windowWidth() {
	var de = document.documentElement;
	return window.innerWidth || (de && de.clientWidth) || document.body.clientWidth;
}

reader = {
	dir: './',
	scale: true,
	images: [],
	curPage: 0,
	availHeightMod: -4,
	availWidthMod: -4,
	wstat: false,

	setPage: function(num) {
		var imgPath = reader.dir + reader.images[num];

		show('prevpage', num > 0);
		show('prevpagei', num == 0);

		show('nextpage', num < reader.images.length);
		show('nextpagei', num == reader.images.length);

		reader.curPage = reader.checkPageNum(num);

		ge('curpage').selectedIndex = reader.curPage;

		if(num == reader.images.length) {
			ge('manga').style.display = 'none';
			ge('bbar').style.display = 'none';
			if(reader.nextChapter) ge('nextchapter').style.display = 'block';
			else ge('chapterList').style.display = 'block';
			return;
		}

		ge('nextchapter').style.display = 'none';
		ge('chapterList').style.display = 'none';

		ge('bbar').style.display = 'block';
		var manga = ge('manga');
		if(manga) manga.parentNode.removeChild(manga);

		manga = document.createElement('img');
		ge('reader').appendChild(manga);

		manga.onclick = reader.nextPage;

		manga.id = 'manga';
		manga.imgh = 0;
		manga.imgw = 0;

		manga.src = imgPath;

		reader.recalcImageSize();
		setTimeout(reader.recalcImageSize, 7)
		manga.onload = reader.recalcImageSize;
	},

	recalcImageSize: function() {
		ge('bbar').style.position = (reader.scale && reader.wstat) ? 'absolute' : 'static';
		ge('bbar').style.top = (windowHeight() - ge('bbar').offsetHeight) + 'px';

		if(!ge('manga')) return;
		var curh = ge('manga').height;
		var curw = ge('manga').width;
		if(curh == reader.emptyHeight || curw == reader.emptyWidth) return;

		var availHeight = windowHeight() - ge('tbar').offsetHeight - ge('bbar').offsetHeight + reader.availHeightMod;
		var availWidth = windowWidth() + reader.availWidthMod;

		if(!ge('manga').imgh) {
			ge('manga').imgh = curh;
			ge('manga').imgw = curw;
		}

		var rh = availHeight / ge('manga').imgh;
		var rw = availWidth / ge('manga').imgw;
		var mr = Math.min(rh, rw);
		if(!reader.scale) mr = 1;


		if(mr < 0.6) {
			mr = 0.6;
			ge('bbar').style.position = 'static';
		}
		reader.wstat = mr < 0.6;
		ge('manga').height = ge('manga').imgh * mr;
		ge('manga').width = ge('manga').imgw * mr;

	},

	checkPageNum: function(page) {
		if(page > reader.images.length - 1) return reader.images.length - 1;
		if(page < 0) return 0;
		return page;
	},

	prevPage: function() {
		if(reader.curPage == 0) return false;
		reader.setPage(reader.curPage - 1);
		return false;
	},

	nextPage: function() {
		if(reader.curPage == reader.images.length) return false;
		reader.setPage(reader.curPage + 1);
		return false;
	},

	preload: function() {
		ge('loaded').innerHTML = reader.loadInd;
		if(reader.loadInd >= reader.images.length) return;
		ge('preload').onload = reader.preload;
		ge('preload').src = reader.dir + reader.images[reader.loadInd];
		reader.loadInd++;
	},

	init: function(options) {
		reader.dir = options.dir;
		reader.images = options.images;
		reader.chaptersList = options.chaptersList;
		reader.nextChapter = options.nextChapter;

		page = options.page;

		ge('manga').src = '';
		reader.emptyHeight = ge('manga').height;
		reader.emptyWidth = ge('manga').width;

		ge('prevpage').onclick = reader.prevPage;
		ge('nextpage').onclick = reader.nextPage;
		ge('pagecount').innerHTML = reader.images.length;

		var change_scale = function() {
			reader.scale = !ge('scale').checked;
			reader.recalcImageSize();
		};

		ge('scale').onchange = change_scale;
		ge('scale').onclick = change_scale;
		ge('scale').checked = '';

		page = reader.checkPageNum(page);
		if(reader.images.length) {
			var sbox = ge('curpage');
			for(var i = 0; i < reader.images.length; i++) {
				sbox.options[i] = new Option(i+1, i);
			}
			sbox.onchange = function() {
				reader.setPage(sbox.selectedIndex);
			}
		} else {
			// глава не содержит страниц
		}
		reader.loadInd = page;
		reader.preload();
		reader.setPage(page);
		window.onresize = reader.recalcImageSize;
		setInterval(reader.recalcImageSize, 500);

		window.onkeyup = function(e) {
			switch(e.keyCode) {
				case 32:
					reader.scale = !reader.scale;
					ge('scale').checked = reader.scale ? '' : 'checked';
					reader.recalcImageSize();
					return false;
				case 37:
					reader.prevPage();
					return false;
				case 39:
					reader.nextPage();
					return false;
			}
		};
	}
}