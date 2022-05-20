Content-Type: multipart/mixed; boundary="===============0482174226503653926=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Disable DNS in IWD
Date: Fri, 20 May 2022 10:17:55 -0500
Message-ID: <85cb9d4e-ed56-104d-d13e-51a2bb8ab4a2@gmail.com>
In-Reply-To: bHJm3HWsDSDtX0h9yi1mxsu7h6eNouwsjiRL7NsyR26GHma3-wQXJA9KPsHBDLWuT6-9fzoT4Dl1a7MJS8AUg3SRae0Q_X-PLfBnes25VGo=@protonmail.com

--===============0482174226503653926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gino,

On 5/19/22 09:41, Gino McCarty wrote:
> There appears to be no method for having IWD disable DNS Updates
> is there some method that is undocumented available?
> =

> NameResolvingService=3Dnone
> =


This isn't supported in any released version of iwd.  However, I just added=
 this =

upstream in commits:

d45950908753 ("manpage: describe 'none' in NameResolvingService")
b96bbb35e07a ("resolve: Add "none" method")

Regards,
-Denis
--===============0482174226503653926==--

