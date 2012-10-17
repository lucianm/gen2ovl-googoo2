gen2ovl-googoo2
===============

My Gentoo overlay with ebuilds related to VDR &amp; more...


To install it, just get the file <b>overlay_gen2ovl-googoo2.xml</b> (follow the "Raw" link) and place it in your layman storage directory, then reference it in <b>/etc/layman/layman.cfg</b> under the <b>"overlays:"</b> section as follows:

<b>file://%(storage)s/overlay_gen2ovl-googoo2.xml</b>

Then you can effectively add the overlay by issuing the command:

<b>layman -f -a gen2ovl-googoo2</b>


Have phun!
