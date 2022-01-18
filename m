Content-Type: multipart/mixed; boundary="===============5951137519434782625=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Specifying BSSID in station connect?
Date: Tue, 18 Jan 2022 09:15:02 -0600
Message-ID: <f6428598-1da4-4891-aa62-6dbdeca9ae00@gmail.com>
In-Reply-To: d748f3cc-b72d-5459-721b-7e72e821b39d@blueridgenetworks.com

--===============5951137519434782625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On 1/17/22 09:39, Bruce A. Johnson wrote:
> Has any consideration been given to permitting the specification of a par=
ticular =

> BSSID in the /station <wlan> connect/ command? I initially wrote my proje=
ct to =

> work with WPA supplicant, and this was a feature that my testing guy like=
d. I =

> seem some utility in being able to lock onto a specific access point.

This (and more) is already possible using the StationDebug interface.  Note=
 that =

this interface is only available when iwd is started in developer mode, see=
 'iwd =

--help' for the right incantation.

Our python based auto tests use this functionality quite a bit.  We haven't=
 had =

a need to support this API in iwctl.  Should be pretty easily doable if som=
eone =

needs this.

Regards,
-Denis
--===============5951137519434782625==--

