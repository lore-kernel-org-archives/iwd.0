Content-Type: multipart/mixed; boundary="===============8556486675146143701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] anqp: refactor to use frame-xchg
Date: Thu, 28 May 2020 15:42:51 +0000
Message-ID: <f5422c7e-fcf5-3d1f-2b26-9ff95677cae9@gmail.com>
In-Reply-To: <20200527204559.2571-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8556486675146143701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/27/20 3:45 PM, James Prestwood wrote:
> The new frame-xchg module now handles a lot of what ANQP used to do. ANQP
> now does not need to depend on nl80211/netdev for building and sending
> frames. It also no longer needs any of the request lookups or frame
> watches because frame-xchg filters this for us. The request queue did
> need to remain in ANQP because station fires off ANQP requests all in
> a row, and frame-xchg cannot handle this. Now ANQP just sends out the
> first request, and queue's the rest. As the responses come in it will
> send out the next frame in the queue until there are no more left.
> =

> The anqp_request API was changed to only return a bool, as well as
> take the wdev_id rather than ifindex. Station was updated to remove
> the 'pending' member since it was not actually used, as well as fix
> a bug on the timeout path where the request queue would get popped
> twice.
> =

> There is somewhat of a TODO that was overlooked initially with ANQP
> and was realized when testing these patches. Since the network_info
> depends on ANQP completing there is a race condition between scanning
> finishing and being ready to connect to networks which require ANQP.
> The autoconnect case does not have this issue, but explicit Dbus
> connects do. In practice this may not matter since the user would have
> to issue a connect at just the right time, but it could still happen.
> This may need to be fixed in network where we see if there are any
> pending ANQP requests before we return NotConfigured. If there are
> pending requests we should wait for those, then attempt to connect.
> ---
>   src/anqp.c    | 438 +++++++++++++-------------------------------------
>   src/anqp.h    |   2 +-
>   src/station.c |  16 +-
>   3 files changed, 114 insertions(+), 342 deletions(-)
> =


<snip>

> +#define ANQP_GROUP	1
> +

Maybe a question for Andrew, but can't we fix frame-xchg to run this =

over group 0?

<snip>

>   =

> -static uint32_t netdev_watch;

So how do you handle device removal while ANQP queue is running?

Right now I think the kernel ends up sending us FRAME_WAIT_CANCEL for =

all pending remain-on-channel requests if the device is removed.  So it =

would seem that we get lucky and this all works in the current =

implementation.

It doesn't look like frame-xchg does this though and depends on its own =

timers...

So either station/network has to cancel any pending anqp requests, or =

anqp has to somehow clean this up after itself.

<snip>

> diff --git a/src/anqp.h b/src/anqp.h
> index 998277dd..99af76d5 100644
> --- a/src/anqp.h
> +++ b/src/anqp.h
> @@ -34,7 +34,7 @@ typedef void (*anqp_response_func_t)(enum anqp_result r=
esult,
>   					const void *anqp, size_t len,
>   					void *user_data);
>   =

> -uint32_t anqp_request(uint32_t ifindex, const uint8_t *addr,
> +bool anqp_request(uint64_t wdev_id, const uint8_t *addr,

See above for the likely reason why we had this return a uint32_t =

originally.

>   			struct scan_bss *bss, const uint8_t *anqp, size_t len,
>   			anqp_response_func_t cb, void *user_data,
>   			anqp_destroy_func_t destroy);
> diff --git a/src/station.c b/src/station.c
> index c532319a..29f94e3b 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -104,7 +104,6 @@ struct station {
>   struct anqp_entry {
>   	struct station *station;
>   	struct network *network;
> -	uint32_t pending;
>   };

Do we currently send a single ANQP request per network?  If so, maybe we =

can drop this structure completely, by:

1. Adding network_get_station() getter if necessary
2. Using the network object itself as the user_data for =

station_anqp_response_cb
3. Maybe storing pending inside network itself?

The above would also make it easier to solve the issue of the user =

triggering Connect just when ANQP hasn't been done yet...

Regards,
-Denis
--===============8556486675146143701==--

