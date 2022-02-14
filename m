Content-Type: multipart/mixed; boundary="===============2842255290520930383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: fix valgrind after no radio change
Date: Mon, 14 Feb 2022 16:03:38 -0600
Message-ID: <4f4fbb7f-0a4c-6ec9-9853-728c94250bf4@gmail.com>
In-Reply-To: 20220214214139.1017355-1-prestwoj@gmail.com

--===============2842255290520930383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/14/22 15:41, James Prestwood wrote:
> The change adding support for starting IWD with no radios ended up
> breaking the valgrind option.
> ---
>   tools/test-runner | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Applied.  I squashed this into the commit in question.

Regards,
-Denis

--===============2842255290520930383==--

