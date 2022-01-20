Content-Type: multipart/mixed; boundary="===============3684627820033036871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 06/12] frame-xchg: set allow multicast flag
Date: Thu, 20 Jan 2022 14:17:13 -0600
Message-ID: <0ad74b26-9ea4-d703-7026-fb4eb6ef9ecc@gmail.com>
In-Reply-To: 20220118212512.2017977-6-prestwoj@gmail.com

--===============3684627820033036871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 15:25, James Prestwood wrote:
> Receiving multicast frames is required by DPP
> ---
>   src/frame-xchg.c | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/src/frame-xchg.c b/src/frame-xchg.c
> index 5ba36081..95c030d8 100644
> --- a/src/frame-xchg.c
> +++ b/src/frame-xchg.c
> @@ -611,6 +611,7 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group=
_id, uint16_t frame_type,
>   =

>   	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
>   	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST, 0, NULL);

Should this be opt-in?  You may want to audit all uses of frame_watch_add t=
o see =

if they can deal with multicast frames.

>   	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
>   				prefix_len, prefix);
>   =

> =


Regards,
-Denis
--===============3684627820033036871==--

