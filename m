Content-Type: multipart/mixed; boundary="===============5236011646461603462=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 5/6] netdev: add SAE offload support
Date: Fri, 19 Mar 2021 08:51:11 -0700
Message-ID: <5f3f459e5f71fb1244c7ae7d24531309843a6e08.camel@gmail.com>
In-Reply-To: <6395b7de-4bd5-a1b5-f0b7-78447f2cd320@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5236011646461603462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-03-19 at 10:15 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 3/18/21 12:20 PM, James Prestwood wrote:
> > SAE offload support requires some minor tweaks to CMD_CONNECT
> > as well as special checks once the connect event comes in. Since
> > at this point we are fully connected.
> > ---
> >   src/netdev.c | 31 ++++++++++++++++++++++++++++---
> >   1 file changed, 28 insertions(+), 3 deletions(-)
> > =

> > diff --git a/src/netdev.c b/src/netdev.c
> > index 66a781bc..f4b44b31 100644
> > --- a/src/netdev.c
> > +++ b/src/netdev.c
> > @@ -1979,6 +1979,13 @@ process_resp_ies:
> >   			netdev_send_qos_map_set(netdev, qos_set,
> > qos_len);
> >   	}
> >   =

> > +	/*
> > +	 * A successful connect event using offload means IWD is fully
> > +	 * connected and completed the 4-way handshake
> > +	 */
> > +	if (netdev->handshake->offload)
> > +		goto done;
> > +
> =

> So we only offload SAE connections, right?  Otherwise for 802.1X + HS
> offload =

> this may be incorrect...
> =

> >   	if (netdev->sm) {
> >   		/*
> >   		 * Let station know about the roam so a state change
> > can occur.
> =

> <snip>
> =

> > @@ -2618,6 +2628,15 @@ static struct l_genl_msg
> > *netdev_build_cmd_connect(struct netdev *netdev,
> >   						bss->ssid_len, bss-
> > >ssid);
> >   	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4,
> > &auth_type);
> >   =

> > +	if (hs->offload) {
> > +		l_genl_msg_append_attr(msg,
> > NL80211_ATTR_EXTERNAL_AUTH_SUPPORT,
> > +					0, NULL);
> > +
> =

> Hmm, this part looks suspicious?  See my reply to patch 2?

Yeah I misread the docs, as well as followed how wpa_s does it (which
includes this) but its not needed. With respect to your other comments
I think I'll punt on EXTERNAL_AUTH for now since I have no way of
testing it and only one driver actually uses it.

> =

> > +		if (IE_AKM_IS_SAE(hs->akm_suite))
> > +			l_genl_msg_append_attr(msg,
> > NL80211_ATTR_SAE_PASSWORD,
> > +					strlen(hs->passphrase), hs-
> > >passphrase);
> > +	}
> > +
> >   	if (prev_bssid)
> >   		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID,
> > ETH_ALEN,
> >   						prev_bssid);
> =

> Regards,
> -Denis

--===============5236011646461603462==--

