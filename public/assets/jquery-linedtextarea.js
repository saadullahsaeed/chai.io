/**
 * jQuery Lined Textarea Plugin 
 *   http://alan.blog-city.com/jquerylinedtextarea.htm
 *
 * Copyright (c) 2010 Alan Williamson
 * 
 * Version: 
 *    $Id: jquery-linedtextarea.js 464 2010-01-08 10:36:33Z alan $
 *
 * Released under the MIT License:
 *    http://www.opensource.org/licenses/mit-license.php
 * 
 * Usage:
 *   Displays a line number count column to the left of the textarea
 *   
 *   Class up your textarea with a given class, or target it directly
 *   with JQuery Selectors
 *   
 *   $(".lined").linedtextarea({
 *   	selectedLine: 10,
 *    selectedClass: 'lineselect'
 *   });
 *
 * History:
 *   - 2010.01.08: Fixed a Google Chrome layout problem
 *   - 2010.01.07: Refactored code for speed/readability; Fixed horizontal sizing
 *   - 2010.01.06: Initial Release
 *
 */
(function(e){e.fn.linedtextarea=function(t){var n=e.extend({},e.fn.linedtextarea.defaults,t),r=function(e,t,r){while(e.height()-t<=0)r==n.selectedLine?e.append("<div class='lineno lineselect'>"+r+"</div>"):e.append("<div class='lineno'>"+r+"</div>"),r++;return r};return this.each(function(){var t=1,i=e(this);i.attr("wrap","off"),i.css({resize:"none"});var s=i.outerWidth();i.wrap("<div class='linedtextarea'></div>");var o=i.parent().wrap("<div class='linedwrap' style='width:"+s+"px'></div>"),u=o.parent();u.prepend("<div class='lines' style='width:50px'></div>");var a=u.find(".lines");a.height(i.height()+6),a.append("<div class='codelines'></div>");var f=a.find(".codelines");t=r(f,a.height(),1);if(n.selectedLine!=-1&&!isNaN(n.selectedLine)){var l=parseInt(i.height()/(t-2)),c=parseInt(l*n.selectedLine)-i.height()/2;i[0].scrollTop=c}var h=a.outerWidth(),p=parseInt(u.css("border-left-width"))+parseInt(u.css("border-right-width"))+parseInt(u.css("padding-left"))+parseInt(u.css("padding-right")),d=s-p,v=s-h-p-20;i.width(v),u.width(d),i.scroll(function(n){var i=e(this)[0],s=i.scrollTop,o=i.clientHeight;f.css({"margin-top":-1*s+"px"}),t=r(f,s+o,t)}),i.resize(function(t){var n=e(this)[0];a.height(n.clientHeight+6)})})},e.fn.linedtextarea.defaults={selectedLine:-1,selectedClass:"lineselect"}})(jQuery);