Content-Type: multipart/mixed; boundary="===============1924890641400929369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: fix testhome mounting for QEMU
Date: Fri, 03 Jun 2022 18:21:14 -0500
Message-ID: <f220ca45-0b0f-2d0b-e934-19f48f72da95@gmail.com>
In-Reply-To: 20220603220245.227338-1-prestwoj@gmail.com

--===============1924890641400929369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/3/22 17:02, James Prestwood wrote:
> This was lazily copied from UML but really made no sense in the context
> of QEMU. First QEMU needs the virtfs option to define the mount tag and
> in addition a 9p mount should be used rather than 'hostfs'.
> ---
>   tools/runner.py | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1924890641400929369==--

