Content-Type: multipart/mixed; boundary="===============2762368474992831337=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: refactor/fix valgrind logging issue
Date: Wed, 06 Nov 2019 15:16:13 -0600
Message-ID: <46f76516-8d1c-43ff-b1e6-d75d40af8d71@gmail.com>
In-Reply-To: <20191105232226.11705-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2762368474992831337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/5/19 5:22 PM, James Prestwood wrote:
> After the logging changes verbose IWD with valgrind did not show any IWD
> output. This commit fixes this by checking the verbosity against log_name
> rather than argv[0] since log_name has a special case for valgrind/iwd.
> =

> The valgrind logic in start_iwd was refactored to only use the --log-fd
> option rather than using --log-file in addition to --log-fd.
> ---
>   tools/test-runner.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2762368474992831337==--

