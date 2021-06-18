Content-Type: multipart/mixed; boundary="===============8810609525989619598=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/3] station: Stop periodic scan when netdev connected
Date: Fri, 18 Jun 2021 19:27:31 +0200
Message-ID: <CAOq732JQVgOxYw5+uEmj=G7gJ5G2pY+=FZEDEFoxRQLqjH7GUA@mail.gmail.com>
In-Reply-To: <fc43e0e1-eb99-97d1-e528-6955c72671a3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8810609525989619598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jun 2021 at 19:21, Denis Kenzior <denkenz@gmail.com> wrote:
> On 6/18/21 11:16 AM, Andrew Zaborowski wrote:
> > On Fri, 18 Jun 2021 at 17:05, Denis Kenzior <denkenz@gmail.com> wrote:
> >>  We should be calling periodic_scan_stop as soon as we
> >> transition to CONNECTING/CONNECTING_AUTO state.
> >
> > That's another option but I think the logic until now was that if the
> > connection failed we'd just return to periodic scanning without ever
> > stopping and restarting it.  During the netdev CMD_CONNECT it would be
>
> I don't think so.  See commit c3e160880f32f and commit da485179a6e92 prio=
r to
> that.  It looks like we have stopped periodic scan when entering CONNECTI=
NG
> state for quite some time.

True, I missed this.  Please ignore this patch.

Best regards
--===============8810609525989619598==--

