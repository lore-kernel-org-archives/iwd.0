Content-Type: multipart/mixed; boundary="===============1273192190147677024=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 2/8] netdev: add netdev_get_station
Date: Mon, 11 Jan 2021 12:54:13 -0800
Message-ID: <0e4dd87f7c34ec5ffc5e7a3e04d3ce726bb98719.camel@gmail.com>
In-Reply-To: <942c0148-7da3-d984-2670-923df7755011@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1273192190147677024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >   struct wiphy *netdev_get_wiphy(struct netdev *netdev);
> >   const uint8_t *netdev_get_address(struct netdev *netdev);
> >   uint32_t netdev_get_ifindex(struct netdev *netdev);
> > @@ -174,6 +182,10 @@ int netdev_neighbor_report_req(struct netdev
> > *netdev,
> >   int netdev_set_rssi_report_levels(struct netdev *netdev, const
> > int8_t *levels,
> >   					size_t levels_num);
> >   =

> > +int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
> =

> Do you want to add a convenience method to grab the current
> station?  The mac =

> parameter is for cases where you might have multiple ones, like AP.

I could, although its not too bad just passing in handshake->aa... But
if you want a current station API and a separate one for AP I don't
mind either way.

> =

> > +			netdev_get_station_cb_t cb, void *user_data,
> > +			netdev_destroy_func_t destroy);
> > +
> >   void netdev_handshake_failed(struct handshake_state *hs, uint16_t
> > reason_code);
> >   =

> >   struct netdev *netdev_find(int ifindex);
> > =

> =

> Regards,
> -Denis

--===============1273192190147677024==--

