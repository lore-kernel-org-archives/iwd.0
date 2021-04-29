Content-Type: multipart/mixed; boundary="===============7246230060255375678=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: fix verbose output with --valgrind
Date: Thu, 29 Apr 2021 12:57:21 -0500
Message-ID: <232c64db-19de-6420-cb73-be884d575c7d@gmail.com>
In-Reply-To: <20210429160742.183855-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7246230060255375678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 11:07 AM, James Prestwood wrote:
> Since using --valgrind actually runs IWD using the valgrind
> process the --verbose flag would only work if 'valgrind' was
> also specified. This was taken into account with is_verbose
> but the actual logic enabling stdout did not use that helper.
> This was due, in part, to logging since is_verbose will always
> return true if --log is used. To fix this a new flag was added
> to is_verbose which omits the --log check to handle this
> specific case.
> ---
>   tools/test-runner | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7246230060255375678==--

