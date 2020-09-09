Content-Type: multipart/mixed; boundary="===============2458029671986104238=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 14/17] ap: Pass extra IEs between mgmt frames and user
Date: Thu, 10 Sep 2020 01:38:20 +0200
Message-ID: <CAOq732JNLNC9mSJiuKnvhQ+B-ZYpq-=7-B=uN86bqXZxr83xfw@mail.gmail.com>
In-Reply-To: <582c0a46-4b3d-f5f2-cdf0-74ac626ead5f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2458029671986104238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 9 Sep 2020 at 22:44, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> > @@ -505,7 +514,11 @@ static void ap_set_beacon_cb(struct l_genl_msg *ms=
g, void *user_data)
> >   static void ap_update_beacon(struct ap_state *ap)
> >   {
> >       struct l_genl_msg *cmd;
> > -     uint8_t head[256], tail[256];
> > +     size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
> > +             ap->ops->get_mgmt_frame_ies_len(MPDU_MANAGEMENT_SUBTYPE_B=
EACON,
> > +                                             ap->user_data) : 0;
> > +     uint8_t head[256];
> > +     uint8_t tail[256 + extra_ies_len];
> >       size_t head_len, tail_len;
> >       uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
> >       static const uint8_t bcast_addr[6] =3D {
>
> Given that this is semi-static, and the caller has to call ap_update_beac=
on
> anyway, wouldn't it make more sense to just have the caller pass in the e=
xtra
> ies so you could just use append_attrv() on the NL80211_ATTR_BEACON_TAIL?

I can do that I guess, but since we're already adding the
write_mgmt_frame_ies() API we can save some effort by using it here.

ops->write_mgmt_frame_ies() is also called when we set up the initial beaco=
n.

Best regards
--===============2458029671986104238==--

