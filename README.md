gen2ovl-googoo2
===============

My Gentoo overlay with ebuilds related to VDR &amp; more...


To install it, just get the overlay description file [overlay_gen2ovl-googoo2.xml](https://github.com/lucianm/gen2ovl-googoo2/raw/master/overlay_gen2ovl-googoo2.xml) and place it in your layman storage directory, then reference it in <b>/etc/layman/layman.cfg</b> under the <b>"overlays:"</b> section as follows:

<pre>file://%(storage)s/overlay_gen2ovl-googoo2.xml</pre>

Alternatively, on newer layman versions, you can just place it in the <b>/etc/layman/overlays</b> directory (but then do not reference it in the config file).

Then you can effectively add the overlay by issuing the command:

<pre>layman -f -a gen2ovl-googoo2</pre>

If using eselect repository, you can use the command:

<pre>eselect repository add gen2ovl-googoo2 git https://github.com/lucianm/gen2ovl-googoo2.git</pre>

Have phun!

