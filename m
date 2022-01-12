Content-Type: multipart/mixed; boundary="===============1238938116635958041=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 04/10] dpp: put no station device print behind else if
Date: Wed, 12 Jan 2022 09:39:56 -0600
Message-ID: <f0d36c74-e2ac-0a70-e345-634d409b2e13@gmail.com>
In-Reply-To: 20220112005558.1158405-4-prestwoj@gmail.com

--===============1238938116635958041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/22 18:55, James Prestwood wrote:
> The previous (incorrect) else was removed since it ended up
> printing in most cases since the if clause returned. This should
> have been an else if conditional from the start and only print if the
> station device was not found.
> ---
>   src/dpp.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> =


Patches 4 and 5 applied, thanks.

Regards,
-Denis

--===============1238938116635958041==--

