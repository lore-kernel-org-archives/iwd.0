Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF871339B6
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941479; cv=none; b=OFptKdDvGMD2LnqcFuL2duQakk0hWc9aRXAMaZFXgBfQH5MEfUImuNkAAycbjQzhZrfO9KgI948vlL0F9/zCQQc+cO/KVs4fmV3ZfxqhH10cMgSaSjccVScoBFCf3siauNte4mjFxygqEVPrMn3FRsJZi8gu63omc3p/sk+6tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941479; c=relaxed/simple;
	bh=aj3Ox1t0APkA8OSWLUJFxkg07yPNJVQd6EL4yd2r9WM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f8GISxHTDhT2+Iw16S/1qK3+3ZBVExZWSEjtIFGy8d3gDjaJjTgMcJsiYTCtxRkU3OOEt+nnBGB1A5+CENMYFqRDsRtkSFAMSrqHoakSzxGhaegI9LdYN4f3+pMzqtuC9KqdR+GS7SkWJRKLaZnQVb0m1KUA+9I3PX/rvf0Jxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id CFFA7CECBE;
	Wed, 14 Feb 2024 21:11:15 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC 2/5] station: use l_notice for station_debug_event, allow
 arguments
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <95c6f271-2f18-4381-b0d9-b31e86741700@gmail.com>
Date: Wed, 14 Feb 2024 21:11:05 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB183D5B-747B-44C8-A5F0-0C6588C2AFFE@holtmann.org>
References: <20240214193743.963349-1-prestwoj@gmail.com>
 <20240214193743.963349-3-prestwoj@gmail.com>
 <708401D3-CE90-4A7C-9008-F64904877BC9@holtmann.org>
 <95c6f271-2f18-4381-b0d9-b31e86741700@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi James,

>>> For anyone debugging or trying to identify network infrastructure
>>> problems the IWD DBus API isn't all that useful and ultimately
>>> requires going through debug logs to figure out exactly what
>>> happened. Having a concise set of debug logs containing only
>>> relavent information would be very useful. In addition, having
>>> some kind of syntax for these logs to be parsed by tooling could
>>> automate these tasks.
>>>=20
>>> This is being done, starting with station, by using l_notice. The
>>> use of l_notice in IWD will be strictly for the type of messages
>>> described above. Modules using l_notice should follow the same
>>> log format so tooling can parse the messages generically. The
>>> format should be zero or more comma-separated key value pairs,
>>> starting with "event: <event name>".
>>>=20
>>> station_debug_event is being modified to use l_notice as most of
>>> the events are useful for debugging. This was modified slightly
>>> to allow arguments to be passed in order to provide extra
>>> information if available.
>>> ---
>>> src/station.c | 25 +++++++++++++++----------
>>> 1 file changed, 15 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/src/station.c b/src/station.c
>>> index ea505ca2..a097174e 100644
>>> --- a/src/station.c
>>> +++ b/src/station.c
>>> @@ -215,15 +215,13 @@ static bool station_is_roaming(struct station =
*station)
>>> station->state =3D=3D STATION_STATE_FW_ROAMING;
>>> }
>>>=20
>>> -static bool station_debug_event(struct station *station, const char =
*name)
>>> +static bool station_emit_event(struct station *station, const char =
*name)
>>> {
>>> struct l_dbus_message *signal;
>>>=20
>>> if (!iwd_is_developer_mode())
>>> return true;
>>>=20
>>> - l_debug("StationDebug.Event(%s)", name);
>>> -
>>> signal =3D l_dbus_message_new_signal(dbus_get_bus(),
>>> netdev_get_path(station->netdev),
>>> IWD_STATION_DEBUG_INTERFACE, "Event");
>>> @@ -233,6 +231,12 @@ static bool station_debug_event(struct station =
*station, const char *name)
>>> return l_dbus_send(dbus_get_bus(), signal) !=3D 0;
>>> }
>>>=20
>>> +#define station_debug_event(station, name, fmt, ...) \
>>> +({ \
>>> + l_notice("event: %s, " fmt, name, ##__VA_ARGS__); \
>>> + station_emit_event(station, name); \
>>> +})
>>> +
>>> static void station_property_set_scanning(struct station *station,
>>> bool scanning)
>>> {
>>> @@ -1565,7 +1569,7 @@ static void station_enter_state(struct station =
*station,
>>> station_state_to_string(station->state),
>>> station_state_to_string(state));
>>>=20
>>> - station_debug_event(station, station_state_to_string(state));
>>> + station_debug_event(station, station_state_to_string(state), "");
>>>=20
>>> disconnected =3D !station_is_busy(station);
>>>=20
>>> @@ -2351,13 +2355,14 @@ static bool station_ft_work_ready(struct =
wiphy_radio_work_item *item)
>>> l_queue_insert(station->roam_bss_list, rbss,
>>> roam_bss_rank_compare, NULL);
>>>=20
>>> - station_debug_event(station, "ft-fallback-to-reassoc");
>>> + station_debug_event(station, "ft-fallback-to-reassoc", "");
>>>=20
>>> station_transition_start(station);
>>> l_steal_ptr(rbss);
>>> break;
>>> case -ENOENT:
>>> - station_debug_event(station, "ft-roam-failed");
>>> + station_debug_event(station, "ft-roam-failed",
>>> + "reason: authentication timeout");
>>> try_next:
>>> station_transition_start(station);
>>> break;
>>> @@ -2560,7 +2565,7 @@ static void station_roam_scan_triggered(int =
err, void *user_data)
>>> return;
>>> }
>>>=20
>>> - station_debug_event(station, "roam-scan-triggered");
>>> + station_debug_event(station, "roam-scan-triggered", "");
>> this is really awful.
>>=20
>> Lets have the event / state name as enum or something so that it is =
const.
>>=20
>> And then having the empty =E2=80=9C=E2=80=9D all the time is insane. =
That is horrible API and in 2 month you wonder what the =E2=80=9C=E2=80=9D=
 is for. So let=E2=80=99s not do that. Rather have station_debug_event =
and station_debug_event_printf.
>=20
> So, I can separate station_debug_event from this l_notice stuff, it =
just fit nicely together from the standpoint of these "debug events" are =
useful, and I didn't want have repeated calls like:
>=20
> station_debug_event(...)
>=20
> l_notice(...)

problem is that this turns into spaghetti code. And more complicated the =
calling function has _debug_ in it, while the action purpose is to =
actually send a debug event via D-Bus. So the naming is bad.

> The extra argument was to avoid manually parsing some arbitrary number =
of args by always passing in a format string but we could avoid this by =
separating the two and making them independent calls.

Yes. This avoids argument guessing. If the majority of cases you use =
=E2=80=9C=E2=80=9D or NULL, then it is worth while to have a separate =
function for it.

Regards

Marcel

