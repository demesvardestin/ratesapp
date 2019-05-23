/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.5 (2019-05-09)
 */

!function(c){"use strict";var n,t,e,r,o=tinymce.util.Tools.resolve("tinymce.PluginManager"),u=tinymce.util.Tools.resolve("tinymce.util.Tools"),i=function(n,t){var e,r=n.dom,o=n.selection.getSelectedBlocks();o.length&&(e=r.getAttrib(o[0],"dir"),u.each(o,function(n){r.getParent(n.parentNode,'*[dir="'+t+'"]',r.getRoot())||r.setAttrib(n,"dir",e!==t?t:null)}),n.nodeChanged())},f=function(n){n.addCommand("mceDirectionLTR",function(){i(n,"ltr")}),n.addCommand("mceDirectionRTL",function(){i(n,"rtl")})},d=function(n){return function(){return n}},l=d(!1),a=d(!0),N=l,m=a,s=function(){return T},T=(r={fold:function(n,t){return n()},is:N,isSome:N,isNone:m,getOr:e=function(n){return n},getOrThunk:t=function(n){return n()},getOrDie:function(n){throw new Error(n||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:e,orThunk:t,map:s,ap:s,each:function(){},bind:s,flatten:s,exists:N,forall:m,filter:s,equals:n=function(n){return n.isNone()},equals_:n,toArray:function(){return[]},toString:d("none()")},Object.freeze&&Object.freeze(r),r),g=function(e){var n=function(){return e},t=function(){return o},r=function(n){return n(e)},o={fold:function(n,t){return t(e)},is:function(n){return e===n},isSome:m,isNone:N,getOr:n,getOrThunk:n,getOrDie:n,getOrNull:n,getOrUndefined:n,or:t,orThunk:t,map:function(n){return g(n(e))},ap:function(n){return n.fold(s,function(n){return g(n(e))})},each:function(n){n(e)},bind:r,flatten:n,exists:r,forall:r,filter:function(n){return n(e)?o:T},equals:function(n){return n.is(e)},equals_:function(n,t){return n.fold(N,function(n){return t(e,n)})},toArray:function(){return[e]},toString:function(){return"some("+e+")"}};return o},O=function(n){return null===n||n===undefined?T:g(n)},E=function(n){if(null===n||n===undefined)throw new Error("Node cannot be null or undefined");return{dom:d(n)}},y={fromHtml:function(n,t){var e=(t||c.document).createElement("div");if(e.innerHTML=n,!e.hasChildNodes()||1<e.childNodes.length)throw c.console.error("HTML does not have a single root node",n),new Error("HTML must have a single root node");return E(e.childNodes[0])},fromTag:function(n,t){var e=(t||c.document).createElement(n);return E(e)},fromText:function(n,t){var e=(t||c.document).createTextNode(n);return E(e)},fromDom:E,fromPoint:function(n,t,e){var r=n.dom();return O(r.elementFromPoint(t,e)).map(E)}},D=function(t){return function(n){return function(n){if(null===n)return"null";var t=typeof n;return"object"===t&&Array.prototype.isPrototypeOf(n)?"array":"object"===t&&String.prototype.isPrototypeOf(n)?"string":t}(n)===t}},p=(D("string"),D("boolean"),D("function")),h=(D("number"),Array.prototype.slice,p(Array.from)&&Array.from,Object.keys,function(n){return n.style!==undefined}),_=(c.Node.ATTRIBUTE_NODE,c.Node.CDATA_SECTION_NODE,c.Node.COMMENT_NODE,c.Node.DOCUMENT_NODE,c.Node.DOCUMENT_TYPE_NODE,c.Node.DOCUMENT_FRAGMENT_NODE,c.Node.ELEMENT_NODE),C=c.Node.TEXT_NODE,v=(c.Node.PROCESSING_INSTRUCTION_NODE,c.Node.ENTITY_REFERENCE_NODE,c.Node.ENTITY_NODE,c.Node.NOTATION_NODE,function(t){return function(n){return n.dom().nodeType===t}}),A=(v(_),v(C)),b=function(n,t){var e,r,o=n.dom(),u=c.window.getComputedStyle(o).getPropertyValue(t),i=""!==u||(r=A(e=n)?e.dom().parentNode:e.dom())!==undefined&&null!==r&&r.ownerDocument.body.contains(r)?u:S(o,t);return null===i?undefined:i},S=function(n,t){return h(n)?n.style.getPropertyValue(t):""},R=function(t,r){return function(e){var n=function(n){var t=y.fromDom(n.element);e.setActive(("rtl"===b(t,"direction")?"rtl":"ltr")===r)};return t.on("NodeChange",n),function(){return t.off("NodeChange",n)}}},w=function(n){n.ui.registry.addToggleButton("ltr",{tooltip:"Left to right",icon:"ltr",onAction:function(){return n.execCommand("mceDirectionLTR")},onSetup:R(n,"ltr")}),n.ui.registry.addToggleButton("rtl",{tooltip:"Right to left",icon:"rtl",onAction:function(){return n.execCommand("mceDirectionRTL")},onSetup:R(n,"rtl")})};o.add("directionality",function(n){f(n),w(n)}),function M(){}}(window);
