Content-Type: multipart/mixed; boundary="===============6988238972053019604=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: fix segfault running with --log non-root
Date: Thu, 02 Apr 2020 00:32:24 -0500
Message-ID: <a8bad238-5ab3-af9e-9068-94def86190c4@gmail.com>
In-Reply-To: <20200402164848.1580-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6988238972053019604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/2/20 11:48 AM, James Prestwood wrote:
> When running test-runner as non-root the environment variables
> SUDO_GID/SUDO_UID were unset, causing atoi to segfault. This replaces
> atoi with strtol, and checks the existance of SUDO_GID/SUDO_UID
> before trying to turn it into an integer. This patch also allows
> the uid/gid to be read from the user if running as non-root.
> =

> Note: running as non-root does require the users permissions to be
> setup properly. Directories and files are created when running with
> logging, so if the user running test-runner does not have these
> permissions the creation of these files will fail.
> ---
>   tools/test-runner.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============6988238972053019604==--

