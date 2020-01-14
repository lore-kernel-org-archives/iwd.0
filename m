Content-Type: multipart/mixed; boundary="===============3703194068536551190=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Tue, 14 Jan 2020 14:53:36 -0600
Message-ID: <f614a716-3f47-1b49-9bfc-b3b9500f4296@gmail.com>
In-Reply-To: <CAOq732Le12r6LjdZppay4U0agPHCzHgNmjeJ-WfwsE05ay1JNQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3703194068536551190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/14/20 7:23 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Mon, 13 Jan 2020 at 19:49, Denis Kenzior <denkenz@gmail.com> wrote:
>>>>>         case -ECANCELED:
>>>>> -             dbus_pending_reply(&wsc->pending,
>>>>> +             if (wsc->pending)
>>>>> +                     dbus_pending_reply(&wsc->pending,
>>>>>                                         dbus_error_aborted(wsc->pendi=
ng));
>>>>
>>>> Hmm, why the if ()?
>>>
>>> In some scenario we're sending a not_available reply so this is a
>>> mechanism to override the specific reply.
>>
>> This happens only on wsc_free, and I think you should be bypassing
>> calling wsc_enrollee_cancel in that case.  The netdev is likely already
>> gone by then anyway.
> =

> wsc_free may happen because the netdev is going away or because iwd is
> shutting down, or we're switching modes.  In those cases if we have a

There are two cases, in both cases it is too late to send CMD_DISCONNECT:

1. netdev_set_iftype path.  If the interface is up, we bring it down =

first.  This is what causes the NETDEV_WATCH_EVENT_DOWN.  Trying to send =

netdev_disconnect seems sort of pointless.

2. netdev itself is removed.  At which point netdev_connect_free has =

been called or we cancel the netdev_disconnect command if it is pending. =

  netdev object is destroyed shortly thereafter.  So it is absolutely =

wrong to call netdev_connect in the watch callback here.

> WSC negotiation running we should try to send the disconnect, although
> I think this is automatically triggered at some lower layer too.  But

It is.  And on an iface type switch in case you're not running mac80211 =

and the driver supports 'live' iftype switching.

> we also use netdev_disconnect to sort of make sure we never get
> another connect callback from netdev and I don't think skipping it is

See above.  We really shouldn't anyway.  station doing it is absolutely =

wrong in the NETDEV_WATCH_EVENT_DEL case for sure.  And even the =

EVENT_DOWN case is likely wrong as well.

> a good idea (we'd need to analyse a few code paths and add comments
> and we might end up getting it wrong anyway).  This is why I think
> station_free does it and I don't think it's wrong.
> =


I disagree :)  I think likely what is saving station in this case is =

that the Disconnect event comes first (most of the time).  But =

inherently we might get this event via RTNL first and then we can go *boom*.

Regards,
-Denis
--===============3703194068536551190==--

