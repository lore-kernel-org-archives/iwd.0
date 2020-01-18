Content-Type: multipart/mixed; boundary="===============1959206718391313800=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: KnownNetwork AutoConnect property changed signal
Date: Sat, 18 Jan 2020 17:21:01 +0100
Message-ID: <20200118162101.iuncljo23jqoxzb5@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1959206718391313800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm in the process of updating the iwd plugin for ConnMan. Since
ConnMan wants to decide when to connect to a network, I decided to
tell iwd not to auto connect to any known networks. Not sure if this
will work but that's a different topic.

Anyway, during boot up the plugin discovers the known network and for
each network with AutoConnect set to true it will issue an set
property call. There is also a property changed callback which does
the same.

[iwd]# known-networks "owl stretching time" show
                       Known Network: owl stretching time
---------------------------------------------------------------------------=
-----
  Settable  Property          Value
---------------------------------------------------------------------------=
-----
            Name              owl stretching time
            Hidden
         *  AutoConnect       no

[iwd]# known-networks owl stretching time set-property AutoConnect yes


I observe following:

connmand[27914]: plugins/iwd.c:known_network_property_change() 0x1af1450 au=
to_connect 0
connmand[27914]: plugins/iwd.c:known_network_property_change() 0x1af1450 au=
to_connect 1
connmand[27914]: plugins/iwd.c:disable_auto_connect() =

connmand[27914]: plugins/iwd.c:known_network_property_change() 0x1af1450 au=
to_connect 1
connmand[27914]: plugins/iwd.c:disable_auto_connect() =

connmand[27914]: plugins/iwd.c:known_network_property_change() 0x1af1450 au=
to_connect 0
connmand[27914]: plugins/iwd.c:known_network_property_change() 0x1af1450 au=
to_connect 0

and monitor-iwd sees

{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D False
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] LastConnectedTime =3D 2020-01-18T16:10:34Z
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D True
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D True
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D False
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D False


I am bit surprised by the number of property changed signals. I
expected to see only 'auto_connect 1' and then a 'auto_connect 0'.

I verified the behavior without ConnMan running:

{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D False
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] LastConnectedTime =3D 2020-01-18T16:19:26Z
{KnownNetwork} [/net/connman/iwd/6f776c2073747265746368696e672074696d65_psk=
] AutoConnect =3D True

Is this supposed to be so?

Thanks,
Daniel
--===============1959206718391313800==--

