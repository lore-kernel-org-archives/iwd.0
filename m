Content-Type: multipart/mixed; boundary="===============3525230201962006255=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] ap: Implement P2P GO-side 4-way handshake IP
 Allocation
Date: Sat, 10 Jul 2021 03:37:31 +0200
Message-ID: <CAOq732LBHNEafhFWSVPPqmtZ3iOpQc=OPxaCUqRmz7kMAKt78w@mail.gmail.com>
In-Reply-To: <CAOq732LUGQS2ZA5A568wt1z3YeNyg7TdpsShWJiBbuQFVcye8w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3525230201962006255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Jul 2021 at 02:52, Andrew Zaborowski
<andrew.zaborowski@intel.com> wrote:
> We'd need to start tracking the offered
> lease expiry times though.  Right now we set a 5s timeout for offered
> leases (lease->lifetime =3D OFFER_TIME) but
> dhcp-server.c:set_next_expire_timer() disables all timeouts whenever
> there's an offered lease so they're not tracked.

I misread that check, it actually disables the timeout if there are
*only* "offered" leases on the list.  This still seems wrong.  We
probably also need to skip the LEASE_EXPIRED event in
lease_expired_cb() for "offered" leases because we don't emit
NEW_LEASE for these.

Best regards
--===============3525230201962006255==--

