Content-Type: multipart/mixed; boundary="===============8955337209689909258=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] nlmon: make len parameter a size_t
Date: Fri, 10 Apr 2020 14:52:43 +0000
Message-ID: <1c4d9e87-a279-64e0-55b1-d2039dae7b0d@gmail.com>
In-Reply-To: <20200410003831.258910-3-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8955337209689909258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On 4/9/20 7:38 PM, Rosen Penev wrote:
> Fixes a sign comparison warning. Found with -Wsign-compare
> ---
>   monitor/nlmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> index df628c2c..e54ae2e9 100644
> --- a/monitor/nlmon.c
> +++ b/monitor/nlmon.c
> @@ -7171,7 +7171,7 @@ static bool nlmon_receive(struct l_io *io, void *us=
er_data)
>   	unsigned char buf[8192];
>   	unsigned char control[32];
>   	ssize_t bytes_read;
> -	int nlmsg_len;
> +	size_t nlmsg_len;

I think a different fix is neeeded.  Please see commit 98e1d38056e7 =

("monitor: Fix crash") for why this is an int.

Which line in particular are you seeing the sign comparison warning on?

Regards,
-Denis
--===============8955337209689909258==--

