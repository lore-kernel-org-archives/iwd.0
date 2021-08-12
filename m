Content-Type: multipart/mixed; boundary="===============0527847538179599223=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 09:22:57 -0500
Message-ID: <8c08d082-0494-8e77-32fb-2b42d99599cf@gmail.com>
In-Reply-To: <CACsRnHWusQ22=YJVn23OBAC2ssiBrr5EQ_9msjamU_1dPx-DbA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0527847538179599223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/10/21 5:58 AM, Michael Johnson wrote:
> Hi all,
> =

> I'm having a problem with iwd when it comes to roaming. Most of the
> time it is working perfectly but rarely I get into this situation > where=
 I can't resolve any hostnames.
> I'm using a default server setup on ubuntu which uses systemd-networkd
> and systemd-resolved with iwd configured to use
> `EnableNetworkConfiguration=3Dtrue`.
> =


Hmm, are you configuring systemd-networkd not to manage wireless interfaces=
? =

Otherwise iwd and networkd might be fighting each other when it comes to =

managing the network interface.  Generally, one would not set =

'EnableNetworkConfiguration=3Dtrue' if networkd is being used.

Regards,
-Denis
--===============0527847538179599223==--

