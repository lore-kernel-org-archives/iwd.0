Content-Type: multipart/mixed; boundary="===============1083416695860991175=="
MIME-Version: 1.0
From: Leonard Lausen <leonard at lausen.nl>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 16:28:40 +0000
Message-ID: <d4bfbc85b1e901373067ca346fd18e11@lausen.nl>
In-Reply-To: 4a03689b-8c38-bf54-6b9b-1f158ce4780f@gmail.com

--===============1083416695860991175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

April 5, 2022 3:18 PM, "Denis Kenzior" <denkenz(a)gmail.com> wrote:
> I'm curious what brand / model / firmware of router is this?

This is a Vodafone Station WiFi 6 also known as Technicolor CGA6444VF. Firm=
ware-Version 19.3B57-1.0.41.
 =

>> Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/scan.c:scan_notify() Scan=
 notification Trigger
>> Scan(33)
>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/netdev.c:netdev_unicast_n=
otify() Unicast
>> notification Frame(59)
> =

> Looks like it is sending out a completely unsolicited AP directed roaming=
 frame. I need to dig into
> the specs, but I'm not aware of any where this is allowed.
> =

>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_dire=
cted_roam() ifindex: 23
>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_dire=
cted_roam() roam: BSS
>> transition received from AP: Disassociation Time: 0, Validity interval: =
100
>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_dire=
cted_roam() roam: AP sent a
>> preferred candidate list
>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_neighbo=
r_report_cb() ifindex: 23,
>> error: 0()
>> Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:parse_neighbor_=
report() Neighbor report
>> received for ec:a8:1f:99:cf:e8: ch 6 (oper class 4), MD not set
> =

> And that's what causes a crash. I'll send a patch for you to try shortly.

Thank you! Your patch prevents the crash. Whenever I walk towards or away f=
rom
the router and the router tries to switch me between 2.4G and 5G, I see a
`iwd[29343]: src/station.c:station_ap_directed_roam() roam: unexpected AP
directed roam -- ignore` logline. However, my laptop remains on the 2.4G / =
5G
band respectively and does not switch.

Do you think the router's band steering functionality is broken / non-stand=
ard?

>> After enabling (to collect the debug logs) and disabling again Band
>> Steering on the router, AX210 would no longer authenticate with the
>> router "denied authentication (status 33)" and finally cause kernel
>> crash, followed by a kernel hang that could only be resolved by
>> restarting the WiFi network (by logging into the router admin interface
>> from my phone and changing WLAN Mode setting "Mixed 802.11 a/n/ac/ax" to
>> "Mixed 802.11 n/ac" which triggers the router to shutdown and start
>> again the WiFi network) followed by another crash. These are probably
>> unrelated to this issue, but you may know if and where I could report
>> them so I'm including them here. This was with AX210 firmware version
>> 68.01d30b0c.0 ty-a0-gf-a0-68.ucode and Linux 5.17.0-rc8.
> =

> yikes. You can try to report this on the linux-wireless mailing list:
> linux-wireless(a)vger.kernel.org
> =

> or via kernel bugzilla:
> https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=
=3Dnetwork-wireless&product=3DDrive
> s

Ok, thank you.

Best regards
Leonard
--===============1083416695860991175==--

