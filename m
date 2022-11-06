Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6C28EC
	for <iwd@lists.linux.dev>; Sun,  6 Nov 2022 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667745389; bh=l+frvoWWBmmeW+LEmmoh3RHA6aoMEhBTdKiEO44n1EY=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=MdfgKwv7Rz+91u7HTzQoSHSffn63HuzKMyEAgjbXdt9puc44olowdPLghvCDIE+Fm
	 Vi9wCaWf5D987TRc8Z4ZhoYKRFVTXJ0LH1nbsEJrIU8JEzbl7zeAkFJJIMT2mKNeUZ
	 V/EmLSCabM2zf+mobjmop3xwQ0yA23mySLiYB4rmtIaf/qWwbv5rwTKjSE6P3R58MI
	 iH34Plp1Gk4T2rtsgJzzIo58uRKNHKrt+f6jZS9k5tTvfggkGcZnv4dQKygWt4q9/A
	 CiqpmgaZEBCRx93aobiijEfG2TKEB7AoZg/hLnEq32kc4hZ176avjJvZyGEM6h1rpy
	 buOlp9GosIRng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mmm.localnet ([2.205.106.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1omVxO2aNX-00E2Zy for
 <iwd@lists.linux.dev>; Sun, 06 Nov 2022 15:36:29 +0100
From: Patrick =?ISO-8859-1?Q?H=E4cker?= <pat_h@web.de>
To: iwd@lists.linux.dev
Subject: Sometimes RxBitrate of 1000 Kbit/s
Date: Sun, 06 Nov 2022 15:36:11 +0100
Message-ID: <5893463.lOV4Wx5bFT@mmm>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4799761.31r3eYUQgx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:T4AUpbF+Z692PDrbVtCH0rFvKN9lYLGH5UrYIObZ9+qCh7bOJGJ
 bTAbb4R0nBxsk88S7s/6ETFnE4OF49V7KQuraUdx/q14dtIcUAvjwLXQFJ5bXzKec6dG6X2
 72CH3JN76ppAB+MCahmXvdCVqyS0PCFGVp73oHaVjRKrU3SBJwlMgYo57l9IGyjuaxlf0wX
 vYDmm+Zw4UpFflINXjmLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mthC+F+9tHo=;NBNzsVvYchh7h01NMqsrfGd8Rwj
 mHnWu4muaKExM+Mv0gUTKHCHnt+HBLmlz0LR3AjdZyYjsLAY4ItwL/Jmh13+o6TL8YsEXxa3K
 DbKQVk6J8wgm3yap9ofJLd7DhDbOtdC3gl4QMfyCu/pt1QkST6BJy9mLQhUSM+sD69ujtz6zr
 a5uaRf54CxmzCqPw4dVdbZ+dRYMzRPyM5lwPqD65sIGvPFa87Fnvmns1AsG4wuNfLAOo21w/+
 Ow/g3QH7UY00XyLSeCHUxtJZBrKMQv2w5TL275Y/BIK6jk6jQ1VdDUNDJVE7i7MKIgsvGPZoV
 DHCrQmxoQmnZ7HyAEfbdmbR2T0MTenno4b04n6Stk24Mye9oOYAwEN5jqvKzeQYkh+mDOV+mw
 80n9Jm8q0IMMhS3sjgT9qmRW+kSTFImb6/etgTCSEIH7ur/AVtvsIMbav6J4Es4O913Jt4G7B
 RDeqEJXHWa3TUMJ/IXr0TGRIF/UuCLumKGJkWtVNKnV0kTd64zOYxErdaGF9JeoD0KLpz6SL4
 /kxHZthga5X0Q/b43xIDmgskPOLBKJdRQv2dXOleWQJ1Uit/b/JD6HrKTKqPX4HcWUw9pa1GA
 63V5Hrugrw4P27KT+aUkBBhqS8WyrMfWXwvVL7aPQkjVKb6S6aFGPTij8Iyw7TVtcOhS10wuW
 TTIbdyYkFLXsb5JYzy3ooTYlNGdA2r3Gn1YOc4Q2fAOFgvUEquowhmp0TxbFb9JLgkWF+CCg2
 k2lKmYR72uQv8vp/fz6RcaVQAD+soFyITcSuGYN00LBhbBhi3+uZ74YVi5ebH2fpGiWh7KmP6
 HW1PSfvtITRmmDebIUsvxgHUFbbnBhNDqvs+0m6D7n7ZpILPVcVXek2G1qVfD08NJQt6XIrjU
 nMfm5qEmD4K+gePRHkJ2+l41nddiNlBqNEzYmsA1D+UZ8r/g3m2EKOpC+Arm1IQWvh3iLsQZa
 T4EIZBAkQrQNhJfnO6Uzfgj0uFY=

--nextPart4799761.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Patrick =?ISO-8859-1?Q?H=E4cker?= <pat_h@web.de>
To: iwd@lists.linux.dev
Subject: Sometimes RxBitrate of 1000 Kbit/s
Date: Sun, 06 Nov 2022 15:36:11 +0100
Message-ID: <5893463.lOV4Wx5bFT@mmm>
MIME-Version: 1.0

Hello all,

from time to time my RxBitrate (sometimes the TxBitrate, too) goes down to
1000 Kbit/s, whereas it otherwise is in the usual 5 to 6 digit range. This
seems to especially happen some time after waking up from standby (S3), ma=
ybe
also from hibernate (S4).

When it happens, wireless usage is super slow to non-existent.

Restarting iwd immediately solves the problem. I routinely also reloaded t=
he
involved kernel modules, but I think this was unnecessary as I
skipped it the last few times and only restarted iwd and this was enough t=
o
get it back to a working state.

Naturally, it seems to occur every few hours, but I might be able to trigg=
er
it more often with extensive standby cycles, but I am not sure.

That's how it looks when it happens (although TxBitrate is often still in =
the
normal 5 to 6 digit rate; please note ExpectedThroughput being much larger
than TxBitrate or RxBitrate):
# iwctl station wlan0 show
                                 Station: wlan0
=2D-----------------------------------------------------------------------=
--------
  Settable  Property              Value
=2D-----------------------------------------------------------------------=
--------
            Scanning              no
            State                 connected
            Connected network     *redacted*
            IPv4 address          192.168.0.10
            ConnectedBss          98:9b:cb:4b:b1:cc
            Frequency             2412
            Security              WPA3-Personal
            RSSI                  -44 dBm
            AverageRSSI           -55 dBm
            TxBitrate             1000 Kbit/s
            RxBitrate             1000 Kbit/s
            ExpectedThroughput    56906 Kbit/s

This is how it looks after restarting iwd:
# systemctl restart iwd
# iwctl station wlan0 show
                                 Station: wlan0
=2D-----------------------------------------------------------------------=
--------
  Settable  Property              Value
=2D-----------------------------------------------------------------------=
--------
            Scanning              no
            State                 connected
            Connected network     *redacted*
            IPv4 address          192.168.0.10
            ConnectedBss          98:9b:cb:4b:b1:cd
            Frequency             5180
            Security              WPA3-Personal
            RSSI                  -72 dBm
            AverageRSSI           -72 dBm
            RxMode                802.11n
            RxMCS                 9
            TxMode                802.11n
            TxMCS                 3
            TxBitrate             60000 Kbit/s
            RxBitrate             60000 Kbit/s
            ExpectedThroughput    31125 Kbit/s

Please note, that currently the router steers clients towards either 2.4 G=
Hz
or 5 GHz. I already tried to restrict the client to either of both frequen=
cy
bands, but that did not seem to avoid the problem.

# uname -a
Linux mmm 6.0.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.0.5-1 (2022-10-28)
x86_64 GNU/Linux

(Probably) involved kernel modules:
rt2800usb rt2x00usb rt2800lib rt2x00lib mac80211 cfg80211

The device is a USB device
Ralink Technology, Corp. RT5572 Wireless Adapter

Any tips how to debug this?

=46rom https://iwd.wiki.kernel.org/debugging I would assume, that IWD_GENL=
_DEBUG
might the relevant environment variable, but I am really not sure.
I could obviously implement some kind of watchdog checking the output of i=
wctl
every some seconds and restarting iwd in case, but I would avoid that if t=
here
is a cleaner solution available.

I think is problem started to occur some months ago. It might be related w=
ith
some kernel or iwd update some time ago. But due to the long time until
occuring, a sound bisect might take more than a week.

Kind regards
Patrick

--nextPart4799761.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE8JojVI+cFX1k1E7YHGgu1+TJBeAFAmNnxlsACgkQHGgu1+TJ
BeCyChAAmUu8/jskB2YeA0LfgAUEwyPC0uQiRzfDdwkeeLPY/JnrAMnko3Zz0lrw
c7RqXmxaTD9mt+mqZSNjfQtpLJvzePlqJ176LgSXcinI+bFrNfnn4dNeCCqEgWZH
WgczuJyNU0muH1j0sQUoi19cgyvmHrfQLsQ+vErYLgWBxQeQ19dvJ7brD5waV3rF
ApOAjvCb/ktr0Iqf5CLlxO56M4RMjcd6dcbs5DE+KFtA+ESN1oVdajIgIZVzrviH
6e6ILRiDfnihXOSeukhYzbDq8eUladGgBSi/wvSs9/5H9v34ovb5VVnrS4c07zt7
ceyPYUL2Um+E2fSRPbkRtmQG/3LP1LnlT0GhXefmbFGkqJIzCjSippTvVe5Klzp+
Bsf9mvA567BY0lQjo9W/0DIuZiouW6YTx6zon6EBS1al8ySzSGkoYNGe1xN8aAxK
8V/iJ6xbWPHeJE1xA0DMTdXUE39WUiRE146K+BNaOwXkjxHq8hyLvu5bHTVzn+fc
W2EaSQXVewModNm1RaqcOXnFBv1gW2HIpYyBVA+nYMVx/Y0nP5exmbXZ7f/fu8lN
E+kbqWWMskhRVtBQHIDsW0denNTRFrT/CCeq94YH3HoOAd3wwK07LPYC3Vl+8lCh
uemq7KQAddBwgNMNWh+GpWB1Yj9BSaeOqhjap/yIm5wSSEbB9vE=
=+Svy
-----END PGP SIGNATURE-----

--nextPart4799761.31r3eYUQgx--



