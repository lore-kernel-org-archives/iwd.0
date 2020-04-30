Content-Type: multipart/mixed; boundary="===============7312006257967116118=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/11] test: Add a connect-p2p test script
Date: Thu, 30 Apr 2020 15:48:47 +0200
Message-ID: <20200430134847.62234-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200430134847.62234-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7312006257967116118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/connect-p2p | 155 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100755 test/connect-p2p

diff --git a/test/connect-p2p b/test/connect-p2p
new file mode 100755
index 00000000..76b242b9
--- /dev/null
+++ b/test/connect-p2p
@@ -0,0 +1,155 @@
+#!/usr/bin/python3
+
+import sys
+import dbus
+import dbus.mainloop.glib
+from gi.repository import GLib
+import fnmatch
+
+if len(sys.argv) not in [1, 2]:
+    print("Usage: %s [<name_mask>]" % (sys.argv[0],))
+    sys.exit(1)
+
+name_mask =3D None
+if len(sys.argv) >=3D 2:
+    name_mask =3D sys.argv[1]
+
+DEVICE_IF =3D 'net.connman.iwd.p2p.Device'
+PEER_IF =3D 'net.connman.iwd.p2p.Peer'
+WSC_IF =3D 'net.connman.iwd.SimpleConfiguration'
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+bus =3D dbus.SystemBus()
+manager =3D dbus.Interface(bus.get_object('net.connman.iwd', '/'),
+                                        'org.freedesktop.DBus.ObjectManage=
r')
+objects =3D manager.GetManagedObjects()
+
+p2p_path =3D None
+peers =3D {}
+connecting =3D False
+mainloop =3D None
+
+for path in objects:
+    if DEVICE_IF in objects[path] and p2p_path is None:
+        p2p_path =3D path
+
+if p2p_path is None:
+    print('No P2P interfaces')
+    sys.exit(-1)
+
+values =3D objects[p2p_path][DEVICE_IF]
+properties =3D dbus.Interface(bus.get_object('net.connman.iwd', p2p_path),
+                                           'org.freedesktop.DBus.Propertie=
s')
+p2p =3D dbus.Interface(bus.get_object('net.connman.iwd', p2p_path), DEVICE=
_IF)
+
+def list_peers():
+    global peers
+
+    print('We have the following P2P peers')
+    for path in peers:
+        result =3D peers[path]
+
+        print('   ' + result['Name'] + ' at ' + path)
+
+def connect(path):
+    global connecting, peers, mainloop
+
+    list_peers()
+
+    peer =3D dbus.Interface(bus.get_object('net.connman.iwd', path), PEER_=
IF)
+    peer_wsc =3D dbus.Interface(bus.get_object('net.connman.iwd', path), W=
SC_IF)
+    peer_props =3D peers[path]
+
+    print('Connecting to ' + peer_props['Name'])
+    connecting =3D True
+    try:
+        peer_wsc.PushButton()
+        print('New connection')
+    except Exception as e:
+        connecting =3D False
+        print('Connection error: ' + repr(e))
+
+    if mainloop:
+        mainloop.quit()
+    else:
+        sys.exit(0)
+
+def properties_changed(interface, changed, invalidated, path):
+    global peers
+
+    path =3D str(path)
+    if interface !=3D PEER_IF or path not in peers:
+        return
+
+    peers[path].update(changed)
+    for k in invalidated:
+        del peers[path][k]
+
+def interfaces_added(path, interfaces):
+    global connecting, peers
+
+    if PEER_IF not in interfaces:
+        return
+
+    path =3D str(path)
+    peers[path] =3D interfaces[PEER_IF]
+    print('Added peer ' + str(peers[path]['Name']))
+
+    if connecting or name_mask is None or not fnmatch.fnmatch(peers[path][=
'Name'], name_mask):
+        return
+
+    connect(path)
+
+def interfaces_removed(path, interfaces):
+    global peers
+
+    if PEER_IF not in interfaces:
+        return
+
+    print('Removed peer ' + str(peers[path]['Name']))
+    del peers[path]
+
+if not values['Enabled']:
+    properties.Set(DEVICE_IF, 'Enabled', True)
+
+if not values['AvailableConnections']:
+    # See if we have peers we can disconnect or where we can cancel an ong=
oing
+    # connection that may be in the 120s GO Negotiation timeout for exampl=
e.
+    # Should we have a Connecting property on the WSC interface so we can =
know
+    # whether a connection is in progress?
+    for path in objects:
+        if PEER_IF not in objects[path]:
+            continue
+        peer_values =3D objects[path][PEER_IF]
+        print('Trying to disconnect from peer ' + str(peer_values['Name']))
+        peer =3D dbus.Interface(bus.get_object('net.connman.iwd', path), P=
EER_IF)
+        try:
+            peer.Disconnect()
+        except:
+            pass
+
+for path in objects:
+    if PEER_IF in objects[path]:
+        interfaces_added(path, objects[path])
+
+p2p.RequestDiscovery()
+
+bus.add_signal_receiver(properties_changed,
+                        bus_name=3D"net.connman.iwd",
+                        dbus_interface=3D"org.freedesktop.DBus.Properties",
+                        signal_name=3D"PropertiesChanged",
+                        path_keyword=3D"path")
+
+bus.add_signal_receiver(interfaces_added,
+                        bus_name=3D"net.connman.iwd",
+                        dbus_interface=3D"org.freedesktop.DBus.ObjectManag=
er",
+                        signal_name=3D"InterfacesAdded")
+
+bus.add_signal_receiver(interfaces_removed,
+                        bus_name=3D"net.connman.iwd",
+                        dbus_interface=3D"org.freedesktop.DBus.ObjectManag=
er",
+                        signal_name=3D"InterfacesRemoved")
+
+mainloop =3D GLib.MainLoop()
+mainloop.run()
-- =

2.25.1

--===============7312006257967116118==--

