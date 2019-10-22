Content-Type: multipart/mixed; boundary="===============7209931859032162354=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Tue, 22 Oct 2019 09:53:51 -0500
Message-ID: <80e427d5-7b3a-41c4-bb37-8d40fef3fd6e@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7209931859032162354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/19 8:55 AM, Andrew Zaborowski wrote:
> From: Andrew Zaborowski <andrew.zaborowski@intel.com>
> =

> Allow watching for frames on interfaces that have no netdev in the
> kernel and can only be referenced through the wdev_id instead of the
> ifindex.
> ---
>   src/netdev.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-----
>   src/netdev.h |  6 ++++
>   2 files changed, 84 insertions(+), 8 deletions(-)
> =


<snip>

> diff --git a/src/netdev.h b/src/netdev.h
> index 114a6035..624811b2 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -197,6 +197,12 @@ uint32_t netdev_frame_watch_add(struct netdev *netde=
v, uint16_t frame_type,
>   				void *user_data);
>   bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id);
>   =

> +uint32_t netdev_wdev_frame_watch_add(uint64_t wdev_id, uint16_t frame_ty=
pe,
> +				const uint8_t *prefix, size_t prefix_len,
> +				netdev_frame_watch_func_t handler,
> +				void *user_data);
> +bool netdev_wdev_frame_watch_remove(uint32_t id);
> +

So this really seems like it is jammed in there and it doesn't fit well.

I think that we should make frame watches into a separate module now =

that they no longer are only associated with a netdev.  This would allow =

us to also track iftype changes and wipe out those frame watches that =

are no longer registered with the kernel.  And also allow us not to try =

and register frame watches that are already live (and bounce with an =

-EAGAIN from the kernel).

We could also implement 'transient' frame watch sets by using a genl =

socket dedicated to each set.  At least until the kernel people fix =

their subsystem.

>   void netdev_handshake_failed(struct handshake_state *hs, uint16_t reaso=
n_code);
>   =

>   struct netdev *netdev_find(int ifindex);
> =


Regards,
-Denis
--===============7209931859032162354==--

