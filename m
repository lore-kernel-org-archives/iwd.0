Content-Type: multipart/mixed; boundary="===============4388808319846858483=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/18] auto-t: rename testFT-SAE-roam to testSAE-roam
Date: Thu, 12 Aug 2021 13:21:58 -0700
Message-ID: <20210812202207.737053-9-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4388808319846858483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since reassociation is now tested this name fits better
---
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/TestFT.psk         | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/connection_test.py | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-psk-3.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-1.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-2.conf      | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/hw.conf            | 0
 autotests/{testFT-SAE-roam =3D> testSAE-roam}/main.conf          | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/TestFT.psk (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/connection_test.py (1=
00%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-psk-3.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-1.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/ft-sae-2.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/hw.conf (100%)
 rename autotests/{testFT-SAE-roam =3D> testSAE-roam}/main.conf (100%)

diff --git a/autotests/testFT-SAE-roam/TestFT.psk b/autotests/testSAE-roam/=
TestFT.psk
similarity index 100%
rename from autotests/testFT-SAE-roam/TestFT.psk
rename to autotests/testSAE-roam/TestFT.psk
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

--===============4388808319846858483==--

