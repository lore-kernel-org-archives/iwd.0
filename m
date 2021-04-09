Content-Type: multipart/mixed; boundary="===============7940126515738148598=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd as AP "Couldn't connect to network"
Date: Fri, 09 Apr 2021 09:06:35 -0500
Message-ID: <6a3064b6-6830-b973-50a2-b3152f0d8520@gmail.com>
In-Reply-To: <eee7f926c78f3dba582bc527695dad3749970181.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7940126515738148598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 4/7/21 10:34 AM, Altous, Salahaldeen wrote:
> Hi Denis,
> =

> After some try and error I have found the the /etc/iwd/main.conf case
> this error, I have deleted it. my main.conf looks like
> =

> [General]
> EnableNetworkConfiguration=3Dtrue
> APRanges=3D192.168.5.1/24
> [Network]
> RoutePriorityOffset=3D200
> NameResolvingService=3Dresolvconf

This looks fine.

> =

> =

> Now I can start iwd 1.13 without problem but still can not connect to
> this ap. I have started iwd-ap and I got [connection to "myssid"
> timeout out. connection failed].

Can you tell us what hardware / driver is being used for the AP side?  I as=
sume =

the same hardware works fine in station mode?

> =

> AP Probe Request from dc:a6:32:22:5f:ac
> ../iwd-1.13/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> ../iwd-1.13/src/wiphy.c:wiphy_radio_work_next() Starting work item 5
> ../iwd-1.13/src/netdev.c:netdev_mlme_notify() MLME notification Frame
> TX Status(60)
> ../iwd-1.13/src/frame-xchg.c:frame_xchg_mlme_notify() Received no ACK
> ../iwd-1.13/src/frame-xchg.c:frame_xchg_tx_cb() err 0
> ../iwd-1.13/src/frame-xchg.c:frame_xchg_wait_cancel()
> Frame tx retry limit reached
> =


This is rather strange.  Looks like CMD_FRAME is failing.  Can you send us =
logs =

(iwmon and iwd with '-d') of both sides of the connection?  Make sure iwmon=
 is =

started prior to iwd so we get a trace of the full initialization procedure.

Regards,
-Denis
--===============7940126515738148598==--

