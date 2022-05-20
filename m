Content-Type: multipart/mixed; boundary="===============2978422787608162785=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] Initial signal level notification
Date: Fri, 20 May 2022 17:00:00 -0500
Message-ID: <4d0d7992-e1cd-1dd0-3591-f7a161e6e295@gmail.com>
In-Reply-To: 20220520215324.15537-1-jesse@twosheds.org

--===============2978422787608162785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/20/22 16:53, Jesse Lentz wrote:
> After registration of a SignalLevelAgent, make iwd inform the client of
> the initial signal level via a "Changed" method call.
> ---
>   src/netdev.c  |  5 +++++
>   src/netdev.h  |  1 +
>   src/station.c | 19 ++++++++++++++-----
>   3 files changed, 20 insertions(+), 5 deletions(-)
> =


I added a 'station:' prefix to the commit message and...

> +	if (station->connected_network)
> +	{

... since we use the kernel coding style, I amended this to:
if (..) {

Both patches applied, thanks!

Regards,
-Denis
--===============2978422787608162785==--

