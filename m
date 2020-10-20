Content-Type: multipart/mixed; boundary="===============5384712766215748344=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/13] ap: add support for DHCPv4 server
Date: Tue, 20 Oct 2020 13:51:39 -0500
Message-ID: <b111caae-01da-a122-0ba0-afb024baa384@gmail.com>
In-Reply-To: <a936dd184b0054d7b2c295fd92c3af2f022b4c93.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5384712766215748344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/20/20 1:41 PM, James Prestwood wrote:
> On Tue, 2020-10-20 at 13:28 -0500, Denis Kenzior wrote:
>> Hi James,
>>
>> On 10/20/20 1:02 PM, James Prestwood wrote:
>>> The DHCP server can be enabled by including an [IPv4] group
>>> in the AP provisioning file and including at least a subnet
>>> mask.
>>
>> Any chance we can add this code to the current implementation without
>> changing
>> the API just yet?  I think it is safe to assume that if the address
>> is set prior
>> to AP starting on a given interface, then we should not start our own
>> DHCP, and
>> if the address isn't set, then start DHCP server.  If the address is
>> provided by
>> provisioning, then start our own DHCP as well, overriding whatever we
>> picked.
> =

> Sure, so keep the 'psk' DBus argument and remove [Security].Passphrase?
> It seems weird to have both since we would be ignoring one.

I don't know yet.  I don't think removing the simple 'Start' method which j=
ust =

provides an SSID and PSK is a good idea.  It is useful for quick and dirty =

setups.  Provisioning files might be for more advanced users and might need =

their own dedicated Start method.  So something like KnownNetwork(s) but fo=
r =

AccessPointConfiguration(s).

> =

> But do we really want to make the decision to use DHCP based on if the
> address is set? It really seems like the user would want to decide that
> explicitly with a config file. OTOH if all no DHCP options are required
> (using defaults) we would need some way of knowing to start DHCP or
> not. I just don't see a correlation between the address being set and
> the user wanting/not wanting a DHCP server.

Well, the user has to first switch the device into AP mode or create the =

required interface first somehow.  So before they actually hit .Start, they=
 have =

a chance to configure the IP or not.  If the IP is configured, then we assu=
me =

the interface is managed by someone else.  If it isn't, we take ownership.

I suppose we can add an explicit setting in main.conf somewhere, or in the =

profile itself.  But I'd keep things simple for now.

>>
>> I think we may need Andrew's opinion on whether these should be part
>> of
>> ap_config.  P2P might not really care about setting up these
>> variables and would
>> prefer for ap.c to just figure things out.
> =

> Sure, but they aren't required anyways so p2p doesn't have to include
> them and defaults will be used (once netmask is fixed). The ap_config
> structure was just a convenient storage object for these but we could
> define something else too.

Yes, true.  But not much sense in actually storing them long-term if that's=
 the =

case.  Generate them / load from settings, give them to dhcp-server and for=
get.

Regards,
-Denis
--===============5384712766215748344==--

