Content-Type: multipart/mixed; boundary="===============0640160081640498767=="
MIME-Version: 1.0
From: salahaldeen.altous at leica-camera.com
To: iwd at lists.01.org
Subject: Re: IWD is running as AP with the build-in DHCP but android phones
 report no internet connection and switch back to WiFi home network
Date: Fri, 05 Nov 2021 17:47:31 +0000
Message-ID: <20211105174731.2830.19174@ml01.vlan13.01.org>
In-Reply-To: b29d30cd-7e96-3bed-4555-e79373f2dda9@gmail.com

--===============0640160081640498767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Salahaldeen,
> =

> On 11/5/21 10:14 AM, salahaldeen.altous(a)leica-camera.com wrote:
> =

> Interesting.  Not sure why they would do that if the user explicitly sele=
cted to =

> connect to your device...
not all Android phones are doing that. But many of them.
> =

> =

> I suppose we could use the same approach.  Could you try the attached pat=
ch and =

> see if this helps.
I have tested the attached patch but still not working. I have checked agai=
n. We have dropped DHCP option 6 to report Domain Name servers
+dhcp-option=3Doption:dns-server
+dhcp-option=3Doption:router

How I can also drop dhcp option 6 to report Domain Name servers?
> =

> Regards,
> -Denis

Regards,
Salahaldeen
--===============0640160081640498767==--

