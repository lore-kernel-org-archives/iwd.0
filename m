Content-Type: multipart/mixed; boundary="===============4582262029165770877=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Mon, 14 Feb 2022 17:05:58 -0600
Message-ID: <d996ac97-38b6-0392-fc1f-fc78f167ffa1@gmail.com>
In-Reply-To: 20220214214809.1017870-4-prestwoj@gmail.com

--===============4582262029165770877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
>   =

> -bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_ty=
pe,
> -			const uint8_t *prefix, size_t prefix_len,
> -			frame_watch_cb_t handler, void *user_data,
> -			frame_xchg_destroy_func_t destroy);
> +bool frame_watch_add(uint64_t wdev_id, uint32_t group, bool mcast,
> +			uint16_t frame_type, const uint8_t *prefix,
> +			size_t prefix_len, frame_watch_cb_t handler,
> +			void *user_data, frame_xchg_destroy_func_t destroy);

Can we just add frame_watch_add_multicast_allowed instead?  The number of =

arguments in frame_watch_add is already too much.

>   bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
>   bool frame_watch_wdev_remove(uint64_t wdev_id);
>   =


Regards,
-Denis
--===============4582262029165770877==--

