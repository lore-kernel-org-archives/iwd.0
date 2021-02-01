Content-Type: multipart/mixed; boundary="===============7484957105284488195=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 5/5] client: ap: show SSID in 'ap <wlan> show'
Date: Mon, 01 Feb 2021 14:10:19 -0800
Message-ID: <0c0d1617aa9fafc19ac9c63c16a718f62b913219.camel@gmail.com>
In-Reply-To: <20210201220518.36975-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7484957105284488195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-02-01 at 14:05 -0800, James Prestwood wrote:
> This will show some basic AP information like Started and
> SSID. Some cleanup was done to make the AP interface and
> client table columns line up.
> ---
>  client/ap.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> =

> diff --git a/client/ap.c b/client/ap.c
> index 9a7f8642..783f1e19 100644
> --- a/client/ap.c
> +++ b/client/ap.c
> @@ -34,6 +34,7 @@
>  =

>  struct ap {
>  	bool started;
> +	char *ssid;

Looks like I forgot to free this in destroy. Will send v2 after any
comments.

Thanks,
James

--===============7484957105284488195==--

