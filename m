Content-Type: multipart/mixed; boundary="===============6558295342938869957=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 12:12:24 -0500
Message-ID: <c11a18de-19a8-54c9-19f6-6593a5537833@gmail.com>
In-Reply-To: <CACsRnHVsREZ=Z6Gj=pkpPbJ+N7037q=01Uj_MhjYDbhLtTPQKg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6558295342938869957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/12/21 11:57 AM, Michael Johnson wrote:
> Hi Denis,
> =

> Using dbus-monitor I can see that networkd is sending out messages
> during a roam despite being set to "Unmanaged" for this interface.
> This appears to trigger a resolved message which I'm guessing is where
> the problem is.

So carrier disappearing is expected.  Kernel/driver takes away the carrier =
when =

it disassociates from the current AP.  Carrier should be restored once we =

associate to the new AP and iwd should be setting the device back up after =
the =

roam.  This happens in netdev_connect_ok(), l_rtnl_set_linkmode_and_opersta=
te() =

invocation.

What is unclear is why the carrier is sometimes not restored according to =

networkd.  Looking at the log in your first post on this topic I see that =

station_fast_transition_cb() is called and station goes from roaming to =

connected state.  So that would imply that netdev_connect_ok is called in t=
he =

'failure' case (since connect_cb would be set to station_fast_transition_cb=
) and =

we should have restored carrier earlier.

Any chance you have iwmon logs of this happening?

Regards,
-Denis
--===============6558295342938869957==--

