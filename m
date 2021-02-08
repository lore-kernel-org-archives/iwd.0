Content-Type: multipart/mixed; boundary="===============7546828083228547689=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reconnect issues, still
Date: Mon, 08 Feb 2021 13:53:15 -0600
Message-ID: <731470a8-d37e-b432-209d-1119e4628912@gmail.com>
In-Reply-To: <CAG17S_MGPRQY9hP0m9OR-FBB2PT1yf=TO5MOaPaM=GeYkEDc4g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7546828083228547689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 2/7/21 10:39 PM, KeithG wrote:
> The group at connman has re-written connman and it now leverages the back=
ground =

> scanning in iwd as it allows the setting of 'AutoConnect=3Dtrue' now. Tha=
t =

> definitely helps, but I am still struggling to get the RPIs to effortless=
ly =

> reconnect. As it is, I have to manipulate the interface to force a reconn=
ect (if =

> down/up) by running a script to check if the interface is up or down.
> =

> For whatever reason, a reconnect is never tried unless we restart the iwd=
 or =

> connman process or restart the interface. What I see is my android device=
s =

> reconnect in < 1 minute if I force a disconnect from the router or restar=
t the =

> radio or reboot. I am running the latest git of iwd (r5144.074bc52). I fo=
rce =

> disconnect from the router at 18:32. Then I wait. spg3 is my SSID. It sca=
ns and =

> 'sees' it but never initiates or tries a re-connect. If I do this with my=
 phone =

> (Android 10), it is reconnected in less than 2 minutes. If I let iwd cont=
rol it, =


If iwd reconnects properly, I'm not sure why you're asking this question he=
re =

and not on the connman mailing list?

> it reconnects in < 2 minutes as well. Is there something that connman is =
waiting =

> for to let connman know it is ready?

Not really.  Once iwd 'sees' it, connman should as well.  Run monitor-iwd s=
cript =

from iwd.git/test to see all the communication going over d-bus.  Alternati=
vely =

you can run dbus-monitor, but that is harder to parse.

> If I try the same thing with connman controlling it, it 'sees' the SSID, =
but =

> never triggers connman to reconnect. Should connman be looking for someth=
ing? If =

> I restart iwd, it immediately connects. I get a ton of:

To me, it looks like scanning is being driven over D-Bus by invoking =

Station.Scan().  It also looks like autoconnect has been forced off, perhap=
s via =

Station.Disconnect() being invoked?  Hard to tell from this log, but looks =
iwd =

isn't trying to autoconnect and would instead rely on connman to trigger th=
e =

connection.

Regards,
-Denis
--===============7546828083228547689==--

