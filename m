Content-Type: multipart/mixed; boundary="===============8843897969987096903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 11:50:00 -0500
Message-ID: <adfc7d6f-ccb9-4f10-1667-1c716ad7cac0@gmail.com>
In-Reply-To: d4bfbc85b1e901373067ca346fd18e11@lausen.nl

--===============8843897969987096903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leonard,

> Thank you! Your patch prevents the crash. Whenever I walk towards or away=
 from
> the router and the router tries to switch me between 2.4G and 5G, I see a
> `iwd[29343]: src/station.c:station_ap_directed_roam() roam: unexpected AP
> directed roam -- ignore` logline. However, my laptop remains on the 2.4G =
/ 5G
> band respectively and does not switch.

I'm not sure what is going on, but according to iwd, you're not even connec=
ted!? =

  What does 'iwctl station wlan0 show' say?

I'm confused why the AP is even sending this.  Maybe the kernel crash you =

reported is confusing everything.

Regards,
-Denis
--===============8843897969987096903==--

