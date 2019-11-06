Content-Type: multipart/mixed; boundary="===============2063414881875483012=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2 2/3] rrm: add radio resource management module
Date: Wed, 06 Nov 2019 13:51:38 -0800
Message-ID: <62ca199a1e05bc90e09f7469282ecafce8a3ca4a.camel@gmail.com>
In-Reply-To: <fefac4d3-28be-6a56-a8c2-887e68765bd7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2063414881875483012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

<snip>
> > +
> > +static void rrm_new_state(struct netdev *netdev)
> > +{
> > +	struct rrm_state *rrm;
> > +	uint16_t frame_type =3D 0x00d0;
> > +	uint8_t prefix[] =3D { 0x05, 0x00 };
> > +	struct station *station;
> > +
> > +	rrm =3D l_new(struct rrm_state, 1);
> > +
> > +	rrm->last_request =3D l_time_now();
> > +	rrm->ifindex =3D netdev_get_ifindex(netdev);
> > +	rrm->wdev_id =3D netdev_get_wdev_id(netdev);
> > +
> > +	netdev_frame_watch_add(netdev, frame_type, prefix,
> > sizeof(prefix),
> > +					rrm_frame_watch_cb, rrm);
> > +
> > +	station =3D station_find(rrm->ifindex);
> > +	station_add_state_watch(station, rrm_station_watch_cb, rrm,
> > NULL);
> =

> Shouldn't you be checking that station exists first?  Also, you have
> a =

> bit of a chicken/egg problem since station is watching the same =

> netdev_watch.  So by luck of the draw it may be getting notified
> (and =

> thus created) after the rrm module.
> =

> How we get around this is unclear.  One way would be to check the
> iftype =

> to be station and just assume that the station object comes around =

> eventually.  Perhaps by lazy-instantiating the station watch only
> once =

> an actual request arrives.

What about adding a module depends on station? This would make RRM get
initialized after station which should make the netdev watch call into
station before RRM.

> > +
> > +	l_queue_push_head(states, rrm);
> > +}
> > +
> > +static bool match_ifindex(const void *a, const void *b)
> > +{
> > +	const struct rrm_state *rrm =3D a;
> > +	uint32_t ifindex =3D L_PTR_TO_UINT(b);
> > +
> > +	return rrm->ifindex =3D=3D ifindex;
> > +}
> > +
> > +static void rrm_netdev_watch(struct netdev *netdev,
> > +				enum netdev_watch_event event, void
> > *user_data)
> > +{
> > +	struct rrm_state *rrm;
> > +	uint32_t ifindex =3D netdev_get_ifindex(netdev);
> > +
> > +	switch (event) {
> > +	case NETDEV_WATCH_EVENT_NEW:
> > +		rrm_new_state(netdev);
> > +		return;
> > +	case NETDEV_WATCH_EVENT_DEL:
> > +		rrm =3D l_queue_find(states, match_ifindex,
> > +					L_UINT_TO_PTR(ifindex));
> > +		if (!rrm)
> > +			return;
> > +
> > +		rrm_cancel_pending(rrm);
> =

> Shouldn't you be freeing the rrm state?
> =

> > +		return;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static int rrm_init(void)
> > +{
> > +	struct l_genl *genl =3D iwd_get_genl();
> > +
> > +	states =3D l_queue_new();
> > +
> > +	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
> > +
> > +	netdev_watch =3D netdev_watch_add(rrm_netdev_watch, NULL, NULL);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rrm_exit(void)
> > +{
> > +	l_genl_family_free(nl80211);
> > +	nl80211 =3D NULL;
> > +
> > +	netdev_watch_remove(netdev_watch);
> > +
> > +	l_queue_destroy(states, rrm_state_destroy);
> > +}
> > +
> > +IWD_MODULE(rrm, rrm_init, rrm_exit);
> > +IWD_MODULE_DEPENDS(rrm, netdev);
> > =

> =

> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============2063414881875483012==--

