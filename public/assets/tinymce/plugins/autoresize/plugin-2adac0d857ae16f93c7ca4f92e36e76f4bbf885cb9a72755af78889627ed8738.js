/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.5 (2019-05-09)
 */

!function(){"use strict";var i=function(e){var t=e,n=function(){return t};return{get:n,set:function(e){t=e},clone:function(){return i(n())}}},e=tinymce.util.Tools.resolve("tinymce.PluginManager"),d=tinymce.util.Tools.resolve("tinymce.Env"),r=tinymce.util.Tools.resolve("tinymce.util.Delay"),h=function(e){return e.getParam("min_height",e.getElement().offsetHeight,"number")},v=function(e){return e.getParam("max_height",0,"number")},o=function(e){return e.getParam("autoresize_overflow_padding",1,"number")},y=function(e){return e.getParam("autoresize_bottom_margin",50,"number")},u=function(e){return e.getParam("autoresize_on_init",!0,"boolean")},a=function(e,t,n,i,o){r.setEditorTimeout(e,function(){C(e,t),n--?a(e,t,n,i,o):o&&o()},i)},p=function(e,t){var n=e.getBody();n&&(n.style.overflowY=t?"":"hidden",t||(n.scrollTop=0))},z=function(e,t,n,i){var o=parseInt(e.getStyle(t,n,i),10);return isNaN(o)?0:o},C=function(e,t){var n,i,o,r=e.dom,u=e.getDoc();if(u)if((a=e).plugins.fullscreen&&a.plugins.fullscreen.isFullscreen())p(e,!0);else{var a,s=u.documentElement,c=y(e);i=h(e);var f=z(r,s,"margin-top",!0),g=z(r,s,"margin-bottom",!0);(o=s.offsetHeight+f+g+c)<0&&(o=0);var l=e.getContainer().offsetHeight-e.getContentAreaContainer().offsetHeight;o+l>h(e)&&(i=o+l);var m=v(e);m&&m<i?(i=m,p(e,!0)):p(e,!1),i!==t.get()&&(n=i-t.get(),r.setStyle(e.getContainer(),"height",i+"px"),t.set(i),d.webkit&&n<0&&C(e,t))}},n={setup:function(t,n){t.on("init",function(){var e=o(t);t.dom.setStyles(t.getBody(),{paddingLeft:e,paddingRight:e,"min-height":0})}),t.on("NodeChange SetContent keyup FullscreenStateChanged ResizeContent",function(e){C(t,n)}),u(t)&&t.on("init",function(){a(t,n,20,100,function(){a(t,n,5,1e3)})})},resize:C},s=function(e,t){e.addCommand("mceAutoResize",function(){n.resize(e,t)})};e.add("autoresize",function(e){if(e.settings.hasOwnProperty("resize")||(e.settings.resize=!1),!e.inline){var t=i(0);s(e,t),n.setup(e,t)}}),function t(){}}();
