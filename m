Content-Type: multipart/mixed; boundary="===============3060843561800377650=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/11] ap: Push Button mode API and beacon changes
Date: Thu, 27 Aug 2020 15:51:58 -0500
Message-ID: <42d9c101-f87f-8d9a-b944-d78d4b5bb732@gmail.com>
In-Reply-To: <CAOq732+4_ExBB1xNxvMq6=5Sa8hRcj7+ttvCNnAXjV_wgVsPUw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3060843561800377650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +
>>> +bool ap_push_button(struct ap_state *ap);
>>>
>>
>> So correct me if I'm wrong, but the intent here seems to be:
>>
>> Have P2P-GO start AP in PBC mode by setting authorized_macs to whatever,=
 then
>> run ap_push_button().  Then the AP has to be shut down and restarted (or=
 maybe
>> not?)  But regardless, it seems that PBC cannot be restarted with AP run=
ning
>> after the previous PBC transaction has finished.
>>
>> This seems like an unnecessary limitation.  Why not implement PBC (and i=
n the
>> future PIN) as a transitory state instead?  This way we could have our A=
P (non
>> P2P-GO) mode support push buttons / PINs almost for free...
> =

> So the idea was that this function corresponds to a physical button
> press, i.e. whenever the AP UI senses button press it calls this, and
> perhaps lights up the "WPS" LED until it receives
> AP_EVENT_PBC_MODE_EXIT.

Right

> =

> So in P2P we'd first wait for the AP_EVENT_STARTED event, call this,
> and from there we should receive REGISTRATION_START -> PBC_MODE_EXIT
> -> REGISTRATION_SUCCESS -> STATION_ADDED without doing much, except
> perhaps restarting a timeout on each step.  The PBC mode doesn't
> preclude an RSN connection or multiple connections from different
> STAs, so the client can reassociate and do the 4-Way handshake as soon
> as it receives the credentials.
> =

>>
>> So something like:
>>
>> ap_push_button(struct ap_state *ap, struct wsc_config *wsc);
> =

> What information would go in wsc_config?
> =


Its been a while since I looked at WSC, so I could be wrong, but wouldn't =

authorized_macs belong to the wsc_config and not ap_config?

I suppose you could have them in both, but it seemed strange to see it in =

ap_config given you're trying to make wsc work and not configuring mac filt=
ering.

Regards,
-Denis
--===============3060843561800377650==--

