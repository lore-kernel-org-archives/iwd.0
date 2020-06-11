Content-Type: multipart/mixed; boundary="===============1951350998438589389=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] station: add ANQP state watch API
Date: Thu, 11 Jun 2020 16:30:40 -0500
Message-ID: <ab8a1b39-29a1-6668-f184-9eaf5ccf5bd2@gmail.com>
In-Reply-To: <20200611172628.31815-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1951350998438589389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/11/20 12:26 PM, James Prestwood wrote:
> This is to allow network to watch for ANQP activity in order to
> fix the race condition between scanning finishing and ANQP finishing.
> Without this it is possible for a DBus Connect() to come in before
> ANQP has completed and causing the network to return NotConfigured,
> when its actually in the process of obtaining all the network info.
> =

> The watch was made globally in station due to network not having
> a station object until each individual network is created. Adding a
> watch during network creation would result in many watchers as well
> as a lot of removal/addition as networks are found and lost.
> ---
>   src/station.c | 21 +++++++++++++++++++++
>   src/station.h | 13 +++++++++++++
>   2 files changed, 34 insertions(+)
> =


<snip>

>   struct station {
>   	enum station_state state;
> @@ -489,6 +490,9 @@ static void station_anqp_response_cb(enum anqp_result=
 result,
>   request_done:
>   	l_queue_remove(station->anqp_pending, entry);
>   =

> +	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
> +				STATION_ANQP_FINISHED, network);
> +

So you don't want to delay until all anqp requests finish?  Will the kernel =

cancel all the anqp work items nicely in this case?

>   	/* If no more requests, resume scanning */
>   	if (!l_queue_isempty(station->anqp_pending))
>   		return;

Regards,
-Denis
--===============1951350998438589389==--

