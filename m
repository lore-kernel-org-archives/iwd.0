Content-Type: multipart/mixed; boundary="===============5173387180304194022=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Tue, 14 Jan 2020 16:00:12 -0600
Message-ID: <d774c86a-3b5f-ff3f-981a-c0d7f30e7593@gmail.com>
In-Reply-To: <CAOq732+d7H4x_VOeP-SeGYxzBCqoziqvCQA+9LBfpb-6XqZSgQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5173387180304194022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/14/20 8:41 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Wed, 15 Jan 2020 at 02:54, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 1/14/20 7:23 PM, Andrew Zaborowski wrote:
>>> On Mon, 13 Jan 2020 at 19:49, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> This happens only on wsc_free, and I think you should be bypassing
>>>> calling wsc_enrollee_cancel in that case.  The netdev is likely already
>>>> gone by then anyway.
>>>
>>> wsc_free may happen because the netdev is going away or because iwd is
>>> shutting down, or we're switching modes.  In those cases if we have a
>>
>> There are two cases, in both cases it is too late to send CMD_DISCONNECT:
>>
>> 1. netdev_set_iftype path.  If the interface is up, we bring it down
>> first.  This is what causes the NETDEV_WATCH_EVENT_DOWN.  Trying to send
>> netdev_disconnect seems sort of pointless.
> =

> Trying to send CMD_DISCONNECT is pointless there but netdev_disconnect
> still achieves what we need which is cancel the connect callback.

I think this is the wrong way to accomplish this.  It feels like a hack =

/ shortcut.  We simply should not be trying to utilize API that is meant =

to schedule a clean tear down when we already know this is futile.

> =

>>
>> 2. netdev itself is removed.  At which point netdev_connect_free has
>> been called or we cancel the netdev_disconnect command if it is pending.
>>    netdev object is destroyed shortly thereafter.  So it is absolutely
>> wrong to call netdev_connect in the watch callback here.

I did mean netdev_disconnect here by the way :)

> =

> Right, but the wsc_enrollee object will have been freed inside that
> netdev_connect_free call and we wouldn't be calling
> wsc_enrollee_cancel or netdev_disconnect anymore.  Conceptually
> whenever we do have a netdev_connect running who's callback is still

Are you sure? netdev_connect_free doesn't invoke callbacks.  It is =

netdev_connect_failed and netdev_connect_ok that do.

> pending, I believe we should call netdev_disconnect, and whenever we
> have a wsc_enrollee object we need to call wsc_enrollee_cancel.

I think we should not try to lump together a 'clean-async-shutdown' and =

'cleanup-right-away' concepts.

>> I disagree :)  I think likely what is saving station in this case is
>> that the Disconnect event comes first (most of the time).  But
>> inherently we might get this event via RTNL first and then we can go *bo=
om*.
> =

> Mostly what can happen is that the CMD_DISCONNECT command returns an
> error so we've sent a useless command (if we'd cancelled a wrong
> connection attempt that would be slightly worse).  On the other hand
> if we free station without calling netdev_disconnect, then things can
> actually go *boom* because we could get the connect callback with an
> outdated user_data pointer.

Aha!  And this is likely why this was added in the first place:
	git show daf248e1b

But it doesn't make it 'right' from an API perspective.  I suspect that =

netdev should be invoking connect_cb with ABORTED in this case instead. =

In fact I'm still a bit lost what this call is accomplishing at the =

moment.  The only thing station_connect_cb does when =

NETDEV_RESULT_ABORTED is set is to generate a dbus reply.  And then we =

do it unconditionally later in station_free.

Regards,
-Denis
--===============5173387180304194022==--

