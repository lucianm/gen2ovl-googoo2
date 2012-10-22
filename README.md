gen2ovl-googoo2
===============

My Gentoo overlay with ebuilds related to VDR &amp; more...


To install it, just get the overlay description file https://github.com/lucianm/gen2ovl-googoo2/raw/master/overlay_gen2ovl-googoo2.xml and place it in your layman storage directory, then reference it in <b>/etc/layman/layman.cfg</b> under the <b>"overlays:"</b> section as follows:

<pre>file://%(storage)s/overlay_gen2ovl-googoo2.xml</pre>

Then you can effectively add the overlay by issuing the command:

<pre>layman -f -a gen2ovl-googoo2</pre>


Have phun!
