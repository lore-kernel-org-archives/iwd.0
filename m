Content-Type: multipart/mixed; boundary="===============2351198018685808110=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] wfd-source: Update the switch state using set_state
Date: Tue, 04 Aug 2020 16:52:59 +0200
Message-ID: <20200804145303.151878-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2351198018685808110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Gtk.Switch representing the p2p.Device's Enabled property should use
the "delayed state change" logic as described in Gtk.Switch docs, i.e.
we need to use .set_state() instead of .set_active() when we get
confirmation of the property having changed its value in the
PropertiesChanged handler.  The ::active property is automatically
changed by Gtk.Switch on user input.

This way the UI gives visual feedback of when the device enable/disable
op starts and ends (or fails).
---
 test/wfd-source | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/test/wfd-source b/test/wfd-source
index a83cd0cb..e99ae818 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -1116,7 +1116,7 @@ class WFDSource(Gtk.Window):
         dev_str =3D self.get_dev_string(path)
         name =3D str(device.props['Name'])
         label.set_markup(dev_str + '\n<small>' + ('Local name: ' + name + =
'\n' if dev_str !=3D name else '') + 'State: ' + state + '</small>')
-        switch.set_active(device.props['Enabled'])
+        switch.set_state(device.props['Enabled'])
 =

     def update_peer_props(self, dev_path, path):
         device =3D self.devices[dev_path]
@@ -1560,7 +1560,6 @@ class WFDSource(Gtk.Window):
         device =3D self.devices[path]
         if device.props['Enabled'] =3D=3D state:
             return
-        device.props['Enabled'] =3D state
         device.props_proxy.Set(DEVICE_IF, 'Enabled', state)
         return True
 =

-- =

2.25.1

--===============2351198018685808110==--

