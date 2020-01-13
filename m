Content-Type: multipart/mixed; boundary="===============3203709982575469068=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Mon, 13 Jan 2020 07:48:32 -0600
Message-ID: <9cfe570e-16f2-f9a6-b3d2-48baed9ff6cb@gmail.com>
In-Reply-To: <CAOq732+41a2Sshdz1E4s1ZwKMgtMjkkkDucx7rMd6Q_tpNHK9A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3203709982575469068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>>        case -ECANCELED:
>>> -             dbus_pending_reply(&wsc->pending,
>>> +             if (wsc->pending)
>>> +                     dbus_pending_reply(&wsc->pending,
>>>                                        dbus_error_aborted(wsc->pending)=
);
>>
>> Hmm, why the if ()?
> =

> In some scenario we're sending a not_available reply so this is a
> mechanism to override the specific reply.

This happens only on wsc_free, and I think you should be bypassing =

calling wsc_enrollee_cancel in that case.  The netdev is likely already =

gone by then anyway.

> =

>>
>> Also, if you wait until netdev_disconnect_cb to signal done_cb with
>> -ECANCELED, you can reply to both the pending and cancel messages here.
> =

> I think it's actually nicer to send the "pending" reply early.  It's
> also a nice property that we can use wsc_enrollee_cancel to
> immediately forget the done callback, also from P2P point of view
> where we're destroying the netdev right after we call this.  So I
> think it'll need a separate optional callback.

This is what we have now, so I'm fine with the above as well.

> =

> I wonder if we need to re-check that wsc->station still exists every
> time we use it.
> =


station and wsc would be created or destroyed at the same time as part =

of the netdev notification procedure.  So I don't think checking it is =

needed.

>>> +void wsc_enrollee_cancel(struct wsc_enrollee *wsce);
>>>
>>
>> You may still want an explicit wsc_enrollee_free for cases where
>> netdev_disconnect shouldn't be used / attempted.
> =

> We'd need to be very sure that the netdev is also being freed.  We
> mainly use netdev_disconnect to make sure netdev forgets our connect
> callbacks, note that station also does this in station_free.

Not sure why station_free does this.  Maybe it is to force certain =

signals to go out.  I suspect this is something that we should fix in =

station and not a desirable behavior to emulate.  Sending a =

netdev_disconnect when the device is gone or down anyway seems pretty =

pointless.

Regards,
-Denis
--===============3203709982575469068==--

