Content-Type: multipart/mixed; boundary="===============5942120904530741716=="
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael at amarulasolutions.com>
To: iwd at lists.01.org
Subject: iwd access point mode
Date: Thu, 07 Oct 2021 21:48:10 +0200
Message-ID: <CAOf5uwk5RkWEOuOsWTyFynQRsnWBHx8nByOzew283YHNanQQTg@mail.gmail.com>

--===============5942120904530741716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI all

I'm playing with iwd. Looking at iwmon I can see virtual device
discovered by iwd when they are created.

iw phy phy0 interface add wlan1 __ap

iwctl still report wlan0

 I was able to create wifi connection and access point mode using
wpa_supplicant and NetworkManager. My idea
is was experimenting iwd

iwctl device list still report only wlan1. The idea behind is to
control ap+sta interface. Any feedback?

Michael
--===============5942120904530741716==--

