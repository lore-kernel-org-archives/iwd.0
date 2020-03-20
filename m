Content-Type: multipart/mixed; boundary="===============3248247766384688118=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] frame-xchg: Add facility to keep retransmitting after
 ACK
Date: Fri, 20 Mar 2020 10:15:24 -0500
Message-ID: <37ffb092-6f3b-6edf-bbe7-bd3536ff71f4@gmail.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3248247766384688118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/19/20 4:12 PM, Andrew Zaborowski wrote:
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

<snip>

> @@ -850,17 +862,19 @@ static void frame_xchg_tx_status(struct frame_xchg_=
data *fx, bool acked)
>   		fx->have_cookie =3D false;
>   =

>   		l_debug("Processing an early frame");
> -		frame_xchg_resp_cb(fx->early_frame.mpdu, fx->early_frame.body,
> -					fx->early_frame.body_len,
> -					fx->early_frame.rssi, fx);
>   =

> -		frame_xchg_done(fx, 0);
> +		if (frame_xchg_resp_handle(fx->early_frame.mpdu, fx->early_frame.body,

I fixed up this >80 char line...

> +						fx->early_frame.body_len,
> +						fx->early_frame.rssi, fx))
> +			return;
> +
> +		frame_xchg_listen_end_cb(NULL, fx);
>   		return;
>   	}


and applied.  Thanks.

Regards,
-Denis
--===============3248247766384688118==--

