/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.5 (2019-05-09)
 */

!function(){"use strict";var e,n,t=tinymce.util.Tools.resolve("tinymce.PluginManager"),s=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),f=tinymce.util.Tools.resolve("tinymce.util.I18n"),i=tinymce.util.Tools.resolve("tinymce.util.Tools"),a=function(t){return t.getParam("toc_class","mce-toc")},m=function(t){var e=t.getParam("toc_header","h2");return/^h[1-6]$/.test(e)?e:"h2"},c=function(t){var e=parseInt(t.getParam("toc_depth","3"),10);return 1<=e&&e<=9?e:3},l=(e="mcetoc_",n=0,function(){var t=(new Date).getTime().toString(32);return e+t+(n++).toString(32)}),u=function u(t){var e,n=[];for(e=1;e<=t;e++)n.push("h"+e);return n.join(",")},v=function(n){var o=a(n),t=m(n),e=u(c(n)),r=n.$(e);return r.length&&/^h[1-9]$/i.test(t)&&(r=r.filter(function(t,e){return!n.dom.hasClass(e.parentNode,o)})),i.map(r,function(t){return{id:t.id?t.id:l(),level:parseInt(t.nodeName.replace(/^H/i,""),10),title:n.$.text(t),element:t}})},d=function(t){var e,n,o,r,i,c,a,l="",u=v(t),d=function(t){var e,n=9;for(e=0;e<t.length;e++)if(t[e].level<n&&(n=t[e].level),1===n)return n;return n}(u)-1;if(!u.length)return"";for(l+=(i=m(t),c=f.translate("Table of Contents"),a="</"+i+">","<"+i+' contenteditable="true">'+s.DOM.encode(c)+a),e=0;e<u.length;e++){if((o=u[e]).element.id=o.id,r=u[e+1]&&u[e+1].level,d===o.level)l+="<li>";else for(n=d;n<o.level;n++)l+="<ul><li>";if(l+='<a href="#'+o.id+'">'+o.title+"</a>",r!==o.level&&r)for(n=o.level;r<n;n--)l+="</li></ul><li>";else l+="</li>",r||(l+="</ul>");d=o.level}return l},g=function(t){var e=a(t),n=t.$("."+e);n.length&&t.undoManager.transact(function(){n.html(d(t))})},o={hasHeaders:function(t){return 0<v(t).length},insertToc:function(t){var e,n,o,r,i=a(t),c=t.$("."+i);o=t,!(r=c).length||0<o.dom.getParents(r[0],".mce-offscreen-selection").length?t.insertContent((n=d(e=t),'<div class="'+e.dom.encode(a(e))+'" contenteditable="false">'+n+"</div>")):g(t)},updateToc:g},r=function(t){t.addCommand("mceInsertToc",function(){o.insertToc(t)}),t.addCommand("mceUpdateToc",function(){o.updateToc(t)})},h=function(t){var n=t.$,o=a(t);t.on("PreProcess",function(t){var e=n("."+o,t.node);e.length&&(e.removeAttr("contentEditable"),e.find("[contenteditable]").removeAttr("contentEditable"))}),t.on("SetContent",function(){var t=n("."+o);t.length&&(t.attr("contentEditable",!1),t.children(":first-child").attr("contentEditable",!0))})},p=function(n){return function(t){var e=function(){return t.setDisabled(n.readonly||!o.hasHeaders(n))};return e(),n.on("LoadContent SetContent change",e),function(){return n.on("LoadContent SetContent change",e)}}},T=function(t){var e;t.ui.registry.addButton("toc",{icon:"toc",tooltip:"Table of contents",onAction:function(){return t.execCommand("mceInsertToc")},onSetup:p(t)}),t.ui.registry.addButton("tocupdate",{icon:"reload",tooltip:"Update",onAction:function(){return t.execCommand("mceUpdateToc")}}),t.ui.registry.addMenuItem("toc",{icon:"toc",text:"Table of contents",onAction:function(){return t.execCommand("mceInsertToc")},onSetup:p(t)}),t.ui.registry.addContextToolbar("toc",{items:"tocupdate",predicate:(e=t,function(t){return t&&e.dom.is(t,"."+a(e))&&e.getBody().contains(t)}),scope:"node",position:"node"})};t.add("toc",function(t){r(t),T(t),h(t)}),function y(){}}();
