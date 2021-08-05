Content-Type: multipart/mixed; boundary="===============8905835740129536481=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: rename testFT-SAE-roam to testSAE-roam
Date: Thu, 05 Aug 2021 08:19:57 -0700
Message-ID: <20210805151958.288829-5-prestwoj@gmail.com>
In-Reply-To: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8905835740129536481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since reassociation is now tested this name fits better
---
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/connection_test.py | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-psk-3.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-1.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-2.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/hw.conf            | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/main.conf          | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/connection_test.py (1=
00%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-psk-3.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-1.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-2.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/hw.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/main.conf (100%)

diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testS=
AE-roam/connection_test.py
similarity index 100%
rename from autotests/testFT-SAE-roam/connection_test.py
rename to autotests/testSAE-roam/connection_test.py
diff --git a/autotests/testFT-SAE-roam/ft-psk-3.conf b/autotests/testSAE-ro=
am/ft-psk-3.conf
similarity index 100%
rename from autotests/testFT-SAE-roam/ft-psk-3.conf
rename to autotests/testSAE-roam/ft-psk-3.conf
diff --git a/autotests/testFT-SAE-roam/ft-sae-1.conf b/autotests/testSAE-ro=
am/ft-sae-1.conf
similarity index 100%
rename from autotests/testFT-SAE-roam/ft-sae-1.conf
rename to autotests/testSAE-roam/ft-sae-1.conf
diff --git a/autotests/testFT-SAE-roam/ft-sae-2.conf b/autotests/testSAE-ro=
am/ft-sae-2.conf
similarity index 100%
rename from autotests/testFT-SAE-roam/ft-sae-2.conf
rename to autotests/testSAE-roam/ft-sae-2.conf
diff --git a/autotests/testFT-SAE-roam/hw.conf b/autotests/testSAE-roam/hw.=
conf
similarity index 100%
rename from autotests/testFT-SAE-roam/hw.conf
rename to autotests/testSAE-roam/hw.conf
diff --git a/autotests/testFT-SAE-roam/main.conf b/autotests/testSAE-roam/m=
ain.conf
similarity index 100%
rename from autotests/testFT-SAE-roam/main.conf
rename to autotests/testSAE-roam/main.conf
-- =

2.31.1

--===============8905835740129536481==--

