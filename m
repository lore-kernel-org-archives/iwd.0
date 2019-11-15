Content-Type: multipart/mixed; boundary="===============0808830895925279992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 08:51:50 -0600
Message-ID: <73ee28b9-9336-f547-cf2b-1246181c9dde@gmail.com>
In-Reply-To: <CAOq732JF9n1fk-Z13Xq2UD_pXE-NrSrA2hqY20AZVrOmxeb9dg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0808830895925279992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> I think about this differently.  You have 2 phases:
>>     1. Simple Configuration (WiFi Direct flavor) which involves the group
>> formation and wsc negotiation
> =

> Well, it simply isn't part of WSC, but ok.
> =


P2P in the end just took WSC and changed the discovery bits a bit. =

Fundamentally its still WSC in the end.  But I guess depends on how you =

think about it...

>>     2. Actual connection establishment
>>
>> I don't see why Disconnect can't just affect 2 without affecting 1.  The
>> operations are on different interfaces after all.
> =

> We just don't need 2 methods and I already have Disconnect working
> this way (consistent with Station.Disconnect) so it'd mean just
> artificially crippling it, also adding a race where your Cancel call
> may work or not.

Station.Disconnect does not affect WSC state FYI.  It can't since =

Station doesn't even know about the ongoing WSC process until after =

station_connect_network is invoked.  So in that respect we'd be =

completely consistent.

> =

> (Tecnically provisioning and the connection are both on the P2P_CLIENT
> interface)
> =


Same as Station/WSC today...

Regards,
-Denis
--===============0808830895925279992==--

