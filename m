Content-Type: multipart/mixed; boundary="===============2153119418604769071=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: iwd provides only Legacy Access point (802.11b)
Date: Tue, 10 Aug 2021 12:40:43 +0200
Message-ID: <CAOq732JcwkAGreKbmHTPvKUnJKkC0gNzU5CJsE3Pa=evdXj5KQ@mail.gmail.com>
In-Reply-To: <9dea2815e2aad153b1b14c540a25679c72872aad.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2153119418604769071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Aug 2021 at 13:30, Altous, Salahaldeen
<Salahaldeen.Altous@leica-camera.com> wrote:
> how big effort is needed to add the 802.11g/n support for AP.

So the work is actually done by the driver but src/ap.c will need to
announce/negotiate the support with the clients.  I haven't
investigated what changes are needed exactly, you'll at least need to
update the capabilities fields in some IEs in our beacons, add the
Extended Supported Rates, HT Operation & HT Capability IEs.  Some of
the information in those IEs will be based on what wiphy.c already
knows and some may need to be queried through netlink commands.

Best regards
--===============2153119418604769071==--

