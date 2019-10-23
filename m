Content-Type: multipart/mixed; boundary="===============1728009649233028112=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: fix double free issue on subtest queue
Date: Wed, 23 Oct 2019 12:29:27 -0500
Message-ID: <6d48cf20-c3ae-7a4e-1b10-d54964efb9a8@gmail.com>
In-Reply-To: <20191023162410.27743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1728009649233028112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/23/19 11:24 AM, James Prestwood wrote:
> Coverity reported this as a leak, but the test queue is actually
> getting freed later and does not need to be freed locally in add_path
> =

> This basically reverts c0863e5bc62f645f0bde144e4e906b7277866bf7
> ---
>   tools/test-runner.c | 2 --
>   1 file changed, 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1728009649233028112==--

