Content-Type: multipart/mixed; boundary="===============8441241505892263333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 10/12] frame-xchg: Add facility to keep retransmitting
 after ACK
Date: Wed, 18 Mar 2020 13:53:44 -0500
Message-ID: <e42b6f58-62cd-4ba9-1de7-555a393f8899@gmail.com>
In-Reply-To: <20200318144531.30613-10-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8441241505892263333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/18/20 9:45 AM, Andrew Zaborowski wrote:
> In some cases a P2P peer will ACK our frame but not reply on the first
> attempt, and other implementations seem to handle this by going back to
> retransmitting the frame at a high rate until it gets ACKed again, at
> which point they will again give the peer a longer time to tx the
> response frame.  Implement the same logic here by adding a
> retries_on_ack parameter that takes the number of additional times we
> want to restart the normal retransmit counter after we received no
> response frame on the first attempt.  So passing 0 maintains the
> current behaviour, 1 for 1 extra attempt, etc.
> =

> In effect we may retransmit a frame about 15 * (retry_on_ack + 1) *
> <in-kernel retransmit limit> times.  The kernel/driver retransmits a
> frame a number of times if there's no ACK (I've seen about 20 normally)
> at a high frequency, if that fails we retry the whole process 15 times
> inside frame-xchg.c and if we still get no ACK at any point, we give up.
> If we do get an ACK, we wait for a response frame and if we don't get
> that we will optionally reset the retry counter and restart the whole
> thing retry_on_ack times.
> ---
>   src/frame-xchg.c | 61 +++++++++++++++++++++++++++++++++---------------
>   src/frame-xchg.h |  4 ++--
>   2 files changed, 44 insertions(+), 21 deletions(-)
> =

> diff --git a/src/frame-xchg.c b/src/frame-xchg.c
> index a7565a24..a4b6b740 100644
> --- a/src/frame-xchg.c
> +++ b/src/frame-xchg.c
> @@ -107,6 +107,7 @@ struct frame_xchg_data {
>   	unsigned int retry_cnt;
>   	unsigned int retry_interval;
>   	unsigned int resp_timeout;
> +	unsigned int retries_on_ack;
>   	bool in_frame_cb : 1;
>   	bool stale : 1;
>   };
> @@ -722,12 +723,16 @@ static bool frame_watch_remove_by_handler(uint64_t =
wdev_id, uint32_t group_id,
>   	if (!group)
>   		return false;
>   =

> +	l_error(" ** settign grp %i elems that match to nop", group->id);////

??

>   	return l_queue_foreach_remove(group->watches.items,
>   					frame_watch_item_remove_by_handler,
>   					&handler_info) > 0;
>   }
>   =

>   static void frame_xchg_tx_retry(struct frame_xchg_data *fx);
> +static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
> +					const void *body, size_t body_len,
> +					int rssi, void *user_data);
>   static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
>   				const void *body, size_t body_len,
>   				int rssi, void *user_data);
> @@ -807,12 +812,19 @@ static void frame_xchg_timeout_cb(struct l_timeout =
*timeout,
>   	frame_xchg_tx_retry(fx);
>   }
>   =

> -static void frame_xchg_resp_timeout_cb(struct l_timeout *timeout,
> +static void frame_xchg_listen_end_cb(struct l_timeout *timeout,
>   					void *user_data)
>   {
>   	struct frame_xchg_data *fx =3D user_data;
>   =

> -	frame_xchg_done(fx, 0);
> +	if (!fx->retries_on_ack--) {

Is this post-decrement intended?  Might be better to do this in a way =

that doesn't require head-scratching for a minute :)

> +		frame_xchg_done(fx, 0);
> +		return;
> +	}
> +
> +	l_timeout_remove(fx->timeout);
> +	fx->retry_cnt =3D 0;
> +	frame_xchg_tx_retry(fx);
>   }
>   =

>   static void frame_xchg_tx_status(struct frame_xchg_data *fx, bool acked)

Regards,
-Denis
--===============8441241505892263333==--

