Content-Type: multipart/mixed; boundary="===============2951136162431591810=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/18] auto-t: rename testFT-FILS-SHA256 to testFT-FILS
Date: Thu, 12 Aug 2021 13:22:02 -0700
Message-ID: <20210812202207.737053-13-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2951136162431591810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/TestFT.8021x       | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/connection_test.py | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/ft-eap-ccmp-1.conf | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/ft-eap-ccmp-2.conf | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/hw.conf            | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/main.conf          | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/pwd.eap_user       | 0
 autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/radius.conf        | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/TestFT.8021x (100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/connection_test.py =
(100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/ft-eap-ccmp-1.conf =
(100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/ft-eap-ccmp-2.conf =
(100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/hw.conf (100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/main.conf (100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/pwd.eap_user (100%)
 rename autotests/{testFT-FILS-SHA256 =3D> testFT-FILS}/radius.conf (100%)

diff --git a/autotests/testFT-FILS-SHA256/TestFT.8021x b/autotests/testFT-F=
ILS/TestFT.8021x
similarity index 100%
rename from autotests/testFT-FILS-SHA256/TestFT.8021x
rename to autotests/testFT-FILS/TestFT.8021x
diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS/connection_test.py
similarity index 100%
rename from autotests/testFT-FILS-SHA256/connection_test.py
rename to autotests/testFT-FILS/connection_test.py
diff --git a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf b/autotests/te=
stFT-FILS/ft-eap-ccmp-1.conf
similarity index 100%
rename from autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf
rename to autotests/testFT-FILS/ft-eap-ccmp-1.conf
diff --git a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf b/autotests/te=
stFT-FILS/ft-eap-ccmp-2.conf
similarity index 100%
rename from autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf
rename to autotests/testFT-FILS/ft-eap-ccmp-2.conf
diff --git a/autotests/testFT-FILS-SHA256/hw.conf b/autotests/testFT-FILS/h=
w.conf
similarity index 100%
rename from autotests/testFT-FILS-SHA256/hw.conf
rename to autotests/testFT-FILS/hw.conf
diff --git a/autotests/testFT-FILS-SHA256/main.conf b/autotests/testFT-FILS=
/main.conf
similarity index 100%
rename from autotests/testFT-FILS-SHA256/main.conf
rename to autotests/testFT-FILS/main.conf
diff --git a/autotests/testFT-FILS-SHA256/pwd.eap_user b/autotests/testFT-F=
ILS/pwd.eap_user
similarity index 100%
rename from autotests/testFT-FILS-SHA256/pwd.eap_user
rename to autotests/testFT-FILS/pwd.eap_user
diff --git a/autotests/testFT-FILS-SHA256/radius.conf b/autotests/testFT-FI=
LS/radius.conf
similarity index 100%
rename from autotests/testFT-FILS-SHA256/radius.conf
rename to autotests/testFT-FILS/radius.conf
-- =

2.31.1

--===============2951136162431591810==--

