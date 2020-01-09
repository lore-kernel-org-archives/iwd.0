Content-Type: multipart/mixed; boundary="===============4568008896469088660=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] wsc: Refactor to make the DBus interface reusable
Date: Thu, 09 Jan 2020 13:56:09 -0600
Message-ID: <5dbc9e53-129a-79f6-8517-f022f41b0e16@gmail.com>
In-Reply-To: <CAOq732JCzYDTj4rhdZx7HvKh6KPOaOj1NnAE2SOYShb=egj=-g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4568008896469088660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> So while this works, I would think that separating the layers more
>> explicitly would make things more elegant.  You have the EAP-WSC state
>> machine object that takes care of the actual WSC connection:
>>          wsc_enrollee_new
>>          wsc_enrollee_start
>>          wsc_enrollee_cancel
>>          wsc_enrollee_free
> =

> Ok, this sounds good.  I'm not even sure if we need a start and a
> cancel, or it's Ok to create and free this whole state machine as
> needed.

See how it looks.  We might need a cancel at least since you have a =

'destroy immediately' case where the device goes away due to hot-unplug. =

  Or cancel and try to cleanup first case.

> =

> So those functions would operate on a "struct wsc_enrollee".

Right.

> =

>>
>> Then you have the p2p/station layers that take care of scanning, etc.
>> This is where your ops stuff can live.  Something like:
>>
>> struct wsc {
>>          const char *(*get_path)(struct wsc *wsc);
>>          int (*connect)(struct wsc *wsc, const char *pin,
>>                          connect_cb_t cb, void *userdata);
>>          int (*cancel)(struct wsc *wsc, cancel_cb_t cb, void *userdata);
>>          void (*remove)(struct wsc *wsc);
>> };
> =

> So this would be exposed in wsc.h I understand.  I think I'd still
> rather call it wsc_ops.
> =


Can do that too.  But there might be state you can share across the =

different sub-types.  Maybe the netdev for example.

>>
>> Then for p2p you can do:
>>
>> struct wsc_p2p {
>>          // some members
>>          struct wsc super;
>> };
>>
>> struct wsc *wsc_p2p_new();
> =

> And this would live in p2p.c.  We have one WSC interface per peer so
> this would really be called "struct p2p_peer_wsc_dbus" or similar and
> in the callbacks it can use container_of() instead of needing the
> user_data so that parameter can be dropped.
> =


Yep

>>
>> for station:
>> struct wsc_station {
>>          struct wsc super;
>>          // some members;
>>          struct station *station;
>>          uint32_t station_state_watch;
>>          ...
>> };
>>
>> struct wsc *wsc_station_new();
>>
>> And if you want to unify the D-Bus bits, then:
>>
>> struct wsc_dbus {
>>          struct wsc *wsc;
>>          struct l_dbus_message *pending;
>>          struct l_dbus_message *pending_cancel;
>> };
> =

> Ok, so this would be created by a call to:
> =

> struct wsc_dbus *wsc_dbus_new(struct wsc *wsc)   (or struct wsc_ops *wsc)
> =


yes, something like that would be needed.  Can also do something like =

wsc_dbus_object_add and let struct wsc_dbus be hidden away in wsc.c

> and it would either need to be public in wsc.h or have enough
> accessors for pending and pending_cancel.
> =


Reegards,
-Denis
--===============4568008896469088660==--

