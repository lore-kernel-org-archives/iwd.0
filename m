Content-Type: multipart/mixed; boundary="===============6756537803294873495=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/3] station: Stop periodic scan when netdev connected
Date: Fri, 18 Jun 2021 18:16:12 +0200
Message-ID: <CAOq732+9jc8Mj4Gi+xrgJaVt4BHLx-LEwU9JcaDKg=efL6s0LQ@mail.gmail.com>
In-Reply-To: <3334d49c-c269-c398-9cf7-4a4a6ca903bd@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6756537803294873495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jun 2021 at 17:05, Denis Kenzior <denkenz@gmail.com> wrote:
> On 6/18/21 2:33 AM, Andrew Zaborowski wrote:
> > For consistency call periodic_scan_stop() right after netdev signals
> > connected even if station stays in the CONNECTING state because it's
> > waiting for netconfig to finish.
>
> Hmm, why is this needed?  We should be calling periodic_scan_stop as soon=
 as we
> transition to CONNECTING/CONNECTING_AUTO state.

That's another option but I think the logic until now was that if the
connection failed we'd just return to periodic scanning without ever
stopping and restarting it.  During the netdev CMD_CONNECT it would be
inhibited by the kernel or by the radio work.  We only needed to
explicitly stop the scanning when CMD_CONNECT succeeded, so that's
what I was trying to restore in this patch, otherwise if we were
unlucky we might have been scanning during the netconfig.

Best regards
--===============6756537803294873495==--

