Content-Type: multipart/mixed; boundary="===============3952593076514316299=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] doc: document SimAuthBackend option
Date: Wed, 16 Sep 2020 10:08:13 -0700
Message-ID: <20200916170814.660095-6-prestwoj@gmail.com>
In-Reply-To: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3952593076514316299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 96774092..5652ef50 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -154,6 +154,14 @@ The group ``[General]`` contains general settings.
        off by default.  If you want to easily utilize Hotspot 2.0 networks,
        then setting ``DisableANQP`` to ``false`` is recommended.
 =

+   * - SimAuthBackend
+     - Values: ofono, hardcoded
+
+       Enable the simauth backend. A value of 'ofono' enables communicatio=
n with
+       the ofono daemon for use with EAP-SIM/EAP-AKA/EAP-AKA-prime. The
+       'hardcoded' option is only used for testing. If this option is not
+       provided neither backend will be initialized.
+
 Network
 ---------
 =

-- =

2.26.2

--===============3952593076514316299==--

