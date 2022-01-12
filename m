Content-Type: multipart/mixed; boundary="===============5030398383330543300=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 03/10] dpp: don't send StartEnrollee reply until
 offchannel starts
Date: Wed, 12 Jan 2022 09:38:50 -0600
Message-ID: <544dc103-93f6-6772-ae13-6414e6b349c5@gmail.com>
In-Reply-To: 20220112005558.1158405-3-prestwoj@gmail.com

--===============5030398383330543300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/22 18:55, James Prestwood wrote:
> IWD may be in the middle of some long operation, e.g. scanning.
> If the URI is returned before IWD is ready, a configurator could
> start sending frames and IWD either wont receive them, or will
> be unable to respond quickly.
> ---
>   src/dpp.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> =

> diff --git a/src/dpp.c b/src/dpp.c
> index 98d2a75c..c10ec978 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -118,6 +118,8 @@ struct dpp_sm {
>   =

>   	struct dpp_configuration *config;
>   	uint32_t connect_scan_id;
> +
> +	struct l_dbus_message *message;

We customarily call this member 'pending', so I changed this naming and app=
lied.

Regards,
-Denis
--===============5030398383330543300==--

