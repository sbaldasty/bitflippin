<%!
    title_ = 'Time release lock'
    date_ = '2023-08-05'
    enable_gallery_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">
    <p>asdf content!</p>
    <%bflib:gallery fn="time-release-lock-charging-port" fid="00000003" x="1650", y="2150", width="1500", angle="150">
        <%def name="title()">Charging port</%def>
        <%def name="caption()">Charge through a USB cable every couple months. If the battery runs out of charge, the lock cannot open again until it is at least partially recharged.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="time-release-lock-timer" fid="00000004" x="0", y="200", width="3000", angle="0">
        <%def name="title()">Setting the timer</%def>
        <%def name="caption()">Set the timer for about 20 hours. The lock should release overnight, giving you flexibility around when you get your junk food in the morning.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="toolbox-of-chocolate" fid="00000005" x="0", y="1150", width="2980", angle="0">
        <%def name="title()">Stocking the container</%def>
        <%def name="caption()">Restock infrequently to minimize your free access to junk food; but when you do, fill the container completely. Take advantage of good sales and bulk deals.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="open-time-release-lock" fid="00000006" x="1000", y="1020", width="2900", angle="75">
        <%def name="title()">Basic features</%def>
        <%def name="caption()">This lock is currently available on Amazon for under $25. It is sturdy and has worked reliably for several years. It has a simple digital display, and buttons for setting and starting the timer.</%def>
    </%bflib:gallery>
</%block>