Content-Type: multipart/mixed; boundary="===============6379128573571573469=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel at molgen.mpg.de>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: increase RAM size
Date: Sat, 19 Mar 2022 06:12:29 +0100
Message-ID: <d454c143-cc4d-a4bb-3bd8-72e97b8e466e@molgen.mpg.de>
In-Reply-To: 20220318223646.756590-1-prestwoj@gmail.com

--===============6379128573571573469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear James,


Am 18.03.22 um 23:36 schrieb James Prestwood:
> This is explained in the comment, but until the issue can be
> tracked down increase RAM.

Before it was distinguished if run under Valgrind or not. It=E2=80=99s runn=
ing =

out of memory regardless of that now?

The comment says, the reason is unclear, but could you document the test =

setup (QEMU, Linux version, compiler) of the last successful run, and =

the parameters of the first failure?


Kind regard,

Paul


PS: To be more specific in the commit message, you could use:

test-runner: Increase RAM size to 1 GB

> ---
>   tools/test-runner | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> =

> diff --git a/tools/test-runner b/tools/test-runner
> index b0ec87a2..534f08f2 100755
> --- a/tools/test-runner
> +++ b/tools/test-runner
> @@ -1816,12 +1816,15 @@ class Main:
>   			smp =3D int(nproc / 2)
>   =

>   		#
> -		# Increase RAM if valgrind is being used
> +		# TODO: Its unclear exactly what causes it (leak, fragmentation,
> +		# or ?), but after many test runs the kernel starts running out
> +		# of memory. This is sometimes non-fatal, e.g. a python call
> +		# fails, but other times the kernel fully panics.
>   		#
> -		if self.args.valgrind:
> -			ram =3D 512
> -		else:
> -			ram =3D 384
> +		# For now increase the RAM which allows full test runs to
> +		# complete.
> +		#
> +		ram =3D 1024
>   =

>   		print("Using %d cores, %d RAM for VM" % (smp, ram))
>  =20
--===============6379128573571573469==--

