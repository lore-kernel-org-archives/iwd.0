Content-Type: multipart/mixed; boundary="===============1888194412038891568=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] offchannel: introduce new offchannel module
Date: Mon, 06 Dec 2021 10:03:39 -0800
Message-ID: <f38627a0c4c02189f3cc2e08619b6349452b58eb.camel@gmail.com>
In-Reply-To: 7739b0a3-217e-408b-cc02-4f469657c5c0@gmail.com

--===============1888194412038891568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-01 at 12:06 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 11/30/21 3:49 PM, James Prestwood wrote:
> > This module provides a convenient wrapper around both
> > CMD_[CANCEL_]_REMAIN_ON_CHANNEL APIs.
> > =

> > Certain protocols require going offchannel to send frames, and/or
> > wait for a response. The frame-xchg module somewhat does this but
> > has some limitations. For example you cannot just go offchannel;
> > an initial frame must be sent out to start the procedure. In
> > addition
> > frame-xchg does not work for broadcasts since it expects an ACK.
> > =

> > This module is much simpler and only handles going offchannel for
> > a duration. During this time frames may be sent or received. After
> > the duration the caller will get a callback and any included error
> > if there was one. Any offchannel request can be cancelled prior to
> > the duration expriring if the offchannel work has finished early.
> > ---
> > =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 src/offchannel.c | 302
> > +++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 src/offchannel.h |=C2=A0 29 +++++
> > =C2=A0 3 files changed, 332 insertions(+)
> > =C2=A0 create mode 100644 src/offchannel.c
> > =C2=A0 create mode 100644 src/offchannel.h
> > =

> > v2:
> > =C2=A0 * Removed internal timer and intead rely on the kernel to keep
> > track
> > =C2=A0 * Specially handle the cancel case where the command had been
> > sent to
> > =C2=A0=C2=A0=C2=A0 the kernel already. For this we need to wait until t=
he genl
> > callback
> > =C2=A0=C2=A0=C2=A0 to cancel (since we then have the cookie).
> > =

> =

> <snip>
> =

> > +static void offchannel_cancel_roc(struct offchannel_info *info)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct l_genl_msg *msg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0msg =3D l_genl_msg_new(NL802=
11_CMD_CANCEL_REMAIN_ON_CHANNEL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(msg, =
NL80211_ATTR_WDEV, 8, &info-
> > >wdev_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(msg, =
NL80211_ATTR_COOKIE, 8, &info-
> > >roc_cookie);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Nothing much can be done =
if this fails */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!l_genl_family_send(nl80=
211, msg, NULL, NULL, NULL))
> =

> Would it not be better to wait until the cancel is at least acked and
> only end =

> the wiphy work then?=C2=A0 Might be even better if we waited around until
> the kernel =

> sends the cancel event as well.

Sure I think waiting till the kernel sends cancel ROC is best, that
moves most of the 'done' paths into one spot anyways. I'll change the=C2=A0
'needs_cancel' check to just return below.=C2=A0

Even with this though I don't see a point of waiting for the ACK since
the kernel will send cancel ROC. The ACK callback for this would have
no purpose AFAIK.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_genl_msg_unref(msg);
> > +}
> > +
> > +static void offchannel_roc_cb(struct l_genl_msg *msg, void
> > *user_data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct offchannel_info *info=
 =3D user_data;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info->error =3D l_genl_msg_g=
et_error(msg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info->roc_cmd_id =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->error < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_debug("Error from CMD_REMAIN_ON_CHANNEL (%d)",
> > info->error);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto work_done;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info->error =3D nl80211_pars=
e_attrs(msg, NL80211_ATTR_COOKIE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0&info->roc_cookie,
> > NL80211_ATTR_UNSPEC);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->error < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_error("Could not parse ROC cookie");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto work_done;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* This request was cancelle=
d, and ROC needs to be
> > cancelled */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->needs_cancel) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0offchannel_cancel_roc(info);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto work_done;

This can just return, and be 'done' in the ROC cancel event.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +work_done:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wiphy_radio_work_done(wiphy_=
find_by_wdev(info->wdev_id),
> > info->work.id);
> > +}
> > +
> =

> <snip>
> =

> > +
> > +void offchannel_cancel(uint64_t wdev_id, uint32_t id)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct wiphy *wiphy =3D wiph=
y_find_by_wdev(wdev_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct offchannel_info *info;
> > +
> =

> Maybe be paranoid and check wiphy isn't NULL?
> =

> Also, shouldn't we check that the work id exists?
> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Hasn't even started yet */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!wiphy_radio_work_is_run=
ning(wiphy, id))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto work_done;
> =

> Guess we could modify wiphy_radio_work_is_running to return an int
> and use 0/1 =

> for true/false and -ENOENT if the work doesn't exist.

Sure, sounds good.

> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info =3D l_queue_find(offcha=
nnel_list, match_wdev, &wdev_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!info)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->roc_cmd_id) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * The command has been sent to the kernel. This
> > means we must
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * wait till ROC starts and cancel at that time.
> > Cancelling just
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * the ROC command now will have no effect.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (l_genl_family_request_sent(nl80211, info-
> > >roc_cmd_id))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info->=
needs_cancel =3D true;
> =

> Hmm, is a patch missing for ell?

Yeah, I'll send this out.

> =

> So you set needs_cancel and invoke l_genl_family_cancel, which means
> that =

> offchannel_roc_cb() is never called.=C2=A0 Yet that seems to be the only
> place you =

> check needs_cancel?
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_genl_family_cancel(nl80211, info->roc_cmd_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0info->roc_cmd_id =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!info->needs_cancel)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto w=
ork_done;
> =

> If the request hasn't started, then indeed invoking
> l_genl_family_cancel and =

> destroying the work right away should be fine.=C2=A0 If the request has
> already been =

> sent, then we are stuck waiting for the ack.=C2=A0 You could also assume
> that if =

> roc_cmd_id is set, then the command is in flight and setting =

> needs_cancel/waiting for the ack is needed.
> =

> In either case, we should invoke the destroy callback here and clear
> out the =

> user data/callbacks.

Yes, I need to only cancel conditionally. I don't see why we need to
invoke destroy here though? I would rather keep destroy() in one
location, in the work done callback.

> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Something must have happe=
ned in the genl callback. Any
> > errors there
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * will be handled already
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!info->roc_cookie)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> =

> I'm guessing this should be an L_WARN_ON.
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this point we know ROC=
 has at least been queued
> > (potentially not
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * started) and can be cance=
lled.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0offchannel_cancel_roc(info);
> > +
> > +work_done:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wiphy_radio_work_done(wiphy,=
 id);
> > +}
> > +
> =

> Regards,
> -Denis


--===============1888194412038891568==--

