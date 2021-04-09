Content-Type: multipart/mixed; boundary="===============7526139914442738051=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 3/5] netdev: implement netdev_handshake_state_set_pmk
Date: Fri, 09 Apr 2021 09:09:33 -0700
Message-ID: <c7280601c89665b3f15f711656f2d055c4cc429a.camel@gmail.com>
In-Reply-To: <c26a63f4-1f49-64fc-ff01-49e909d3e142@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7526139914442738051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-04-08 at 15:14 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 4/8/21 10:46 AM, James Prestwood wrote:
> > The 8021x offloading procedure still does EAP in userspace which
> > negotiates the PMK. The kernel then expects to obtain this PMK
> > from userspace by calling SET_PMK. This then allows the firmware
> > to begin the 4-way handshake.
> > =

> > netdev_handshake_set_pmk kicks off the final userspace
> > actions prior to the firmware starting the 4-way handshake:
> > =

> >   - SET_PMK using PMK negotiated with EAP
> >   - SET_STATION (concurrently with SET_PMK)
> >   - Emit SETTING_KEYS event
> >   - netdev_connect_ok
> > =

> > One thing to note is that the kernel provides no way of knowing if
> > the 4-way handshake completed. Assuming SET_PMK/SET_STATION come
> > back with no errors, IWD assumes the PMK was valid. If not, or
> > due to some other issue in the 4-way, the kernel will send a
> > disconnect.
> > ---
> >   src/netdev.c | 85
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/netdev.h |  2 ++
> >   2 files changed, 87 insertions(+)
> > =

> =

> <snip>
> =

> > +void netdev_handshake_set_pmk(struct handshake_state *hs)
> > +{
> > +	struct l_genl_msg *msg;
> > +	struct netdev_handshake_state *nhs =3D l_container_of(hs,
> > +				struct netdev_handshake_state, super);
> > +	struct netdev *netdev =3D nhs->netdev;
> > +
> > +	/* Only relevent for 8021x offload */
> > +	if (nhs->type !=3D CONNECTION_TYPE_8021X_OFFLOAD)
> > +		return;
> > +
> > +	msg =3D l_genl_msg_new(NL80211_CMD_SET_PMK);
> > +
> > +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev-
> > >index);
> > +	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6, netdev-
> > >handshake->aa);
> > +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK,
> > +				netdev->handshake->pmk_len,
> > +				netdev->handshake->pmk);
> > +
> > +	nhs->set_pmk_cmd_id =3D l_genl_family_send(nl80211, msg,
> > +							netdev_set_pmk_
> > cb,
> > +							nhs, NULL);
> > +	if (!nhs->set_pmk_cmd_id) {
> > +		l_error("Failed to set SET_PMK");
> > +		netdev_setting_keys_failed(nhs, -EIO);
> > +		return;
> > +	}
> > +
> > +	msg =3D nl80211_build_set_station_authorized(netdev->index,
> > +							netdev-
> > >handshake->aa);
> =

> I seem to recall that brcmfmac reports a -ENOTSUP error for
> SET_STATION.  So is =

> this even needed?

Its accepting it just fine, but I tried removing it and it looks like
I'm still staying connected so apparently its not required :)

> =

> > +
> > +	nhs->set_station_cmd_id =3D l_genl_family_send(nl80211, msg,
> > +						netdev_set_station_offl
> > oad_cb,
> > +						nhs, NULL);
> > +	if (!nhs->set_station_cmd_id) {
> > +		l_error("Failed to SET_STATION");
> > +		netdev_setting_keys_failed(nhs, -EIO);
> > +	}
> > +}
> > +
> =

> Regards,
> -Denis

--===============7526139914442738051==--

