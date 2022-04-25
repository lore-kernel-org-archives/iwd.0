Content-Type: multipart/mixed; boundary="===============8995476079489118920=="
MIME-Version: 1.0
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen_=3Ctoke_at_toke=2Edk=3E?=
To: iwd at lists.01.org
Subject: WiFi interface stuck in 'Powered off' (link down) mode after suspend
Date: Mon, 25 Apr 2022 23:58:04 +0200
Message-ID: <871qxkkeqb.fsf@toke.dk>

--===============8995476079489118920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone

I am encountering a strange problem with my WiFi not coming back after a
suspend. Specifically, after a suspend-resume cycle, iwd will report,
when issuing a 'station list' in iwctl:

  No devices in Station mode available.

But when issuing a 'device list' it shows up:

  wlan0               7a:e2:f0:31:a5:ae   off        phy0      station   =


which is a bit confusing, IMO. Issuing a 'device wlan0 show' gets me:

            Name                wlan0
            Mode                station
            Powered             off
            Address             7a:e2:f0:31:a5:ae
            Adapter             phy0                                       =
    =


And issuing a 'device wlan0 set-property Powered on' restores the device
to working order and reconnects.

I went looking in the iwd source code, and it looks like that 'Powered'
in iwd lingo translates to 'link up' in the kernel, right? Indeed,
issuing an 'ip link up' on the wlan device after coming back from
suspend is enough to get me back online.

I'm honestly not really sure if this is a bug in the kernel, or in iwd.
I mean, it seems like iwd should be able to just set 'link up' and
continue on its merry way (and indeed if I restart iwd entirely it will
do this). But am also fairly sure it used to work on previous kernels,
so maybe the kernel behaviour changed? (I have not had a chance to test
this as bisecting is a bit cumbersome on my daily driver laptop; so
figured I'd ask y'all's opinion first).

This happens on a 5.17 kernel with an Intel AX201 device (using the
iwlwifi) driver.

Hoping someone can help me get this fixed, whether that be by fixing iwd
or telling me to go bisect the kernel :)

-Toke
--===============8995476079489118920==--

