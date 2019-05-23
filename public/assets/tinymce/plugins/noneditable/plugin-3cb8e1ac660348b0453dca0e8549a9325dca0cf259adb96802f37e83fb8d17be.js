/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.5 (2019-05-09)
 */

!function(){"use strict";var t=tinymce.util.Tools.resolve("tinymce.PluginManager"),c=tinymce.util.Tools.resolve("tinymce.util.Tools"),l=function(t){return t.getParam("noneditable_noneditable_class","mceNonEditable")},u=function(t){return t.getParam("noneditable_editable_class","mceEditable")},f=function(t){var n=t.getParam("noneditable_regexp",[]);return n&&n.constructor===RegExp?[n]:n},s=function(n){return function(t){return-1!==(" "+t.attr("class")+" ").indexOf(n)}},d=function(i,o,c){return function(t){var n=arguments,e=n[n.length-2],r=0<e?o.charAt(e-1):"";if('"'===r)return t;if(">"===r){var a=o.lastIndexOf("<",e);if(-1!==a&&-1!==o.substring(a,e).indexOf('contenteditable="false"'))return t}return'<span class="'+c+'" data-mce-content="'+i.dom.encode(n[0])+'">'+i.dom.encode("string"==typeof n[1]?n[1]:n[0])+"</span>"}},n=function(n){var t,e,r="contenteditable";t=" "+c.trim(u(n))+" ",e=" "+c.trim(l(n))+" ";var a=s(t),i=s(e),o=f(n);n.on("PreInit",function(){0<o.length&&n.on("BeforeSetContent",function(t){!function(t,n,e){var r=n.length,a=e.content;if("raw"!==e.format){for(;r--;)a=a.replace(n[r],d(t,a,l(t)));e.content=a}}(n,o,t)}),n.parser.addAttributeFilter("class",function(t){for(var n,e=t.length;e--;)n=t[e],a(n)?n.attr(r,"true"):i(n)&&n.attr(r,"false")}),n.serializer.addAttributeFilter(r,function(t){for(var n,e=t.length;e--;)n=t[e],(a(n)||i(n))&&(0<o.length&&n.attr("data-mce-content")?(n.name="#text",n.type=3,n.raw=!0,n.value=n.attr("data-mce-content")):n.attr(r,null))})})};t.add("noneditable",function(t){n(t)}),function e(){}}();
