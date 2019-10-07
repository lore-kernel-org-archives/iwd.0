Content-Type: multipart/mixed; boundary="===============5989714689233275868=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: add TLS test with embedded PEMs
Date: Mon, 07 Oct 2019 12:55:49 -0700
Message-ID: <20191007195549.1653-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5989714689233275868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../connection_test.py                        | 77 +++++++++++++++
 autotests/testEAP-TLS-embedded-pems/hw.conf   |  6 ++
 .../ssidEAP-TLS.8021x                         | 94 +++++++++++++++++++
 .../ssidEAP-TLS.conf                          | 12 +++
 4 files changed, 189 insertions(+)
 create mode 100644 autotests/testEAP-TLS-embedded-pems/connection_test.py
 create mode 100644 autotests/testEAP-TLS-embedded-pems/hw.conf
 create mode 100644 autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
 create mode 100644 autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf

diff --git a/autotests/testEAP-TLS-embedded-pems/connection_test.py b/autot=
ests/testEAP-TLS-embedded-pems/connection_test.py
new file mode 100644
index 00000000..1102b810
--- /dev/null
+++ b/autotests/testEAP-TLS-embedded-pems/connection_test.py
@@ -0,0 +1,77 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+import testutil
+import hostapd
+
+class Test(unittest.TestCase):
+
+    def do_test_connection_success(self, ssid, passphrase=3DNone):
+        wd =3D IWD()
+
+        if passphrase:
+            psk_agent =3D PSKAgent(passphrase)
+            wd.register_psk_agent(psk_agent)
+
+        hostapd_ifname =3D None
+        for ifname in hostapd.hostapd_map:
+            if ssid + '.conf' in hostapd.hostapd_map[ifname].config:
+                hostapd_ifname =3D ifname
+                break
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        if not device.get_ordered_networks():
+            device.scan()
+            condition =3D 'obj.scanning'
+            wd.wait_for_object_condition(device, condition)
+            condition =3D 'not obj.scanning'
+            wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network(ssid)
+
+        self.assertEqual(ordered_network.type, NetworkType.eap)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected(hostapd_ifname, device.name)
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        if passphrase:
+            wd.unregister_psk_agent(psk_agent)
+
+    def test_eap_tls(self):
+        self.do_test_connection_success('ssidEAP-TLS')
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage('ssidEAP-TLS.8021x')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TLS-embedded-pems/hw.conf b/autotests/testEA=
P-TLS-embedded-pems/hw.conf
new file mode 100644
index 00000000..0cbda377
--- /dev/null
+++ b/autotests/testEAP-TLS-embedded-pems/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+tmpfs_extra_stuff=3D../misc/certs
+
+[HOSTAPD]
+rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x b/autote=
sts/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
new file mode 100644
index 00000000..e1c34e46
--- /dev/null
+++ b/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
@@ -0,0 +1,94 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3Dembed:cert_ca
+EAP-TLS-ClientCert=3Dembed:cert_client
+EAP-TLS-ClientKey=3Dembed:cert_client_key
+EAP-Identity=3Dabc(a)example.com
+
+[@pem(a)cert_ca]
+-----BEGIN CERTIFICATE-----
+MIIEVDCCAzygAwIBAgIJAJmt2W7CutHvMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
+BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
+MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
+Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ2WhcNNDMxMDAzMjEyMDQ2
+WjB4MTUwMwYDVQQKDCxJbnRlcm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3Jn
+YW5pemF0aW9uczEfMB0GA1UEAwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwG
+CSqGSIb3DQEJARYPY2FAbWFpbC5leGFtcGxlMIIBIjANBgkqhkiG9w0BAQEFAAOC
+AQ8AMIIBCgKCAQEAo3GrGqW49h8kY2Wx/1kd5dIkYGazuWrX93ma9904hHBJNsvu
+V34QfHVln6wDpMZMwuvkfct09kl0rQpztJzA9YL4GMdmV6+6J6LiX1kMqLkNaJa+
+Ov+ECG5ypBRbSTYKpqFsc5wPOQf/N8brBiZS1v67va3fCwO6dgLeAf7dZ3Q70oUr
+mghbK8UnlC+wLShxCBAW8TUKg7B7M5Gea794CO9wH7NsFyAr963WVcLxrdL3xMHZ
+9hcscrljh35nCAc6sum1cTtWI651OGehr0Bhp2o2Exgr2mbo5TobqEW+fe4gc4ik
+0nzHGWiOVaszUcvpeeduGV3y6om93atffeKuxQIDAQABo4HgMIHdMA8GA1UdEwQI
+MAYBAf8CAQAwHQYDVR0OBBYEFO+M3tJAELTnseUqZyP4vl5X7SmUMIGqBgNVHSME
+gaIwgZ+AFO+M3tJAELTnseUqZyP4vl5X7SmUoXykejB4MTUwMwYDVQQKDCxJbnRl
+cm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3JnYW5pemF0aW9uczEfMB0GA1UE
+AwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwGCSqGSIb3DQEJARYPY2FAbWFp
+bC5leGFtcGxlggkAma3ZbsK60e8wDQYJKoZIhvcNAQELBQADggEBAA/Yb9jB94OF
+swbyCrA6Qe53YGC4dfqrKGRThtGKTrH0XcM2x2qLIIbiNDogwhRqlUW8iNY6Dm2k
+43mJzNsYhy7Nt3IJFCguTJFilfGzQnBtK8wCr/C9qsj//BESOIlo/TDZ2Ho4ixcJ
+n+FTnN34F6JJ0DIvA6tNBe1kUFSrbubL8ygNWJ9BKMebEzokGNGCGFNr70DlQj2o
+1EOMMOkj0gWO0WegAYFLojzag3l+uvU59YE+/fbZ2iclyvbF7IutQ5M9g5TnQE6F
+f+qFKR5+bhlJwry6vLl/6ulihkvF3y1bm7zae62zbFaZRU6PJUl1DtXiA23ZTm9T
+VDivqs07R84=3D
+-----END CERTIFICATE-----
+
+[@pem(a)cert_client]
+-----BEGIN CERTIFICATE-----
+MIIEPTCCAyWgAwIBAgIJAPk7rut4SWQCMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
+BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
+MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
+Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ3WhcNNDMxMDAzMjEyMDQ3
+WjBnMSEwHwYDVQQKDBhCYXIgRXhhbXBsZSBPcmdhbml6YXRpb24xITAfBgNVBAMM
+GEJhciBFeGFtcGxlIE9yZ2FuaXphdGlvbjEfMB0GCSqGSIb3DQEJARYQYmFyQG1h
+aWwuZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOE5D/lU
+haTC3xL281ttZPRURXlKJqLwcHGXQSuQm6wwYWtAhLyMLEHrryE0oChKdw3eV7Nn
+/IODxvk1S8uIuKfHWuNd5qX/yu7CjCWvyim2CSJHF24rQFmb9ePoddOZnDMMAIz7
+PC325JVhbr/LSBLbqhZ0smHy1HKyrzzHHzKU4YcTH/3+3H4MHZwnNZfbfG5qhRZG
+Nuu/8t+AWVcEocPRGYZpzWJNq6AAzojAHSSOxxiscBMiuQ+BdofPw9XhwpS+Fstk
+rvF8J9FfZj5U3FOm/EgOQn8efnrUL231PqB1R9PIKYv/938p3iDMIi0ETiKi5ced
+WV8m2PcykPdNOKMCAwEAAaOB2jCB1zAJBgNVHRMEAjAAMB0GA1UdDgQWBBTs9eey
+OkMw3uiPpDOa3b9KErbEfzCBqgYDVR0jBIGiMIGfgBTvjN7SQBC057HlKmcj+L5e
+V+0plKF8pHoweDE1MDMGA1UECgwsSW50ZXJuYXRpb25hbCBVbmlvbiBvZiBFeGFt
+cGxlIE9yZ2FuaXphdGlvbnMxHzAdBgNVBAMMFkNlcnRpZmljYXRlIGlzc3VlciBn
+dXkxHjAcBgkqhkiG9w0BCQEWD2NhQG1haWwuZXhhbXBsZYIJAJmt2W7CutHvMA0G
+CSqGSIb3DQEBCwUAA4IBAQA8MxPjU2h5gwntQeSs8eeaEUILMkoU6JSDS4s5Hex5
+xYMLfcSoPPI0E6ahvKtWkSM0UZThyWsulSDTI1EgAiebjms06m1Ogh9V+0VbcOlQ
+D/k3+fSRIiyY+v3J/h8ArUby+m5O2g1TgECr/nZl4avoAI0RpBi3lH6tC8GQYdbc
+SA6hpNCM/dY3LWtAo2W6mdE8+RlCuTj4VZiQ1g6GE77t6XwDFL6vQBzLLXrinvXK
+Ha+IssV5sGdpH9bVFWIJV2q3OZuv3HLhQfGmeUrGyWVcokQQ8d6kRwg65Zb1+KT2
+bNlVKhPAMBk4ayEocpqFIfqfCKDjGdPUruIh8IVDc684
+-----END CERTIFICATE-----
+
+[@pem(a)cert_client_key]
+-----BEGIN PRIVATE KEY-----
+MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDhOQ/5VIWkwt8S
+9vNbbWT0VEV5Siai8HBxl0ErkJusMGFrQIS8jCxB668hNKAoSncN3lezZ/yDg8b5
+NUvLiLinx1rjXeal/8ruwowlr8optgkiRxduK0BZm/Xj6HXTmZwzDACM+zwt9uSV
+YW6/y0gS26oWdLJh8tRysq88xx8ylOGHEx/9/tx+DB2cJzWX23xuaoUWRjbrv/Lf
+gFlXBKHD0RmGac1iTaugAM6IwB0kjscYrHATIrkPgXaHz8PV4cKUvhbLZK7xfCfR
+X2Y+VNxTpvxIDkJ/Hn561C9t9T6gdUfTyCmL//d/Kd4gzCItBE4iouXHnVlfJtj3
+MpD3TTijAgMBAAECggEBAIbg9YAL7j1NtupUmkkWqm7oSPLqRVkvRSfBvXWplJD6
+KF1itht0lsyjqK3qJj/62HGlxj/a9o6MTIzSLiImLu/Lo9KmWYrwNUfnmqa3MArq
+yW2NxapknJUNoaRrgqTGSZUIiwvjKZcdVKdhQkH6K5+fja0FFg8yrahC+k8bsMNI
+5mw8NwRdR3SvHJWHCLfKCQ31tju7On/4C6jr0siUCc2//W+SO5c+FHDY1bma02cp
+jXTEiFpw91YcyKxiADIaH9/qfxWdefxqYg1WlUeXF3jYt5xYnYr34qKW1gOZ3jy1
+QJ3esn382ZTml3TFZWy+g9tkYyOSgmDwQZbLk/ppBAECgYEA8RzLBFwP018ieMBv
+khDtwcKk6ZihkWZxEPQPuUljWzzAHn/f3dXOcrfmflAKeoDEeYDimDYDizTLDPC4
+zmWkMJHNadcM5H065BbGVFQWXo47ltccfIlB/1vzG8aywfJ/yNfHvH87wbH2eg6N
+yOr+96ZjLJszQ+Rv189BbXDzTcMCgYEA7yEbUL/A1J0l2kLoYyS0vfVa7AyBVOFW
+vPgfkF7HdNpIiFWlukMr+DWOolaoZp5iHqQXFwJsL8qCcrbZuHbaNHAI/5vDE9xG
+fh8KzrfBrjIPIyNm6EWpsBo5unXK+wTeqIAGKdzDo5Q3zEE6G5DkkHItKA7yjPOM
+gz/b/MR3W6ECgYBBv3dA3hXWrreIs/j4nLMoxfoQVPWh34xvcg4jmXaFd6Bv8LDM
+HjRopestgIgK9bgd5d5kYT5AJIpGIhJS/fZy5B9egCzc1aVMc0Vr024yJJjtPgVf
+lFIx3xIA/gLazlS4INcveIaEABJVIEjbg/E4+N9MV5n4Jn+1GqgdvtIp3wKBgQC0
+C3lFkxrc+nVFoJrYCwsK+3E5yTCXeBKWtTsOuE307WUvQU1GsMyqVajPEfA5U4cN
+Cv9Xk7thQFh3hrTm7pXcZX5g9iYrDe8FhtncSv7I6Wf8TOtudwUMUrKkcYwi88ex
+lrMNUer7ft2ELJhTqQRuvYjCYH6/IaDqMWqxJju4AQKBgQDPjOh75ykQc93SsYpt
+Tb4gQKLeqOb57pofT8D44DccatfEgk31D4fBIIQu6XKopQmCtQyX9DUDjOWFTxuo
+IMPysN6Fh1quCbC6Xt5xfKoaJG5yQYKeKtLhknwEW9SUifU2xVrOcPikLs7Iwmmp
+BkDLsu/YKwRFSfrbYZXbTlU8tQ=3D=3D
+-----END PRIVATE KEY-----
+
+[Settings]
+Autoconnect=3DFalse
diff --git a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf b/autotes=
ts/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf
new file mode 100644
index 00000000..e1d7c6b4
--- /dev/null
+++ b/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf
@@ -0,0 +1,12 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidEAP-TLS
+
+wpa=3D3
+wpa_key_mgmt=3DWPA-EAP
+ieee8021x=3D1
+eap_server=3D1
+eap_user_file=3D/tmp/certs/eap-user-tls.text
+ca_cert=3D/tmp/certs/cert-ca.pem
+server_cert=3D/tmp/certs/cert-server.pem
+private_key=3D/tmp/certs/cert-server-key.pem
-- =

2.17.1

--===============5989714689233275868==--

