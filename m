Content-Type: multipart/mixed; boundary="===============8094616086506111107=="
MIME-Version: 1.0
From: Mauro Condarelli <mc5686@mclink.it>
Subject: Dancing iwd connection
Date: Mon, 20 Apr 2020 12:53:05 +0200
Message-ID: <b50a812c-68dc-620f-f97c-01e3494318fe@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8094616086506111107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I am using iwd standalone and it works.

Problem is I see, every few seconds, what seems an attempt to reassociate:

[=C2=A0 149.402346] wlan0: authenticate with a0:04:60:9f:2f:f8
[=C2=A0 149.408961] wlan0: send auth to a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 149.425285] wlan0: authenticated
[=C2=A0 149.430547] wlan0: associate with a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 149.442573] wlan0: RX AssocResp from a0:04:60:9f:2f:f8 (capab=3D0x4=
11 status=3D0 aid=3D1)
[=C2=A0 149.451181] wlan0: associated
[=C2=A0 154.083051] wlan0: authenticate with a0:04:60:9f:2f:f8
[=C2=A0 154.089863] wlan0: send auth to a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 154.102931] wlan0: authenticated
[=C2=A0 154.110477] wlan0: associate with a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 154.120922] wlan0: RX AssocResp from a0:04:60:9f:2f:f8 (capab=3D0x4=
11 status=3D0 aid=3D1)
[=C2=A0 154.129485] wlan0: associated
[=C2=A0 167.402736] wlan0: authenticate with a0:04:60:9f:2f:f8
[=C2=A0 167.409354] wlan0: send auth to a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 167.423899] wlan0: authenticated
[=C2=A0 167.427327] wlan0: associating with AP with corrupt probe response
[=C2=A0 167.439400] wlan0: associate with a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 167.452192] wlan0: RX AssocResp from a0:04:60:9f:2f:f8 (capab=3D0x4=
11 status=3D0 aid=3D1)
[=C2=A0 167.463676] wlan0: associated
[=C2=A0 171.402969] wlan0: authenticate with a0:04:60:9f:2f:f8
[=C2=A0 171.409574] wlan0: send auth to a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 171.423368] wlan0: authenticated
[=C2=A0 171.430927] wlan0: associate with a0:04:60:9f:2f:f8 (try 1/3)
[=C2=A0 171.442946] wlan0: RX AssocResp from a0:04:60:9f:2f:f8 (capab=3D0x4=
11 status=3D0 aid=3D1)
[=C2=A0 171.451552] wlan0: associated

Can someone divine what's happening (and/or suggest what I should check)?
This is very annoying on console, *and* I can see connection disruption whe=
n reconnect happens.
Most likely this is some misconfig on my side, but I don't know how to tack=
le it.

Any comment welcome.

Thanks in Advance
Mauro
--===============8094616086506111107==--

