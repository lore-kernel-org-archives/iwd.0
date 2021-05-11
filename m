Content-Type: multipart/mixed; boundary="===============8178264073900845746=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] station: Fix autoconnect loops
Date: Tue, 11 May 2021 23:41:09 +0200
Message-ID: <CAOq732JPBOr8urQ=qc1jMWULf3GxiWFrj_7OA7Z6sdmj4_hOwQ@mail.gmail.com>
In-Reply-To: <bdbcc33cb3e86a050778ae0460d5aefe0f301c43.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8178264073900845746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, 11 May 2021 at 18:32, James Prestwood <prestwoj@gmail.com> wrote:
> On Mon, 2021-05-10 at 12:12 +0200, Andrew Zaborowski wrote:
> > Make sure we process the result of a connect attempt both in a D-Bus
> > triggered connection and during autoconnect.  Until now we'd only
> > call
> > station_connect_cb() on NETDEV_EVENT_DISCONNECT_BY_{AP,SME} if
> > station->connect_pending was non-NULL, i.e. only in the D-Bus method.
> > As a result we were never blacklisting BSSes and never calling
> > network_connect_failed() (to set ask_passphrase) during autoconnect.
>
> Is the purpose of this to avoid re-trying the same network over and
> over? Relying on network_autoconnect() to fail due to ask_passphrase
> being true?

Either this, or getting the BSS blacklisted.  Oherwise autoconnect is
working around the blacklist logic and has no chance to try another
BSS or another network.

I don't think the current blacklist and ask_passphrase logic is very
good, but it could be misleading that station_connect_cb is called
only in D-Bus triggered connections.  station_connect_cb is already
handling NETDEV_RESULT_HANDSHAKE_FAILED for both manual- and
auto-connect, it should also handle NETDEV_EVENT_DISCONNECT_BY_* for
both cases.  Perhaps station_connect_cb should then implement a better
policy that looks at whether we're in autoconnect or not, and handles
NETDEV_RESULT_HANDSHAKE_FAILED and NETDEV_EVENT_DISCONNECT_BY_* in the
same way.

>
> Seems like it would be better to re-work autoconnect to actually pop
> the list when autoconnect fails, and immediately move onto the next (no
> scanning).

Yep, using autoconnect_list would at least give justification for
having a list, as it is now we could just as well select a single
network/bss (if ask_passphrase is true there's no point adding it to
the list in the first place).

Ideally I think this should happen:

* the blacklist can be dropped completely,

* a connection failure at a given timestamp causes the BSS rank and
the network's rank to be penalized and recover to its normal value
with time, independent of auto- vs. manual- connect.

* ask_password should be set based on the failure reason, either
always or only for manual connect (IIRC Denis thinks it should be only
for manual connect)

Best regards
--===============8178264073900845746==--

