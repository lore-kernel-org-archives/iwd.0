Content-Type: multipart/mixed; boundary="===============4371761821719417858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: allow regex for verbose option
Date: Fri, 03 Jun 2022 18:21:36 -0500
Message-ID: <9aca4b07-c168-b401-dd4c-c6647f1eea54@gmail.com>
In-Reply-To: 20220603231201.242500-1-prestwoj@gmail.com

--===============4371761821719417858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/3/22 18:12, James Prestwood wrote:
> The glob match was completely broken for --verbose because globs
> are actually path matches, not generally for strings. Instead
> match based on regular expressions.
> =

> First the verbose option was fixed to store it as an array as well
> as write any list arguments into the kernel command line properly
> (str() would include []). This has worked up until now because the
> 'in' keyword in python will work on strings just as well
> as lists, for example:
> =

>>>> 'test' in 'this,is,a,test'
> True
> =

> Then, the glob match was replaced with a regex match. Any exceptions
> are caught and somewhat ignored (printed, but only seen with --debug).
> This only guards against fatal exceptions from a user passing an
> invalid expression.
> ---
>   tools/runner.py |  7 +++++--
>   tools/utils.py  | 11 +++++++----
>   2 files changed, 12 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4371761821719417858==--

