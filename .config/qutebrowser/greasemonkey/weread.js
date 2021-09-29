// ==UserScript==
// @match https://weread.qq.com/web/reader/*
// ==/UserScript==


/* 字体 */
GM_addStyle("*{font-family: 'Fira Code','KaiTi'; font-weight:bold ; !important;}");

/* app_content */
GM_addStyle(".app_content{padding:0,100; !important;}");

/* 顶部工具栏 */
GM_addStyle(".readerTopBar{max-width:100%; font-family: 'Fira Code','KaiTi' !important;}");
/* 书标题 */
GM_addStyle(".readerTopBar_title .readerTopBar_title_link{font-family: 'Fira Code','KaiTi'; !important; font-weight:bold !important;}");
/* 当前章节标题 */
GM_addStyle(".readerTopBar_title .readerTopBar_title_chapter{font-family: 'Fira Code','KaiTi' !important;}");
/* 去书架查看 */
GM_addStyle(".readerTopBar_actions .addShelfItem{font-family: 'Fira Code','KaiTi' !important;}");

/* 背影色 */
GM_addStyle(".wr_whiteTheme .renderTargetContainer .renderTargetContent .wr_readerImage_opacity {background-color: rgba(40,44,52,100) !important;}");
GM_addStyle(".wr_whiteTheme .renderTargetContainer .renderTargetContent .wr_readerBackground_opacity{background-color: rgba(171,178,191,100) !important;}");
GM_addStyle(".wr_readerBackground_opacity, .wr_readerImage_opacity {opacity: 0.2 !important;}");
/* 配图不透明度 边框 */
GM_addStyle("img.wr_readerImage_opacity {opacity: 1.0 !important;border:5px solid #ccc; margin:5px; padding:5px;}");

GM_addStyle(".wr_whiteTheme .readerContent .app_content{background-color: rgba(40,44,52,100) !important;}");
GM_addStyle(".readerChapterContent{color: rgba(171,178,191,100) !important;}");
GM_addStyle(".readerChapterContent{font-weight: bold !important;}");

/* 笔记 */
GM_addStyle(".readerNotePanel .selectionListItem{border:5px solid  #f00; font-family: 'Fira Code','KaiTi';!important;}");

/* 目录 */
GM_addStyle(".readerCatalog h2.readerCatalog_bookInfo_title .readerCatalog_bookInfo_title_txt{font-family: 'Fira Code','KaiTi' !important;}");
GM_addStyle(".readerCatalog ul.readerCatalog_list li.chapterItem span.chapterItem_text{font-family: 'Fira Code','KaiTi' !important;}");
//GM_addStyle(".readerCatalog ul.readerCatalog_list li.chapterItem_current{border:5px solid #ccc; font-family: 'Fira Code','KaiTi' !important;}");
GM_addStyle(".readerCatalog ul.readerCatalog_list li.chapterItem_current span.chapterItem_text{font-family:  'Fira Code','KaiTi' !important;}");
/* 目录-滚动条（隐藏） */
GM_addStyle(".readerCatalog_list::-webkit-scrollbar {overflow: hidden ;position: relative ;display: none;};");

/* 下一页 */
GM_addStyle(".readerFooter .readerFooter_button {font-family: 'Fira Code','KaiTi';font-weight:bold !important;}");

(function() {
    'use strict';

    /* 100% 宽度 */
    //document.getElementsByClassName("app_content")[0].style.width="100%";
    //document.getElementsByClassName("app_content")[0].style.maxWidth="100%";

    /* 顶部工具条 想要让它左右各有 100 的 margin 或 padding 但总不成功*/
    //document.getElementsByClassName("readerTopbar")[0].style.width="100%";
    //document.getElementsByClassName("readerTopbar")[0].style.maxWidth="100%";

    /* 内容容器 */
    //document.getElementsByClassName("renderTargetContainer")[0].style.width="100%";
    //document.getElementsByClassName("renderTargetContainer")[0].style.maxWidth="100%";

    /* 内容 */
    //document.getElementsByClassName("renderTargetContent")[0].style.width="100%";
    //document.getElementsByClassName("renderTargetContent")[0].style.maxWidth="100%";

})();
