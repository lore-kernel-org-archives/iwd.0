Content-Type: multipart/mixed; boundary="===============2119845980046307520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: erase valgrind log after each test
Date: Wed, 13 Nov 2019 16:36:34 -0600
Message-ID: <3b056ff4-9dea-3197-61f0-4abd548fd26b@gmail.com>
In-Reply-To: <20191113194102.30627-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2119845980046307520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/13/19 1:41 PM, James Prestwood wrote:
> After changing the valgrind log to --log-fd, it appears that
> the log file just gets appended, where before it was overwritten.
> This makes test print out all previous tests valgrind results.
> =

> Now after printing out the valgrind info we can erase the file
> for the next test.
> ---
>   tools/test-runner.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2119845980046307520==--

