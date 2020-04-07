Content-Type: multipart/mixed; boundary="===============4790270456969141418=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: [PATCH 2/3] adhoc: fix bogus Failed error and segfault on stop
Date: Tue, 07 Apr 2020 23:33:46 +0200
Message-ID: <20200407213347.32130-2-Diego.SantaCruz@spinetix.com>
In-Reply-To: <20200407213347.32130-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4790270456969141418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The netdev_leave_adhoc() returns a negative errno on errors and zero
on success, but adhoc_dbus_stop() assumed the inverse when checking for
an error.

Also, the DBus message was not being referenced in adhoc->pending and
then adhoc_leave_cb() segfaulted attempting to dereference it.
---
 src/adhoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index a8ff8c3a..328433ca 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -576,9 +576,11 @@ static struct l_dbus_message *adhoc_dbus_stop(struct l=
_dbus *dbus,
 	if (!adhoc->started)
 		return l_dbus_message_new_method_return(message);
 =

-	if (!netdev_leave_adhoc(adhoc->netdev, adhoc_leave_cb, adhoc))
+	if (netdev_leave_adhoc(adhoc->netdev, adhoc_leave_cb, adhoc))
 		return dbus_error_failed(message);
 =

+	adhoc->pending =3D l_dbus_message_ref(message);
+
 	return NULL;
 }
 =

-- =

2.18.1

--===============4790270456969141418==--

