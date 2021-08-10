Content-Type: multipart/mixed; boundary="===============8183804616182505291=="
MIME-Version: 1.0
From: salahaldeen.altous@leica-camera.com
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Tue, 10 Aug 2021 08:22:03 +0000
Message-ID: <20210810082203.2797.20276@ml01.vlan13.01.org>
In-Reply-To: <4758091633c1cf9c2920e05072770bd5c84c4ad4.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8183804616182505291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi James,
> On Mon, 2021-08-09 at 08:58 -0700, James Prestwood wrote:
> I have connected multiple clients at this time but it returns only
> client 0
> I am using qualcomm qca9377 chip
the output for dbus-mointer looks like this (only one client even more than=
 one client are connected)
method call time=3D2754.711884 sender=3D:1.5 -> destination=3Dnet.connman.i=
wd serial=3D15 path=3D/net/connman/iwd/0/4; interface=3Dnet.connman.iwd.Acc=
essPointDiagnostic; member=3DGetDiagnostics
method return time=3D2754.715240 sender=3D:1.0 -> destination=3D:1.5 serial=
=3D81 reply_serial=3D15
   array [
      array [
         dict entry(
            string "Address"
            variant                string "84:25:3f:9f:XX:XX"
         )
         dict entry(
            string "TxBitrate"
            variant                uint32 1995880597
         )
         dict entry(
            string "ExpectedThroughput"
            variant                uint32 30397488
         )
      ]
   ]
--===============8183804616182505291==--

