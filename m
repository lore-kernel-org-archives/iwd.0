Content-Type: multipart/mixed; boundary="===============8470057054864874226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 10:15:43 -0500
Message-ID: <4a03689b-8c38-bf54-6b9b-1f158ce4780f@gmail.com>
In-Reply-To: 1077324508f3b40f15026b53b08e46f2@lausen.nl

--===============8470057054864874226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leonard,

On 4/5/22 04:40, Leonard Lausen wrote:
> Hi Denis,
> =

> (resending as prior message to the iwd mailing-list was rejected as I was=
 not a list member)
> =

> thank you for forwarding this report to the right mailing list. I'm

no worries

> adding the debug log below. The router triggering the issue is
> ec:a8:1f:99:cf:f0. I noticed that the issue will not occur when
> disabling Band Steering on the router and splitting the 2.4G and 5G
> networks into two separate SSIDs.
> =


I'm curious what brand / model / firmware of router is this?

<snip>

> Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/scan.c:scan_notify() Scan =
notification Trigger
> Scan(33)
> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/netdev.c:netdev_unicast_no=
tify() Unicast
> notification Frame(59)

Looks like it is sending out a completely unsolicited AP directed roaming f=
rame. =

  I need to dig into the specs, but I'm not aware of any where this is allo=
wed.

> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_direc=
ted_roam() ifindex: 23
> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_direc=
ted_roam() roam: BSS
> transition received from AP: Disassociation Time: 0, Validity interval: 1=
00
> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_direc=
ted_roam() roam: AP sent a
> preferred candidate list
> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_neighbor=
_report_cb() ifindex: 23,
> error: 0()
> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:parse_neighbor_r=
eport() Neighbor report
> received for ec:a8:1f:99:cf:e8: ch 6 (oper class 4), MD not set

And that's what causes a crash.  I'll send a patch for you to try shortly.


<snip>

> =

> After enabling (to collect the debug logs) and disabling again Band
> Steering on the router, AX210 would no longer authenticate with the
> router "denied authentication (status 33)" and finally cause kernel
> crash, followed by a kernel hang that could only be resolved by
> restarting the WiFi network (by logging into the router admin interface
> from my phone and changing WLAN Mode setting "Mixed 802.11 a/n/ac/ax" to
> "Mixed 802.11 n/ac" which triggers the router to shutdown and start
> again the WiFi network) followed by another crash. These are probably
> unrelated to this issue, but you may know if and where I could report
> them so I'm including them here. This was with AX210 firmware version
> 68.01d30b0c.0 ty-a0-gf-a0-68.ucode and Linux 5.17.0-rc8.

yikes.  You can try to report this on the linux-wireless mailing list:
linux-wireless(a)vger.kernel.org

or via kernel bugzilla:
https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=3Dn=
etwork-wireless&product=3DDrivers

Regards,
-Denis
--===============8470057054864874226==--

