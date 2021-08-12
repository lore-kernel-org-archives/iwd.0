Content-Type: multipart/mixed; boundary="===============0286260140464268353=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 17:57:46 +0100
Message-ID: <CACsRnHVsREZ=Z6Gj=pkpPbJ+N7037q=01Uj_MhjYDbhLtTPQKg@mail.gmail.com>
In-Reply-To: <d8ffff0a-17c8-9edd-7064-be62af96317b@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0286260140464268353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Using dbus-monitor I can see that networkd is sending out messages
during a roam despite being set to "Unmanaged" for this interface.
This appears to trigger a resolved message which I'm guessing is where
the problem is.
I'll see if I can chase this from the systemd side.

```
NAME                         PID PROCESS         USER
CONNECTION    UNIT                        SESSION DESCRIPTION
:1.0                         344 systemd-network systemd-network :1.0
        systemd-networkd.service    -       -
:1.1                         394 systemd-resolve systemd-resolve :1.1
        systemd-resolved.service    -       -
:1.4                       12653 iwd             root            :1.4
        iwd.service                 -       -

---

signal time=3D1628782447.272527 sender=3D:1.4 -> destination=3D(null
destination) serial=3D49 path=3D/net/connman/iwd/0/5;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged
   string "net.connman.iwd.Station"
   array [
      dict entry(
         string "State"
         variant             string "roaming"
      )
   ]
   array [
   ]
signal time=3D1628782447.340425 sender=3D:1.0 -> destination=3D(null
destination) serial=3D71 path=3D/org/freedesktop/network1/link/_35;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged
   string "org.freedesktop.network1.Link"
   array [
      dict entry(
         string "CarrierState"
         variant             string "no-carrier"
      )
      dict entry(
         string "OperationalState"
         variant             string "no-carrier"
      )
   ]
   array [
   ]
signal time=3D1628782447.341656 sender=3D:1.1 -> destination=3D(null
destination) serial=3D48 path=3D/org/freedesktop/resolve1;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged
   string "org.freedesktop.resolve1.Manager"
   array [
      dict entry(
         string "DNS"
         variant             array [
               struct {
                  int32 5
                  int32 2
                  array of bytes [
                     0a 65 40 02
                  ]
               }
            ]
      )
   ]
   array [
   ]
```

On Thu, 12 Aug 2021 at 15:43, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 8/12/21 9:30 AM, Michael Johnson wrote:
> > Hi Denis,
> >
> > `systemd-networkd` isn't managing the wireless interface but still
> > needs to run for wired connections (or at least shouldn't be). I'm not
>
> Okay.  Not sure we tested such a setup here...
>
> > sure why it still prints connected/disconnect states. How does `iwd`
> > interact with `systemd-resolved`?
>
> iwd uses systemd-resolved dbus API to set up certain information obtained=
 from
> DHCP (DNS, hostname, etc).  See [1].
>
> You can poke around in src/resolve.c in iwd tree for more details.  Right=
 now
> iwd assumes that no IP configuration details change on a roam (which is w=
hat
> 802.11 says).  There may be networks where this assumption breaks, but we
> haven't seen any yet.  So at the moment, the resolved settings are left
> untouched between roams.
>
> It might help to spy on the resolved dbus interface using dbus-monitor an=
d see
> if we can learn something useful from that.
>
> [1] https://www.freedesktop.org/software/systemd/man/org.freedesktop.reso=
lve1.html
--===============0286260140464268353==--

