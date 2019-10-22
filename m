Content-Type: multipart/mixed; boundary="===============8558815483315111283=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] eapol: Move the EAP event handler to handshake state
Date: Tue, 22 Oct 2019 09:34:47 -0500
Message-ID: <d0bfc5b8-7880-7bb5-1a1c-bc671918de76@gmail.com>
In-Reply-To: <CAOq732LBGVjOPiArgWd-bKa_eh0x5kHm3V1Sv3fOYxzve3aG3A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8558815483315111283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/22/19 9:00 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Tue, 22 Oct 2019 at 06:11, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 10/21/19 8:55 AM, Andrew Zaborowski wrote:
>>> Move the storage of the eapol event callback from the eapol_sm struct to
>>> the handshake_state struct.  Rename from eapol event to eap event as the
>>> callback is only used to relay eap-specific event in eapol.c.
>>
>> Hmm, I'd be tempted to use handshake_state_set_event_func() for this as
>> well.  Especially given that wsc.c already subscribes to handshake
>> events.  Only problem is getting the eap event type and data to the
>> event func.  I wonder if variadic functions work through pointers...
> =

> I think they should and this may be the best option.  So I guess we
> would want handshake_event_func_t to take:
> =

>    struct handshake_state *hs,
>    enum handshake_event event,
>    void *user_data,
>    ...
> =

> while event_data and the eap event subtype would already be part of the "=
...".

That is what I'm thinking.  Or make event_data part of the argument list =

and any 'extra' arguments are part of the variadic argument array.  That =

way existing callers don't have to worry about invoking va_arg, etc.

> =

> The uglier option would be to reserve a range of enum handshake_event
> values for eap events.

I considered that, but this seems less elegant.

> =

>>
>>>
>>> This is allows the handler to be set before calling
>>> netdev_connect/netdev_connect_wsc.  It's also in theory more type-safe
>>> because don't need the cast in netdev_connect_wsc anymore.
>>>
>>> Note that eapol_sm_set_user_data is now unused.  I'm not sure if it
>>> should be removed on its own, the user_data that it sets will also
>>> affect rekey_offload callbacks.  However rekey_offload's user_data
>>> parameter is not used by the only implementation of that callback, so
>>> both could be removed together.
>>
>> I'd imagine they can be reworked to act like netdev_set_tk, etc.
> =

> Or those could be reworked to take the user_data so we don't have to
> look up by ifindex.

Well, we can't since user_data is used by wsc/station to observe =

handshake events.

And set_tk and friends don't look up by ifindex any more.  They get =

passed in the handshake_state as the first argument.

> =

> Best regards
> =


Regards,
-Denis
--===============8558815483315111283==--

