Content-Type: multipart/mixed; boundary="===============5697591466191583067=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Tue, 31 Aug 2021 08:11:55 +0200
Message-ID: <36a705db-b6c8-c1b0-abba-a15b170fc694@molgen.mpg.de>
In-Reply-To: <20210831055406.2717.71292@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5697591466191583067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Jesus,


Am 31.08.21 um 07:54 schrieb Jesus Gonzalez:

> this was with no NetworkManager running, and before and after a
> "known-networks forget" (so also entering the PSK again on "station
> wlan0 connect"), just in case it was what you just pointed out, which
> also was my first reaction to that message.

If you have a little time, bisecting the commit introducing the issue =

might be the quickest way to get to the bottom of this.


Kind regards,

Paul
--===============5697591466191583067==--

