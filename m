Content-Type: multipart/mixed; boundary="===============7366761760092467291=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Dual phy device not always detected
Date: Thu, 10 Feb 2022 16:21:06 -0600
Message-ID: <a21cae1c-4197-33ed-8bd7-f12681e9cfeb@gmail.com>
In-Reply-To: CAMSdBrG=OGXZRMSjf-u41rAuTaxUdMw0sVMbNPX995B8sCiq_A@mail.gmail.com

--===============7366761760092467291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi David,

On 2/10/22 10:51, David Bourgeois wrote:
> Hi,
> =

> We plan to use iwd for an embedded device where we need both station and =
ap at =

> the same time. For this we have devices based on the rtl88x2bu driver com=
piled  > to enable the dual phy. This works well, the dongle is detected as=
 2 different
> interfaces wlan0 and wlan1 and both work properly. IWD doesn't always det=
ect =

> both interfaces though when the dongle is plugged. If IWD is restarted, t=
hen =

> most of the time both interfaces are detected. When the dongle is plugged=
 at =

> boot it also works most of the time.

We still need to test this better here, but can you try the patch I just se=
nt out:
[PATCH] manager: Refine filtered dumps

Regards,
-Denis
--===============7366761760092467291==--

