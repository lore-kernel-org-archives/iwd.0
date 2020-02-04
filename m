Content-Type: multipart/mixed; boundary="===============6077983877363059904=="
MIME-Version: 1.0
From: hector@ikatu.com
Subject: Re: Interface not detected sometimes
Date: Tue, 04 Feb 2020 19:08:47 +0000
Message-ID: <20200204190847.2820.5022@ml01.vlan13.01.org>
In-Reply-To: <2e72e05e-7a2a-6058-739e-f88c087b1b72@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6077983877363059904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thanks for your reply.

Yes, I'm using brcmfmac.

I had the EBUSY errors the first time I tried iwd. I got rid of those error=
s setting "--interfaces wlan0" in iwd.service (I have wlan0 and uap0 interf=
aces, I think I just need iwd to manage the wlan0, uap0 will be managed by =
hostapd). After that I didn't get the EBUSY errors anymore, but now I've th=
is "No default interface for wiphy 0" problem.

Applying the 55f9639ee37c commit didn't change the behavior. I mean, I stil=
l need to set the "--interfaces wlan0" parameter to avoid the EBUSY errors,=
 and if I set the parameter I still need to sleep some seconds to avoid the=
 "No default interface for wiphy 0" error.

Regards,
Hector
--===============6077983877363059904==--

