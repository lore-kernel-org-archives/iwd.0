Content-Type: multipart/mixed; boundary="===============4602098141618320445=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 3/7] autotests: Test loading binary key formats in
 testEAP-TLS
Date: Tue, 26 Jan 2021 10:28:59 -0800
Message-ID: <9ccfe7e5422d86d9235b572082ffbb61c757bd73.camel@gmail.com>
In-Reply-To: <20210125175617.2417412-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4602098141618320445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> =

> diff --git a/autotests/testEAP-TLS/connection_test.py
> b/autotests/testEAP-TLS/connection_test.py
> index 1e390e69..c90b0ceb 100644
> --- a/autotests/testEAP-TLS/connection_test.py
> +++ b/autotests/testEAP-TLS/connection_test.py
> @@ -66,11 +66,15 @@ class Test(unittest.TestCase):
>      def test_eap_tls3(self):
>          self.do_test_connection_success('ssidEAP-TLS3', 'abc')
>  =

> +    def test_eap_tls4(self):
> +        self.do_test_connection_success('ssidEAP-TLS4')
> +

Just FYI, these two new tests do not pass for me. Seems to fail loading
the client-cert. I'm guessing its a lack of those recent keyring
changes you've been working on in the kernel?

Failed to load /tmp/certs/cert-client.crt
Esrc/agent.c:agent_unregister() agent unregister
src/agent.c:agent_free() agent free 0x191c520
src/network.c:network_connect() =

src/network.c:network_connect_8021x() =

EAP-TLS-ClientKeyPassphrase present but no client private key value set
(EAP-TLS-ClientKey)
E
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: test_eap_tls3 (connection_test.Test)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/jprestwo/iwd/autotests/testEAP-TLS/connection_test.py",
line 67, in test_eap_tls3
    self.do_test_connection_success('ssidEAP-TLS3', 'abc')
  File "/home/jprestwo/iwd/autotests/testEAP-TLS/connection_test.py",
line 44, in do_test_connection_success
    ordered_network.network_object.connect()
  File "/home/jprestwo/iwd/autotests/util/iwd.py", line 590, in connect
    self._wait_for_async_op()
  File "/home/jprestwo/iwd/autotests/util/iwd.py", line 119, in
_wait_for_async_op
    raise tmp
iwd.NotConfiguredEx: net.connman.iwd.NotConfigured: Not configured

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: test_eap_tls4 (connection_test.Test)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/jprestwo/iwd/autotests/testEAP-TLS/connection_test.py",
line 70, in test_eap_tls4
    self.do_test_connection_success('ssidEAP-TLS4')
  File "/home/jprestwo/iwd/autotests/testEAP-TLS/connection_test.py",
line 44, in do_test_connection_success
    ordered_network.network_object.connect()
  File "/home/jprestwo/iwd/autotests/util/iwd.py", line 590, in connect
    self._wait_for_async_op()
  File "/home/jprestwo/iwd/autotests/util/iwd.py", line 119, in
_wait_for_async_op
    raise tmp
iwd.NotConfiguredEx: net.connman.iwd.NotConfigured: Not configured

----------------------------------------------------------------------
Ran 4 tests in 4.663s

Thanks,
James

--===============4602098141618320445==--

