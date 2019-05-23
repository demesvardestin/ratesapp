/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.5 (2019-05-09)
 */

!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),s=tinymce.util.Tools.resolve("tinymce.util.Tools"),d=function(e){return e.getParam("content_style","")},i=function(t){var n="",i=t.dom.encode,e=d(t);n+='<base href="'+i(t.documentBaseURI.getURI())+'">',e&&(n+='<style type="text/css">'+e+"</style>"),s.each(t.contentCSS,function(e){n+='<link type="text/css" rel="stylesheet" href="'+i(t.documentBaseURI.toAbsolute(e))+'">'});var o=t.settings.body_id||"tinymce";-1!==o.indexOf("=")&&(o=(o=t.getParam("body_id","","hash"))[t.id]||o);var r=t.settings.body_class||"";-1!==r.indexOf("=")&&(r=(r=t.getParam("body_class","","hash"))[t.id]||"");var a=t.getBody().dir,c=a?' dir="'+i(a)+'"':"";return"<!DOCTYPE html><html><head>"+n+'</head><body id="'+i(o)+'" class="mce-content-body '+i(r)+'"'+c+">"+t.getContent()+'<script>document.addEventListener && document.addEventListener("click", function(e) {for (var elm = e.target; elm; elm = elm.parentNode) {if (elm.nodeName === "A") {e.preventDefault();}}}, false);<\/script> </body></html>'},t=function(n){n.addCommand("mcePreview",function(){var e,t;t=i(e=n),e.windowManager.open({title:"Preview",size:"large",body:{type:"panel",items:[{name:"preview",type:"iframe",sandboxed:!0}]},buttons:[{type:"cancel",name:"close",text:"Close",primary:!0}],initialData:{preview:t}}).focus("close")})},n=function(e){e.ui.registry.addButton("preview",{icon:"preview",tooltip:"Preview",onAction:function(){return e.execCommand("mcePreview")}}),e.ui.registry.addMenuItem("preview",{icon:"preview",text:"Preview",onAction:function(){return e.execCommand("mcePreview")}})};e.add("preview",function(e){t(e),n(e)}),function o(){}}();
