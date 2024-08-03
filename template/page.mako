<%!
    from bflib import HEADSHOT_WIDTH

    enable_article_ = False
    enable_download_ = False
    enable_gallery_ = False
    enable_codesnippets_ = False
    enable_headline_ = False
    enable_lang_bash_ = False
    enable_lang_python_ = False
    enable_lang_xml_ = False
%>
<!DOCTYPE html>
<html>
<head>
<title>${self.attr.title_} | bitflippin.com</title>
<meta charset="utf-8">
<meta name="robots" content="index, follow">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="Steven Baldasty">
<link rel="icon" type="image/x-icon" href="/logo.png">
<link rel="stylesheet" href="/page.css">
% if self.attr.enable_article_:
    <link rel="stylesheet" href="/article.css">
% endif
% if self.attr.enable_codesnippets_:
    <link rel="stylesheet" href="/codesnippet.css">
% endif
% if self.attr.enable_download_:
    <link rel="stylesheet" href="/download.css">
% endif
% if self.attr.enable_gallery_:
    <link rel="stylesheet" href="/gallery.css">
% endif
% if self.attr.enable_headline_:
    <link rel="stylesheet" href="/headline.css">
% endif
% if self.attr.enable_lang_bash_:
    <link rel="stylesheet" href="/lang-bash.css">
% endif
% if self.attr.enable_lang_python_:
    <link rel="stylesheet" href="/lang-python.css">
% endif
% if self.attr.enable_lang_xml_:
    <link rel="stylesheet" href="/lang-xml.css">
% endif
</head>
<body>
<header>
<a href="/">
<img alt="Logo" class="logo" src="/logo.png" title="Logo" width="${HEADSHOT_WIDTH}px">
</a>
<div class="expo">
<div class="title">bitflippin.com</div>
<div>Steven's personal website and bit flipping laboratory</div>
</div>
</header>
<main>
<%block name="main"/>
</main>
<footer>
<div class="author">
<img alt="Headshot" src="/headshot.jpg" title="Getting my picture taken in Burlington" width="86px">
<div>Steven Baldasty</div>
</div>
<div class="biography">Proud father, Barefoot runner, Chocolate enthusiast, Seasoned software engineer, Starry eyed PhD student, Novice human</div>
<div class="social-media">
<a href="https://www.linkedin.com/in/sbaldasty/"><img alt="LinkedIn" height="24px" src="/linkedin.svg" title="LinkedIn" width="24px"></a>
<a href="https://github.com/sbaldasty"><img alt="GitHub" height="24px" src="/github.svg" title="GitHub" width="24px"></a>
<a href="https://www.instagram.com/sbaldasty/"><img alt="Instagram" height="24px" src="/instagram.svg" title="Instagram" width="24px"></a>
<a href="https://www.facebook.com/sbaldasty"><img alt="Facebook" height="24px" src="/facebook.svg" title="Facebook" width="24px"></a>
<a href="https://twitter.com/sbaldasty"><img alt="Twitter" height="24px" src="/twitter.svg" title="Twitter" width="24px"></a>
</div>
</footer>
</body>
</html>