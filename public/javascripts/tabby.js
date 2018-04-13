//Copyright 2007 Keybasket.com
var Tabby = {
  Version : '0.07',
  Manager : Class.create(),
  Pair    : Class.create(),
  Tab     : Class.create(),
  Page    : Class.create(),
  Helpers : {},
  Globals : {}
};

Tabby.Helpers.getParentTab = function(node) {
  var p = node.up('div[tabby_id]');
  if (p) {
    var tabbyId = p.getAttribute('tabby_id');
    var p = Tabby.Page.idx.id[tabbyId];
    return p.tPair;
  }
};

Tabby.Helpers.getTabByPath = function(path) {
  if (Tabby.Page.idx.path.hasOwnProperty(path)) {
    return Tabby.Page.idx.path[path].tPair;
  }
  return [path];
};

Tabby.Manager.prototype = {
  initialize : function(tabContainerId, binderId, opts) {
    if (!opts) opts = {};
    this.tabContainerNode = $(tabContainerId);
    this.binderNode = $(binderId);
    this.idx = [];
  },
  createTab : function(label, opts) {
    var t = new Tabby.Pair(label, this, opts);
    this.idx.push(t);
    return t;
  },
  registerSelected : function(tPair) {
    if (this.selectedPair) {
      this.prevPair = this.selectedPair;
      this.selectedPair.deselect();
    }
    this.selectedPair = tPair;
  },
  selectPrevPair : function() {
    if (this.prevPair) this.prevPair.select();
  },
  autoSetup : function() {
    var e = this.binderNode;
    if (e.hasChildNodes()) {
      var self = this;
      var children = $A(e.childNodes).each(function(n) {
        if (n.nodeType != 3) self.createTab(
          n.readAttribute('tabby_name'),
          {page : n}
        );
      });
      this.selectTab(0);
    }
  },
  getCurrPageNode : function() {
    return this.selectedPair.page.rootNode;
  },
  selectTab : function(n) {
    this.idx[n].select();
  }
};

Tabby.Pair.prototype = {
  initialize : function(label, tManager, opts) {
    this.opts = opts || {};
    this.tManager = tManager;
    this.tab = new Tabby.Tab(label, this);
    this.page = new Tabby.Page(this);
    this.attrs = {};
  },
  loadUrl : function (url, opts) {
    this.page.loadUrl(url, opts);
  },
  reload : function() {
    this.loadUrl(this.opts.url);
  },
  select : function() {
    this.tManager.registerSelected(this);
    this.tab.highlight();
    this.page.show();
  },
  deselect : function() {
    this.tab.unhighlight();
    this.page.hide();
  },
  setLabel : function(l) {
    this.tab.setLabel(l);
  },
  setAttribute : function(k, v) {
    this.attrs[k] = v;
  },
  getAttribute : function(k) {
    return this.attrs[k];
  },
  getPageNode : function() {
    return this.page.rootNode;
  },
  close : function() {
    this.tManager.selectPrevPair();
    [this.tab, this.page].each(function(e) {
      e.rootNode.remove();
    });
  }
};

Tabby.Tab.prototype = {
  initialize : function(label, tPair) {
    this.tPair = tPair;
    this.createElements();
    this.setLabel(label);
  },
  showLoadingImg : function() {
    if (this.loadingImgNode) this.loadingImgNode.show();
  },
  hideLoadingImg : function() {
    if (this.loadingImgNode) this.loadingImgNode.hide();
  },
  createElements : function() {
    this.rootNode = $(document.createElement('li'));
    this.tPair.tManager.tabContainerNode.appendChild(this.rootNode)

    var loadingImg = Tabby.Globals.loadingImg;
    if (loadingImg) {
      var imgNode = document.createElement('img');
      imgNode.hide();
      imgNode.setAttribute('src', loadingImg);
      imgNode.className = 'loading';
      this.rootNode.appendChild(imgNode);
      this.loadingImgNode = imgNode;
    }

    this.labelNode = document.createElement('span');
    this.rootNode.appendChild(this.labelNode);
    Event.observe(
      this.labelNode,
      'click',
      this.tPair.select.bind(this.tPair)
    );

    if (this.tPair.opts.closeable && Tabby.Globals.closeImg) {
      var xNode = document.createElement('img');
      xNode.setAttribute('src', Tabby.Globals.closeImg);
      xNode.style.verticalAlign = 'top';
      this.rootNode.appendChild(xNode);
      Event.observe(
        xNode,
        'click',
        this.tPair.close.bind(this.tPair)
      );
    }
  },
  highlight : function() {
    this.rootNode.addClassName('tabby_selected');
  },
  unhighlight : function() {
    this.rootNode.removeClassName('tabby_selected');
  },
  setLabel : function(l) {
    while (this.labelNode.firstChild)
      this.labelNode.removeChild(this.labelNode.firstChild);
    this.labelNode.appendChild(document.createTextNode(l));
  }
};

Tabby.Page.globalId = 0;
Tabby.Page.idx = {id : [], path : {}};
Tabby.Page.prototype = {
  initialize : function(tPair) {
    this.globalId = Tabby.Page.globalId++;
    Tabby.Page.idx.id[this.globalId] = this;
    this.tPair = tPair;
    if (tPair.opts.page) {
      this.rootNode = $(tPair.opts.page);
      this.hide();
    } else {
      this.createElements();
    }
    if (tPair.opts.url && !tPair.opts.deferLoading) {
      this.loadUrl(tPair.opts.url, tPair.opts);
    }
    this.rootNode.setAttribute('tabby_id', this.globalId);
  },
  createElements : function() {
    this.rootNode = $(document.createElement('div'));
    this.tPair.tManager.binderNode.appendChild(this.rootNode);
    this.hide();
  },
  loadUrl : function(url, opts) {
    this.tPair.tab.showLoadingImg();
    Tabby.Page.idx.path[url] = this;
    if (!opts) opts = {};
    opts.evalScripts = opts.hasOwnProperty('evalScripts')
      ? opts.evalScripts
      : true;
    var self = this;
    var customHook = opts.onSuccess;
    opts.onSuccess = function() {
      if (customHook) customHook();
      self.tPair.tab.hideLoadingImg();
      if (opts.autoSelect) self.tPair.select();
    }
    new Ajax.Updater({
      success : this.rootNode
    }, url, opts);
  },
  show : function() {
    if (this.tPair.opts.deferLoading && !this.stopReloading) {
      this.loadUrl(this.tPair.opts.url);
      if (!this.tPair.opts.reloadOnSelect)
        this.stopReloading = true;
    }
    this.rootNode.show();
  },
  hide : function() {
    this.rootNode.hide();
  }
};
