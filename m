Content-Type: multipart/mixed; boundary="===============8385503614997729281=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Tue, 22 Sep 2020 23:34:15 +0200
Message-ID: <CAOq732LD5V_T8VynvuhoMzH4V8n64Hy0tUx8cCpKhq8zCtYbKg@mail.gmail.com>
In-Reply-To: <237c1ec9-7f85-59b4-19db-d4f1f36a731d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8385503614997729281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 22 Sep 2020 at 16:46, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/22/20 9:28 AM, Andrew Zaborowski wrote:
> > On Tue, 22 Sep 2020 at 16:19, Denis Kenzior <denkenz@gmail.com> wrote:
> >> On 9/21/20 11:18 PM, Andrew Zaborowski wrote:
> >>> I'm still using netconfig from P2P, I guess we shouldn't require
> >>> General.EnableNetworkConfiguration to be set for P2P.  P2P doesn't
> >>> (usually) have DNS so this should still work but maybe the checks
> >>> should be in netconfig.c after all, not sure.
> >>
> >> I don't think it makes sense to have this asymmetry.  Why is P2P speci=
al
> >> compared to normal station client?
> >
> > We also don't have any configuration for P2P netconfig because the
> > spec mandates the use of DHCP.  There's also no legacy to worry about,
> > so I don't see the point of making DHCP optional for P2P.
>
> That isn't exactly the point I was trying to make.  P2P would always use =
DHCP or
> network config KDEs, no disagreement there.  But from a user / system
> configuration perspective I don't think this asymmetry is something that =
one
> would expect or would want.us
>
> So if the user has not enabled EnableNetworkConfiguration setting then
> systemd-networkd (for example) expects to perform DHCP for all WiFi inter=
faces.
> How would you tell systemd-networkd not to configure P2P devices?  They'r=
e just
> WiFi as far as it is concerned.

Ok, I wouldn't have expected that.  I wonder then if we should wait
for the IP configuration to finish before returning from dbus calls so
that the clients can expect consistent behaviour.  And the client
still needs a way to get the peer's IP.

Best regards
--===============8385503614997729281==--

