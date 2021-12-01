Content-Type: multipart/mixed; boundary="===============0216460315650068813=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] offchannel: introduce new offchannel module
Date: Wed, 01 Dec 2021 12:06:09 -0600
Message-ID: <7739b0a3-217e-408b-cc02-4f469657c5c0@gmail.com>
In-Reply-To: 20211130214937.470466-1-prestwoj@gmail.com

--===============0216460315650068813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/30/21 3:49 PM, James Prestwood wrote:
> This module provides a convenient wrapper around both
> CMD_[CANCEL_]_REMAIN_ON_CHANNEL APIs.
> =

> Certain protocols require going offchannel to send frames, and/or
> wait for a response. The frame-xchg module somewhat does this but
> has some limitations. For example you cannot just go offchannel;
> an initial frame must be sent out to start the procedure. In addition
> frame-xchg does not work for broadcasts since it expects an ACK.
> =

> This module is much simpler and only handles going offchannel for
> a duration. During this time frames may be sent or received. After
> the duration the caller will get a callback and any included error
> if there was one. Any offchannel request can be cancelled prior to
> the duration expriring if the offchannel work has finished early.
> ---
>   Makefile.am      |   1 +
>   src/offchannel.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++
>   src/offchannel.h |  29 +++++
>   3 files changed, 332 insertions(+)
>   create mode 100644 src/offchannel.c
>   create mode 100644 src/offchannel.h
> =

> v2:
>   * Removed internal timer and intead rely on the kernel to keep track
>   * Specially handle the cancel case where the command had been sent to
>     the kernel already. For this we need to wait until the genl callback
>     to cancel (since we then have the cookie).
> =


<snip>

> +static void offchannel_cancel_roc(struct offchannel_info *info)
> +{
> +	struct l_genl_msg *msg;
> +
> +	msg =3D l_genl_msg_new(NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &info->wdev_id);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_COOKIE, 8, &info->roc_cookie);
> +
> +	/* Nothing much can be done if this fails */
> +	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))

Would it not be better to wait until the cancel is at least acked and only =
end =

the wiphy work then?  Might be even better if we waited around until the ke=
rnel =

sends the cancel event as well.

> +		l_genl_msg_unref(msg);
> +}
> +
> +static void offchannel_roc_cb(struct l_genl_msg *msg, void *user_data)
> +{
> +	struct offchannel_info *info =3D user_data;
> +
> +	info->error =3D l_genl_msg_get_error(msg);
> +	info->roc_cmd_id =3D 0;
> +
> +	if (info->error < 0) {
> +		l_debug("Error from CMD_REMAIN_ON_CHANNEL (%d)", info->error);
> +		goto work_done;
> +	}
> +
> +	info->error =3D nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE,
> +					&info->roc_cookie, NL80211_ATTR_UNSPEC);
> +	if (info->error < 0) {
> +		l_error("Could not parse ROC cookie");
> +		goto work_done;
> +	}
> +
> +	/* This request was cancelled, and ROC needs to be cancelled */
> +	if (info->needs_cancel) {
> +		offchannel_cancel_roc(info);
> +		goto work_done;
> +	}
> +
> +	return;
> +
> +work_done:
> +	wiphy_radio_work_done(wiphy_find_by_wdev(info->wdev_id), info->work.id);
> +}
> +

<snip>

> +
> +void offchannel_cancel(uint64_t wdev_id, uint32_t id)
> +{
> +	struct wiphy *wiphy =3D wiphy_find_by_wdev(wdev_id);
> +	struct offchannel_info *info;
> +

Maybe be paranoid and check wiphy isn't NULL?

Also, shouldn't we check that the work id exists?

> +	/* Hasn't even started yet */
> +	if (!wiphy_radio_work_is_running(wiphy, id))
> +		goto work_done;

Guess we could modify wiphy_radio_work_is_running to return an int and use =
0/1 =

for true/false and -ENOENT if the work doesn't exist.

> +
> +	info =3D l_queue_find(offchannel_list, match_wdev, &wdev_id);
> +	if (!info)
> +		return;
> +
> +	if (info->roc_cmd_id) {
> +		/*
> +		 * The command has been sent to the kernel. This means we must
> +		 * wait till ROC starts and cancel at that time. Cancelling just
> +		 * the ROC command now will have no effect.
> +		 */
> +		if (l_genl_family_request_sent(nl80211, info->roc_cmd_id))
> +			info->needs_cancel =3D true;

Hmm, is a patch missing for ell?

So you set needs_cancel and invoke l_genl_family_cancel, which means that =

offchannel_roc_cb() is never called.  Yet that seems to be the only place y=
ou =

check needs_cancel?

> +
> +		l_genl_family_cancel(nl80211, info->roc_cmd_id);
> +		info->roc_cmd_id =3D 0;
> +
> +		if (!info->needs_cancel)
> +			goto work_done;

If the request hasn't started, then indeed invoking l_genl_family_cancel an=
d =

destroying the work right away should be fine.  If the request has already =
been =

sent, then we are stuck waiting for the ack.  You could also assume that if =

roc_cmd_id is set, then the command is in flight and setting =

needs_cancel/waiting for the ack is needed.

In either case, we should invoke the destroy callback here and clear out th=
e =

user data/callbacks.

> +
> +		return;
> +	}
> +
> +	/*
> +	 * Something must have happened in the genl callback. Any errors there
> +	 * will be handled already
> +	 */
> +	if (!info->roc_cookie)
> +		return;

I'm guessing this should be an L_WARN_ON.

> +
> +	/*
> +	 * At this point we know ROC has at least been queued (potentially not
> +	 * started) and can be cancelled.
> +	 */
> +	offchannel_cancel_roc(info);
> +
> +work_done:
> +	wiphy_radio_work_done(wiphy, id);
> +}
> +

Regards,
-Denis
--===============0216460315650068813==--

