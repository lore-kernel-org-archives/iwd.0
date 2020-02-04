Content-Type: multipart/mixed; boundary="===============2666992099223735537=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Interface not detected sometimes
Date: Tue, 04 Feb 2020 16:14:46 -0600
Message-ID: <2ae955ab-fb4c-e6f5-b06a-5045d1122dcb@gmail.com>
In-Reply-To: <20200204204516.2820.74539@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2666992099223735537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On 2/4/20 2:45 PM, hector(a)ikatu.com wrote:
> Well the behavior is not the same! Don't know what I did wrong on my firs=
t test after applying the commit.
> =

> Now I'm not setting the "--interfaces wlan0" parameter and I'm not execut=
ing the sleep in iwd.service, and it's working almost always (before it was=
 failling almost always).

Good.  It seems the original issue is fixed, but we uncovered another :)

> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_con=
fig_notify() Notification of command Del Interface(8)

So we manage to delete the AP interface (probably not what you want anyway)

> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_=
notify() event 16 on ifindex 4
> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_del=
_interface_cb()
> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_=
notify() event 17 on ifindex 4
> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_del=
_interface_cb()
> Feb 04 20:37:52 Paris-00100105 iwd[502]: DEL_INTERFACE failed: Unknown er=
ror 524

But we fail to delete the station interface.

> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_use=
_default()
> Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_creat=
e_from_genl() Created interface uap0[4 2]

And now we are completely confused and using the just deleted interface..

> Feb 04 20:37:52 Paris-00100105 iwd[502]: Could not register frame watch t=
ype 00d0: -19
> Feb 04 20:37:52 Paris-00100105 iwd[502]: RTM_GETLINK error -19: No such d=
evice

Which of course fails :)  We'll have to come up with a fix for this one...

But in the meantime....

Note that by default iwd will try and remove all interfaces and will =

only create a single station interface by default (if the driver allows, =

which yours doesn't).  iwd itself doesn't yet enable the scenario where =

simultaneous use of station + ap interfaces is a possibility.  Of course =

it won't care if some other entity is managing other interfaces...

Since you stated that you want to run hostapd on the ap interface, the =

best way forward would be to blacklist uap0 via iwd command line =

--nointerfaces=3Duap0 (or whitelist wlan0 as you have been doing)

Regards,
-Denis
--===============2666992099223735537==--

