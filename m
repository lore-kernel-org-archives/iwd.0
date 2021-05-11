Content-Type: multipart/mixed; boundary="===============4191168388312465563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Tue, 11 May 2021 17:34:02 -0500
Message-ID: <4b7b601f-2fba-345d-fb96-26b980d1aa13@gmail.com>
In-Reply-To: <CAOq732Jtd25r9dL7qsqNHeLHLHxJMw14wFQi3Gvch--Aj6XpMA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4191168388312465563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 5/11/21 4:56 PM, Andrew Zaborowski wrote:
> On Tue, 11 May 2021 at 18:36, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 5/10/21 5:12 AM, Andrew Zaborowski wrote:
>>> Station callbacks expect a reason code (as opposed to status codes) with
>>> this event type.  This shouldn't matter a lot because
>>> station_disconnect_event() only actually looks at the value during
>>
>> I'm not sure why station is written this way.  I'm pretty sure that call=
ing
>> station_disconnect_event() for NETDEV_EVENT_DISCONNECT_BY_SME() is the w=
rong
>> thing to do.
> =

> That is currently the only use of that function though.

No, we have DISCONNECT_BY_AP and DISCONNECT_BY_SME.  DISCONNECT_BY_SME shou=
ld =

pretty much imply station_disassociated() should be called since we should =
never =

receive this event when we're in the connecting state.

Receiving DISCONNECT_BY_AP needs to be treated differently as well, dependi=
ng on =

whether we're connected or connecting, regardless of connect_pending state =
(i.e. =

during autoconnect).  Or have netdev.c invoke connect_cb if we're still =

connecting instead of sending this event.

> =

>>
>>> connection establishment so usually the "result" parameter is going to
>>> be HANDSHAKE_FAILED meaning that we'd already be getting a reason code
>>> in status_or_reason, but there could be corner cases where we got a
>>> different "result".
>>
>> That is correct for AP disconnections during handshaking, but that is si=
gnaled
>> by NETDEV_EVENT_DISCONNECT_BY_AP...
>>
>>> ---
>>>    src/netdev.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/netdev.c b/src/netdev.c
>>> index 4fbe813a..6c063df5 100644
>>> --- a/src/netdev.c
>>> +++ b/src/netdev.c
>>> @@ -771,10 +771,15 @@ static void netdev_connect_failed(struct netdev *=
netdev,
>>>
>>>        if (connect_cb)
>>>                connect_cb(netdev, result, &status_or_reason, connect_da=
ta);
>>> -     else if (event_filter)
>>> +     else if (event_filter) {
>>> +             /* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
>>> +             if (result !=3D NETDEV_RESULT_HANDSHAKE_FAILED)
>>> +                     status_or_reason =3D MMPDU_REASON_CODE_UNSPECIFIE=
D;
>>> +
>>
>>   From what I remember, the only time we can get here is if a rekey some=
how
>> fails, or setting keys during a rekey fails.  Are there other cases?
> =

> In theory you can pass a null connect_cb to netdev_connect_common(),

Yes, so either netdev should handle this specially, or we should make it an =

error condition during netdev_connect().

> but in practice we don't do this so you could trigger this only for:
> =

> NETDEV_RESULT_HANDSHAKE_FAILED,
> NETDEV_RESULT_KEY_SETTING_FAILED,
> NETDEV_RESULT_ABORTED.

NETDEV_ABORTED should only be invoked in the connecting phase, no?  I suppo=
se =

there may be some bizarre situations, like we're rekeying and the device go=
es down.

> =

> I realize I was confused, I thought that netdev_connect_failed() was
> actually sending NETDEV_EVENT_DISCONNECT_BY_SME to station and
> triggering my autoconnect loop, but actually it was
> netdev_disconnect_event() which always calls netdev->event_filter and

This confirms my suspicions that we're not handling DISCONNECT_BY_AP comple=
tely =

correctly.

> never uses netdev->connect_cb.  Perhaps netdev_disconnect_event()
> should use netdev_connect_failed() instead.

They're different conditions though.  DISCONNECT_BY_AP tells us the AP sent=
 a =

Deauthenticate.  DISCONNECT_BY_SME says that we did (actual or implied).

Regards,
-Denis
--===============4191168388312465563==--

