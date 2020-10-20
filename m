Content-Type: multipart/mixed; boundary="===============1835574889596789542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/13] ap: add support for DHCPv4 server
Date: Tue, 20 Oct 2020 16:03:05 -0500
Message-ID: <82799cec-7d2a-a1fb-cbbb-f58a1a509b2c@gmail.com>
In-Reply-To: <CAOq732KJpw9Vz9t-4PFUSHiupdXPK56yjgBrVf_+ZFAfDrpXDA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1835574889596789542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> Well, the user has to first switch the device into AP mode or create the
>> required interface first somehow.  So before they actually hit .Start, t=
hey have
>> a chance to configure the IP or not.  If the IP is configured, then we a=
ssume
>> the interface is managed by someone else.  If it isn't, we take ownershi=
p.
>>
>> I suppose we can add an explicit setting in main.conf somewhere, or in t=
he
>> profile itself.  But I'd keep things simple for now.
> =

> Maybe we can re-use [General].EnableNetworkConfiguration for the basic
> on/off switch and possibly allow individual access point config files
> to override this?
> =

> In the case of Network Manager users, if they're interfacing with IWD
> through NM they will currently not want DHCP as either client or
> server, and if they use iwctl they might want DHCP everywhere.
> =

> Also for the record, NM only sets the local IP after the AP is started.
> =


Good points.  I'm fine re-using EnableNetworkConfiguration for this.

>>
>>>>
>>>> I think we may need Andrew's opinion on whether these should be part
>>>> of
>>>> ap_config.  P2P might not really care about setting up these
>>>> variables and would
>>>> prefer for ap.c to just figure things out.
>>>
>>> Sure, but they aren't required anyways so p2p doesn't have to include
>>> them and defaults will be used (once netmask is fixed). The ap_config
>>> structure was just a convenient storage object for these but we could
>>> define something else too.
>>
>> Yes, true.  But not much sense in actually storing them long-term if tha=
t's the
>> case.  Generate them / load from settings, give them to dhcp-server and =
forget.
> =

> It does seem logical to put those settings in struct ap_config.  P2P
> wouldn't normally need to use them, it should be fine with the
> defaults although I'm thinking in the future there may be exceptions
> where we need to work around client's bugs (hopefully not).
> =

> Note that the P2P Group Owner will need to decide on an IP for itself
> and the client before the 4-Way Handshake starts to implement the
> optional IP assignment during the handshake.

Hmm, wouldn't it make sense for AP to figure out the setup and for P2P to j=
ust =

use that?  Especially if we start supporting persistent groups eventually.

You do bring up a good point that we'd need a 'reserve' API of sorts on the=
 DHCP =

server side.  That way IP details for the handshaking client can be =

pre-populated if IP configuration through the handshake is supported.

Regards,
-Denis
--===============1835574889596789542==--

