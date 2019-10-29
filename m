Content-Type: multipart/mixed; boundary="===============1205461689416124092=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] manpage: Add command options and examples for iwctl
Date: Tue, 29 Oct 2019 12:45:45 -0700
Message-ID: <20191029194545.6619-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1205461689416124092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/iwctl.rst | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/client/iwctl.rst b/client/iwctl.rst
index 51873965..54af4b7d 100644
--- a/client/iwctl.rst
+++ b/client/iwctl.rst
@@ -16,12 +16,58 @@ Internet wireless control utility
 SYNOPSIS
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-**iwctl** [*options* ...]
+**iwctl** [*options* ...] [*commands* ...]
 =

 DESCRIPTION
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-Tool for configuring **iwd** daemon via D-Bus interface.
+Tool for configuring **iwd** daemon via D-Bus interface. It supports both =
an
+interactive mode and command line mode.
+
+OPTIONS
+=3D=3D=3D=3D=3D=3D=3D
+
+--username, -u          Provide username.
+--password, -p          Provide password.
+--passphrase, -P        Provide passphrase.
+--dont-ask, -v          Don=E2=80=99t ask for missing credentials.
+--help, -h              Show help message and exit.
+
+EXAMPLES
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Interactive mode
+----------------
+
+To start an interactive mode and list all available commands do:
+.. code-block::
+
+   $ iwctl
+   [iwd]# help
+
+To connect to a network:
+.. code-block::
+
+   [iwd]# device list
+   [iwd]# station DEVICE scan
+   [iwd]# station DEVICE get-networks
+   [iwd]# station DEVICE connect SSID
+
+Command line mode
+----------------------
+
+To list all available commands in command line mode and exit do:
+.. code-block::
+
+   $ iwctl --help
+
+To connect to a network:
+.. code-block::
+
+   $ iwctl device list
+   $ iwctl station DEVICE scan
+   $ iwctl station DEVICE get-networks
+   $ iwctl --passphrase=3DPASSPHRASE station DEVICE connect SSID
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
-- =

2.13.6

--===============1205461689416124092==--

