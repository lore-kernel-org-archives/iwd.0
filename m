Content-Type: multipart/mixed; boundary="===============1633061234478015302=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/3] ap: Don't defer ap_reset when ap_free called in event
Date: Fri, 21 Jan 2022 08:54:13 -0600
Message-ID: <5be0d1fe-7ee6-fa75-e237-11ca03d26f81@gmail.com>
In-Reply-To: 20220121102439.267357-1-andrew.zaborowski@intel.com

--===============1633061234478015302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/21/22 04:24, Andrew Zaborowski wrote:
> Previously we added logic to defer doing anything in ap_free() to after
> the AP event handler has returned so that ap_event() has a chance to
> inform whoever called it that the ap_state has been freed.  But there's
> also a chance that the event handler is destroying both the AP and the
> netdev it runs on, so after the handler has returned we can't even use
> netdev_get_wdev_id or netdev_get_ifindex.  The easiest solution seems to
> be to call ap_reset() in ap_free() even if we're within an event handler
> to ensure we no longer need any external objects.  Also make sure
> ap_reset() can be called multiple times.
> =

> Another option would be to watch for NETDEV_WATCH_EVENT_DEL and remove
> our reference to the netdev (because there's no need actually call
> l_rtnl_ifaddr_delete or frame_watch_wdev_remove if the netdev was
> destroyed -- frame_watch already tracks netdev removals), or to save
> just the ifindex and the wdev id...
> ---
>   src/ap.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============1633061234478015302==--

