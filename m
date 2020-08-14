Content-Type: multipart/mixed; boundary="===============7992167032820447638=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH v2 0/2] Fix the documented behaviour of GetOrderedNetworks
Date: Fri, 14 Aug 2020 15:40:31 +0200
Message-ID: <20200814134033.322752-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7992167032820447638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I noticed that the Station DBus method GetOrderedNetworks() was not
respecting the behaviour documented in doc/station-api.txt, namely that:

    1. If the device is currently connected to a network, that network
       is always first on the list,
    2. followed by any known networks that have been used at least once
       before [...]

These two patches should address the two points respectively.

---

v1 -> v2:
    - Fix a careless naming mistake which caused the first patch not to
      compile.

Alvin =C5=A0ipraga (2):
  station: refresh ordered network list on (dis)connect
  treewide: guard compare functions against signed integer overflow

 src/network.c |  2 +-
 src/scan.c    |  2 +-
 src/station.c | 16 ++++++++++++++--
 tools/hwsim.c |  2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)

-- =

2.28.0

--===============7992167032820447638==--

